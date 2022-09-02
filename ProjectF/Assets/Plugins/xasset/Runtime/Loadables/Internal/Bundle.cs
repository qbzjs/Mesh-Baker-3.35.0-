using System;
using System.Collections.Generic;
using UnityEngine;

namespace xasset
{
    public class Bundle : Loadable
    {
        public static bool DisableUnloadUntilLoadBundleFinish = true;
        private static readonly List<AsyncOperation> Progressing = new List<AsyncOperation>();
        public static readonly Dictionary<string, Bundle> Cache = new Dictionary<string, Bundle>();

        protected ManifestBundle info;
        public static Func<string, ManifestBundle, Bundle> customLoader { get; set; } = null;

        public AssetBundle assetBundle { get; protected set; }

        public static bool IsLoadingOrUnloading()
        {
            for (var i = 0; i < Progressing.Count; i++)
            {
                var item = Progressing[i];
                if (item != null && !item.isDone) return true;

                Progressing.RemoveAt(i);
                i--;
            }

            return false;
        }

        protected AssetBundleCreateRequest LoadAssetBundleAsync(string url)
        {
            Logger.I("LoadAssetBundleAsync", info.nameWithAppendHash);
            var request = AssetBundle.LoadFromFileAsync(url);
            if (DisableUnloadUntilLoadBundleFinish) Progressing.Add(request);
            return request;
        }

        protected AssetBundle LoadAssetBundle(string url)
        {
            Logger.I("LoadAssetBundle", info.nameWithAppendHash);
            return AssetBundle.LoadFromFile(url);
        }

        protected void OnLoaded(AssetBundle bundle)
        {
            assetBundle = bundle;
            Finish(assetBundle == null ? "assetBundle == null" : null);
#if UNITY_EDITOR && UNITY_ANDROID
            // 兼容Android资源在电脑上运行
            ReplaceBundleMat();
#endif
        }

        internal static Bundle LoadInternal(ManifestBundle bundle)
        {
            if (bundle == null) throw new NullReferenceException();

            if (!Cache.TryGetValue(bundle.nameWithAppendHash, out var item))
            {
                var url = PathManager.GetBundlePathOrURL(bundle);
                if (customLoader != null) item = customLoader(url, bundle);

                if (item == null)
                {
                    if (url.StartsWith("http://") || url.StartsWith("https://") || url.StartsWith("ftp://"))
                        item = new DownloadBundle {pathOrURL = url, info = bundle};
                    else
                        item = new LocalBundle {pathOrURL = url, info = bundle};
                }

                Cache.Add(bundle.nameWithAppendHash, item);
            }

            item.Load();
            return item;
        }

        protected override void OnUnload()
        {
            Cache.Remove(info.nameWithAppendHash);
            if (assetBundle == null) return;

            assetBundle.Unload(true);
            assetBundle = null;
        }

        private void ReplaceBundleMat()
        {
            if(assetBundle == null) return;
            var mats = assetBundle.LoadAllAssets<Material>();
            if (mats.Length > 0)
            {
                foreach (var mat in mats)
                {
                    var shaderName = mat.shader.name;
                    var shaderInRuntime = Shader.Find(shaderName);
                    if (shaderInRuntime != null)
                    {
                        mat.shader = shaderInRuntime;
                    }
                    else
                    {
                        Logger.E($"Cant not find the shader: {shaderName} used in mat: {mat.name}");
                    }
                }
            }
        }
    }
}