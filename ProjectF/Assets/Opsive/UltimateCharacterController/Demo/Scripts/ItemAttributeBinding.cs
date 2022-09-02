/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Demo
{
    using Opsive.Shared.Game;
    using Opsive.Shared.Events;
    using Opsive.Shared.Inventory;
    using Opsive.UltimateCharacterController.Items;
    using Opsive.UltimateCharacterController.Traits;
    using UnityEngine;

    /// <summary>
    /// Binds the item to the battery AttributeMonitor. This component requires the Attribute Monitor on the same GameObject.
    /// </summary>
    public class ItemAttributeBinding : MonoBehaviour
    {
        [Tooltip("The character that the component should listen for events on.")]
        [SerializeField] protected GameObject m_Character;
        [Tooltip("The Item Definition that should be bound to the Attribute Monitor.")]
        [SerializeField] protected ItemDefinitionBase m_ItemDefinition;

        private UltimateCharacterController.UI.AttributeMonitor m_AttributeMonitor;

        /// <summary>
        /// Initialize the default values.
        /// </summary>
        private void Awake()
        {
            m_AttributeMonitor = GetComponent<Opsive.UltimateCharacterController.UI.AttributeMonitor>();
            if (m_AttributeMonitor == null) {
                Debug.LogError("Error: The ItemAttributeBinding component must exist on the same GameObject as the AttributeMonitor.");
                return;
            }

            EventHandler.RegisterEvent<Item>(m_Character, "OnInventoryAddItem", OnAddItem);
        }

        /// <summary>
        /// The inventory has added the specified item.
        /// </summary>
        /// <param name="item">The item that was added.</param>
        private void OnAddItem(Item item)
        {
            if (item.ItemDefinition != m_ItemDefinition) {
                return;
            }

            var attributeManager = item.GetComponent<AttributeManager>();
            if (attributeManager == null) {
                return;
            }

            m_AttributeMonitor.AttributeManager = attributeManager;
        }

        /// <summary>
        /// The object has been destroyed.
        /// </summary>
        private void OnDestroy()
        {
            EventHandler.UnregisterEvent<Item>(m_Character, "OnInventoryAddItem", OnAddItem);
        }
    }
}