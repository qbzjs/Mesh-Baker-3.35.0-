using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using Sirenix.OdinInspector;

namespace xasset.editor
{
    public enum GroupBy
    {
        None,      // 不打成AssetBundle包
        Explicit,  // 由外部指定AssetBundle名
        Filename,  // 按单文件打成一个AssetBundle
        Directory, // 同一目录下所有文件都打成一个AssetBundle
    }

    public enum ERecordType
    {
        Inner,
        Foreground,
        All,
    }

    [Serializable]
    public class GroupBuild
    {
        [FolderPath, Tooltip("按目录自动分组")]
        public string path = "";
        [Tooltip("过滤文件扩展名")]
        public string searchPattern = "";
        [Tooltip("分组类型")]
        public GroupBy groupBy = GroupBy.Directory;
        [Tooltip("是否递归子目录")]
        public bool includeSubDirectory = true;
        [HideIf("@groupBy != GroupBy.Explicit")]
        public string group;
        [ShowIf("@includeSubDirectory && groupBy == GroupBy.Directory")]
        public bool groupPerSubDir;
        [Tooltip("是否根据图集排除")]
        public bool filterByAtlas;
    }

    [Serializable]
    public class AssetBuild
    {
        public string path;
        public string group;
        public string bundle = string.Empty;
        public int id;
        public GroupBy groupBy = GroupBy.Filename;
    }

    [Serializable]
    public class PatchBuild
    {
        public string name;

        [SerializeField]
        public List<string> assets = new List<string>();
    }

    [Serializable]
    public class BundleBuild
    {
        public string assetBundleName;
        public List<string> assetNames = new List<string>();

        public ManifestBundle ToBuild()
        {
            return new ManifestBundle()
            {
                name = assetBundleName,
                assets = assetNames,
            };
        }
    }
}