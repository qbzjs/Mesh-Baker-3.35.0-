using System.IO;
using UnityEditor;
using UnityEngine;

namespace xasset.editor
{
    public static class MenuItems
    {
        [MenuItem("xasset/Pack by file")]
        public static void PackByFile()
        {
            foreach (var o in Selection.GetFiltered<Object>(SelectionMode.DeepAssets))
            {
                var assetPath = AssetDatabase.GetAssetPath(o);
                if (string.IsNullOrEmpty(assetPath)) continue;

                if (Directory.Exists(assetPath)) continue;

                var assetImport = AssetImporter.GetAtPath(assetPath);
                var dir = Path.GetDirectoryName(assetPath)?.Replace('\\', '/').Replace('/', '_');
                var name = Path.GetFileNameWithoutExtension(assetPath);
                var type = Path.GetExtension(assetPath);
                assetImport.assetBundleName =
                    $"{dir}_{name}{type}".ToLower().Replace('.', '_') + Settings.BundleExtension;
            }
        }

        [MenuItem("xasset/Pack by dir")]
        public static void PackByDir()
        {
            foreach (var o in Selection.GetFiltered<Object>(SelectionMode.DeepAssets))
            {
                var assetPath = AssetDatabase.GetAssetPath(o);
                if (string.IsNullOrEmpty(assetPath)) continue;

                if (Directory.Exists(assetPath)) continue;

                var assetImport = AssetImporter.GetAtPath(assetPath);
                var dir = Path.GetDirectoryName(assetPath)?.Replace('\\', '/').Replace('/', '_').Replace('.', '_');
                assetImport.assetBundleName = dir + Settings.BundleExtension;
            }
        }

        [MenuItem("xasset/Build Bundles", false, 10)]
        public static void BuildBundles()
        {
            var args = System.Environment.GetCommandLineArgs();
            var versionCode = ParseArgsVersionCode(args);
            var outputPath = ParseArgsOutputPath(args);
            BuildScript.BuildBundles(versionCode, outputPath);
        }

        [MenuItem("xasset/Build Player", false, 10)]
        public static void BuildPlayer()
        {
            BuildScript.BuildPlayer();
        }

        [MenuItem("xasset/Copy Build to StreamingAssets ", false, 50)]
        public static void CopyBuildToStreamingAssets()
        {
            BuildScript.CopyToStreamingAssets();
        }

        [MenuItem("xasset/Clear Build", false, 800)]
        public static void ClearBuild()
        {
            BuildScript.ClearBuild();
        }

        [MenuItem("xasset/Clear Build from selection", false, 800)]
        public static void ClearBuildFromSelection()
        {
            BuildScript.ClearBuildFromSelection();
        }

        [MenuItem("xasset/Clear History", false, 800)]
        public static void ClearHistory()
        {
            BuildScript.ClearHistory();
        }

        [MenuItem("xasset/Documentation", false, 2000)]
        private static void OpenDocumentation()
        {
            GotoHomepage();
        }

        public static void GotoHomepage(string location = null)
        {
            Application.OpenURL(
                string.IsNullOrEmpty(location) ? "https://xasset.pro" : $"https://xasset.pro/{location}");
        }

        [MenuItem("xasset/File a Bug", false, 2000)]
        public static void FileABug()
        {
            Application.OpenURL("https://github.com/xasset/xasset/issues");
        }

        [MenuItem("Assets/Compute Hash", false, 2000)]
        public static void ComputeHash()
        {
            var target = Selection.activeObject;
            var path = AssetDatabase.GetAssetPath(target);
            var hash = Utility.ComputeHash(path);
            Debug.LogFormat("Compute Hash for {0} with {1}", path, hash);
        }

        [MenuItem("xasset/ShaderCollections", false, 2000)]
        public static void MakeShaderCollection()
        {
            ShaderCollection.SimpleGenShaderVariant();
        }

        [MenuItem("xasset/Build Rule", false, 2000)]
        public static void BuildGroup()
        {
            BuildScript.GetRule().Build(true);
        }

        [MenuItem("xasset/Build Android Bundles", false, 10)]
        public static void BuildBundlesAndroid()
        {
            SwitchAndBuildBundles(BuildTarget.Android);
        }

        [MenuItem("xasset/Build iOS Bundles", false, 10)]
        public static void BuildBundlesiOS()
        {
            SwitchAndBuildBundles(BuildTarget.iOS);
        }

        [MenuItem("xasset/ReBuild Manifest", false, 10)]
        public static void ReBuildSplitManifest()
        {
            var task = new BuildTask("Manifest");
            task.buildVersion = -1;
            new CreateManifest(task).CreateSplitPackageManifest();
        }

        [MenuItem("xasset/Check Manifest", false, 10)]
        public static void CheckManifest()
        {
            var task = new BuildTask("Manifest", "/Users/poetao/Downloads/com.ayjs.dldl.youwang/files/AssetBundle/");
            task.buildVersion = -1;
            new CreateManifest(task).CheckManifest();
        }

        private static void SwitchAndBuildBundles(BuildTarget buildTarget)
        {
            if (buildTarget != EditorUserBuildSettings.activeBuildTarget)
            {
                EditorUserBuildSettings.SwitchActiveBuildTarget(buildTarget);
            }
            BuildBundles();
        }

        private static int ParseArgsVersionCode(string[] args)
        {
            try
            {
                var match = "versionCode=";
                foreach (var arg in args)
                {
                    if (arg.IndexOf(match) == 0)
                    {
                        return System.Convert.ToInt32(arg.Replace(match, ""));
                    }
                }
            }
            catch (System.Exception e)
            {
                Logger.E(e.Message);
            }

            return -1;
        }

        private static string ParseArgsOutputPath(string[] args)
        {
            try
            {
                var match = "outputPath=";
                foreach (var arg in args)
                {
                    if (arg.IndexOf(match) == 0)
                    {
                        return arg.Replace(match, "");
                    }
                }
            }
            catch (System.Exception e)
            {
                Logger.E(e.Message);
            }

            return "";
        }
    }
}