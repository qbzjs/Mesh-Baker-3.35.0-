/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.FirstPersonController.Items
{
    using Opsive.Shared.Utility;
    using Opsive.UltimateCharacterController.Items.Actions.PerspectiveProperties;
    using UnityEngine;

    /// <summary>
    /// Describes any first person perspective dependent properties for the magic item.
    /// </summary>
    public class FirstPersonMagicItemProperties : FirstPersonItemProperties, IMagicItemPerspectiveProperties
    {
        [Tooltip("The location that the magic originates from.")]
        [SerializeField] protected Transform m_OriginLocation;
        [Tooltip("The ID of the origin location transform. This field will be used if the value is not -1 and the origin location is null.")]
        [SerializeField] protected int m_OriginLocationID = -1;

        public Transform OriginLocation { get { return m_OriginLocation; } set { m_OriginLocation = value; } }
        [NonSerialized] public int OriginLocationID { get { return m_OriginLocationID; } set { m_OriginLocationID = value; } }

        /// <summary>
        /// Initialize the default values.
        /// </summary>
        protected override void Awake()
        {
            base.Awake();

            // The item may be added at runtime while the origin location is on the character.
            if (m_OriginLocationID != -1 && m_OriginLocation == null) {
                var firstPersonObject = GetComponent<FirstPersonPerspectiveItem>().Object;
                if (firstPersonObject != null) {
                    var objectIdentifiers = firstPersonObject.GetComponentsInChildren<Objects.ObjectIdentifier>();
                    if (objectIdentifiers.Length > 0) {
                        for (int i = 0; i < objectIdentifiers.Length; ++i) {
                            if (objectIdentifiers[i].ID == m_OriginLocationID) {
                                m_OriginLocation = objectIdentifiers[i].transform;
                                break;
                            }
                        }
                    }
                }
            }

            if (m_OriginLocation == null && m_OriginLocationID == -1) {
                m_OriginLocation = m_Character.transform;
            }
        }
    }
}