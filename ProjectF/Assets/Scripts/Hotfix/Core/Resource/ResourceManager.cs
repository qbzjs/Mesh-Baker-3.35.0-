using System.Threading.Tasks;
using Hotfix.Utils;

namespace Hotfix.Core.Resource
{
    public class ResourceManager : IManager
    {
        public Task Create()
        {
            return null;
        }

        public void Destroy()
        {
        }
        
        public static T Load<T>(string path) where T : UnityEngine.Object
        {
            var assetPath = GetLoadPath(path);
            var asset = xasset.Asset.Load(assetPath, typeof(T));
            if (asset == null)
            {
                // LOG.Resource.E($"Load Fail, File Not Exsit, path: {path}");
                return default(T);
            }

            return asset.asset as T;
        }
        
        public async Task<xasset.Asset> LoadAssetAsync<T>(string path, string subAssetPath = null)
        {
            var assetPath = GetLoadPath(path);
            if (!(await xasset.Asset.LoadAsync<T>(assetPath, subAssetPath) is xasset.Asset asset))
            {
                // LOG.Resource.E($"LoadAssetAsync Fail, File Not Exists, Path: {path}");
                return null;
            }

            if (!(asset.asset is T))
            {
                asset.Release();
                // LOG.Resource.E($"LoadAssetAsync Fail, Asset is Not {typeof(T)}, Path: {path}");
                return null;
            }

            return asset;
        }
        
        public static string GetLoadPath(string path)
        {
            path = path.Replace("\\", "/");
            if (path.StartsWith(GlobalConfig.DynamicResPrePath)) return path;

            return $"{GlobalConfig.DynamicResPrePath}/{path}";
        }
    }
}