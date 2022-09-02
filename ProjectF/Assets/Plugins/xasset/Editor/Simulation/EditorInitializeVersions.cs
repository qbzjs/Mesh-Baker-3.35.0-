using System.Collections.Generic;
using System.IO;
using UnityEditor;

namespace xasset.editor
{
    /// <summary>
    ///     仿真模式的初始化操作
    /// </summary>
    public class EditorInitializeVersions : Operation
    {
        public override void Start()
        {
            base.Start();
            var manifest = Manifest.LoadFromFile("Simulation");

            var rule = BuildScript.GetRule();
            var bundleBuilds = rule.Build(false);
            var bundles = rule.GetManifestBundles(bundleBuilds);
            foreach (var path in Directory.GetFiles("Assets/DynamicRes/Video", "*.mp4", SearchOption.AllDirectories))
                bundles.Add(new ManifestBundle
                {
                    name = GetBundleName(path),
                    assets = new List<string> { path },
                });
            CreateManifest.LoadManifest(manifest, bundles);
            manifest.ReLoad();
            manifest.name = "Manifest";

            Versions.LoadVersion(manifest);
            Versions.ReloadPlayerVersions(null);
            Finish();
        }
        
        

        private string GetBundleName(string asset)
        {
            var assetName = Path.GetFileNameWithoutExtension(asset);
            var directoryName = Path.GetDirectoryName(asset)?.Replace("\\", "/").Replace("/", "_");
            var group = directoryName + "_" + assetName;
            return group.TrimEnd('_').ToLower() + Settings.BundleExtension;
        }
    }
}