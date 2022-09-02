/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Character.Abilities
{
    using Opsive.Shared.Events;
    using Opsive.Shared.Game;
    using Opsive.Shared.Utility;
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
    using Opsive.UltimateCharacterController.Networking;
#endif
    using Opsive.UltimateCharacterController.Game;
    using Opsive.UltimateCharacterController.Objects.CharacterAssist;
    using Opsive.UltimateCharacterController.Utility;
    using UnityEngine;

    /// <summary>
    /// Ability that uses the IDriveSource interface to drive a vehicle.
    /// </summary>
    [DefaultInputName("Action")]
    [DefaultState("Drive")]
    [DefaultStartType(AbilityStartType.ButtonDown)]
    [DefaultStopType(AbilityStopType.ButtonToggle)]
    [DefaultAllowPositionalInput(false)]
    [DefaultAllowRotationalInput(false)]
    [DefaultUseRootMotionPosition(AbilityBoolOverride.True)]
    [DefaultUseRootMotionRotation(AbilityBoolOverride.True)]
    [DefaultUseGravity(AbilityBoolOverride.False)]
    [DefaultDetectHorizontalCollisions(AbilityBoolOverride.False)]
    [DefaultDetectVerticalCollisions(AbilityBoolOverride.False)]
    [DefaultAbilityIndex(14)]
    [DefaultEquippedSlots(0)]
    public class Drive : DetectObjectAbilityBase
    {
        [Tooltip("Should the character teleport for the enter and exit animations?")]
        [SerializeField] protected bool m_TeleportEnterExit;
        [Tooltip("Can the Drive ability aim?")]
        [SerializeField] protected bool m_CanAim;
        [Tooltip("The speed at which the character moves towards the seat location.")]
        [SerializeField] protected float m_MoveSpeed = 0.2f;
        [Tooltip("The speed at which the character rotates towards the seat location.")]
        [SerializeField] protected float m_RotationSpeed = 2f;
        [Tooltip("When the character enters the vehicle should the SkinnedMeshRenderer be disabled?")]
        [SerializeField] protected bool m_DisableMeshRenderers;

        public bool TeleportEnterExit { get => m_TeleportEnterExit; set => m_TeleportEnterExit = value; }
        public bool CanAim { get => m_CanAim; set => m_CanAim = value; }
        public float MoveSpeed { get => m_MoveSpeed; set => m_MoveSpeed = value; }
        public float RotationSpeed { get => m_RotationSpeed; set => m_RotationSpeed = value; }

        /// <summary>
        /// Specifies the current status of the character.
        /// </summary>
        private enum DriveState
        {
            Enter,          // The character is entering the vehicle.
            Drive,          // The character is driving the vehicle.
            Exit,           // The character is exiting the vehicle.
            ExitComplete    // The character has exited the vehicle.    
        }

        private IDriveSource m_DriveSource;
        private Transform m_OriginalParent;

        private DriveState m_DriveState;
        private Collider[] m_OverlapColliders;
        private SkinnedMeshRenderer[] m_SkinnedMeshRenderers;
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
        private INetworkInfo m_NetworkInfo;
#endif
        private KinematicObjectManager.UpdateLocation m_StartUpdateLocation;
        private float m_Epsilon = 0.99999f;

        public override int AbilityIntData { get { return m_DriveSource.AnimatorID + (int)m_DriveState; } }
        public override float AbilityFloatData { get { return m_CharacterLocomotion.RawInputVector.x; } }

        /// <summary>
        /// Initializes the default values.
        /// </summary>
        public override void Awake()
        {
            base.Awake();

            m_OverlapColliders = new Collider[1];
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            m_NetworkInfo = m_GameObject.GetCachedComponent<INetworkInfo>();
#endif

            EventHandler.RegisterEvent(m_GameObject, "OnAnimatorEnteredVehicle", OnEnteredVehicle);
            EventHandler.RegisterEvent(m_GameObject, "OnAnimatorExitedVehicle", OnExitedVehicle);
        }

        /// <summary>
        /// Validates the object to ensure it is valid for the current ability.
        /// </summary>
        /// <param name="obj">The object being validated.</param>
        /// <param name="raycastHit">The raycast hit of the detected object. Will be null for trigger detections.</param>
        /// <returns>True if the object is valid. The object may not be valid if it doesn't have an ability-specific component attached.</returns>
        protected override bool ValidateObject(GameObject obj, RaycastHit? raycastHit)
        {
            if (!base.ValidateObject(obj, raycastHit)) {
                return false;
            }

            m_DriveSource = obj.GetCachedParentComponent<IDriveSource>();
            if (m_DriveSource == null) {
                return false;
            }

            return true;
        }

        /// <summary>
        /// Called when the ablity is tried to be started. If false is returned then the ability will not be started.
        /// </summary>
        /// <returns>True if the ability can be started.</returns>
        public override bool CanStartAbility()
        {
            if (!base.CanStartAbility()) {
                return false;
            }

            return GetValidStartLocation() != null;
        }

        /// <summary>
        /// Returns a valid start location.
        /// </summary>
        /// <returns>A valid start location (can be null).</returns>
        protected virtual MoveTowardsLocation GetValidStartLocation()
        {
            // At least one ability start location must be on the ground and not obstructed by any object.
            var startLocations = m_DriveSource.GameObject.GetComponentsInChildren<MoveTowardsLocation>();
            for (int i = 0; i < startLocations.Length; ++i) {
                // If the start location has a collider then it should be clear of any other objects.
                var collider = startLocations[i].gameObject.GetCachedComponent<Collider>();
                if (collider == null || !ColliderOverlap(collider)) {
                    return startLocations[i];
                }
            }
            return null;
        }

        /// <summary>
        /// Is the collider overlapping with any other objects?
        /// </summary>
        /// <param name="collider">The collider to determine if it is overlapping with another object.</param>
        /// <returns>True if the collider is overlapping.</returns>
        private bool ColliderOverlap(Collider collider)
        {
            if (collider == null) {
                return true;
            }

            int hitCount;
            var colliderTransform = collider.transform;
            if (collider is CapsuleCollider) {
                Vector3 startEndCap, endEndCap;
                var capsuleCollider = collider as CapsuleCollider;
                MathUtility.CapsuleColliderEndCaps(capsuleCollider, colliderTransform.TransformPoint(capsuleCollider.center), colliderTransform.rotation, out startEndCap, out endEndCap);
                hitCount = Physics.OverlapCapsuleNonAlloc(startEndCap, endEndCap, capsuleCollider.radius * MathUtility.ColliderRadiusMultiplier(capsuleCollider), m_OverlapColliders,
                                m_CharacterLayerManager.IgnoreInvisibleCharacterWaterLayers, QueryTriggerInteraction.Ignore);
            } else if (collider is BoxCollider) {
                var boxCollider = collider as BoxCollider;
                hitCount = Physics.OverlapBoxNonAlloc(colliderTransform.TransformPoint(boxCollider.center), Vector3.Scale(boxCollider.size, colliderTransform.lossyScale) / 2,
                                    m_OverlapColliders, colliderTransform.rotation, m_CharacterLayerManager.IgnoreInvisibleCharacterWaterLayers, QueryTriggerInteraction.Ignore);
            } else { // SphereCollider.
                var sphereCollider = collider as SphereCollider;
                hitCount = Physics.OverlapSphereNonAlloc(colliderTransform.TransformPoint(sphereCollider.center), sphereCollider.radius * MathUtility.ColliderRadiusMultiplier(sphereCollider),
                                        m_OverlapColliders, m_CharacterLayerManager.IgnoreInvisibleCharacterWaterLayers, QueryTriggerInteraction.Ignore);
            }

            // Any overlap occurs anytime there is more one collider intersecting the colliders.
            return hitCount > 0;
        }

        /// <summary>
        /// Returns the possible MoveTowardsLocations that the character can move towards.
        /// </summary>
        /// <returns>The possible MoveTowardsLocations that the character can move towards.</returns>
        public override MoveTowardsLocation[] GetMoveTowardsLocations()
        {
            if (m_TeleportEnterExit) {
                return null;
            }
            return m_DriveSource.GameObject.GetComponentsInChildren<MoveTowardsLocation>();
        }

        /// <summary>
        /// The ability has started.
        /// </summary>
        protected override void AbilityStarted()
        {
            base.AbilityStarted();

#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            // The IDriveSource is responsible for notifying the remote players for the changes.
            if (m_NetworkInfo != null && !m_NetworkInfo.IsLocalPlayer()) {
                return;
            }
#endif

            m_OriginalParent = m_Transform.parent;
            m_StartUpdateLocation = m_CharacterLocomotion.UpdateLocation;
            // Used FixedUpdate so the root motion location is accurate when getting into the vehicle.
            m_CharacterLocomotion.UpdateLocation = KinematicObjectManager.UpdateLocation.FixedUpdate;

            m_CharacterLocomotion.SetPlatform(m_DriveSource.Transform);
            m_Transform.parent = m_DriveSource.Transform;
            m_DriveState = DriveState.Enter;
            m_DriveSource.EnterVehicle(m_GameObject);

            // Teleport the character if there are no enter/exit animations.
            if (m_TeleportEnterExit) {
                OnEnteredVehicle();
                m_CharacterLocomotion.InputVector = Vector2.zero;
                var location = m_DriveSource.DriverLocation != null ? m_DriveSource.DriverLocation : m_DriveSource.Transform;
                m_CharacterLocomotion.SetPositionAndRotation(location.position, location.rotation, true, false);
            }
            m_CharacterLocomotion.AlignToGravity = true;
        }

        /// <summary>
        /// Callback when the character has entered the vehicle.
        /// </summary>
        private void OnEnteredVehicle()
        {
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            // The IDriveSource is responsible for notifying the remote players for the changes.
            if (m_NetworkInfo != null && !m_NetworkInfo.IsLocalPlayer()) {
                return;
            }
#endif

            m_DriveSource.EnteredVehicle(m_GameObject);
            m_DriveState = DriveState.Drive;
            m_CharacterLocomotion.ForceRootMotionRotation = false;
            m_CharacterLocomotion.ForceRootMotionPosition = false;
            m_CharacterLocomotion.AllowRootMotionRotation = false;
            m_CharacterLocomotion.AllowRootMotionPosition = false;
            m_CharacterLocomotion.UpdateLocation = m_StartUpdateLocation;
            m_CharacterLocomotion.UpdateAbilityAnimatorParameters();

            // The character may not be visible within the vehicle.
            if (m_DisableMeshRenderers) {
                m_SkinnedMeshRenderers = m_GameObject.GetComponentsInChildren<SkinnedMeshRenderer>();
                for (int i = 0; i < m_SkinnedMeshRenderers.Length; ++i) {
                    m_SkinnedMeshRenderers[i].enabled = false;
                }
            }
        }

        /// <summary>
        /// Called when another ability is attempting to start and the current ability is active.
        /// Returns true or false depending on if the new ability should be blocked from starting.
        /// </summary>
        /// <param name="startingAbility">The ability that is starting.</param>
        /// <returns>True if the ability should be blocked.</returns>
        public override bool ShouldBlockAbilityStart(Ability startingAbility)
        {
            return m_AllowEquippedSlotsMask == 0 && startingAbility is Items.ItemAbility || (!m_CanAim && startingAbility is Items.Aim) || startingAbility is HeightChange;
        }

        /// <summary>
        /// Called when the current ability is attempting to start and another ability is active.
        /// Returns true or false depending on if the active ability should be stopped.
        /// </summary>
        /// <param name="activeAbility">The ability that is currently active.</param>
        /// <returns>True if the ability should be stopped.</returns>
        public override bool ShouldStopActiveAbility(Ability activeAbility)
        {
            return m_AllowEquippedSlotsMask == 0 && activeAbility is Items.ItemAbility || (!m_CanAim && activeAbility is Items.Aim);
        }

        /// <summary>
        /// Updates the ability.
        /// </summary>
        public override void Update()
        {
            // Try to stop the ability after the character has exited. The ability won't be able to be stopped if the character isn't level with the gravity direction.
            if (m_DriveState == DriveState.ExitComplete && !m_TeleportEnterExit) {
                StopAbility();
            }
        }

        /// <summary>
        /// Update the ability's Animator parameters.
        /// </summary>
        public override void UpdateAnimator()
        {
            // The horizontal input value can be used to animate the steering wheel.
            SetAbilityFloatDataParameter(m_CharacterLocomotion.RawInputVector.x, Time.deltaTime);
        }

        /// <summary>
        /// Update the controller's rotation values.
        /// </summary>
        public override void UpdateRotation()
        {
            var deltaRotation = Quaternion.identity;
            var rotation = m_Transform.rotation;
            if (m_DriveState != DriveState.Drive) {
                if (m_TeleportEnterExit) {
                    return;
                }
                var upNormal = m_DriveState == DriveState.Enter ? m_DriveSource.Transform.up : -m_CharacterLocomotion.GravityDirection;
                // When the character is entering the vehicle they should rotate to face the same up direction as the car. This allows the character to enter while on slopes.
                // Similarly, when the character exits they should rotate to the gravity direction.
                var proj = (rotation * Vector3.forward) - Vector3.Dot(rotation * Vector3.forward, upNormal) * upNormal;
                if (proj.sqrMagnitude > 0.0001f) {
                    var speed = m_RotationSpeed * m_CharacterLocomotion.TimeScale * Time.timeScale * Time.deltaTime * (m_DriveState == DriveState.ExitComplete ? 100 : 1);
                    var targetRotation = Quaternion.Slerp(rotation, Quaternion.LookRotation(proj, upNormal), speed);
                    deltaRotation = deltaRotation * (Quaternion.Inverse(rotation) * targetRotation);
                }
            } else if (m_DriveSource.DriverLocation != null) {
                // The character should fully rotate towards the target rotation after they have entered.
                deltaRotation = MathUtility.InverseTransformQuaternion(m_Transform.rotation, m_DriveSource.DriverLocation.rotation);
            }
            m_CharacterLocomotion.DeltaRotation = deltaRotation.eulerAngles;
        }

        /// <summary>
        /// Update the controller's position values.
        /// </summary>
        public override void UpdatePosition()
        {
            if (m_DriveState != DriveState.Drive || m_TeleportEnterExit || m_DriveSource.DriverLocation == null) {
                return;
            }

            m_CharacterLocomotion.MoveDirection = m_CharacterLocomotion.MotorThrottle = Vector3.zero;
            var position = m_Transform.position;
            var deltaPosition = Vector3.MoveTowards(position, m_DriveSource.DriverLocation.position, m_MoveSpeed) - position;
            var deltaTime = m_CharacterLocomotion.TimeScale * Time.timeScale * (m_CharacterLocomotion.FramerateIndependentForce ? 1 : TimeUtility.FramerateDeltaTime);
            m_CharacterLocomotion.AbilityMotor = deltaPosition / ((m_CharacterLocomotion.UsingRootMotionPosition ? 1 : deltaTime) * m_CharacterLocomotion.TimeScale);
        }

        /// <summary>
        /// Callback when the ability tries to be stopped. Start the dismount.
        /// </summary>
        public override void WillTryStopAbility()
        {
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            // The IDriveSource is responsible for notifying the remote players for the changes.
            if (m_NetworkInfo != null && !m_NetworkInfo.IsLocalPlayer()) {
                return;
            }
#endif

            if (m_DriveState != DriveState.Drive) {
                return;
            }

            // The ability can't stop if there are no valid exit locations.
            MoveTowardsLocation startLocation;
            if ((startLocation = GetValidStartLocation()) == null) {
                return;
            }

            m_DriveSource.ExitVehicle(m_GameObject);
            m_DriveState = DriveState.Exit;
            m_CharacterLocomotion.AbilityMotor = Vector3.zero;
            m_CharacterLocomotion.ForceRootMotionRotation = true;
            m_CharacterLocomotion.ForceRootMotionPosition = true;
            m_CharacterLocomotion.AllowRootMotionRotation = true;
            m_CharacterLocomotion.AllowRootMotionPosition = true;
            m_CharacterLocomotion.UpdateAbilityAnimatorParameters();

            if (m_DisableMeshRenderers && m_SkinnedMeshRenderers != null) {
                for (int i = 0; i < m_SkinnedMeshRenderers.Length; ++i) {
                    m_SkinnedMeshRenderers[i].enabled = true;
                }
            }

            // Teleport the character if there are no enter/exit animations.
            if (m_TeleportEnterExit) {
                OnExitedVehicle();
                var forward = Vector3.ProjectOnPlane(startLocation.transform.forward, -m_CharacterLocomotion.GravityDirection);
                m_CharacterLocomotion.SetPositionAndRotation(startLocation.transform.position, Quaternion.LookRotation(forward, -m_CharacterLocomotion.GravityDirection), true, false);
            }
        }

        /// <summary>
        /// Callback when the character has exited the vehicle.
        /// </summary>
        private void OnExitedVehicle()
        {
#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            // The IDriveSource is responsible for notifying the remote players for the changes.
            if (m_NetworkInfo != null && !m_NetworkInfo.IsLocalPlayer()) {
                return;
            }
#endif

            m_DriveSource.ExitedVehicle(m_GameObject);
            m_DriveState = DriveState.ExitComplete;
            m_CharacterLocomotion.UpdateAbilityAnimatorParameters();
            m_Transform.parent = m_OriginalParent;
            m_CharacterLocomotion.SetPlatform(null);
            m_CharacterLocomotion.AlignToGravity = false;
            m_CharacterLocomotion.ForceRootMotionRotation = false;
        }

        /// <summary>
        /// Can the ability be stopped?
        /// </summary>
        /// <returns>True if the ability can be stopped.</returns>
        public override bool CanStopAbility()
        {
            // The character has to be exited in order to stop.
            return m_DriveState == DriveState.ExitComplete &&
                                (m_TeleportEnterExit || Vector3.Dot(m_Transform.rotation * Vector3.up, -m_CharacterLocomotion.GravityDirection) >= m_Epsilon);
        }

        /// <summary>
        /// The ability has stopped running.
        /// </summary>
        /// <param name="force">Was the ability force stopped?</param>
        protected override void AbilityStopped(bool force)
        {
            base.AbilityStopped(force);

#if ULTIMATE_CHARACTER_CONTROLLER_MULTIPLAYER
            if (m_NetworkInfo != null && !m_NetworkInfo.IsLocalPlayer()) {
                return;
            }
#endif

            // If the drive state isn't exit complete then the ability was force stopped.
            if (m_DriveState != DriveState.ExitComplete) {
                m_DriveSource.ExitVehicle(m_GameObject);
                m_CharacterLocomotion.AbilityMotor = Vector3.zero;
                m_CharacterLocomotion.UpdateLocation = m_StartUpdateLocation;
                OnExitedVehicle();
            }
        }

        /// <summary>
        /// The character has been destroyed.
        /// </summary>
        public override void OnDestroy()
        {
            base.OnDestroy();

            EventHandler.UnregisterEvent(m_GameObject, "OnAnimatorEnteredVehicle", OnEnteredVehicle);
            EventHandler.UnregisterEvent(m_GameObject, "OnAnimatorExitedVehicle", OnExitedVehicle);
        }
    }
}