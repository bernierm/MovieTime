// MovieTime.cs
//
// Author: Marc Bernier
//   Date: 2014-12-28

using System;
using UnityEngine;

namespace MovieTime {

	public class MovieTime : MonoBehaviour {
		private static int windowId = "MovieTime".GetHashCode();
		private static Texture2D buttonTexture = null;

		private ApplicationLauncherButton appButton = null;
		private bool settingsWindow = false;
		private GUIStyle windowStyle = null;
		private Rect windowPosition = new Rect(0, 0, 300, 450);

		public MovieTime() { }

		public virtual void Awake() {

			// This event doesn't appear to fire in KSP v1.0
			// GameEvents.onGUIApplicationLauncherReady.Add(OnGUIAppLauncherReady);
			GameEvents.onGameSceneLoadRequested.Add(OnGameSceneLoadReq);
			RenderingManager.AddToPostDrawQueue(0, OnDraw);

			// So I'm calling it directly here:
			OnGUIAppLauncherReady();
		}

		public virtual void Start() {
			if (windowStyle == null)
				windowStyle = new GUIStyle(HighLogic.Skin.window);
		}

		public void OnGUIAppLauncherReady() {
			if (ApplicationLauncher.Ready) {
				if (buttonTexture == null)
					buttonTexture = CameraFilter.LoadTextureFile("MovieTime.png");
				if (buttonTexture == null)
					throw new Exception("MovieTime: Could not load MovieTime.png.texture");

				appButton = ApplicationLauncher.Instance.AddModApplication(OnAppButtonToggleOn, OnAppButtonToggleOff,
					() => { }, () => { }, () => { }, () => { }, ApplicationLauncher.AppScenes.ALWAYS, buttonTexture);

				if (appButton != null && settingsWindow)
					appButton.SetTrue();
			}
		}

		public void OnGameSceneLoadReq(GameScenes scene) {
			if (appButton != null)
				ApplicationLauncher.Instance.RemoveModApplication(appButton);
		}

		public void OnGUI() {
			GUI.skin = HighLogic.Skin;
			if (settingsWindow)
				OnWindow(0);
		}

		public void OnWindow(int id) {
			if (settingsWindow && id == windowId) {
				GUILayout.BeginHorizontal();
				CameraFilter.eCameraMode mode = GetCameraMode();
				CameraFilter.eCameraMode newMode = (CameraFilter.eCameraMode)GUILayout.SelectionGrid((int)mode, Enum.GetNames(typeof(CameraFilter.eCameraMode)), 1);
				GUILayout.EndHorizontal();
				CameraOptionControls();
				if (mode != newMode)
					SetCameraMode(newMode);

				GUI.DragWindow();
			}
		}

		public void OnDraw() {
			if (settingsWindow)
				windowPosition = GUI.Window(windowId, windowPosition, OnWindow, "MovieTime Settings", windowStyle);
		}

		public void Update() {
			if (Input.GetKeyDown(KeyCode.O) && Input.GetKey(KeyCode.RightControl) && Input.GetKey(KeyCode.RightShift))
				RefreshTitleTexture();
			else if (Input.GetKeyDown(KeyCode.O) && Input.GetKey(KeyCode.RightControl))
				ToggleTitleMode();
		}

		private void OnAppButtonToggleOn() {
			settingsWindow = true;
		}

		private void OnAppButtonToggleOff() {
			settingsWindow = false;
		}

		public virtual void OnDestroy() {
			GameEvents.onGUIApplicationLauncherReady.Remove(OnGUIAppLauncherReady);
			GameEvents.onGameSceneLoadRequested.Remove(OnGameSceneLoadReq);
		}

		protected virtual CameraFilter.eCameraMode GetCameraMode() {
			return CameraFilter.eCameraMode.Normal;
		}

		protected virtual void SetCameraMode(CameraFilter.eCameraMode mode) { }

		protected virtual void CameraOptionControls() { }

		protected virtual void ToggleTitleMode() { }

		protected virtual void RefreshTitleTexture() { }

		protected MovieTimeFilter CreateFilter(Camera camera) {
			if (camera != null) {
				MovieTimeFilter retVal = camera.gameObject.GetComponent<MovieTimeFilter>();
				if (retVal == null) {
					camera.gameObject.AddComponent<MovieTimeFilter>();
					retVal = camera.gameObject.GetComponent<MovieTimeFilter>();
				}
				return retVal;
			}
			return null;
		}

		protected void LoadSettings(string module) {
			LoadSettings settings = new LoadSettings("MovieTime.xml");
			settings.Open("MovieTime");
			settings.SelectNode(module);
			settingsWindow = settings.Get<bool>("SettingsWindow", settingsWindow);
			windowPosition.y = settings.Get<float>("Top", windowPosition.y);
			windowPosition.x = settings.Get<float>("Left", windowPosition.x);
		}

		protected void SaveSettings(string module) {
			SaveSettings settings = new SaveSettings("MovieTime.xml");
			settings.Open("MovieTime");
			settings.SelectNode(module);
			settings.Set<bool>("SettingsWindow", settingsWindow);
			settings.Set<float>("Top", windowPosition.y);
			settings.Set<float>("Left", windowPosition.x);
			settings.Save();
		}
	}
}