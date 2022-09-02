/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Traits.Damage
{
    using Opsive.Shared.Game;
    using Opsive.Shared.Utility;
    using UnityEngine;

    /// <summary>
    /// Interface for showing a damage popup.
    /// </summary>
    public interface IDamagePopup
    {
        /// <summary>
        /// Opens the popup with the specified DamageData.
        /// </summary>
        /// <param name="damageData">Specifies the damage location/amount.</param>
        void Open(DamageData damageData);

        /// <summary>
        /// Opens the popup at the specified position with the specified amount.
        /// </summary>
        /// <param name="position">The position that the popup should open at.</param>
        /// <param name="amount">The amount of damage dealt.</param>
        void Open(Vector3 position, float amount);
    }

    public class DamagePopupManager : MonoBehaviour
    {
        [Tooltip("The unique ID of the Damage Popup Manager. The Health component can specify the ID of the popup used.")]
        [SerializeField] protected uint m_ID;
        [Tooltip("The prefab for showing the damage popup.")]
        [SerializeField] protected GameObject m_DamagePrefab;
        [Tooltip("The prefab for showing the health popup.")]
        [SerializeField] protected GameObject m_HealPrefab;

        /// <summary>
        /// Initailizes the default values.
        /// </summary>
        protected virtual void Awake()
        {
            GlobalDictionary.Set(this, m_ID);
        }

        /// <summary>
        /// Opens the damage popup.
        /// </summary>
        /// <param name="damageData">The data associated with the damage.</param>
        public virtual void OpenDamagePopup(DamageData damageData)
        {
            var popupGameObject = ObjectPool.Instantiate(m_DamagePrefab, transform);
            var popup = popupGameObject.GetCachedComponent<IDamagePopup>();
            if (popup != null) {
                popup.Open(damageData);
            }
        }

        /// <summary>
        /// Opens the heal popup.
        /// </summary>
        /// <param name="health">A reference to the health component that is opening the popup.</param>
        /// <param name="amount">The amount of health restored.</param>
        public virtual void OpenHealPopup(Vector3 position, float amount)
        {
            var popupGameObject = ObjectPool.Instantiate(m_HealPrefab, transform);
            var popup = popupGameObject.GetCachedComponent<IDamagePopup>();
            if (popup != null) {
                popup.Open(position, amount);
            }
        }
    }
}