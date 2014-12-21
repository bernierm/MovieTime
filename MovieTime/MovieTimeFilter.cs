// MovieTimeFilter.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {

  // Manages creation/destruction of various camera filters.
  public class MovieTimeFilter : MonoBehaviour {

    public enum eFilterType { Flight, InVehicle, Map };
    private eFilterType filterType;

    private static CameraFilter cameraFilter = null;
    private static CameraFilter.eCameraMode cameraMode = CameraFilter.eCameraMode.Normal;

    private static bool inVehicleView = true;
    private static bool inMapView = false;

    public void Initialize(eFilterType filtType) {
      filterType = filtType;
      if (cameraFilter == null) {
        cameraFilter = CameraFilter.CreateFilter(cameraMode);
        cameraFilter.Activate();
      }
    }

    public void SetMode(CameraFilter.eCameraMode mode) {
      if (mode != cameraMode) {
        CameraFilter newFilter = CameraFilter.CreateFilter(mode);
        if (newFilter != null && newFilter.Activate()) {
          if (cameraFilter != null) cameraFilter.Deactivate();
          cameraFilter = newFilter;
          cameraMode = mode;
        }
      }
    }

    public CameraFilter.eCameraMode GetMode() {
      return cameraMode;
    }

    public void OptionControls() {
      if (cameraFilter != null) {
        GUILayout.BeginHorizontal();
        inVehicleView = GUILayout.Toggle(inVehicleView, "IVA");
        inMapView = GUILayout.Toggle(inMapView, "Map");
        GUILayout.EndHorizontal();
        cameraFilter.OptionControls();
      }
    }

    public void LateUpdate() {
      if (HighLogic.LoadedSceneIsFlight && cameraFilter != null)
        cameraFilter.LateUpdate(filterType == eFilterType.Flight || filterType == eFilterType.InVehicle && inVehicleView || filterType == eFilterType.Map && inMapView);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture target) {
      if (cameraFilter != null && (filterType == eFilterType.Flight || filterType == eFilterType.InVehicle && inVehicleView || filterType == eFilterType.Map && inMapView))
        cameraFilter.RenderImageWithFilter(source, target);
      else
        Graphics.Blit(source, target);
    }

    public static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("MovieTimeFilter");
      cameraMode = settings.Get<CameraFilter.eCameraMode>("CameraMode", cameraMode);
    }

    public static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("MovieTimeFilter");
      settings.Set<CameraFilter.eCameraMode>("CameraMode", cameraMode);
    }
  }
}