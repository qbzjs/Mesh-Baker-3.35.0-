using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace xasset
{
    public partial class Loadable
    {
        public static readonly List<Loadable> Loading = new List<Loadable>();
        public static readonly List<Loadable> Unused = new List<Loadable>();

        private readonly Reference _reference = new Reference();
        public LoadableStatus status { get; protected set; } = LoadableStatus.Wait;
        public string pathOrURL { get; protected set; }
        public string error { get; internal set; }

        public bool isDone => status == LoadableStatus.SuccessToLoad || status == LoadableStatus.Unloaded ||
                              status == LoadableStatus.FailedToLoad;

        public float progress { get; protected set; }

        protected void Finish(string errorCode = null)
        {
            error = errorCode;
            status = string.IsNullOrEmpty(errorCode) ? LoadableStatus.SuccessToLoad : LoadableStatus.FailedToLoad;
            progress = 1;
        }

        public static void UpdateAll()
        {
            for (var index = 0; index < Loading.Count; index++)
            {
                var item = Loading[index];
                if (Updater.busy) return;

                item.Update();
                if (!item.isDone) continue;

                Loading.RemoveAt(index);
                index--;
                item.Complete();
            }

            if (Scene.IsLoadingOrUnloading()) return;
            if (Bundle.IsLoadingOrUnloading()) return;

            for (int index = 0, max = Unused.Count; index < max; index++)
            {
                var item = Unused[index];
                if (Updater.busy) break;

                if (!item.isDone) continue;

                Unused.RemoveAt(index);
                index--;
                max--;
                if (!item._reference.unused) continue;

                item.Unload();
            }
        }

        private void Update()
        {
            OnUpdate();
        }

        private void Complete()
        {
            if (status == LoadableStatus.FailedToLoad)
            {
                Logger.E("Unable to load {0} {1} with error: {2}", GetType().Name, pathOrURL, error);
                Release();
            }

            OnComplete();
        }

        protected virtual void OnUpdate()
        {
        }

        protected virtual void OnLoad()
        {
        }

        protected virtual void OnUnload()
        {
        }

        protected virtual void OnComplete()
        {
        }

        public virtual void LoadImmediate()
        {
            throw new InvalidOperationException();
        }

        protected void Load()
        {
            if (status != LoadableStatus.Wait && _reference.unused) Unused.Remove(this);

            _reference.Retain();
            Loading.Add(this);
            if (status != LoadableStatus.Wait) return;
            Logger.I("Load {0} {1}.", GetType().Name, pathOrURL);
            status = LoadableStatus.Loading;
            progress = 0;
            OnLoad();
        }

        private void Unload()
        {
            if (status == LoadableStatus.Unloaded) return;
            Logger.I("Unload {0} {1}.", GetType().Name, pathOrURL, error);
            OnUnload();
            status = LoadableStatus.Unloaded;
        }

        public void Release()
        {
            if (_reference.count <= 0)
            {
                Logger.W("Release {0} {1}.", GetType().Name, Path.GetFileName(pathOrURL));
                return;
            }

            _reference.Release();
            if (!_reference.unused) return;

            Unused.Add(this);
            OnUnused();
        }

        protected virtual void OnUnused()
        {
        }

        public static void ClearAll()
        {
            Asset.Cache.Clear();
            Bundle.Cache.Clear();
            Dependencies.Cache.Clear();
            AssetBundle.UnloadAllAssetBundles(true);
        }
    }

    public enum LoadableStatus
    {
        Wait,
        Loading,
        DependentLoading,
        SuccessToLoad,
        FailedToLoad,
        Unloaded
    }
}