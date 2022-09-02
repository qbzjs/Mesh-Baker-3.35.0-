/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Objects.ItemAssist
{
    using Opsive.Shared.Events;
    using Opsive.UltimateCharacterController.Items.Actions;
    using UnityEngine;

    /// <summary>
    /// The ShieldCollider component specifies the object that acts as a collider for the shield.
    /// </summary>
    public class ShieldCollider : MonoBehaviour
    {
        [Tooltip("A reference to the Shield item action.")]
        [SerializeField] protected Shield m_Shield;
        [Tooltip("Is the collider attached to a Shield used for the first person perspective?")]
        [HideInInspector] [SerializeField] protected bool m_FirstPersonPerspective;

        [Shared.Utility.NonSerialized] public Shield Shield { get { return m_Shield; } set { m_Shield = value; } }
        [Shared.Utility.NonSerialized] public bool FirstPersonPerspective { set { m_FirstPersonPerspective = value; } }

        private Collider m_Collider;
        private GameObject m_Character;

        /// <summary>
        /// Initialize the default values.
        /// </summary>
        private void Awake()
        {
            if (m_Shield == null) {
                Debug.LogError("Error: The shield is not assigned. Ensure the shield is created from the Item Manager.", this);
                return;
            }
            var characterLocomotion = m_Shield.gameObject.GetComponentInParent<Character.UltimateCharacterLocomotion>();
            m_Character = characterLocomotion.gameObject;
            m_Collider = GetComponent<Collider>();
            m_Collider.enabled = characterLocomotion.FirstPersonPerspective == m_FirstPersonPerspective;

            EventHandler.RegisterEvent<bool>(m_Character, "OnCharacterChangePerspectives", OnChangePerspectives);
        }

        /// <summary>
        /// The camera perspective between first and third person has changed.
        /// </summary>
        /// <param name="firstPersonPerspective">Is the camera in a first person view?</param>
        private void OnChangePerspectives(bool firstPersonPerspective)
        {
            // The collider should only be enabled for the corresponding perspective.
            m_Collider.enabled = m_FirstPersonPerspective == firstPersonPerspective;
        }

        /// <summary>
        /// The object has been destroyed.
        /// </summary>
        private void OnDestroy()
        {
            EventHandler.UnregisterEvent<bool>(m_Character, "OnCharacterChangePerspectives", OnChangePerspectives);
        }
    }
}