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
    using UnityEngine;

    /// <summary>
    /// Draws a custom inspector for the Top Down View Type.
    /// </summary>
    [InspectorDrawer(typeof(TopDown))]
    public class TopDownInspectorDrawer : ViewTypeInspectorDrawer
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
            InspectorUtility.DrawField(target, "m_UpAxis");
            InspectorUtility.DrawFieldSlider(target, "m_FieldOfView", 1, 179);
            InspectorUtility.DrawFieldSlider(target, "m_FieldOfViewDamping", 0, 5);
            InspectorUtility.DrawField(target, "m_RotationSpeed");
            InspectorUtility.DrawField(target, "m_CollisionRadius");
            InspectorUtility.DrawField(target, "m_ViewDistance");
            InspectorUtility.DrawField(target, "m_ViewStep");
            InspectorUtility.DrawField(target, "m_VerticalLookDirection");

            var minPitchLimit = InspectorUtility.GetFieldValue<float>(target, "m_MinPitchLimit");
            var maxPitchLimit = InspectorUtility.GetFieldValue<float>(target, "m_MaxPitchLimit");
            var minValue = Mathf.Round(minPitchLimit * 100f) / 100f;
            var maxValue = Mathf.Round(maxPitchLimit * 100f) / 100f;
            InspectorUtility.MinMaxSlider(ref minValue, ref maxValue, 0, 89.99f, new GUIContent("Pitch Limit", "The min and max limit of the pitch angle (in degrees)."));
            if (minValue != minPitchLimit) {
                InspectorUtility.SetFieldValue(target, "m_MinPitchLimit", minValue);
            }
            if (minValue != maxPitchLimit) {
                InspectorUtility.SetFieldValue(target, "m_MaxPitchLimit", maxValue);
            }
            InspectorUtility.DrawField(target, "m_AllowDynamicCameraRotation");
            var dynamicRotation = InspectorUtility.GetFieldValue<bool>(target, "m_AllowDynamicCameraRotation");
            if (dynamicRotation) {
                UnityEditor.EditorGUI.indentLevel++;
                InspectorUtility.DrawField(target, "m_DesiredAngle");
                InspectorUtility.DrawField(target, "m_ChangeAngleSpeed");
                InspectorUtility.DrawField(target, "m_RotationTransitionCurve");
                UnityEditor.EditorGUI.indentLevel--;
            }
            InspectorUtility.DrawField(target, "m_AllowDynamicPitchAdjustment");
            var pitchAdjustment = InspectorUtility.GetFieldValue<bool>(target, "m_AllowDynamicPitchAdjustment");
            if (pitchAdjustment) {
                UnityEditor.EditorGUI.indentLevel++;
                InspectorUtility.DrawField(target, "m_DesiredPitch");
                InspectorUtility.DrawField(target, "m_ChangePitchSpeed");
                InspectorUtility.DrawField(target, "m_UseIndependentPitchTransition");
                var pitchTransition = InspectorUtility.GetFieldValue<bool>(target, "m_UseIndependentPitchTransition");
                if (pitchTransition) {
                    InspectorUtility.DrawField(target, "m_PitchTransitionCurve");
                }
                UnityEditor.EditorGUI.indentLevel--;
            }
            InspectorUtility.DrawField(target, "m_AllowDynamicDistanceAdjustment");
            var distanceAdjustment = InspectorUtility.GetFieldValue<bool>(target, "m_AllowDynamicDistanceAdjustment");
            if (pitchAdjustment) {
                UnityEditor.EditorGUI.indentLevel++;
                InspectorUtility.DrawField(target, "m_DesiredDistance");
                InspectorUtility.DrawField(target, "m_ChangeDistanceSpeed");
                InspectorUtility.DrawField(target, "m_UseIndependentDistanceTransition");
                var distanceTransition = InspectorUtility.GetFieldValue<bool>(target, "m_UseIndependentDistanceTransition");
                if (distanceTransition) {
                    InspectorUtility.DrawField(target, "m_DistanceTransitionCurve");
                }
                UnityEditor.EditorGUI.indentLevel--;
            }
            if (Shared.Editor.Inspectors.Utility.InspectorUtility.Foldout(target, "Secondary Spring")) {
                UnityEditor.EditorGUI.indentLevel++;
                InspectorUtility.DrawSpring(target, "Secondary Position Spring", "m_SecondaryPositionSpring");
                InspectorUtility.DrawSpring(target, "Secondary Rotation Spring", "m_SecondaryRotationSpring");
                UnityEditor.EditorGUI.indentLevel--;
            }
        }
    }
}