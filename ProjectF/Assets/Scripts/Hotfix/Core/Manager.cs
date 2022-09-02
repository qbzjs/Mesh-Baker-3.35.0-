using System;
using System.Threading.Tasks;
using Hotfix.Core.Resource;
using Hotfix.Utils;
using UniRx;

namespace Hotfix.Core
{
    public class Manager : ISingleton<Manager>
    {
        private IDisposable updateDisposable;
        
        /// <summary>
        /// 资源管理器
        /// </summary>
        public static ResourceManager GResourceManager { get; private set; }
        

        public async void StartUp()
        {
            await Build();
            //
            updateDisposable = Observable.EveryUpdate().Subscribe(Update);
            // GLifeCycleManager.Start();
        }

        public void Destroy()
        {
            updateDisposable.Dispose();
        }

        private async Task Build()
        {
            // Utils.ProtobufHelper.AutoRegisterProtocol();
            // await BuildManagers();
            // Features.Manager.Instance.Build();
        }
        
        private void Update(long time)
        {
            try
            {
                // if (updateList != null)
                // {
                //     foreach (var manager in updateList)
                //     {
                //         manager.Update(Time.deltaTime, Time.unscaledDeltaTime);
                //     }
                // }

                // Features.Manager.Instance.Update(Time.deltaTime, Time.unscaledDeltaTime);
                // Flowcharts.Manager.Update();
            }
            catch (Exception e)
            {
                // Log.System.Exception(e);
            }
        }
    }
}