using System.Collections.Generic;
using System.IO;
using UnityEditor;

namespace xasset.editor
{
    public class BuildVideoBundles : BuildBundles
    {
        public BuildVideoBundles(BuildTask task, BuildAssetBundleOptions options) : base(task, options)
        {
        }

        protected override void CreateBundles()
        {
            foreach (var path in Directory.GetFiles("Assets/DynamicRes/Video", "*.mp4", SearchOption.AllDirectories))
                bundles.Add(new ManifestBundle
                {
                    name = GetBundleName(path),
                    assets = new List<string> { path },
                });
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