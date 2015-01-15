// MovieTimeFlight.cs
//
// Author: Marc Bernier
//   Date: 2014-11-29

namespace MovieTime {
  [KSPAddon(KSPAddon.Startup.Flight, false)]
  public class MovieTimeFlight : MovieTime {
    private static MovieTimeFilter flightCameraFilter = null;
    private static MovieTimeFilter internalCameraFilter = null;
    private static MovieTimeFilter mapCameraFilter = null;

    public override void Awake() {
      LoadSettings("Flight");
      base.Awake();
    }

    public override void OnDestroy() {
      SaveSettings("Flight");
      if (flightCameraFilter != null) flightCameraFilter.Save();
      if (mapCameraFilter != null) mapCameraFilter.Save();
      base.OnDestroy();
    }

    public override void Start() {
      flightCameraFilter = CreateFilter(FlightCamera.fetch.mainCamera);
      internalCameraFilter = CreateFilter(InternalCamera.Instance.camera);
      mapCameraFilter = CreateFilter(MapView.MapCamera.camera);

      if (flightCameraFilter != null) flightCameraFilter.Initialize("Flight", MovieTimeFilter.eFilterType.Flight);
      if (internalCameraFilter != null) internalCameraFilter.Initialize("Flight", MovieTimeFilter.eFilterType.Flight, false);
      if (internalCameraFilter != null && flightCameraFilter != null) internalCameraFilter.SetFilter(flightCameraFilter.GetFilter());
      if (mapCameraFilter != null) mapCameraFilter.Initialize("Map", MovieTimeFilter.eFilterType.Map);

      base.Start();
    }

    private void LateUpdate() {
      if (mapCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Map) {
        mapCameraFilter.LateUpdate();
      } else if (flightCameraFilter != null && internalCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Flight) {
        flightCameraFilter.LateUpdate();
        internalCameraFilter.LateUpdate();
      }
    }

    protected override void CameraOptionControls() {
      if (mapCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Map)
        mapCameraFilter.OptionControls();
      else if (flightCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Flight)
        flightCameraFilter.OptionControls();
    }

    protected override void ToggleTitleMode() {
      if (mapCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Map)
        mapCameraFilter.ToggleTitleMode();
      else if (flightCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Flight)
        flightCameraFilter.ToggleTitleMode();
    }

    protected override void RefreshTitleTexture() {
      if (mapCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Map)
        mapCameraFilter.RefreshTitleTexture();
      else if (flightCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Flight)
        flightCameraFilter.RefreshTitleTexture();
    }

    protected override CameraFilter.eCameraMode GetCameraMode() {
      if (mapCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Map)
        return mapCameraFilter.GetMode();
      else if (flightCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Flight)
        return flightCameraFilter.GetMode();
      return CameraFilter.eCameraMode.Normal;
    }

    protected override void SetCameraMode(CameraFilter.eCameraMode mode) {
      if (mapCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Map) {
        mapCameraFilter.SetMode(mode);
      } else if (flightCameraFilter != null && internalCameraFilter != null && MovieTimeFilter.LoadedScene() == MovieTimeFilter.eFilterType.Flight) {
        flightCameraFilter.SetMode(mode);
        internalCameraFilter.SetFilter(flightCameraFilter.GetFilter());
      }
    }
  }
}