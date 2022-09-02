using System;
using System.IO;
using UnityEditor;

namespace xasset.editor
{
    public class EditorAsset : Asset
    {
        protected override void OnLoad()
        {
        }

        protected override void OnUnload()
        {
            base.OnUnload();
            subAssets = null;
            asset = null;
        }

        protected override void OnUpdate()
        {
            if (status != LoadableStatus.Loading) return;

            FinishLoad();
        }

        private void FinishLoad()
        {
            if (isSubAssets)
            {
                subAssets = AssetDatabase.LoadAllAssetRepresentationsAtPath(pathOrURL);
                Finish();
            }
            else
            {
                OnLoaded(AssetDatabase.LoadAssetAtPath(pathOrURL, type));
            }
        }

        public override void LoadImmediate()
        {
            if (isDone) return;

            FinishLoad();
        }

        internal static EditorAsset Create(string path, Type type)
        {
            if (!File.Exists(path)) throw new FileNotFoundException(path);

            return new EditorAsset
            {
                pathOrURL = path,
                type = type
            };
        }
    }
}