/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Editor.Inspectors.Objects
{
    using Opsive.UltimateCharacterController.Objects;
    using UnityEditor;

    /// <summary>
    /// Custom inspector for the Destructible component.
    /// </summary>
    [CustomEditor(typeof(Destructible))]
    public class DestructibleInspector : TrajectoryObjectInspector
    {
        /// <summary>
        /// Draws the inspector fields for the object.
        /// </summary>
        protected override void DrawObjectFields()
        {
            base.DrawObjectFields();

            if (Foldout("Destruction")) {
                EditorGUI.indentLevel++;
                EditorGUILayout.PropertyField(PropertyFromName("m_DestroyOnCollision"));
                EditorGUILayout.PropertyField(PropertyFromName("m_WaitForParticleStop"));
                EditorGUILayout.PropertyField(PropertyFromName("m_DestructionDelay"));
                EditorGUILayout.PropertyField(PropertyFromName("m_SpawnedObjectsOnDestruction"), true);
                Shared.Editor.Inspectors.Utility.InspectorUtility.UnityEventPropertyField(PropertyFromName("m_OnImpactEvent"));
                EditorGUI.indentLevel--;
            }
        }
    }
}
