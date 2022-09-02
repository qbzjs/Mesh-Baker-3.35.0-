/// ---------------------------------------------
/// Ultimate Character Controller
/// Copyright (c) Opsive. All Rights Reserved.
/// https://www.opsive.com
/// ---------------------------------------------

namespace Opsive.UltimateCharacterController.Editor.Managers
{
    using Opsive.Shared.Editor.Utility;
    using Opsive.Shared.Utility;
    using Opsive.UltimateCharacterController.Utility;
    using System;
    using System.Collections.Generic;
    using UnityEditor;
    using UnityEngine;

    /// <summary>
    /// The MainManagerWindow is an editor window which contains all of the sub managers. This window draws the high level menu options and draws
    /// the selected sub manager.
    /// </summary>
    [InitializeOnLoad]
    public class MainManagerWindow : EditorWindow
    {
        private const float c_MenuWidth = 120;
        private const string c_DomainResetterGUID = "4fbaee9eba5d5f04eaa1778d3619d37d";

        public float MenuWidth { get { return c_MenuWidth; } }

        private Manager[] m_Managers;
        private string[] m_ManagerNames;
        private Vector2 m_MenuScrollPosition;
        private int m_MenuSelection;

        // Unity's serialization doesn't support abstract classes so serialize the data separately.
        private Serialization[] m_ManagerData;

        private UnityEngine.Networking.UnityWebRequest m_UpdateCheckRequest;
        private DateTime m_LastUpdateCheck = DateTime.MinValue;

        public string LatestVersion
        {
            get { return EditorPrefs.GetString("Opsive.UltimateCharacterController.Editor.LatestVersion", AssetInfo.Version); }
            set { EditorPrefs.SetString("Opsive.UltimateCharacterController.Editor.LatestVersion", value); }
        }
        private DateTime LastUpdateCheck
        {
            get
            {
                try {
                    // Don't read from editor prefs if it isn't necessary.
                    if (m_LastUpdateCheck != DateTime.MinValue) {
                        return m_LastUpdateCheck;
                    }

                    m_LastUpdateCheck = DateTime.Parse(EditorPrefs.GetString("Opsive.UltimateCharacterController.Editor.LastUpdateCheck", "1/1/1971 00:00:01"), System.Globalization.CultureInfo.InvariantCulture);
                } catch (Exception /*e*/) {
                    m_LastUpdateCheck = DateTime.UtcNow;
                }
                return m_LastUpdateCheck;
            }
            set
            {
                m_LastUpdateCheck = value;
                EditorPrefs.SetString("Opsive.UltimateCharacterController.Editor.LastUpdateCheck", m_LastUpdateCheck.ToString(System.Globalization.CultureInfo.InvariantCulture));
            }
        }

        private GUIStyle m_MenuBackground;
        private GUIStyle MenuBackground {
            get {
                if (m_MenuBackground == null) {
                    m_MenuBackground = new GUIStyle(EditorStyles.label);
                    // The left, top, and bottom background border should extend to prevent it from being seen.
                    var overflow = m_MenuBackground.overflow;
                    overflow.left = overflow.top = overflow.bottom = 3;
                    m_MenuBackground.overflow = overflow;
                    var border = m_MenuBackground.border;
                    border.left = border.right = 10;
                    m_MenuBackground.border = border;
                    var background = new Texture2D(1, 1, TextureFormat.RGBA32, false);
                    background.SetPixel(0, 0, EditorGUIUtility.isProSkin ? new Color(0.258f, 0.258f, 0.258f) : new Color(0.819f, 0.819f, 0.819f));
                    background.Apply();
                    m_MenuBackground.normal.background = background;
                }
                if (m_MenuBackground.normal.background == null) {
                    var background = new Texture2D(1, 1, TextureFormat.RGBA32, false);
                    background.SetPixel(0, 0, EditorGUIUtility.isProSkin ? new Color(0.258f, 0.258f, 0.258f) : new Color(0.819f, 0.819f, 0.819f));
                    background.Apply();
                    m_MenuBackground.normal.background = background;
                }
                return m_MenuBackground;
            }
        }

        private GUIStyle m_MenuButton;
        private GUIStyle MenuButton {
            get {
                if (m_MenuButton == null) {
                    m_MenuButton = new GUIStyle(EditorStyles.label);
                    m_MenuButton.fontSize = 13;
                    m_MenuButton.alignment = TextAnchor.MiddleRight;
                }
                return m_MenuButton;
            }
        }
        private GUIStyle m_SelectedMenuButton;
        private GUIStyle SelectedMenuButton {
            get {
                if (m_SelectedMenuButton == null) {
                    m_SelectedMenuButton = new GUIStyle(MenuButton);
                }
                if (m_SelectedMenuButton.active.background == null) {
                    var background = new Texture2D(1, 1, TextureFormat.RGBA32, false);
                    background.SetPixel(0, 0, EditorGUIUtility.isProSkin ? new Color(0.243f, 0.373f, 0.588f) : new Color(0.247f, 0.494f, 0.871f));
                    background.Apply();
                    m_SelectedMenuButton.active.background = m_SelectedMenuButton.normal.background = background;
                }
                return m_SelectedMenuButton;
            }
        }
        private GUIStyle m_ManagerTitle;
        private GUIStyle ManagerTitle
        {
            get
            {
                if (m_ManagerTitle == null) {
                    m_ManagerTitle = new GUIStyle(Shared.Editor.Inspectors.Utility.InspectorStyles.CenterBoldLabel);
                    m_ManagerTitle.fontSize = 16;
                    m_ManagerTitle.alignment = TextAnchor.MiddleLeft;
                }
                return m_ManagerTitle;
            }
        }

        /// <summary>
        /// Perform editor checks as soon as the scripts are done compiling.
        /// </summary>
        static MainManagerWindow()
        {
            EditorApplication.update += EditorStartup;
        }

        /// <summary>
        /// Initializes the Main Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Main Manager", false, 1)]
        public static MainManagerWindow ShowWindow()
        {
            var window = EditorWindow.GetWindow<MainManagerWindow>(false, "Character Manager");
            window.minSize = new Vector2(680, 550);
            return window;
        }

        /// <summary>
        /// Initializes the Main Manager and shows the Character Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Character Manager", false, 11)]
        public static void ShowCharacterManagerWindow()
        {
            var window = ShowWindow();
            window.Open(typeof(CharacterManager));
        }

        /// <summary>
        /// Initializes the Main Manager and shows the Item Type Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Item Type Manager", false, 12)]
        public static void ShowItemTypeManagerWindow()
        {
            var window = ShowWindow();
            window.Open(typeof(ItemTypeManager));
        }

        /// <summary>
        /// Initializes the Main Manager and shows the Item Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Item Manager", false, 13)]
        public static void ShowItemManagerWindow()
        {
            var window = ShowWindow();
            window.Open(typeof(ItemManager));
        }

        /// <summary>
        /// Initializes the Main Manager and shows the Item Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Object Manager", false, 14)]
        public static void ShowObjectManagerWindow()
        {
            var window = ShowWindow();
            window.Open(typeof(ObjectManager));
        }

        /// <summary>
        /// Initializes the Main Manager and shows the Integrations Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Integrations Manager", false, 25)]
        public static void ShowIntegrationsManagerWindow()
        {
            var window = ShowWindow();
            window.Open(typeof(IntegrationsManager));
        }

        /// <summary>
        /// Initializes the Main Manager and shows the Add-Ons Manager.
        /// </summary> 
        [MenuItem("Tools/Opsive/Ultimate Character Controller/Add-Ons Manager", false, 26)]
        public static void ShowAddOnsManagerWindow()
        {
            var window = ShowWindow();
            window.Open(typeof(AddOnsManager));
        }

        /// <summary>
        /// Show the editor window if it hasn't been shown before and also setup.
        /// </summary>
        private static void EditorStartup()
        {
            if (EditorApplication.isCompiling) {
                return;
            }
            EditorApplication.update -= EditorStartup;

#if !ULTIMATE_CHARACTER_CONTROLLER_EXTENSION_DEBUG
            ImportStatus importStatus = null;
            var importStatusAssets = AssetDatabase.FindAssets("t:ImportStatus");
            if (importStatusAssets != null && importStatusAssets.Length > 0) {
                for (int i = 0; i < importStatusAssets.Length; ++i) {
                    var path = AssetDatabase.GUIDToAssetPath(importStatusAssets[i]);
                    if (string.IsNullOrEmpty(path)) {
                        path = importStatusAssets[i];
                    }
                    importStatus = AssetDatabase.LoadAssetAtPath(path, typeof(ImportStatus)) as ImportStatus;
                    if (importStatus != null) {
                        break;
                    }
                }
            }
            if (importStatus == null) {
                // The import status hasn't been created yet. Create it in the same location as the DomainResetter.
                var domainResetterPath = AssetDatabase.GUIDToAssetPath(c_DomainResetterGUID);
                if (string.IsNullOrEmpty(domainResetterPath)) {
                    return;
                }

                importStatus = ScriptableObject.CreateInstance<ImportStatus>();
                AssetDatabase.CreateAsset(importStatus, System.IO.Path.GetDirectoryName(domainResetterPath) + "/ImportStatus.asset");
                AssetDatabase.Refresh();
            }

            if (!importStatus.CharacterProjectSettingsShown) {
                // Versions before 2.3.5 used an editor key.
                if (!EditorPrefs.HasKey("Opsive.UltimateCharacterController.Editor.UpdateProject") || EditorPrefs.GetBool("Opsive.UltimateCharacterController.Editor.UpdateProject", true)) {
                    var window = ShowWindow();
                    var setupManager = window.Open(typeof(SetupManager));
                    (setupManager as SetupManager).OpenProjectSetup();
                }

                importStatus.CharacterProjectSettingsShown = true;
                UnityEditor.EditorUtility.SetDirty(importStatus);
            }
#endif
            if (EditorPrefs.HasKey("Opsive.UltimateCharacterController.Editor.UpdateProject")) {
                EditorPrefs.DeleteKey("Opsive.UltimateCharacterController.Editor.UpdateProject");
            }
            if (EditorPrefs.HasKey("Opsive.UltimateCharacterController.Editor.MainManagerShown")) {
                EditorPrefs.DeleteKey("Opsive.UltimateCharacterController.Editor.MainManagerShown");
            }
        }

        /// <summary>
        /// Updates the inspector.
        /// </summary>
        private void OnInspectorUpdate()
        {
            UpdateCheck();
        }

        /// <summary>
        /// Is an update available?
        /// </summary>
        /// <returns>True if an update is available.</returns>
        private bool UpdateCheck()
        {
            if (m_UpdateCheckRequest != null && m_UpdateCheckRequest.isDone) {
                if (string.IsNullOrEmpty(m_UpdateCheckRequest.error)) {
                    LatestVersion = m_UpdateCheckRequest.downloadHandler.text;
                }
                m_UpdateCheckRequest = null;
                return false;
            }

            if (m_UpdateCheckRequest == null && DateTime.Compare(LastUpdateCheck.AddDays(1), DateTime.UtcNow) < 0) {
                var url = string.Format("https://opsive.com/asset/UpdateCheck.php?asset=UltimateCharacterController&type={0}&version={1}&unityversion={2}&devplatform={3}&targetplatform={4}",
                                            AssetInfo.Name.Replace(" ", ""), AssetInfo.Version, Application.unityVersion, Application.platform, EditorUserBuildSettings.activeBuildTarget);
                m_UpdateCheckRequest = UnityEngine.Networking.UnityWebRequest.Get(url);
                m_UpdateCheckRequest.SendWebRequest();
                LastUpdateCheck = DateTime.UtcNow;
            }

            return m_UpdateCheckRequest != null;
        }

        /// <summary>
        /// The window has been enabled.
        /// </summary>
        private void OnEnable()
        {
            DeserializeManagers();
            BuildManagerItems();
        }

        /// <summary>
        /// Draws the Main Manager.
        /// </summary>
        private void OnGUI()
        {
            // Draw the menu.
            OnMenuGUI();

            EditorGUI.BeginChangeCheck();

            // Draw the manager.
            OnManagerGUI();

            // Use a custom serialization for any changes since Unity's serialization doesn't support abstract inheritance.
            if (EditorGUI.EndChangeCheck()) {
                SerializeManagers();
            }
        }

        /// <summary>
        /// Draws the menu UI.
        /// </summary>
        private void OnMenuGUI()
        {
            GUILayout.BeginArea(new Rect(0, 0, c_MenuWidth, position.height), MenuBackground);
            m_MenuScrollPosition = GUILayout.BeginScrollView(m_MenuScrollPosition);
            GUILayout.BeginVertical();
            GUILayout.Space(32);
            for (int i = 0; i < m_Managers.Length; ++i) {
                if (GUILayout.Button(m_ManagerNames[i], (i == m_MenuSelection ? SelectedMenuButton : MenuButton), GUILayout.Height(32))) {
                    m_MenuSelection = i;
                } 
            }

            GUILayout.EndVertical();
            GUILayout.EndScrollView();
            GUILayout.EndArea();
        }

        /// <summary>
        /// Builds the array which contains all of the IManager objects.
        /// </summary>
        private void BuildManagerItems()
        {
            var managers = new List<Type>();
            var managerIndexes = new List<int>();
            var assemblies = AppDomain.CurrentDomain.GetAssemblies();
            for (int i = 0; i < assemblies.Length; ++i) {
                Type[] assemblyTypes;
                try {
                    assemblyTypes = assemblies[i].GetTypes();
                } catch(Exception /*e*/) {
                    continue;
                }
                for (int j = 0; j < assemblyTypes.Length; ++j) {
                    // Must implement Manager.
                    if (!typeof(Manager).IsAssignableFrom(assemblyTypes[j])) {
                        continue;
                    }
                    
                    // Ignore abstract classes.
                    if (assemblyTypes[j].IsAbstract) {
                        continue;
                    }

                    // A valid manager class.
                    managers.Add(assemblyTypes[j]);
                    var index = managerIndexes.Count;
                    if (assemblyTypes[j].GetCustomAttributes(typeof(OrderedEditorItem), true).Length > 0) {
                        var item = assemblyTypes[j].GetCustomAttributes(typeof(OrderedEditorItem), true)[0] as OrderedEditorItem;
                        index = item.Index;
                    }
                    managerIndexes.Add(index);
                }
            }

            // Do not reinitialize the managers if they are already initialized and there aren't any changes.
            if (m_Managers != null && m_Managers.Length == managers.Count) {
                return;
            }

            // All of the manager types have been found. Sort by the index.
            var managerTypes = managers.ToArray();
            Array.Sort(managerIndexes.ToArray(), managerTypes);

            m_Managers = new Manager[managers.Count];
            m_ManagerNames = new string[managers.Count];

            // The manager types have been found and sorted. Add them to the list.
            for (int i = 0; i < managerTypes.Length; ++i) {
                m_Managers[i] = Activator.CreateInstance(managerTypes[i]) as Manager;
                m_Managers[i].Initialize(this);

                var managerName  = Shared.Editor.Utility.EditorUtility.SplitCamelCase(managerTypes[i].Name);
                if (managers[i].GetCustomAttributes(typeof(OrderedEditorItem), true).Length > 0) {
                    var item = managerTypes[i].GetCustomAttributes(typeof(OrderedEditorItem), true)[0] as OrderedEditorItem;
                    managerName = item.Name;
                }
                m_ManagerNames[i] = managerName;
            }

            SerializeManagers();
        }

        /// <summary>
        /// Draws the manager UI.
        /// </summary>
        private void OnManagerGUI()
        {
            GUILayout.BeginArea(new Rect(c_MenuWidth + 2, 0, position.width - c_MenuWidth, position.height));
            GUILayout.Space(4);
            GUILayout.Label(m_ManagerNames[m_MenuSelection], ManagerTitle);
            GUILayout.Space(2);
            m_Managers[m_MenuSelection].OnGUI();
            GUILayout.EndArea();
        }

        /// <summary>
        /// Opens the specified manager.
        /// </summary>
        /// <param name="managerType">The type of manager to open.</param>
        /// <returns>The manager that was opened.</returns>
        public Manager Open(Type managerType)
        {
            for (int i = 0; i < m_Managers.Length; ++i) {
                if (m_Managers[i].GetType() == managerType) {
                    m_MenuSelection = i;
                    return m_Managers[i];
                }
            }
            return null;
        }

        /// <summary>
        /// Serializes the data for each manager.
        /// </summary>
        private void SerializeManagers()
        {
            m_ManagerData = new Serialization[m_Managers.Length];
            for (int i = 0; i < m_Managers.Length; ++i) {
                var serializedValue = new Serialization();
                serializedValue.Serialize(m_Managers[i], true, MemberVisibility.Public);
                m_ManagerData[i] = serializedValue;
            }
        }

        /// <summary>
        /// Deserializes the data for each manager.
        /// </summary>
        private void DeserializeManagers()
        {
            if (m_ManagerData != null) {
                m_Managers = new Manager[m_ManagerData.Length];
                for (int i = 0; i < m_ManagerData.Length; ++i) {
                    m_Managers[i] = m_ManagerData[i].DeserializeFields(MemberVisibility.Public) as Manager;
                    // The object will be null if the class doesn't exist anymore.
                    if (m_Managers[i] == null) {
                        continue;
                    } 
                    m_Managers[i].Initialize(this);
                }
            }
        }
    }

    /// <summary>
    /// Attribute which specifies the name and ordering of the editor items.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
    public class OrderedEditorItem : Attribute
    {
        private string m_Name;
        private int m_Index;
        public string Name { get { return m_Name; } }
        public int Index { get { return m_Index; } }
        public OrderedEditorItem(string name, int index) { m_Name = name; m_Index = index; }
    }
}