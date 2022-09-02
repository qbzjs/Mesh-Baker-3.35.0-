using System.Collections.Generic;

namespace xasset
{
    public partial class Loadable 
    {
        public void BindAutoRelease(UnityEngine.Object owner)
        {
            if (!WeakRef.TryGetValue(this, out var weakRef))
            {
                _reference.Retain();
                weakRef = WeakRef.Add(this);
            }

            _reference.Release();
            if (owner == null)
            {
                Logger.I("Bind null owner for asset {0}", pathOrURL);
            }

            if (_reference.count < 1)
            {
                Logger.E("reference must great than 1, because AutoRelease retain");
            }

            weakRef.Retain(owner);
        }
    }
}