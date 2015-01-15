// MovieTimeFilter.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {
  public class MovieTimeFilter : MonoBehaviour {
    public enum eFilterType { Flight, Map, SpaceCentre, TrackingStation };

    protected static eFilterType currentMode;

    private string moduleName = "";
    private CameraFilter cameraFilter = null;
    private CameraFilter.eCameraMode cameraMode;
    private eFilterType filterType;

    private bool title = false;
    private string titleFile = "";
    private Texture2D titleTexture = null;

    public MovieTimeFilter() {
    }

    public void Initialize(string module, eFilterType filtType, bool initializeCamera = true) {
      moduleName = module;
      filterType = filtType;
      LoadSettings(moduleName);

      if (initializeCamera) {
        cameraFilter = CameraFilter.CreateFilter(cameraMode);
        cameraFilter.Activate();
      }
      currentMode = (filterType == eFilterType.Map ? eFilterType.Flight : filterType);

      if (titleFile != "")
        titleTexture = CameraFilter.LoadTextureFile(titleFile);
    }

    public void Save() {
      SaveSettings(moduleName);
      if (cameraFilter != null) cameraFilter.Save(moduleName);
      if (titleTexture != null) MonoBehaviour.Destroy(titleTexture);
      titleTexture = null;
    }

    public void SetMode(CameraFilter.eCameraMode mode) {
      if (mode != cameraMode) {
        CameraFilter newFilter = CameraFilter.CreateFilter(mode);
        if (newFilter != null && newFilter.Activate()) {
          if (cameraFilter != null) {
            cameraFilter.Save(moduleName);
            cameraFilter.Deactivate();
          }
          cameraFilter = newFilter;
          cameraFilter.Load(moduleName);
          cameraMode = mode;
        }
      }
    }

    public void ToggleTitleMode() {
      title = !title;
    }

    public void RefreshTitleTexture() {
      LoadSettings settings = new LoadSettings("MovieTime.xml");
      settings.Open("MovieTime");
      settings.SelectNode(moduleName);
      titleFile = settings.Get<string>("TitleFile", "");

      if (titleTexture != null)
        MonoBehaviour.Destroy(titleTexture);
      titleTexture = null;
      if (titleFile != "")
        titleTexture = CameraFilter.LoadTextureFile(titleFile);
    }

    public CameraFilter GetFilter() {
      return cameraFilter;
    }

    public void SetFilter(CameraFilter filter) {
      cameraFilter = filter;
    }

    public CameraFilter.eCameraMode GetMode() {
      return cameraMode;
    }

    public void OptionControls() {
      if (cameraFilter != null) {
        GUILayout.BeginVertical();
        title = GUILayout.Toggle(title, "Title Mode");
        GUILayout.EndVertical();
        cameraFilter.OptionControls();
      }
    }

    public void LateUpdate() {
      if (cameraFilter != null)
        cameraFilter.LateUpdate();
    }

    private void OnRenderImage(RenderTexture source, RenderTexture target) {
      if (cameraFilter != null && filterType == LoadedScene()) {
        cameraFilter.RenderTitlePage(title, titleTexture);
        cameraFilter.RenderImageWithFilter(source, target);
      } else {
        Graphics.Blit(source, target);
      }
    }

    private void LoadSettings(string module) {
      LoadSettings settings = new LoadSettings("MovieTime.xml");
      settings.Open("MovieTime");
      settings.SelectNode(module);
      cameraMode = settings.GetEnumerator<CameraFilter.eCameraMode>("CameraMode", CameraFilter.eCameraMode.Normal);
      titleFile = settings.Get<string>("TitleFile", "");
    }

    private void SaveSettings(string module) {
      SaveSettings settings = new SaveSettings("MovieTime.xml");
      settings.Open("MovieTime");
      settings.SelectNode(module);
      settings.Set<CameraFilter.eCameraMode>("CameraMode", cameraMode);
      settings.Save();
    }

    public static eFilterType LoadedScene() {
      if (currentMode == eFilterType.Flight && !MapView.MapIsEnabled)
        return eFilterType.Flight;
      else if (currentMode == eFilterType.Flight && MapView.MapIsEnabled)
        return eFilterType.Map;
      return currentMode;
    }
  }
}