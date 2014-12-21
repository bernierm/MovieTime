// MovieTime.cs
//
// Author: Marc Bernier
//   Date: 2014-11-29

using System;
using System.Collections;

using UnityEngine;

namespace MovieTime {

  // Main class for MovieTime plugin. Manages initialization and GUI interaction.
  [KSPAddon(KSPAddon.Startup.Flight, false)]
  public class MovieTime : MonoBehaviour {

    private static int windowId = "MovieTime".GetHashCode();

    private ApplicationLauncherButton appButton = null;
    private static bool settingsWindow = false;

    private static GUIStyle windowStyle = null;
    private static Rect windowPosition = new Rect(0, 0, 300, 450);

    private static MovieTimeFilter mainCameraFilter = null;
    private static MovieTimeFilter internalCameraFilter = null;
    private static MovieTimeFilter mapCameraFilter = null;

    public MovieTime() {
      StartCoroutine("AddAppButton");
    }

    private void OnGUI() {
      GUI.skin = HighLogic.Skin;
      if (settingsWindow)
        OnWindow(0);
    }

    // Add MovieTime button to KSP's ribbon.
    IEnumerator AddAppButton() {
      while (!ApplicationLauncher.Ready)
        yield return null;

      if (HighLogic.LoadedSceneIsFlight && appButton == null) {
        Texture2D tex = CameraFilter.LoadTextureFile("MovieTime.png");
        if (tex == null) {
          Debug.Log("AddAppButton: Could not load MovieTime.png texture");
          throw new Exception("AddAppButton: Could not load MovieTime.png texture");
        }
        appButton = ApplicationLauncher.Instance.AddModApplication(OnAppButtonToggleOn, OnAppButtonToggleOff,
          () => { }, () => { }, () => { }, () => { }, ApplicationLauncher.AppScenes.FLIGHT, tex);
        if (appButton != null && settingsWindow)
          appButton.SetTrue(true);
        else if (appButton != null)
          appButton.SetFalse(true);
      }
    }

    private void Awake() {
      RenderingManager.AddToPostDrawQueue(0, OnDraw);
    }

    private void Start() {
      if (windowStyle == null)
        windowStyle = new GUIStyle(HighLogic.Skin.window);

      if (mainCameraFilter == null) {
        Camera mainCamera = FlightCamera.fetch.mainCamera;
        mainCamera.gameObject.AddComponent<MovieTimeFilter>();
        mainCameraFilter = mainCamera.gameObject.GetComponent<MovieTimeFilter>();
        mainCameraFilter.Initialize(MovieTimeFilter.eFilterType.Flight);
      }
      if (internalCameraFilter == null) {
        Camera internalCamera = InternalCamera.Instance.camera;
        internalCamera.gameObject.AddComponent<MovieTimeFilter>();
        internalCameraFilter = internalCamera.gameObject.GetComponent<MovieTimeFilter>();
        internalCameraFilter.Initialize(MovieTimeFilter.eFilterType.InVehicle);
      }
      if (mapCameraFilter == null) {
        Camera mapCamera = MapView.MapCamera.camera;
        mapCamera.gameObject.AddComponent<MovieTimeFilter>();
        mapCameraFilter = mapCamera.gameObject.GetComponent<MovieTimeFilter>();
        mapCameraFilter.Initialize(MovieTimeFilter.eFilterType.Map);
      }

      LoadSettings settings = new LoadSettings("MovieTime.xml");
      settings.Open("MovieTime");

      LoadSettings(settings);
      CameraFilter.LoadAllSettings(settings);
      MovieTimeFilter.LoadSettings(settings);

      if (appButton != null && settingsWindow)
        appButton.SetTrue(true);
      else if (appButton != null)
        appButton.SetTrue(true);
    }

    private static void OnAppButtonToggleOn() {
      settingsWindow = true;
    }

    private static void OnAppButtonToggleOff() {
      settingsWindow = false;
    }

    private void OnDraw() {
      if (settingsWindow)
        windowPosition = GUI.Window(windowId, windowPosition, OnWindow, "MovieTime Settings", windowStyle);
    }

    private void OnWindow(int id) {
      if (settingsWindow && id == windowId) {
        GUILayout.BeginHorizontal();
        CameraFilter.eCameraMode mode = mainCameraFilter.GetMode();
        mode = (CameraFilter.eCameraMode)GUILayout.SelectionGrid((int)mode, Enum.GetNames(typeof(CameraFilter.eCameraMode)), 1);
        GUILayout.EndHorizontal();

        mainCameraFilter.OptionControls();
        mainCameraFilter.SetMode(mode);

        GUI.DragWindow();
      }
    }

    private void OnDestroy() {
      if (appButton != null)
        ApplicationLauncher.Instance.RemoveModApplication(appButton);

      SaveSettings settings = new SaveSettings("MovieTime.xml");
      settings.Open("MovieTime");

      SaveSettings(settings);
      CameraFilter.SaveAllSettings(settings);
      MovieTimeFilter.SaveSettings(settings);

      settings.Save();
    }

    private void LateUpdate() {
      if (mainCameraFilter != null)
        mainCameraFilter.LateUpdate();
    }

    private static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("Main");
      settingsWindow = settings.Get<bool>("SettingsWindow", settingsWindow);
      windowPosition.y = settings.Get<float>("Top", windowPosition.y);
      windowPosition.x = settings.Get<float>("Left", windowPosition.x);
    }

    private static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("Main");
      settings.Set<bool>("SettingsWindow", settingsWindow);
      settings.Set<float>("Top", windowPosition.y);
      settings.Set<float>("Left", windowPosition.x);
    }
  }
}