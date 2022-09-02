using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;

namespace xasset.editor
{
    public class CreateManifest : BuildTaskJob
    {
        public CreateManifest(BuildTask task) : base(task)
        {
        }

        public override void Run()
        {
            var forceRebuild = _task.forceRebuild;
            var buildNumber = _task.buildVersion;
            var versions = BuildVersions.Load(GetBuildPath(Versions.Filename));
            var version = versions.Get(_task.name);
            var manifest = Manifest.LoadFromFile(GetBuildPath(version?.file));
            manifest.name = _task.name;
            if (buildNumber > 0)
                manifest.version = buildNumber;
            else
                manifest.version++;

            _task.buildVersion = manifest.version;
            var getBundles = new Dictionary<string, ManifestBundle>();
            foreach (var bundle in manifest.bundles) getBundles[bundle.name] = bundle;

            var manifestAssets = LoadManifest(manifest, _task.bundles);
            for (var index = 0; index < manifest.bundles.Count; index++)
            {
                var bundle = manifest.bundles[index];
                if (getBundles.TryGetValue(bundle.name, out var value) && value.hash == bundle.hash)
                {
                    continue;
                }

                changes.Add(bundle.nameWithAppendHash);
            }

            if (changes.Count == 0 && !forceRebuild)
            {
                error = "Nothing to build.";
                Debug.LogWarning(error);
                return;
            }

            GetDependencies(manifestAssets);
            _task.changes.AddRange(changes);
            _task.SaveManifest(manifest);

            CreateSplitPackageManifest(manifest, versions);
        }

        public void CreateSplitPackageManifest(Manifest manifest = null, BuildVersions versions = null)
        {
            versions = versions ? versions : BuildVersions.Load(GetBuildPath(Versions.Filename));
            manifest = manifest ? manifest : Manifest.LoadFromFile(GetBuildPath(versions.Get(_task.name)?.file));

            var rule = BuildScript.GetRule();
            var innerBundles = GetBundles(rule.innerPatch.assets, manifest);
            CreatePatchManifest(rule.innerPatch.name, manifest.version, innerBundles, versions);

            var foregroundAssets = rule.foregroundPatch.assets.Concat(rule.innerPatch.assets).ToList();
            var foregroundBundles = GetBundles(foregroundAssets, manifest);
            CreatePatchManifest(rule.foregroundPatch.name, manifest.version, foregroundBundles, versions);

            var backgroundBundles = new List<ManifestBundle>(manifest.bundles.Count - foregroundBundles.Count);
            var foregroundIds = new HashSet<int>(foregroundBundles.ConvertAll(x => x.id));
            foreach (var manifestBundle in manifest.bundles)
            {
                if (foregroundIds.Contains(manifestBundle.id)) continue;
                backgroundBundles.Add(manifestBundle);
            }

            var orders = GetBundleOrders(rule.allPatch.assets, manifest);
            var maxOrder = rule.allPatch.assets.Count + 100;
            backgroundBundles.Sort((l, r) =>
            {
                if (!orders.TryGetValue(l.id, out var lOrder))
                {
                    lOrder = maxOrder;
                }
                if (!orders.TryGetValue(r.id, out var rOrder))
                {
                    rOrder = maxOrder;
                }

                if (lOrder != rOrder) return lOrder.CompareTo(rOrder);
                return l.id.CompareTo(r.id);
            });
            CreatePatchManifest("Background", manifest.version, backgroundBundles, versions);
        }

        public void CheckManifest(Manifest manifest = null, BuildVersions versions = null)
        {
            versions = versions ? versions : BuildVersions.Load(GetBuildPath(Versions.Filename));
            manifest = manifest ? manifest : Manifest.LoadFromFile(GetBuildPath(versions.Get(_task.name)?.file));

            _task.CheckManifest(manifest);
        }

        public static Dictionary<string, ManifestAsset> LoadManifest(Manifest manifest, List<ManifestBundle> bundles)
        {
            var dirs = new List<string>();
            var assets = new List<ManifestAsset>();
            var manifestAssets = new Dictionary<string, ManifestAsset>();

            for (var index = 0; index < bundles.Count; index++)
            {
                var bundle = bundles[index];
                foreach (var asset in bundle.assets)
                {
                    var dir = Path.GetDirectoryName(asset)?.Replace("\\", "/");
                    var pos = dirs.IndexOf(dir);
                    if (pos == -1)
                    {
                        pos = dirs.Count;
                        dirs.Add(dir);
                    }

                    var manifestAsset = new ManifestAsset
                    {
                        name = Path.GetFileName(asset),
                        bundle = index,
                        dir = pos,
                        id = assets.Count
                    };
                    assets.Add(manifestAsset);
                    manifestAssets.Add(asset, manifestAsset);
                }
            }

            manifest.bundles = bundles;
            manifest.assets = assets;
            manifest.dirs = dirs;
            manifest.bundleExtension = Settings.BundleExtension;

            return manifestAssets;
        }

        private static void GetDependencies(Dictionary<string, ManifestAsset> assets)
        {
            foreach (var pair in assets)
            {
                var asset = pair.Value;
                var deps = new HashSet<int>();
                var dependencies = Settings.GetDependencies(pair.Key);
                foreach (var dependency in dependencies)
                    if (assets.TryGetValue(dependency, out var value))
                        deps.Add(value.id);

                asset.deps = deps.ToArray();
            }
        }

        private static Dictionary<int, int> GetBundleOrders(List<string> assets, Manifest manifest)
        {
            var result = new Dictionary<int, int>();

            void AddToDictionary(int bundleId, int order)
            {
                if (result.ContainsKey(bundleId)) return;
                result.Add(bundleId, order);
            }

            manifest.ReLoad();
            for (var i = 0; i < assets.Count; ++i)
            {
                var asset = assets[i];
                var mainBundle = manifest.GetBundle(asset);
                if (mainBundle == null) continue;
                AddToDictionary(mainBundle.id, i);
                var dependencies = manifest.GetDependencies(mainBundle);
                foreach (var depBundle in dependencies)
                {
                    AddToDictionary(depBundle.id, i);
                }
            }

            return result;
        }

        private List<ManifestBundle> GetBundles(List<string> assets, Manifest manifest)
        {
            var bundleIndexes = new HashSet<int>();
            var dirs = manifest.dirs;
            foreach (var asset in manifest.assets)
            {
                var path = $"{dirs[asset.dir]}/{asset.name}";
                if (!assets.Contains(path)) continue;

                bundleIndexes.Add(asset.bundle);
                var bundle = manifest.bundles[asset.bundle];
                foreach (var bundleDep in bundle.deps)
                {
                    bundleIndexes.Add(bundleDep);
                }
            }

            var bundles = new List<ManifestBundle>(bundleIndexes.Count);
            foreach (var index in bundleIndexes)
            {
                bundles.Add(manifest.bundles[index]);
            }

            return bundles;
        }

        private void CreatePatchManifest(string name, int versionNum, List<ManifestBundle> bundles, BuildVersions versions)
        {
            var patchVersion = versions.Get(name);
            var patchManifest = Manifest.LoadFromFile(GetBuildPath(patchVersion?.file));
            patchManifest.name = name;
            patchManifest.bundles = bundles;
            patchManifest.version = versionNum;
            patchManifest.bundleExtension = Settings.BundleExtension;
            _task.SaveManifest(patchManifest);
        }
    }
}