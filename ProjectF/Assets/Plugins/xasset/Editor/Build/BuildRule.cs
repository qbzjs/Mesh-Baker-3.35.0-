using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEditor;

namespace xasset.editor
{
    [CreateAssetMenu(menuName = "Versions/Rules", fileName = "Rules")]
    public sealed class BuildRule : ScriptableObject
    {
        [Header("自动分包分组配置")]
        [Tooltip("是否自动记录资源的分包分组")]
        public bool autoRecord;
        [Tooltip("记录类型, 将记录添加到选回类型的列表中")]
        public ERecordType recordType;
        [Tooltip("记录前是否清理旧的")]
        public bool clearBeforeRecord;
        public List<GroupBuild> autoGroupList = new List<GroupBuild>();
        [Sirenix.OdinInspector.FilePath, Header("过滤的配置文件")]
        public List<string> filterFiles = new List<string>();

        [SerializeField, Tooltip("打包AB的选项")]
        private BuildAssetBundleOptions options = BuildAssetBundleOptions.DeterministicAssetBundle | BuildAssetBundleOptions.ChunkBasedCompression;

        [Header("整包内置的资源")]
        public PatchBuild innerPatch = new PatchBuild();

        [Header("需要前台下载的资源")]
        public PatchBuild foregroundPatch = new PatchBuild();

        [Header("总的资源优先级")]
        public PatchBuild allPatch = new PatchBuild();

        private List<AssetBuild> assetBuilds = new List<AssetBuild>();

        private static bool filterByAtlas = true;
        private static bool writeTypeTree = true;
        private static bool forceRebuild = false;

        public BuildAssetBundleOptions GetOptions()
        {
            var result = options;
            if (!writeTypeTree) result |= BuildAssetBundleOptions.DisableWriteTypeTree;
            if (forceRebuild) result |= BuildAssetBundleOptions.ForceRebuildAssetBundle;
            return result;
        }

        public void OnLoadAsset(string assetPath)
        {
            if (!autoRecord) return;

            var assetBuild = assetBuilds.Find(x => x.path == assetPath);
            if (assetBuild == null)
            {
                Framework.Log.Editor.E("自动绑定分包失败, {0}未加入到打包列表中", assetPath);
                return;
            }

            var patch = GetPatchBuildByType(recordType);
            if (patch.assets.Contains(assetPath))
            {
                return;
            }

            patch.assets.Add(assetPath);
        }

        public void OnUnloadAsset(string assetPath)
        {
        }

        #region API

        public void PatchAsset(string path)
        {
            if (File.Exists(path) && !foregroundPatch.assets.Contains(path))
            {
                foregroundPatch.assets.Add(path);
            }
        }

        public List<BundleBuild> Build(bool analysis)
        {
            if (autoRecord)
            {
                Asset.onAssetLoaded = OnLoadAsset;
                var patch = GetPatchBuildByType(recordType);
                if (clearBeforeRecord) patch.assets.Clear();
            }

            if (analysis) assetBuilds.Clear();
            BuildAutoGroup();

            var asset2Bundles = CollectAssets();
            if (analysis) asset2Bundles = AnalysisAssets(asset2Bundles);
            var bundleBuilds = GetBundles(asset2Bundles).Select((x) => new BundleBuild()
            {
                assetBundleName = x.Key,
                assetNames = x.Value,
            }).ToList();

            if (analysis) Save();

            return bundleBuilds;
        }

        public List<ManifestBundle> GetManifestBundles(List<BundleBuild> bundleBuilds)
        {
            return bundleBuilds.Select(x => x.ToBuild()).ToList();
        }

        #endregion

        #region Private

        private PatchBuild GetPatchBuildByType(ERecordType type)
        {
            var patch = allPatch;
            switch (type)
            {
                case ERecordType.Inner: patch = innerPatch; break;
                case ERecordType.Foreground: patch = foregroundPatch; break;
                case ERecordType.All: patch = allPatch; break;
            }

            return patch;
        }

        private void BuildAutoGroup()
        {
            var atlasInfos = BuildScript.GetAtlasInfos();
            foreach (var info in autoGroupList)
            {
                if (!Directory.Exists(info.path)) continue;
                BuildAutoGroupInner(info.path, info.group, info);
                if (!info.includeSubDirectory) continue;

                var directors = Directory.GetDirectories(info.path, "*", SearchOption.AllDirectories);
                foreach (var subDir in directors)
                {
                    BuildAutoGroupInner(subDir, info.groupPerSubDir ? subDir : info.group, info);
                }
            }

            void BuildAutoGroupInner(string directory, string group, GroupBuild info)
            {
                var fileList = GetFileList(directory, true, info.searchPattern);
                fileList = fileList.Where(x =>
                {
                    if (filterFiles.Contains(x)) return false;
                    if (!filterByAtlas || !info.filterByAtlas) return true;

                    var atlasInfo = atlasInfos.Find(x);
                    return atlasInfo == null;
                }).ToList();
                foreach (var assetPath in fileList)
                {
                    GroupAsset(assetPath, info.groupBy, group);
                }
            }
        }

        private bool ValidateAsset(string asset)
        {
            if (!asset.StartsWith("Assets/")) return false;

            var ext = Path.GetExtension(asset).ToLower();
            return ext != ".dll" && ext != ".cs" && ext != ".meta" && ext != ".js" && ext != ".boo";
        }

        private bool IsScene(string asset)
        {
            return asset.EndsWith(".unity");
        }

        private string GetGroupName(GroupBy groupBy, string asset, string group = null, bool isChildren = false, bool isShared = false)
        {
            if (asset.EndsWith(".shader") || asset.EndsWith(".shadervariants"))
            {
                group = "shaders";
                groupBy = GroupBy.Explicit;
                isChildren = false;
                isShared = false;
            }

            else if (IsScene(asset))
            {
                groupBy = GroupBy.Filename;
            }

            switch (groupBy)
            {
                case GroupBy.Explicit:
                    break;
                case GroupBy.Filename:
                    {
                        var assetName = Path.GetFileNameWithoutExtension(asset);
                        var directoryName = Path.GetDirectoryName(asset)?.Replace("\\", "/").Replace("/", "_");
                        group = directoryName + "_" + assetName;
                    }
                    break;
                case GroupBy.Directory:
                    {
                        var directoryName = Path.GetDirectoryName(asset)?.Replace("\\", "/").Replace("/", "_");
                        group = directoryName;
                        break;
                    }
            }

            if (isChildren)
            {
                return "children_" + group;
            }

            if (isShared)
            {
                group = "shared_" + group;
            }

            if (string.IsNullOrEmpty(group))
            {
                Framework.Log.Editor.E("{0} group 为空", asset);
                return "";
            }

            return group.TrimEnd('_').ToLower() + Settings.BundleExtension;
        }

        private void Track(string asset, string bundle, Dictionary<string, HashSet<string>> tracker, Dictionary<string, string> unexplicits)
        {
            if (!tracker.TryGetValue(asset, out var hashSet))
            {
                hashSet = new HashSet<string>();
                tracker.Add(asset, hashSet);
            }

            hashSet.Add(bundle);
            if (hashSet.Count <= 1)
            {
                unexplicits[asset] = GetGroupName(GroupBy.Explicit, asset, bundle, true);
            }
            else
            {
                unexplicits[asset] = GetGroupName(GroupBy.Directory, asset, null, false, true);
            }
        }

        private Dictionary<string, List<string>> GetBundles(Dictionary<string, string> asset2Bundles)
        {
            var dictionary = new Dictionary<string, List<string>>();
            foreach (var item in asset2Bundles)
            {
                var bundle = item.Value;
                List<string> list;
                if (!dictionary.TryGetValue(bundle, out list))
                {
                    list = new List<string>();
                    dictionary[bundle] = list;
                }
                if (!list.Contains(item.Key)) list.Add(item.Key);
            }
            return dictionary;
        }

        private void Save()
        {
            UnityEditor.EditorUtility.ClearProgressBar();
            UnityEditor.EditorUtility.SetDirty(this);
            AssetDatabase.SaveAssets();
        }

        private Dictionary<string, string> AnalysisAssets(Dictionary<string, string> asset2Bundles)
        {
            var tracker = new Dictionary<string, HashSet<string>>();
            var unexplicits = new Dictionary<string, string>();

            var getBundles = GetBundles(asset2Bundles);
            var count = getBundles.Count;
            var i = 0;
            foreach (var item in getBundles)
            {
                ++i;
                var bundle = item.Key;
                if (UnityEditor.EditorUtility.DisplayCancelableProgressBar($"分析依赖{i}/{count}", bundle, i * 1.0f / count)) break;

                var dependencies = AssetDatabase.GetDependencies(item.Value.ToArray(), true);
                if (dependencies.Length <= 0) continue;

                foreach (var depAsset in dependencies)
                {
                    if (Directory.Exists(depAsset)
                        || Settings.IsExcluded(depAsset)
                        || !ValidateAsset(depAsset))
                    {
                        continue;
                    }

                    asset2Bundles.TryGetValue(depAsset, out var depBundleName);
                    if (!string.IsNullOrEmpty(depBundleName)) continue;

                    Track(depAsset, bundle, tracker, unexplicits);
                }
            }

            UnityEditor.EditorUtility.ClearProgressBar();
            return asset2Bundles.Concat(unexplicits).ToDictionary(x => x.Key, y => y.Value);
        }

        private Dictionary<string, string> CollectAssets()
        {
            var asset2Bundles = new Dictionary<string, string>();
            var list = new List<AssetBuild>();
            var len = Environment.CurrentDirectory.Length + 1;
            foreach (var assetBuild in assetBuilds)
            {
                var path = new FileInfo(assetBuild.path);
                if (path.Exists && ValidateAsset(assetBuild.path))
                {
                    var relativePath = path.FullName.Substring(len).Replace("\\", "/");
                    if (!relativePath.Equals(assetBuild.path))
                    {
                        Logger.W("检查到路径大小写不匹配！输入：{0}实际：{1}，已经自动修复。", assetBuild.path, relativePath);
                        assetBuild.path = relativePath;
                    }
                    list.Add(assetBuild);
                }
            }

            for (var i = 0; i < list.Count; i++)
            {
                var asset = list[i];
                if (asset.groupBy == GroupBy.None)
                {
                    continue;
                }

                asset.bundle = GetGroupName(asset.groupBy, asset.path, asset.group);
                asset2Bundles[asset.path] = asset.bundle;
            }

            assetBuilds = list;
            return asset2Bundles;
        }

        private void GroupAsset(string path, GroupBy groupBy = GroupBy.Filename, string group = null)
        {
            var value = assetBuilds.Find(x => x.path == path);
            if (value == null)
            {
                value = new AssetBuild()
                {
                    path = path.Replace("\\", "/"),
                };
                assetBuilds.Add(value);
            }

            value.groupBy = groupBy;
            if (groupBy == GroupBy.Explicit)
            {
                value.group = group;
            }
        }

        private IEnumerable<string> GetFileList(string path, bool topDirOnley, string searchPattern)
        {
            var fullSearchPath = path;
            var searchOption = topDirOnley ? SearchOption.TopDirectoryOnly : SearchOption.AllDirectories;

            var fileList = new List<string>();
            var searchPatterns = searchPattern.Split(';');
            for (int i = 0; i < searchPatterns.Length; i++)
            {
                var files = Directory.GetFiles(fullSearchPath, searchPatterns[i], searchOption);
                if (files.Length > 0)
                {
                    fileList.AddRange(files);
                }
            }

            return fileList.Select(x => x.Replace("\\", "/"));
        }
        #endregion
    }
}