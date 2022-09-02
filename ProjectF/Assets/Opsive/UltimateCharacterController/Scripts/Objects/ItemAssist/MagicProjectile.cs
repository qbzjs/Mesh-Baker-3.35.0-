/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Objects.ItemAssist
{
    using Opsive.UltimateCharacterController.Items.Actions;
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
    using Opsive.UltimateCharacterController.Networking.Game;
#endif
    using Opsive.UltimateCharacterController.Objects;
    using UnityEngine;

    /// <summary>
    /// The ParticleProjectile extends Projectile and notifies the MagicItem when the object has collided with another object.
    /// TrajectoryObject.CollisionMode should be set to Ignore for the projectile to pass through the object.
    /// </summary>
    public class MagicProjectile : Projectile
    {
        protected MagicItem m_MagicItem;
        protected uint m_CastID;

        /// <summary>
        /// Initializes the object with the specified velocity and torque.
        /// </summary>
        /// <param name="velocity">The starting velocity.</param>
        /// <param name="torque">The starting torque.</param>
        /// <param name="originator">The object that instantiated the trajectory object.</param>
        /// <param name="magicItem">The MagicItem that created the projectile.</param>
        /// <param name="castID">The ID of the cast.</param>
        public virtual void Initialize(Vector3 velocity, Vector3 torque, GameObject originator, MagicItem magicItem, uint castID)
        {
            m_MagicItem = magicItem;
            m_CastID = castID;

            Initialize(velocity, torque, m_DamageProcessor, m_DamageAmount, m_ImpactForce, m_ImpactForceFrames, m_ImpactLayers, m_ImpactStateName, m_ImpactStateDisableTimer, m_SurfaceImpact, originator);
            if (m_Collider != null) {
                m_Collider.enabled = false;
            }
        }

        /// <summary>
        /// The object has collided with another object.
        /// </summary>
        /// <param name="hit">The RaycastHit of the object. Can be null.</param>
        protected override void OnCollision(RaycastHit? hit)
        {
            base.OnCollision(hit);

            if (!hit.HasValue) {
                return;
            }

            m_MagicItem.PerformImpact(m_CastID, m_GameObject, hit.Value.transform.gameObject, hit.Value);
        }
    }
}