/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Editor.Inspectors.Inventory
{
    using UnityEditor;
    using UnityEditorInternal;
    using UnityEngine;

    /// <summary>
    /// Custom inspector for the Inventory component.
    /// </summary>
    [CustomEditor(typeof(UltimateCharacterController.Inventory.Inventory))]
    public class InventoryInspector : InventoryBaseInspector
    {
        private ReorderableList m_DefaultLoadoutReordableList;
        private ReorderableList m_RuntimePickupReorderableList;

        /// <summary>
        /// Draws the properties for the inventory subclass.
        /// </summary>
        protected override void DrawInventoryProperties()
        {
            if (Foldout("Default Loadout")) {
                EditorGUI.indentLevel++;
                if (m_DefaultLoadoutReordableList == null) {
                    var itemListProperty = PropertyFromName("m_DefaultLoadout");
                    m_DefaultLoadoutReordableList = new ReorderableList(serializedObject, itemListProperty, true, true, true, true);
                    m_DefaultLoadoutReordableList.drawHeaderCallback = OnDefaultLoadoutHeaderDraw;
                    m_DefaultLoadoutReordableList.drawElementCallback = OnDefaultLoadoutElementDraw;
                }
                var listRect = GUILayoutUtility.GetRect(0, m_DefaultLoadoutReordableList.GetHeight());
                listRect.x += EditorGUI.indentLevel * Shared.Editor.Inspectors.Utility.InspectorUtility.IndentWidth;
                listRect.xMax -= EditorGUI.indentLevel * Shared.Editor.Inspectors.Utility.InspectorUtility.IndentWidth;
                m_DefaultLoadoutReordableList.DoList(listRect);
                EditorGUI.indentLevel--;
            }
            if (Foldout("Runtime Pickups")) {
                EditorGUI.indentLevel++;
                if (m_RuntimePickupReorderableList == null) {
                    var itemListProperty = PropertyFromName("m_RuntimePickups");
                    m_RuntimePickupReorderableList = new ReorderableList(serializedObject, itemListProperty, true, true, true, true);
                    m_RuntimePickupReorderableList.drawHeaderCallback = (Rect rect) =>
                    {
                        EditorGUI.LabelField(new Rect(rect.x, rect.y, rect.width, EditorGUIUtility.singleLineHeight), "Prefabs");
                    };

                    m_RuntimePickupReorderableList.drawElementCallback = (Rect rect, int index, bool isActive, bool isFocused) =>
                    {
                        EditorGUI.PropertyField(new Rect(rect.x - 12, rect.y + (rect.height- 18) / 2, rect.width + 8, 16), PropertyFromName("m_RuntimePickups").GetArrayElementAtIndex(index), new GUIContent());
                    };

                }
                var listRect = GUILayoutUtility.GetRect(0, m_RuntimePickupReorderableList.GetHeight());
                listRect.x += EditorGUI.indentLevel * Shared.Editor.Inspectors.Utility.InspectorUtility.IndentWidth;
                listRect.xMax -= EditorGUI.indentLevel * Shared.Editor.Inspectors.Utility.InspectorUtility.IndentWidth;
                m_RuntimePickupReorderableList.DoList(listRect);
                EditorGUI.indentLevel--;
            }
        }

        /// <summary>
        /// Draws the DefaultLoadout ReordableList header.
        /// </summary>
        private void OnDefaultLoadoutHeaderDraw(Rect rect)
        {
            ItemDefinitionAmountInspector.OnItemDefinitionAmountHeaderDraw(rect);
        }

        /// <summary>
        /// Draws the DefaultLoadout ReordableList element.
        /// </summary>
        private void OnDefaultLoadoutElementDraw(Rect rect, int index, bool isActive, bool isFocused)
        {
            ItemDefinitionAmountInspector.OnItemDefinitionAmountElementDraw(PropertyFromName("m_DefaultLoadout"), rect, index, isActive, isFocused);
        }
    }
}