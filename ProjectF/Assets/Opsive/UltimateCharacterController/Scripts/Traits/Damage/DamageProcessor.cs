/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Traits.Damage
{
    using Opsive.Shared.Game;
    using UnityEngine;

    /// <summary>
    /// Container class which holds the data associated with damaging a target.
    /// </summary>
    public class DamageData
    {
        [Tooltip("The object that caused the damage.")]
        protected IDamageOriginator m_DamageOriginator;
        [Tooltip("The object that is the target.")]
        protected IDamageTarget m_DamageTarget;
        [Tooltip("The amount of damage that should be dealt.")]
        protected float m_Amount;
        [Tooltip("The hit position.")]
        protected Vector3 m_Position;
        [Tooltip("The hit direction.")]
        protected Vector3 m_Direction;
        [Tooltip("The magnitude of the damage force.")]
        protected float m_ForceMagnitude;
        [Tooltip("The number of frames that the force should be applied over.")]
        protected int m_Frames;
        [Tooltip("The radius of the force.")]
        protected float m_Radius;
        [Tooltip("The collider that was hit.")]
        protected Collider m_HitCollider;
        [Tooltip("Object allowing custom user data.")]
        protected object m_UserData;

        public IDamageOriginator DamageOriginator { get => m_DamageOriginator; set => m_DamageOriginator = value; }
        public IDamageTarget DamageTarget { get => m_DamageTarget; set => m_DamageTarget = value; }
        public float Amount { get => m_Amount; set => m_Amount = value; }
        public Vector3 Position { get => m_Position; set => m_Position = value; }
        public Vector3 Direction { get => m_Direction; set => m_Direction = value; }
        public float ForceMagnitude { get => m_ForceMagnitude; set => m_ForceMagnitude = value; }
        public int Frames { get => m_Frames; set => m_Frames = value; }
        public float Radius { get => m_Radius; set => m_Radius = value; }
        public Collider HitCollider { get => m_HitCollider; set => m_HitCollider = value; }
        public object UserData { get => m_UserData; set => m_UserData = value; }

        /// <summary>
        /// Initializes the DamageData to the spciefied parameters.
        /// </summary>
        public virtual void SetDamage(float amount, Vector3 position, Vector3 direction, float forceMagnitude, int frames, float radius, GameObject attacker, object attackerObject, Collider hitCollider)
        {
            m_DamageOriginator = new DefaultDamageOriginator()
            {
                Owner = attacker,
                OriginatingGameObject = (attackerObject is MonoBehaviour) ? (attackerObject as MonoBehaviour).gameObject : (attackerObject is GameObject ? (attackerObject as GameObject) : null)
            };
            m_Amount = amount;
            m_Position = position;
            m_Direction = direction;
            m_ForceMagnitude = forceMagnitude;
            m_Frames = frames;
            m_Radius = radius;
            m_HitCollider = hitCollider;
        }

        /// <summary>
        /// Initializes the DamageData to the spciefied parameters.
        /// </summary>
        public virtual void SetDamage(IDamageOriginator damageOriginator, float amount, Vector3 position, Vector3 direction, float forceMagnitude, int frames, float radius, Collider hitCollider)
        {
            m_DamageOriginator = damageOriginator;
            m_Amount = amount;
            m_Position = position;
            m_Direction = direction;
            m_ForceMagnitude = forceMagnitude;
            m_Frames = frames;
            m_Radius = radius;
            m_HitCollider = hitCollider;
        }

        /// <summary>
        /// Copies the specified DamageData to the current object.
        /// </summary>
        /// <param name="damageData">The DamageData that should be copied.</param>
        public virtual void Copy(DamageData damageData)
        {
            m_DamageOriginator = damageData.DamageOriginator;
            m_Amount = damageData.Amount;
            m_Position = damageData.Position;
            m_Direction = damageData.Direction;
            m_ForceMagnitude = damageData.ForceMagnitude;
            m_Frames = damageData.Frames;
            m_Radius = damageData.Radius;
            m_HitCollider = damageData.HitCollider;
            m_UserData = damageData.UserData;
        }
    }

    /// <summary>
    /// Specifies an object that can cause damage.
    /// </summary>
    public interface IDamageOriginator
    {
        // The GameObject that causes damage.
        GameObject Owner { get; }
        // The GameObject that originates the damage. This can be different from the Owner in that it can be the IUsableItem.
        GameObject OriginatingGameObject { get; }
    }
    
    /// <summary>
    /// Default implementation of IDamageOriginator.
    /// </summary>
    public struct DefaultDamageOriginator : IDamageOriginator
    {
        // The GameObject that causes damage.
        public GameObject Owner { get; set; }
        // The GameObject that originates the damage. This can be different from the Owner in that it can be the IUsableItem.
        public GameObject OriginatingGameObject { get; set; }
    }

    /// <summary>
    /// Specifies an object that can receive damage.
    /// </summary>
    public interface IDamageTarget
    {
        // The GameObject that receives damage.
        GameObject Owner { get; }
        // The GameObject that was hit. This can be a child of the Owner.
        GameObject HitGameObject { get; }

        /// <summary>
        /// Damages the object.
        /// </summary>
        /// <param name="damageData">The damage received.</param>
        void Damage(DamageData damageData);

        /// <summary>
        /// Is the object alive?
        /// </summary>
        /// <returns>True if the object is alive.</returns>
        bool IsAlive();
    }

    /// <summary>
    /// A ScriptableObject which applies the damage to the IDamageTarget.
    /// </summary>
    public class DamageProcessor : ScriptableObject
    {
        private static DamageProcessor m_Default;
        public static DamageProcessor Default {
            get
            {
                if (m_Default == null) {
                    m_Default = CreateInstance<DamageProcessor>();
                }

                return m_Default;
            }
        }

        /// <summary>
        /// Processes the DamageData on the DamageTarget.
        /// </summary>
        /// <param name="target">The object receiving the damage.</param>
        /// <param name="damageData">The damage data to be applied to the target.</param>
        public virtual void Process(IDamageTarget target, DamageData damageData)
        {
            target.Damage(damageData);
        }
    }

    /// <summary>
    /// A small utility class which retrieves the IDamageTarget.
    /// </summary>
    public static class DamageUtility
    {
        /// <summary>
        /// Returns the IDamageTarget on the specified GameObject.
        /// </summary>
        /// <param name="gameObject">The GameObject that contains the IDamageTarget.</param>
        /// <returns>The IDamageTarget on the specified GameObject.</returns>
        public static IDamageTarget GetDamageTarget(GameObject gameObject)
        {
            var damageTarget = gameObject.GetCachedParentComponent<IDamageTarget>();
            if (damageTarget != null) {
                return damageTarget;
            }
            damageTarget = gameObject.GetCachedComponent<IDamageTarget>();
            return damageTarget;
        }
    }
}