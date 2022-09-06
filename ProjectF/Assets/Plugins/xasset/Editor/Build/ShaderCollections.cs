using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering;
using System;
using System.IO;
using System.Linq;
using System.Reflection;

namespace xasset.editor
{
    
    public class ShaderCollection : EditorWindow
    {
        // GlobalConfig.DynamicResPrePath +
        private const string ALL_SHADER_VARAINT_PATH =  "/Materials/AllShaders.shadervariants";
        private const string TOOLS_SVC_PATH = "Assets/Materials/Tools.shadervariants";

        private static List<string> allShaderNameList = new List<string>();
        private static MethodInfo GetShaderVariantEntries;
        private static ShaderVariantCollection toolSVC;
        private static Dictionary<string, ShaderData> ShaderDataDict = new Dictionary<string, ShaderData>();
        private static Dictionary<string, List<ShaderVariantCollection.ShaderVariant>> ShaderVariantDict = new Dictionary<string, List<ShaderVariantCollection.ShaderVariant>>();
        private static List<string> passShaderList = new List<string>();

        public static void SimpleGenShaderVariant()
        {
            ShaderDataDict.Clear();
            ShaderVariantDict.Clear();
            passShaderList.Clear();

            //先搜集所有keyword到工具类SVC
            toolSVC = new ShaderVariantCollection();
            var shaders = AssetDatabase.FindAssets("t:Shader", new [] {"Assets", "Packages"}).ToList();
            foreach (var shader in shaders)
            {
                ShaderVariantCollection.ShaderVariant sv         = new ShaderVariantCollection.ShaderVariant();
                var                                   shaderPath = AssetDatabase.GUIDToAssetPath(shader);
                sv.shader = AssetDatabase.LoadAssetAtPath<Shader>(shaderPath);
                toolSVC.Add(sv);
                allShaderNameList.Add(shaderPath);
            }

            if (File.Exists(TOOLS_SVC_PATH)) AssetDatabase.DeleteAsset(TOOLS_SVC_PATH);
            AssetDatabase.CreateAsset(toolSVC, TOOLS_SVC_PATH);

            var paths   = new [] {GlobalConfig.DynamicResPrePath};
            var assets  = AssetDatabase.FindAssets("t:Prefab", paths).ToList();
            assets.AddRange(AssetDatabase.FindAssets("t:Material", paths));

            var allMats = new List<string>();
            var count = assets.Count;
            for (var i = 0; i < count; ++i)
            {
                var p = AssetDatabase.GUIDToAssetPath(assets[i]);
                UnityEditor.EditorUtility.DisplayProgressBar($"查找引用mat的资源 {i}/{count}", $"处理:{p}", i * 1.0f / count);
                var dependenciesPath = AssetDatabase.GetDependencies(p, true);
                var mats             = dependenciesPath.ToList().FindAll(x => x.EndsWith(".mat"));
                allMats.AddRange(mats);
            }
            allMats = allMats.Distinct().ToList();
            UnityEditor.EditorUtility.ClearProgressBar();

            count = allMats.Count;
            for (var i = 0; i < count; ++i)
            {
                var matObj = AssetDatabase.LoadMainAssetAtPath(allMats[i]);
                if (!(matObj is Material mat)) continue;
                UnityEditor.EditorUtility.DisplayProgressBar($"处理mat {i}/{count}", $"处理:{mat.name} - {mat.shader.name}", i * 1.0f / count);
                AddToDict(mat);
            }
            UnityEditor.EditorUtility.ClearProgressBar();

            var svc = new ShaderVariantCollection();
            foreach (var _sv in ShaderVariantDict.SelectMany(item => item.Value))
            {
                svc.Add(_sv);
            }

            AssetDatabase.DeleteAsset(ALL_SHADER_VARAINT_PATH);
            AssetDatabase.CreateAsset(svc, ALL_SHADER_VARAINT_PATH);
            AssetDatabase.Refresh();
        }


        public class ShaderData
        {
            public  int[]      PassTypes         = {};
            public  string[][] KeyWords          = {};
            public  string[]   ReMainingKeyWords = {};
        }

        /// <summary>
        /// 添加到Dictionary
        /// </summary>
        /// <param name="curMat"></param>
        static void AddToDict(Material curMat)
        {
            if (!curMat || !curMat.shader) return;

            var path = AssetDatabase.GetAssetPath(curMat.shader);
            if (!allShaderNameList.Contains(path))
            {
                Framework.Log.Editor.E("不存在shader: {0}, {1}", curMat.shader.name, path);
                return;
            }

            ShaderDataDict.TryGetValue(curMat.shader.name, out var sd);
            if (sd == null)
            {
                //一次性取出所有的 passtypes 和  keywords
                sd                                 = GetShaderKeywords(curMat.shader);
                ShaderDataDict[curMat.shader.name] = sd;
            }

            var kwCount = sd.PassTypes.Length;
            if (kwCount > 2000)
            {
                if (!passShaderList.Contains(curMat.shader.name))
                {
                    Framework.Log.Editor.I("Shader【{0}】,变体数量:{1},不建议继续分析,后续也会跳过!", curMat.shader.name, kwCount);
                    passShaderList.Add(curMat.shader.name);
                }
                else
                {
                    Framework.Log.Editor.I("mat:{0} , shader:{1} ,keywordCount:{2}", curMat.name, curMat.shader.name, kwCount);
                }

                return;
            }

            //变体增加规则：https://blog.csdn.net/RandomXM/article/details/88642534
            if (!ShaderVariantDict.TryGetValue(curMat.shader.name, out var svlist))
            {
                svlist                                = new List<ShaderVariantCollection.ShaderVariant>();
                ShaderVariantDict[curMat.shader.name] = svlist;
            }

            //求所有mat的kw
            var count = sd.PassTypes.Length;
            for (var i = 0; i < count; ++i)
            {
                var                                    pt = (PassType)sd.PassTypes[i];
                var                                    keywords = sd.KeyWords[i];
                ShaderVariantCollection.ShaderVariant  sv;
                try
                {
                    var intersectKeywords = curMat.shaderKeywords.Intersect(keywords).ToArray();
                    if (intersectKeywords.Length > 0)
                    {
                        //变体交集 大于0 ，添加到 svcList
                        sv = new ShaderVariantCollection.ShaderVariant(curMat.shader, pt, intersectKeywords);
                    }
                    else
                    {
                        sv = new ShaderVariantCollection.ShaderVariant(curMat.shader, pt);
                    }
                }
                catch (Exception e)
                {
                    Framework.Log.Editor.Exception(e);
                    Framework.Log.Editor.E("{0}-当前shader不存在变体（可以无视）:{1}-{2}",curMat.name,pt, JsonMapper.ToJson( curMat.shaderKeywords) );
                    continue;
                }

                //判断sv 是否存在,不存在则添加
                bool isContain = false;
                foreach (var val in svlist)
                {
                    if (val.passType == sv.passType && Enumerable.SequenceEqual(val.keywords, sv.keywords))
                    {
                        isContain = true;
                        break;
                    }
                }

                if (!isContain)
                {
                    svlist.Add(sv);
                }
            }
        }

        public static ShaderData GetShaderKeywords(Shader shader)
        {
            ShaderData sd = new ShaderData();
            GetShaderVariantEntriesFiltered(shader, new string[] {}, out sd.PassTypes, out sd.KeyWords, out sd.ReMainingKeyWords);
            return sd;
        }

        /// <summary>
        /// 获取keyword
        /// </summary>
        /// <param name="shader"></param>
        /// <param name="filterKeywords"></param>
        /// <param name="passTypes"></param>
        /// <param name="keywordLists"></param>
        /// <param name="remainingKeywords"></param>
        static void GetShaderVariantEntriesFiltered(
            Shader shader,
            string[] filterKeywords,
            out int[] passTypes,
            out string[][] keywordLists,
            out string[] remainingKeywords)
        {
            //2019.3接口
//            internal static void GetShaderVariantEntriesFiltered(
//                Shader                  shader,                     0
//                int                     maxEntries,                 1
//                string[]                filterKeywords,             2
//                ShaderVariantCollection excludeCollection,          3
//                out int[]               passTypes,                  4
//                out string[]            keywordLists,               5
//                out string[]            remainingKeywords)          6
            if (GetShaderVariantEntries == null)
            {
                GetShaderVariantEntries = typeof(ShaderUtil).GetMethod("GetShaderVariantEntriesFiltered", BindingFlags.NonPublic | BindingFlags.Static);
            }

            passTypes         = new int[] { };
            keywordLists      = new string[][] { };
            remainingKeywords = new string[] { };
            if (toolSVC == null) return;

            var      _passtypes         = new int[] { };
            var      _keywords          = new string[] { };
            var      _remainingKeywords = new string[] { };
            var      args               = new object[] {shader, 256, filterKeywords, toolSVC, _passtypes, _keywords, _remainingKeywords};
            GetShaderVariantEntries?.Invoke(null, args);

            if (args[4] is int[] passtypes && args[5] is string[] kws)
            {
                passTypes = passtypes;
                keywordLists = new string[passtypes.Length][];
                for (int i = 0; i < passtypes.Length; i++)
                {
                    keywordLists[i] = kws[i].Split(' ');
                }
            }

            if (args[6] is string[] rnkws) remainingKeywords = rnkws;
        }
    }
}