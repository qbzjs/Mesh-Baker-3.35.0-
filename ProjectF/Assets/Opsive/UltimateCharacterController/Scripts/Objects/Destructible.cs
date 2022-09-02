/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Objects
{
    using Opsive.Shared.Events;
    using Opsive.Shared.Game;
    using Opsive.Shared.StateSystem;
    using Opsive.Shared.Utility;
    using Opsive.UltimateCharacterController.Character;
    using Opsive.UltimateCharacterController.Events;
    using Opsive.UltimateCharacterController.Game;
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
    using Opsive.UltimateCharacterController.Networking;
    using Opsive.UltimateCharacterController.Networking.Game;
    using Opsive.UltimateCharacterController.Networking.Objects;
#endif
    using Opsive.UltimateCharacterController.Objects.ItemAssist;
    using Opsive.UltimateCharacterController.SurfaceSystem;
    using Opsive.UltimateCharacterController.Traits.Damage;
    using Opsive.UltimateCharacterController.Utility;
    using UnityEngine;

    /// <summary>
    /// The Destructible class is an abstract class which acts as the base class for any object that destroys itself and applies a damange.
    /// Primary uses include projectiles and grenades.
    /// </summary>
    [RequireComponent(typeof(Rigidbody))]
    public abstract class Destructible : TrajectoryObject, IDamageOriginator
    {
        [Tooltip("The layers that the object can stick to.")]
        [SerializeField] protected LayerMask m_StickyLayers = ~((1 << LayerManager.IgnoreRaycast) | (1 << LayerManager.Water) | (1 << LayerManager.UI) | (1 << LayerManager.VisualEffect) |
                                                                (1 << LayerManager.Overlay) | (1 << LayerManager.Character) | (1 << LayerManager.SubCharacter));
        [Tooltip("Should the projectile be destroyed when it collides with another object?")]
        [SerializeField] protected bool m_DestroyOnCollision = true;
        [Tooltip("Should the projectile be destroyed after the particle has stopped emitting?")]
        [SerializeField] protected bool m_WaitForParticleStop;
        [Tooltip("The amount of time after a collision that the object should be destroyed.")]
        [SerializeField] protected float m_DestructionDelay;
        [Tooltip("The objects which should spawn when the object is destroyed.")]
        [SerializeField] protected ObjectSpawnInfo[] m_SpawnedObjectsOnDestruction;
        [Tooltip("Unity event invoked when the destructable hits another object.")]
        [SerializeField] protected UnityFloatVector3Vector3GameObjectEvent m_OnImpactEvent;

        public GameObject Owner { get { return m_Originator; } }
        public GameObject OriginatingGameObject { get { return m_GameObject; } }
        public LayerMask StickyLayers { get { return m_StickyLayers; } set { m_StickyLayers = value; } }
        public bool DestroyOnCollision { get { return m_DestroyOnCollision; } set { m_DestroyOnCollision = value; } }
        public bool WaitForParticleStop { get { return m_WaitForParticleStop; } set { m_WaitForParticleStop = value; } }
        public float DestructionDelay { get { return m_DestructionDelay; } set { m_DestructionDelay = value; } }
        public ObjectSpawnInfo[] SpawnedObjectsOnDestruction { get { return m_SpawnedObjectsOnDestruction; } set { m_SpawnedObjectsOnDestruction = value; } }
        public UnityFloatVector3Vector3GameObjectEvent OnImpactEvent { get { return m_OnImpactEvent; } set { m_OnImpactEvent = value; } }

        protected DamageProcessor m_DamageProcessor;
        protected float m_DamageAmount;
        protected float m_ImpactForce;
        protected int m_ImpactForceFrames;
        protected string m_ImpactStateName;
        protected float m_ImpactStateDisableTimer;
        private TrailRenderer m_TrailRenderer;
        private ParticleSystem m_ParticleSystem;
        private ScheduledEventBase m_DestroyEvent;
        private bool m_Destroyed;

        private UltimateCharacterLocomotion m_StickyCharacterLocomotion;
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
        private INetworkInfo m_NetworkInfo;
        private IDestructibleMonitor m_DestructibleMonitor;
#endif

        /// <summary>
        /// Initialize the defualt values.
        /// </summary>
        protected override void Awake()
        {
            base.Awake();

            m_TrailRenderer = GetComponent<TrailRenderer>();
            if (m_TrailRenderer != null) {
                m_TrailRenderer.enabled = false;
            }
            m_ParticleSystem = GetComponent<ParticleSystem>();
            if (m_ParticleSystem != null) {
                m_ParticleSystem.Stop();
            }

            // The Rigidbody is only used to notify Unity that the object isn't static. The Rigidbody doesn't control any movement.
            var destructableRigidbody = GetComponent<Rigidbody>();
            if (destructableRigidbody != null) {
                destructableRigidbody.mass = m_Mass;
                destructableRigidbody.isKinematic = true;
                destructableRigidbody.constraints = RigidbodyConstraints.FreezeAll;
            }
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            m_NetworkInfo = GetComponent<INetworkInfo>();
            m_DestructibleMonitor = GetComponent<IDestructibleMonitor>();
#endif

            if (m_DestroyOnCollision && m_CollisionMode != CollisionMode.Collide && GetType() != typeof(MagicProjectile)) {
                Debug.LogWarning($"Warning: The Destructible {name} will be destroyed on collision but does not have a Collision Mode set to Collide.");
                m_CollisionMode = CollisionMode.Collide;
            }
        }

        /// <summary>
        /// Initializes the object. This will be called from an object creating the projectile (such as a weapon).
        /// </summary>
        /// <param name="velocity">The velocity to apply.</param>
        /// <param name="torque">The torque to apply.</param>
        /// <param name="damageProcessor">Processes the damage dealt to a Damage Target.</param>
        /// <param name="damageAmount">The amount of damage to apply to the hit object.</param>
        /// <param name="impactForce">The amount of force to apply to the hit object.</param>
        /// <param name="impactForceFrames">The number of frames to add the force to.</param>
        /// <param name="impactLayers">The layers that the projectile can impact with.</param>
        /// <param name="impactStateName">The name of the state to activate upon impact.</param>
        /// <param name="impactStateDisableTimer">The number of seconds until the impact state is disabled.</param>
        /// <param name="surfaceImpact">A reference to the Surface Impact triggered when the object hits an object.</param>
        /// <param name="originator">The object that instantiated the trajectory object.</param>
        public virtual void Initialize( Vector3 velocity, Vector3 torque, DamageProcessor damageProcessor, float damageAmount, float impactForce, int impactForceFrames, LayerMask impactLayers,
                                     string impactStateName, float impactStateDisableTimer, SurfaceImpact surfaceImpact, GameObject originator)
        {
            InitializeDestructibleProperties(damageProcessor, damageAmount, impactForce, impactForceFrames, impactLayers, impactStateName, impactStateDisableTimer, surfaceImpact);

            base.Initialize(velocity, torque, originator);
        }

        /// <summary>
        /// Initializes the destructible properties.
        /// </summary>
        /// <param name="damageProcessor">Processes the damage dealt to a Damage Target.</param>
        /// <param name="damageAmount">The amount of damage to apply to the hit object.</param>
        /// <param name="impactForce">The amount of force to apply to the hit object.</param>
        /// <param name="impactForceFrames">The number of frames to add the force to.</param>
        /// <param name="impactLayers">The layers that the projectile can impact with.</param>
        /// <param name="impactStateName">The name of the state to activate upon impact.</param>
        /// <param name="impactStateDisableTimer">The number of seconds until the impact state is disabled.</param>
        /// <param name="surfaceImpact">A reference to the Surface Impact triggered when the object hits an object.</param>
        public void InitializeDestructibleProperties(DamageProcessor damageProcessor, float damageAmount, float impactForce, int impactForceFrames, LayerMask impactLayers, string impactStateName, float impactStateDisableTimer, SurfaceImpact surfaceImpact)
        {
            m_Destroyed = false;
            if (m_DestroyEvent != null) {
                SchedulerBase.Cancel(m_DestroyEvent);
                m_DestroyEvent = null;
            }
            m_DamageProcessor = damageProcessor;
            m_DamageAmount = damageAmount;
            m_ImpactForce = impactForce;
            m_ImpactForceFrames = impactForceFrames;
            m_ImpactLayers = impactLayers;
            m_ImpactStateName = impactStateName;
            m_ImpactStateDisableTimer = impactStateDisableTimer;
            // The SurfaceImpact may be set directly on the destructible prefab.
            if (m_SurfaceImpact == null) {
                m_SurfaceImpact = surfaceImpact;
            }
            if (m_TrailRenderer != null) {
                m_TrailRenderer.Clear();
                m_TrailRenderer.enabled = true;
            }
            if (m_ParticleSystem != null) {
                m_ParticleSystem.Play();
            }
            if (m_Collider != null) {
                m_Collider.enabled = false;
            }
            // The object may be reused and was previously stuck to a character.
            if (m_StickyCharacterLocomotion != null) {
                m_StickyCharacterLocomotion.RemoveIgnoredCollider(m_Collider);
                m_StickyCharacterLocomotion = null;
            }
            enabled = true;
        }

        /// <summary>
        /// The object has collided with another object.
        /// </summary>
        /// <param name="hit">The RaycastHit of the object. Can be null.</param>
        protected override void OnCollision(RaycastHit? hit)
        {
            base.OnCollision(hit);

            var forceDestruct = false;
            if (m_CollisionMode == CollisionMode.Collide) {
                // When there is a collision the object should move to the position that was hit so if it's not destroyed then it looks like it
                // is penetrating the hit object.
                if (hit != null && hit.HasValue && m_Collider != null) {
                    var closestPoint = m_Collider.ClosestPoint(hit.Value.point);
                    m_Transform.position += (hit.Value.point - closestPoint);
                    // Only set the parent to the hit transform on uniform objects to prevent stretching.
                    if (MathUtility.IsUniform(hit.Value.transform.localScale)) {
                        // The parent layer must be within the sticky layer mask.
                        if (MathUtility.InLayerMask(hit.Value.transform.gameObject.layer, m_StickyLayers)) {
                            m_Transform.parent = hit.Value.transform;

                            // If the destructible sticks to a character then the object should be added as a sub collider so collisions will be ignored.
                            m_StickyCharacterLocomotion = hit.Value.transform.gameObject.GetCachedComponent<UltimateCharacterLocomotion>();
                            if (m_StickyCharacterLocomotion != null) {
                                m_StickyCharacterLocomotion.AddIgnoredCollider(m_Collider);
                            }
                        } else {
                            forceDestruct = true;
                        }
                    }
                }
                if (m_TrailRenderer != null) {
                    m_TrailRenderer.enabled = false;
                }
            }

            var destructionDelay = m_DestructionDelay;
            if (m_ParticleSystem != null && m_WaitForParticleStop) {
                destructionDelay = m_ParticleSystem.main.duration;
                m_ParticleSystem.Stop(true, ParticleSystemStopBehavior.StopEmitting);
                Stop();
            }

            // The object may not have been initialized before it collides.
            if (m_GameObject == null) {
                InitializeComponentReferences();
            }

            if (hit != null && hit.HasValue) {
                var hitValue = hit.Value;
                var hitGameObject = hitValue.collider.gameObject;
                // The shield can absorb some (or none) of the damage from the destructible.
                var damageAmount = m_DamageAmount;
#if ULTIMATE_CHARACTER_CONTROLLER_MELEE
                ShieldCollider shieldCollider;
                if ((shieldCollider = hitGameObject.GetCachedComponent<ShieldCollider>()) != null) {
                    damageAmount = shieldCollider.Shield.Damage(this, damageAmount);
                }
#endif

                // Allow a custom event to be received.
                EventHandler.ExecuteEvent<float, Vector3, Vector3, GameObject, object, Collider>(hitGameObject, "OnObjectImpact", damageAmount, hitValue.point, m_Velocity.normalized * m_ImpactForce, m_Originator, this, hitValue.collider);
                if (m_OnImpactEvent != null) {
                    m_OnImpactEvent.Invoke(damageAmount, hitValue.point, m_Velocity.normalized * m_ImpactForce, m_Originator);
                }

                // If the shield didn't absorb all of the damage then it should be applied to the character.
                if (damageAmount > 0) {
                    var damageTarget = DamageUtility.GetDamageTarget(hitGameObject);
                    if (damageTarget != null) {
                        var pooledDamageData = GenericObjectPool.Get<DamageData>();
                        pooledDamageData.SetDamage(this, damageAmount, hitValue.point, -hitValue.normal, m_ImpactForce, m_ImpactForceFrames, 0, hitValue.collider);
                        var damageProcessorModule = hitGameObject.GetCachedComponent<DamageProcessorModule>();
                        if (damageProcessorModule != null) {
                            damageProcessorModule.ProcessDamage(m_DamageProcessor, damageTarget, pooledDamageData);
                        } else {
                            if (m_DamageProcessor == null) { m_DamageProcessor = DamageProcessor.Default; }
                            m_DamageProcessor.Process(damageTarget, pooledDamageData);
                        }
                        GenericObjectPool.Return(pooledDamageData);
                    } else if (m_ImpactForce > 0) {
                        // If the damage target exists it will apply a force to the rigidbody in addition to procesing the damage. Otherwise just apply the force to the rigidbody. 
                        var collisionRigidbody = hitGameObject.GetCachedParentComponent<Rigidbody>();
                        if (collisionRigidbody != null && !collisionRigidbody.isKinematic) {
                            collisionRigidbody.AddForceAtPosition(m_ImpactForce * MathUtility.RigidbodyForceMultiplier * -hitValue.normal, hitValue.point);
                        } else {
                            var forceObject = hitGameObject.GetCachedParentComponent<IForceObject>();
                            if (forceObject != null) {
                                forceObject.AddForce(m_Transform.forward * m_ImpactForce);
                            }
                        }
                    }
                }

                // An optional state can be activated on the hit object.
                if (!string.IsNullOrEmpty(m_ImpactStateName)) {
                    StateManager.SetState(hitGameObject, m_ImpactStateName, true);
                    // If the timer isn't -1 then the state should be disabled after a specified amount of time. If it is -1 then the state
                    // will have to be disabled manually.
                    if (m_ImpactStateDisableTimer != -1) {
                        StateManager.DeactivateStateTimer(hitGameObject, m_ImpactStateName, m_ImpactStateDisableTimer);
                    }
                }
            }

            // The object can destroy itself after a small delay.
            if (m_DestroyEvent == null && (m_DestroyOnCollision || forceDestruct || destructionDelay > 0)) {
                m_DestroyEvent = SchedulerBase.ScheduleFixed(destructionDelay, Destruct, hit);
            }
        }

        /// <summary>
        /// Destroys the object.
        /// </summary>
        /// <param name="hit">The RaycastHit of the object. Can be null.</param>
        protected void Destruct(RaycastHit? hit)
        {
            if (m_Destroyed) {
                return;
            }

#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            // The object can only explode on the server.
            if (m_NetworkInfo != null && !m_NetworkInfo.IsServer()) {
                return;
            }
#endif
            m_DestroyEvent = null;

            // The RaycastHit will be null if the destruction happens with no collision.
            var hitPosition = (hit != null && hit.HasValue) ? hit.Value.point : m_Transform.position;
            var hitNormal = (hit != null && hit.HasValue) ? hit.Value.normal : m_Transform.up;
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            if (m_NetworkInfo != null && m_NetworkInfo.IsServer()) {
                m_DestructibleMonitor.Destruct(hitPosition, hitNormal);
            }
#endif
            Destruct(hitPosition, hitNormal);
        }

        /// <summary>
        /// Destroys the object.
        /// </summary>
        /// <param name="hitPosition">The position of the destruction.</param>
        /// <param name="hitNormal">The normal direction of the destruction.</param>
        public void Destruct(Vector3 hitPosition, Vector3 hitNormal)
        {
            for (int i = 0; i < m_SpawnedObjectsOnDestruction.Length; ++i) {
                if (m_SpawnedObjectsOnDestruction[i] == null) {
                    continue;
                }

                var spawnedObject = m_SpawnedObjectsOnDestruction[i].Instantiate(hitPosition, hitNormal, m_NormalizedGravity);
                if (spawnedObject == null) {
                    continue;
                }
                var explosion = spawnedObject.GetCachedComponent<Explosion>();
                if (explosion != null) {
                    explosion.Explode(m_DamageAmount, m_ImpactForce, m_ImpactForceFrames, m_Originator, m_GameObject);
                }
            }

            // The component and collider no longer need to be enabled after the object has been destroyed.
            if (m_Collider != null) {
                m_Collider.enabled = false;
            }
            if (m_ParticleSystem != null) {
                m_ParticleSystem.Stop();
            }
            m_Destroyed = true;
            m_DestroyEvent = null;
            enabled = false;

            // The destructible should be destroyed.
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            if (NetworkObjectPool.IsNetworkActive()) {
                // The object may have already been destroyed over the network.
                if (!m_GameObject.activeSelf) {
                    return;
                }
                NetworkObjectPool.Destroy(m_GameObject);
                return;
            }
#endif
            ObjectPoolBase.Destroy(m_GameObject);
        }

        /// <summary>
        /// The component has been disabled.
        /// </summary>
        protected override void OnDisable()
        {
            base.OnDisable();

            if (m_DestroyOnCollision && m_StickyCharacterLocomotion != null) {
                m_StickyCharacterLocomotion.RemoveIgnoredCollider(m_Collider);
                m_StickyCharacterLocomotion = null;
            }
        }
    }
}