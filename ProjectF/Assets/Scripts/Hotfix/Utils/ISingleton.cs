using System;

namespace Hotfix.Utils
{
    public abstract class ISingleton<TEntry>
        where TEntry : class, new()
    {
        protected ISingleton() {}

        private static TEntry _instance;

        public static TEntry Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = Activator.CreateInstance(typeof(TEntry)) as TEntry;
                }

                return _instance;
            }

            private set {}
        }
    }
}