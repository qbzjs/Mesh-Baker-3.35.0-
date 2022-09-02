using System.Threading.Tasks;

namespace Hotfix.Core
{
    /// <summary>
    /// 管理器接口类
    /// </summary>
    public interface IManager
    {
        /// <summary>
        /// 构造
        /// </summary>
        Task Create();
        
        /// <summary>
        /// 销毁
        /// </summary>
        void Destroy();
    }
}