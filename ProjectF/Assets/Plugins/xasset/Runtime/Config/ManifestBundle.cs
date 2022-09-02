using System;
using System.Collections.Generic;

namespace xasset
{
    [Serializable]
    public class ManifestBundle
    {
        public int id;
        public string name;
        public long size;
        public string hash;
        public int[] deps;
        public List<string> assets { get; set; }
        public string nameWithAppendHash { get; set; }
    }
}