// MovieTimeSpaceCentre.cs
//
// Author: Marc Bernier
//   Date: 2014-12-30

namespace MovieTime {
  [KSPAddon(KSPAddon.Startup.SpaceCentre, false)]
  public class MovieTimeSpaceCentre : MovieTime {
    private static MovieTimeFilter spaceCentreFilter = null;

    public override void Awake() {
      CameraFilter.InitializeAssets();
      LoadSettings("SpaceCentre");
      base.Awake();
    }

    public override void OnDestroy() {
      SaveSettings("SpaceCentre");
      if (spaceCentreFilter != null) spaceCentreFilter.Save();
      base.OnDestroy();
    }

    public override void Start() {
      spaceCentreFilter = CreateFilter(FlightCamera.fetch.mainCamera);
      if (spaceCentreFilter != null) spaceCentreFilter.Initialize("SpaceCentre", MovieTimeFilter.eFilterType.SpaceCentre);
      base.Start();
    }

    private void LateUpdate() {
      if (spaceCentreFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.SpaceCentre)
        spaceCentreFilter.LateUpdate();
    }

    protected override void CameraOptionControls() {
      if (spaceCentreFilter != null)
        spaceCentreFilter.OptionControls();
    }

    protected override void ToggleTitleMode() {
      if (spaceCentreFilter != null)
        spaceCentreFilter.ToggleTitleMode();
    }

    protected override void RefreshTitleTexture() {
      if (spaceCentreFilter != null)
        spaceCentreFilter.RefreshTitleTexture();
    }

    protected override CameraFilter.eCameraMode GetCameraMode() {
      if (spaceCentreFilter != null)
        return spaceCentreFilter.GetMode();
      return CameraFilter.eCameraMode.Normal;
    }

    protected override void SetCameraMode(CameraFilter.eCameraMode mode) {
      if (spaceCentreFilter != null)
        spaceCentreFilter.SetMode(mode);
    }
  }
}