using System;
using System.Collections.Generic;
using UnityEngine;
 
namespace xasset
{
    public class WeakRef
    {
        private static Dictionary<Loadable, WeakRef> weakRefs = new Dictionary<Loadable, WeakRef>();

        private List<WeakReference> _references;
 
        public bool Unused => GetReferenceCount() <= 0;

        public WeakRef()
        {
            _references = new List<WeakReference>();
        }
 
        public static void UpdateAll()
        {
            var keys = new List<Loadable>(weakRefs.Keys);
            foreach (var asset in keys)
            {
                var weakRef = weakRefs[asset];
                if (weakRef == null || !weakRef.Unused) continue;

                weakRefs.Remove(asset);
                asset.Release();
            }
        }

        public static void ClearAll()
        {
            foreach (var pair in weakRefs)
            {
                pair.Key.Release();
            }
            weakRefs.Clear();
        }

        public static bool TryGetValue(Loadable loadable, out WeakRef weakRef)
        {
            return weakRefs.TryGetValue(loadable, out weakRef);
        }

        public static WeakRef Add(Loadable loadable)
        {
            var weakRef = new WeakRef();
            weakRefs.Add(loadable, weakRef);
            return weakRef;
        }

        public void Retain(object owner)
        {
            if (owner == null)
            {
                Logger.E("owner is null");
                return;
            }
 
            var count = _references.Count;
            for (var i = 0; i < count; i++)
            {
                if (owner.Equals(_references[i].Target))
                {
                    return;
                }
            }
 
            WeakReference weakReference = new WeakReference(owner);
            _references.Add(weakReference);
        }
 
        public void Release(object owner)
        {
            if (owner == null)
            {
                Logger.E("owner is null");
                return;
            }
 
            int count = _references.Count;
            for (int i = 0; i < count; i++)
            {
                if (owner.Equals(_references[i].Target))
                {
                    _references.RemoveAt(i);
                    break;
                }
            }
        }
 
        private int GetReferenceCount()
        {
            var count = 0;
            for (var j = 0; j < _references.Count; j++)
            {
                switch (_references[j].Target)
                {
                    case null:
                        continue;
                    case GameObject go when go != null:
                        count++;
                        break;
                    case GameObject _:
                        //Target不为null,go为null，特殊处理
                        _references.RemoveAt(j);
                        j--;
                        break;
                    default:
                        count++;
                        break;
                }
            }
            return count;
        }
 
        public void Reset()
        {
            _references.Clear();
        }
    }
}