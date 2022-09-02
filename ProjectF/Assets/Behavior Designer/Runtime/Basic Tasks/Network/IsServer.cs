#if !(UNITY_4_6 || UNITY_4_7 || UNITY_5_0)
using UnityEngine;
using UnityEngine.Networking;

namespace BehaviorDesigner.Runtime.Tasks.Basic.UnityNetwork
{
    public class IsServer : Conditional
    {
        public override TaskStatus OnUpdate()
        {
            // return NetworkServer.active ? TaskStatus.Success : TaskStatus.Failure;
            return TaskStatus.Success;
        }
    }
}
#endif