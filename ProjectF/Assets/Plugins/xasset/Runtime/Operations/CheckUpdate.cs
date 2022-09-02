using System.Collections.Generic;
using System.IO;

namespace xasset
{
    /// <summary>
    ///     检查版本更新，先下载 versions.json 文件，同步后根据改文件记录的版本信息更新和下载清单文件。
    /// </summary>
    public sealed class CheckUpdate : Operation
    {
        private readonly List<BuildVersion> _changes = new List<BuildVersion>();
        private Download _download;
        private BuildVersions versions;

        /// <summary>
        ///     需要更新的大小,
        ///     小于0表示版本已最新, 包含所有前台下载的文件都已是最新
        ///     竽于0表示版本清单已是最新,但是前台资源有可能非最新,所有文件需要重新校验一次
        ///     大于0表示需要更新版本清单是旧的，前台下载文件必然也是旧的，
        /// </summary>
        public long downloadSize { get; private set; }

        public string url { get; set; }

        /// <summary>
        ///     下载更新的内容。
        /// </summary>
        /// <returns></returns>
        public DownloadFiles DownloadAsync()
        {
            var infos = _changes.ConvertAll(input => Versions.GetDownloadInfo(input.file, input.hash, input.size));
            var downloadFiles = Versions.DownloadAsync(infos.ToArray(), true);
            downloadFiles.completed = operation => { ApplyChanges(); };
            return downloadFiles;
        }

        public void SaveServerVersion()
        {
            if (Versions.OfflineMode) return;
            File.Copy(_download.info.savePath, Downloader.GetDownloadDataPath(Versions.Filename), true);
            Versions.UpdateTimestamp(versions);
            Versions.UpdateVersionCode();
        }

        /// <summary>
        ///     加载下载后的版本文件。
        /// </summary>
        private void ApplyChanges()
        {
            foreach (var version in _changes)
                // 加载没有加载且已经下载到本地的版本文件。
                if (Versions.Changed(version) && Versions.Exist(version))
                    Versions.LoadVersion(version);

            _changes.Clear();
        }

        public override void Start()
        {
            base.Start();
            if (Versions.OfflineMode)
            {
                Finish();
                return;
            }

            if (string.IsNullOrEmpty(url)) url = Downloader.GetDownloadURL(Versions.Filename);

            var savePath = PathManager.GetTemporaryPath(Versions.Filename);
            if (File.Exists(savePath)) File.Delete(savePath);

            //TODO: 版本文件比较重要，这里最好加上 hash 校验。
            _download = Download.DownloadAsync(url, savePath);
        }

        protected override void Update()
        {
            if (status != OperationStatus.Processing) return;

            if (!_download.isDone) return;

            if (_download.status == DownloadStatus.Success)
            {
                downloadSize = -1;
                versions = BuildVersions.Load(_download.info.savePath);
                // 下载版本比本地版本新才加载
                if (versions.timestamp > Versions.Timestamp)
                {
                    downloadSize = 0;
                    foreach (var item in versions.data)
                    {
                        if (Versions.Exist(item)) continue;

                        downloadSize += item.size;
                        _changes.Add(item);
                    }
                }

                Finish();
            }
            else
            {
                Finish(_download.error);
            }
        }
    }
}