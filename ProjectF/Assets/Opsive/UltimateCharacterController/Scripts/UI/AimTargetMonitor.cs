namespace Opsive.UltimateCharacterController.UI
{
    using Opsive.Shared.Events;
    using Opsive.Shared.Game;
    using Opsive.UltimateCharacterController.Camera;
    using Opsive.UltimateCharacterController.Character;
    using UnityEngine;
    using UnityEngine.UI;

    /// <summary>
    /// The component is used to show the target being selected (usually by the CombatAimAssist ability).
    /// </summary>
    public class AimTargetMonitor : CharacterMonitor
    {
        [Tooltip("The aim image that will move on screen space to point at the target.")]
        [SerializeField] protected Image m_AimImage;
        [Tooltip("The Screen space offset for the image.")]
        [SerializeField] protected Vector2 m_ScreenSpaceOffset;
        [Tooltip("The soft aim icon.")]
        [SerializeField] protected Sprite m_SoftAimIcon;
        [Tooltip("The locked aim icon.")]
        [SerializeField] protected Sprite m_LockedAimIcon;
        [Tooltip("The default color of the soft aim icon.")]
        [SerializeField] protected Color m_SoftAimColor = Color.white;
        [Tooltip("The color of the aim icon a target locked.")]
        [SerializeField] protected Color m_LockedAimColor = Color.red;

        protected UltimateCharacterLocomotion m_CharacterLocomotion;
        protected Camera m_Camera;
        protected AimAssist m_AimAssist;
        protected RectTransform m_CanvasRectTransform;
        protected Transform m_CurrentTarget;
        protected bool m_SoftAim;
        protected bool m_LockedAim;
        
        /// <summary>
        /// Initialize the default values.
        /// </summary>
        protected override void Awake()
        {
            base.Awake();

            m_CanvasRectTransform = GetComponentInParent<Canvas>().GetComponent<RectTransform>();
            if (m_AimImage == null) {
                m_AimImage = GetComponent<Image>();
            }
            m_AimImage.gameObject.SetActive(false);
        }
        
        /// <summary>
        /// Attaches the monitor to the specified character.
        /// </summary>
        /// <param name="character">The character to attach the monitor to.</param>
        protected override void OnAttachCharacter(GameObject character)
        {
            if (m_Character != null) {
                EventHandler.UnregisterEvent<Transform, bool>(m_Character, "OnCombatAimTargetChange", OnAimTargetChange);
            }

            base.OnAttachCharacter(character);

            if (m_Character == null) {
                return;
            }

            m_Camera = Shared.Camera.CameraUtility.FindCamera(m_Character);

            m_AimAssist = m_Camera.GetComponent<AimAssist>();
            m_CharacterLocomotion = m_Character.GetCachedComponent<UltimateCharacterLocomotion>();
            m_SoftAim = false;
            m_LockedAim = false;
            gameObject.SetActive(CanShowUI());

            EventHandler.RegisterEvent<Transform, bool>(m_Character, "OnCombatAimTargetChange", OnAimTargetChange);
        }

        /// <summary>
        /// When the aim target changes the UI should change the icon.
        /// </summary>
        /// <param name="newTarget">The new target.</param>
        /// <param name="locked">Is the target locked?</param>
        private void OnAimTargetChange(Transform newTarget, bool locked)
        {
            if (newTarget == null) {
                m_LockedAim = false;
                m_SoftAim = false;
                m_CurrentTarget = null;
                return;
            }

            m_CurrentTarget = newTarget;
            m_SoftAim = !locked;
            m_LockedAim = locked;
        }

        /// <summary>
        /// Determine the position the image should have to point at the target.
        /// </summary>
        private void LateUpdate()
        {
            if (m_LockedAim == false && m_SoftAim == false) {
                m_AimImage.gameObject.SetActive(false);
                return;
            }

            if (m_LockedAim) {
                if (m_LockedAimIcon == null) {
                    m_AimImage.gameObject.SetActive(false);
                    return;
                }
                m_AimImage.gameObject.SetActive(true);
                m_AimImage.sprite = m_LockedAimIcon;
                m_AimImage.color = m_LockedAimColor;
                
            } else {
                if (m_SoftAimIcon == null) {
                    m_AimImage.gameObject.SetActive(false);
                    return;
                }
                m_AimImage.gameObject.SetActive(true);
                m_AimImage.sprite = m_SoftAimIcon;
                m_AimImage.color = m_SoftAimColor;
            }

            var screenPoint = m_Camera.WorldToScreenPoint(m_CurrentTarget.position);
            var proportionalPosition = new Vector2(screenPoint.x, screenPoint.y) - (m_CanvasRectTransform.sizeDelta / 2f);
            m_AimImage.rectTransform.anchoredPosition = proportionalPosition - m_ScreenSpaceOffset;
        }
    }
}