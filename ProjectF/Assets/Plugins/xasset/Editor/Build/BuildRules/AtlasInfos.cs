using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace xasset.editor
{
    [Serializable]
    public class SpriteInfo
    {
        public string path;
        public string crc32;
        public string guid;
    }

    [Serializable]
    public class AtlasInfo
    {
        public string atlasPath;
        public string atlasCrc32;
        public List<SpriteInfo> assets = new List<SpriteInfo>();

        public void Clone(AtlasInfo info)
        {
            atlasPath = info.atlasPath;
            atlasCrc32 = info.atlasCrc32;
            assets = info.assets;
        }

        public void BindAsset(string assetPath)
        {
            var asset = assets.Find(x => x.path == assetPath);
            if (asset == null)
            {
                asset = new SpriteInfo();
                assets.Add(asset);
            }
            asset.crc32 = xasset.Utility.ComputeHash(assetPath);
            asset.path = assetPath;
            asset.guid = AssetDatabase.AssetPathToGUID(assetPath);
        }

        public bool FindAsset(string assetPath)
        {
            var asset = assets.Find(x => x.path == assetPath);
            if (asset == null) return false;
            return asset.crc32 == xasset.Utility.ComputeHash(assetPath);
        }
    }

    public class AtlasInfos : ScriptableObject
    {
        [SerializeField, Header("缓存数据")]
        private List<AtlasInfo> atlasInfos = new List<AtlasInfo>();

        public AtlasInfo Find(string path) => atlasInfos.Find(x => x.FindAsset(path));

        public AtlasInfo Get(int index) => atlasInfos[index];

        public int Count => atlasInfos.Count;

        public void Add(AtlasInfo info)
        {
            var old = atlasInfos.Find(x => x.atlasPath == info.atlasPath);
            if (old != null)
            {
                old.Clone(info);
                return;
            }

            atlasInfos.Add(info);
        }

        public void Clear()
        {
            atlasInfos.Clear();
        }
    }
}