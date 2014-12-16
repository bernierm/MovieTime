// MovieTimeFilter.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {

  // Manages creation/destruction of various camera filters.
  public class MovieTimeFilter : MonoBehaviour {
    private CameraFilter cameraFilter = null;
    static private CameraFilter.eCameraMode cameraMode = CameraFilter.eCameraMode.Normal;

    public void Initialize() {
      cameraFilter = CameraFilter.CreateFilter(cameraMode);
      cameraFilter.Activate();
    }

    public void SetMode(CameraFilter.eCameraMode mode) {
      if (mode != cameraMode) {
        CameraFilter newFilter = CameraFilter.CreateFilter(mode);
        if (newFilter != null && newFilter.Activate()) {
          cameraFilter.Deactivate();
          cameraFilter = newFilter;
          cameraMode = mode;
        }
      }
    }

    public CameraFilter.eCameraMode GetMode() {
      return cameraMode;
    }

    public void OptionControls() {
      if (cameraFilter != null)
        cameraFilter.OptionControls();
    }

    public void LateUpdate() {
      if (HighLogic.LoadedSceneIsFlight && cameraFilter != null)
        cameraFilter.LateUpdate();
    }

    private void OnRenderImage(RenderTexture source, RenderTexture target) {
      if (HighLogic.LoadedSceneIsFlight && cameraFilter != null)
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