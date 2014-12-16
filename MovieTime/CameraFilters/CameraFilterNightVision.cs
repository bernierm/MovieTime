// CameraFilterNightVision.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {
  public class CameraFilterNightVision : CameraFilter {
    private static float contrast = 4;
    private static float brightness = .41f;

    private static float overlay1Amount = .86f;
    private static float overlay2Amount = .86f;

    private static float ambienceLevel = .5f;

    private float defaultAmbienceLevel = 0;

    private Material shader = null;

    private Texture2D overlay1 = null;
    private Texture2D overlay2 = null;

    public CameraFilterNightVision() : base() { }

    public override bool Activate() {
      shader = LoadShaderFile("MovieTime.shader");
      overlay1 = LoadTextureFile("NVMesh.png");
      overlay2 = LoadTextureFile("Noise.png");

      defaultAmbienceLevel = RenderSettings.ambientLight.r;

      if (shader != null && overlay1 != null & overlay2 != null)
        return true;

      Deactivate();
      return false;
    }

    public override void Deactivate() {
      RenderSettings.ambientLight = new Color(defaultAmbienceLevel, defaultAmbienceLevel, defaultAmbienceLevel, 1);

      if (shader != null) MonoBehaviour.Destroy(shader);
      shader = null;
      if (overlay1 != null) MonoBehaviour.Destroy(overlay1);
      overlay1 = null;
      if (overlay2 != null) MonoBehaviour.Destroy(overlay2);
      overlay2 = null;
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
      Color ambienceColor = RenderSettings.ambientLight;
      ambienceColor.r = ambienceLevel;
      ambienceColor.g = ambienceLevel;
      ambienceColor.b = ambienceLevel;
      RenderSettings.ambientLight = ambienceColor;
    }

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      if (shader != null && overlay1 != null && overlay2 != null) {
        shader.SetTexture("_Overlay1Tex", overlay1);
        shader.SetTexture("_Overlay2Tex", overlay2);

        shader.SetFloat("_Monochrome", 1);
        shader.SetColor("_MonoColor", new Color(0, .5f, 0, 1));
        shader.SetFloat("_Contrast", contrast);
        shader.SetFloat("_Brightness", brightness);

        shader.SetFloat("_Overlay1Amount", overlay1Amount);
        shader.SetFloat("_Overlay2Amount", overlay2Amount);

        Graphics.Blit(source, target, shader);
      } else {
        base.RenderImageWithFilter(source, target);
      }
    }

    public static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("CameraFilterNightVision");
      contrast = settings.Get<float>("Contrast", contrast);
      brightness = settings.Get<float>("Brightness", brightness);
      overlay1Amount = settings.Get<float>("Overlay1Amount", overlay1Amount);
      overlay2Amount = settings.Get<float>("Overlay2Amount", overlay2Amount);
      ambienceLevel = settings.Get<float>("AmbienceLevel", ambienceLevel);
    }

    public static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("CameraFilterNightVision");
      settings.Set<float>("Contrast", contrast);
      settings.Set<float>("Brightness", brightness);
      settings.Set<float>("Overlay1Amount", overlay1Amount);
      settings.Set<float>("Overlay2Amount", overlay2Amount);
      settings.Set<float>("AmbienceLevel", ambienceLevel);
    }
  }
}