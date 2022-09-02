namespace xasset.editor
{
    public class BuildAutoGroupBundles : BuildBundles
    {
        private BuildRule rule;

        public BuildAutoGroupBundles(BuildTask task, BuildRule rule) : base(task, rule.GetOptions())
        {
            this.rule = rule;
        }

        protected override void CreateBundles()
        {
            bundles.Clear();
            bundles.AddRange(rule.GetManifestBundles(rule.Build(true)));
        }
    }
}