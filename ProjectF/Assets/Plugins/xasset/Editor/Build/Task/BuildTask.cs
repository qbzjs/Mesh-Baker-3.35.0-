using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using UnityEditor;
using UnityEngine;
using Debug = UnityEngine.Debug;

namespace xasset.editor
{
    public class BuildTask
    {
        public readonly List<ManifestBundle> bundles = new List<ManifestBundle>();
        public readonly List<string> changes = new List<string>();
        public readonly List<BuildTaskJob> jobs = new List<BuildTaskJob>();
        public readonly string outputPath;
        public readonly Stopwatch stopwatch = new Stopwatch();
        public int buildVersion;
        public bool forceRebuild;

        public BuildTask(int version = -1, string path = "") : this("Manifest", path)
        {
            buildVersion = version;
            var rule = BuildScript.GetRule();
            // jobs.Add(new BuildBundles(this, BuildAssetBundleOptions.ChunkBasedCompression));
            jobs.Add(new BuildAutoGroupBundles(this, rule));
            jobs.Add(new BuildVideoBundles(this, BuildAssetBundleOptions.UncompressedAssetBundle));
            jobs.Add(new BuildHotfixDllBundles(this, rule.GetOptions()));
            jobs.Add(new CreateManifest(this));
        }

        public BuildTask(string build)
        {
            name = build;
            outputPath = Settings.PlatformBuildPath;
        }

        public BuildTask(string build, string path)
        {
            name = build;
            outputPath = string.IsNullOrEmpty(path) ? Settings.PlatformBuildPath : path;
        }

        public string name { get; }

        public void Run()
        {
            stopwatch.Start();
            foreach (var job in jobs)
            {
                try
                {
                    job.Run();
                }
                catch (Exception e)
                {
                    job.error = e.Message;
                    Debug.LogException(e);
                }

                if (string.IsNullOrEmpty(job.error)) continue;
                break;
            }

            stopwatch.Stop();
            var elapsed = stopwatch.ElapsedMilliseconds / 1000f;
            Debug.LogFormat("Run BuildTask for {0} with {1}s", name, elapsed);
        }


        public string GetBuildPath(string filename)
        {
            return $"{outputPath}/{filename}";
        }

        public void SaveManifest(Manifest manifest)
        {
            var timestamp = DateTime.Now.ToFileTime();
            var filename = manifest.name.ToLower();
            var path = GetBuildPath($"{filename}.json");
            File.WriteAllText(path, JsonUtility.ToJson(manifest));
            var hash = Utility.ComputeHash(path);
            var file = $"{filename}_v{manifest.version}_{hash}.json";
            var hashPath = GetBuildPath(file);
            if (File.Exists(hashPath)) File.Delete(hashPath);
            File.Move(path, hashPath);
            changes.Add(file);
            // save version
            SaveVersion(manifest.name, file, timestamp, hash, manifest.version);
        }

        public void CheckManifest(Manifest manifest)
        {
            var count = manifest.bundles.Count;
            for (var i = 0; i < count; ++i)
            {
                var bundle = manifest.bundles[i];
                var path = GetBuildPath(bundle.nameWithAppendHash);
                if (UnityEditor.EditorUtility.DisplayCancelableProgressBar($"校验{i}/{count}", path, i * 1.0f / count)) break;

                var info = new FileInfo(path);
                if (!info.Exists)
                {
                    Logger.E("File Is Not Exist: {0}", bundle.nameWithAppendHash);
                    continue;
                }

                if (info.Length != bundle.size)
                {
                    Logger.E("File {0} Size {1} Is Mismatch With {2}", bundle.nameWithAppendHash, info.Length, bundle.size);
                    continue;
                }

                var hash = Utility.ComputeHash(path);
                if (hash != bundle.hash)
                {
                    Logger.E("File {0} Hash {1} Is Mismatch With {2}", bundle.nameWithAppendHash, hash, bundle.hash);
                    continue;
                }
            }

            UnityEditor.EditorUtility.ClearProgressBar();
        }

        private void SaveVersion(string manifestName, string file, long timestamp, string hash, int version)
        {
            var buildVersions = BuildVersions.Load(GetBuildPath(Versions.Filename));
            var info = new FileInfo(GetBuildPath(file));
            buildVersions.Set(manifestName, file, info.Length, timestamp, hash);
            File.WriteAllText(GetBuildPath(Versions.Filename), JsonUtility.ToJson(buildVersions));

            var fileName = Path.GetFileNameWithoutExtension(Versions.Filename);
            var ext = Path.GetExtension(Versions.Filename);
            File.WriteAllText(GetBuildPath($"{fileName}_v{version}{ext}"), JsonUtility.ToJson(buildVersions));
        }
    }
}