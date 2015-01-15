// CameraFilterNightVision.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {
  public class CameraFilterNightVision : CameraFilter {
    private float contrast = 4;
    private float brightness = .41f;

    private float overlay1Amount = .86f;
    private float overlay2Amount = .86f;

    private float ambienceLevel = .5f;

    private float defaultAmbienceLevel = 0;

    private RandomJitter overlay2Jitter = new RandomJitter(0, 1, 1, 0);

    public CameraFilterNightVision() : base() { }

    public override bool Activate() {
      defaultAmbienceLevel = RenderSettings.ambientLight.r;
      return true;
    }

    public override void Deactivate() {
      RenderSettings.ambientLight = new Color(defaultAmbienceLevel, defaultAmbienceLevel, defaultAmbienceLevel, 1);
    }

    public override void OptionControls() {
      GUILayout.BeginVertical();
      ambienceLevel = GetSliderValue("Boost:", ambienceLevel, 0, 1);
      contrast = GetSliderValue("Contrast:", contrast, 0, 4);
      brightness = GetSliderValue("Brightness:", brightness, 0, 2);
      overlay1Amount = GetSliderValue("CRT Mesh:", overlay1Amount, 0, 1);
      overlay2Amount = GetSliderValue("Snow:", overlay2Amount, 0, 1);
      GUILayout.EndVertical();
    }

    public override void LateUpdate() {
      RenderSettings.ambientLight = new Color(ambienceLevel, ambienceLevel, ambienceLevel, 1);
    }

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      if (mtShader != null && nvMesh != null && noise != null) {

        mtShader.SetTexture("_Overlay1Tex", nvMesh);
        mtShader.SetTexture("_Overlay2Tex", noise);

        mtShader.SetFloat("_Monochrome", 1);
        mtShader.SetColor("_MonoColor", new Color(0, .5f, 0, 1));
        mtShader.SetFloat("_ColorJitter", 1);
        mtShader.SetFloat("_Contrast", contrast);
        mtShader.SetFloat("_ContrastJitter", 1);
        mtShader.SetFloat("_Brightness", brightness);
        mtShader.SetFloat("_BrightnessJitter", 1);

        mtShader.SetFloat("_MainOffsetX", 0);
        mtShader.SetFloat("_MainOffsetY", 0);
        mtShader.SetFloat("_MainSpeedX", 0);
        mtShader.SetFloat("_MainSpeedY", 0);

        mtShader.SetFloat("_VignetteAmount", 1);
        mtShader.SetFloat("_VignetteOffsetX", 0);
        mtShader.SetFloat("_VignetteOffsetY", 0);
        mtShader.SetFloat("_VignetteSpeedX", 0);
        mtShader.SetFloat("_VignetteSpeedY", 0);

        mtShader.SetFloat("_Overlay1Amount", overlay1Amount);
        mtShader.SetFloat("_Overlay1OffsetX", 0);
        mtShader.SetFloat("_Overlay1OffsetY", 0);
        mtShader.SetFloat("_Overlay1SpeedX", 0);
        mtShader.SetFloat("_Overlay1SpeedY", 0);

        mtShader.SetFloat("_Overlay2Amount", overlay2Amount);
        mtShader.SetFloat("_Overlay2OffsetX", overlay2Jitter.NextValue());
        mtShader.SetFloat("_Overlay2OffsetY", overlay2Jitter.NextValue());
        mtShader.SetFloat("_Overlay2SpeedX", 0);
        mtShader.SetFloat("_Overlay2SpeedY", 0);

        Graphics.Blit(source, target, mtShader);
      } else {
        base.RenderImageWithFilter(source, target);
      }
    }

    public override void Load(string moduleName) {
      LoadSettings settings = new LoadSettings("MovieTime.xml");
      settings.Open("MovieTime");
      settings.SelectNode(moduleName + "NightVision");
      contrast = settings.Get<float>("Contrast", contrast);
      brightness = settings.Get<float>("Brightness", brightness);
      overlay1Amount = settings.Get<float>("Overlay1Amount", overlay1Amount);
      overlay2Amount = settings.Get<float>("Overlay2Amount", overlay2Amount);
      ambienceLevel = settings.Get<float>("AmbienceLevel", ambienceLevel);
    }

    public override void Save(string moduleName) {
      SaveSettings settings = new SaveSettings("MovieTime.xml");
      settings.Open("MovieTime");
      settings.SelectNode(moduleName + "NightVision");
      settings.Set<float>("Contrast", contrast);
      settings.Set<float>("Brightness", brightness);
      settings.Set<float>("Overlay1Amount", overlay1Amount);
      settings.Set<float>("Overlay2Amount", overlay2Amount);
      settings.Set<float>("AmbienceLevel", ambienceLevel);
      settings.Save();
    }
  }
}