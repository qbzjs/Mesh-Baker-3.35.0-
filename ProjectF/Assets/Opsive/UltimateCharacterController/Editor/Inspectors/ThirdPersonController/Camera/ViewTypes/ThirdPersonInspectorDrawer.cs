/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Editor.Inspectors.ThirdPersonController.Camera.ViewTypes
{
    using Opsive.Shared.Editor.Inspectors;
    using Opsive.UltimateCharacterController.Editor.Inspectors.Camera;
    using Opsive.UltimateCharacterController.Editor.Inspectors.Utility;
    using Opsive.UltimateCharacterController.ThirdPersonController.Camera.ViewTypes;
    using UnityEditor;
    using UnityEngine;

    /// <summary>
    /// Draws a custom inspector for the Third Person View Type.
    /// </summary>
    [InspectorDrawer(typeof(ThirdPerson))]
    public class ThirdPersonInspectorDrawer : ViewTypeInspectorDrawer
    {
        /// <summary>
        /// Called when the object should be drawn to the inspector.
        /// </summary>
        /// <param name="target">The object that is being drawn.</param>
        /// <param name="parent">The Unity Object that the object belongs to.</param>
        public override void OnInspectorGUI(object target, Object parent)
        {
            InspectorUtility.DrawField(target, "m_LookDirectionDistance");
            InspectorUtility.DrawField(target, "m_ForwardAxis");
            InspectorUtility.DrawField(target, "m_LookOffset");
            InspectorUtility.DrawField(target, "m_LookOffsetSmoothing");
            InspectorUtility.DrawField(target, "m_PositionSmoothing");
            InspectorUtility.DrawField(target, "m_ObstructionPositionSmoothing");
            InspectorUtility.DrawField(target, "m_UpdateCharacterRotation");
            InspectorUtility.DrawFieldSlider(target, "m_AlignToGravityRotationSpeed", 0, 1);
            InspectorUtility.DrawFieldSlider(target, "m_FieldOfView", 1, 179);
            InspectorUtility.DrawFieldSlider(target, "m_FieldOfViewDamping", 0, 5);
            InspectorUtility.DrawField(target, "m_CollisionRadius");
            InspectorUtility.DrawField(target, "m_CollisionAnchorOffset");
            if (Shared.Editor.Inspectors.Utility.InspectorUtility.Foldout(target, "Primary Spring")) {
                EditorGUI.indentLevel++;
                InspectorUtility.DrawSpring(target, "Position Spring", "m_PositionSpring");
                InspectorUtility.DrawSpring(target, "Rotation Spring", "m_RotationSpring");
                EditorGUI.indentLevel--;
            }

            if (Shared.Editor.Inspectors.Utility.InspectorUtility.Foldout(target, "Secondary Spring")) {
                EditorGUI.indentLevel++;
                InspectorUtility.DrawSpring(target, "Position Spring", "m_SecondaryPositionSpring");
                InspectorUtility.DrawSpring(target, "Rotation Spring", "m_SecondaryRotationSpring");
                EditorGUI.indentLevel--;
            }

            if (Shared.Editor.Inspectors.Utility.InspectorUtility.Foldout(target, "Step Zoom")) {
                EditorGUI.indentLevel++;
                InspectorUtility.DrawField(target, "m_StepZoomInputName");
                InspectorUtility.DrawField(target, "m_StepZoomSensitivity");
                InspectorUtility.DrawField(target, "m_MinStepZoom");
                InspectorUtility.DrawField(target, "m_MaxStepZoom");
                EditorGUI.indentLevel--;
            }

            if (Shared.Editor.Inspectors.Utility.InspectorUtility.Foldout(target, "Limits")) {
                EditorGUI.indentLevel++;
                OnDrawLimits(target);
                EditorGUI.indentLevel--;
            }
        }

        /// <summary>
        /// Callback which draws the limits for the view type.
        /// </summary>
        /// <param name="target">The object that is being drawn.</param>
        protected virtual void OnDrawLimits(object target)
        {
            var minLimit = InspectorUtility.GetFieldValue<float>(target, "m_MinAlignToGroundRollLimit");
            var maxLimit = InspectorUtility.GetFieldValue<float>(target, "m_MaxAlignToGroundRollLimit");
            var minValue = Mathf.Round(minLimit * 100f) / 100f;
            var maxValue = Mathf.Round(maxLimit * 100f) / 100f;
            InspectorUtility.MinMaxSlider(ref minValue, ref maxValue, -180, 180, new GUIContent("Align To Ground Roll Limit", "The min and max limit of the Align to Ground Roll angle (in degrees)."));
            if (minValue != minLimit) {
                InspectorUtility.SetFieldValue(target, "m_MinAlignToGroundRollLimit", minValue);
            }
            if (minValue != maxLimit) {
                InspectorUtility.SetFieldValue(target, "m_MaxAlignToGroundRollLimit", maxValue);
            }

            minLimit = InspectorUtility.GetFieldValue<float>(target, "m_MinPitchLimit");
            maxLimit = InspectorUtility.GetFieldValue<float>(target, "m_MaxPitchLimit");
            minValue = Mathf.Round(minLimit * 100f) / 100f;
            maxValue = Mathf.Round(maxLimit * 100f) / 100f;
            InspectorUtility.MinMaxSlider(ref minValue, ref maxValue, -90, 90, new GUIContent("Pitch Limit", "The min and max limit of the pitch angle (in degrees)."));
            if (minValue != minLimit) {
                InspectorUtility.SetFieldValue(target, "m_MinPitchLimit", minValue);
            }
            if (minValue != maxLimit) {
                InspectorUtility.SetFieldValue(target, "m_MaxPitchLimit", maxValue);
            }
        }
    }
}