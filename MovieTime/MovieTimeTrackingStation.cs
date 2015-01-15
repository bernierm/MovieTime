// MovieTimeTrackingStation.cs
//
// Author: Marc Bernier
//   Date: 2014-12-30

namespace MovieTime {
  [KSPAddon(KSPAddon.Startup.TrackingStation, false)]
  public class MovieTimeTrackingStation : MovieTime {
    private static MovieTimeFilter trackingStationFilter = null;

    public override void Awake() {
      LoadSettings("TrackingStation");
      base.Awake();
    }

    public override void OnDestroy() {
      SaveSettings("TrackingStation");
      if (trackingStationFilter != null) trackingStationFilter.Save();
      base.OnDestroy();
    }

    public override void Start() {
      trackingStationFilter = CreateFilter(PlanetariumCamera.Camera);
      if (trackingStationFilter != null) trackingStationFilter.Initialize("TrackingStation", MovieTimeFilter.eFilterType.TrackingStation);
      base.Start();
    }

    private void LateUpdate() {
      if (trackingStationFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.TrackingStation)
        trackingStationFilter.LateUpdate();
    }

    protected override void CameraOptionControls() {
      if (trackingStationFilter != null)
        trackingStationFilter.OptionControls();
    }

    protected override void ToggleTitleMode() {
      if (trackingStationFilter != null)
        trackingStationFilter.ToggleTitleMode();
    }

    protected override void RefreshTitleTexture() {
      if (trackingStationFilter != null)
        trackingStationFilter.RefreshTitleTexture();
    }

    protected override CameraFilter.eCameraMode GetCameraMode() {
      if (trackingStationFilter != null)
        return trackingStationFilter.GetMode();
      return CameraFilter.eCameraMode.Normal;
    }

    protected override void SetCameraMode(CameraFilter.eCameraMode mode) {
      if (trackingStationFilter != null)
        trackingStationFilter.SetMode(mode);
    }
  }
}