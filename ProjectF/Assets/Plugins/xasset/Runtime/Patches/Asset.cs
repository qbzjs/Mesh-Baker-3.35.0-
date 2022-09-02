using System.Collections;

namespace xasset
{
    public partial class Asset
    {
#if UNITY_EDITOR
        public static System.Action<string> onAssetLoaded { get; set; }
#endif

        public static IEnumerator LoadAsync<T>(string path, string subAssetName = null)
        {
            var noSubAsset = string.IsNullOrEmpty(subAssetName);
            var type = typeof(T);
            var asset = noSubAsset ? LoadAsync(path, type) : LoadWithSubAssetsAsync(path, type);
            yield return asset;

#if UNITY_EDITOR
            onAssetLoaded?.Invoke(path);
#endif

            if (!noSubAsset)
            {
                asset?.OnLoadedAllSubAssets(subAssetName);
            }
        }

        private void OnLoadedAllSubAssets(string subAssetName)
        {
            foreach (var subAsset in subAssets)
            {
                if (subAsset.name == subAssetName)
                {
                    asset = subAsset;
                    return;
                }
            }

            Finish($"{pathOrURL} load subAsset {subAssetName} fail");
        }
    }
}