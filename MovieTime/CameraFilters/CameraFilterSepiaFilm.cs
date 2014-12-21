// CameraFilterSepiaFilm.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {
  public class CameraFilterSepiaFilm : CameraFilter {
    private static float contrast = 4;
    private static float brightness = .6f;

    private static float vignetteAmount = .45f;
    private static float overlay1Amount = .5f;
    private static float overlay2Amount = .65f;

    private Material shader = null;

    private Texture2D vignette = null;
    private Texture2D overlay1 = null;
    private Texture2D overlay2 = null;

    private RandomJitter brightnessJitter = new RandomJitter(.95f, 1.05f, .01f, 0);
    private RandomJitter vignetteXJitter = new RandomJitter(-.001f, .001f, .0005f, 0);
    private RandomJitter vignetteYJitter = new RandomJitter(-.001f, .001f, .0005f, 0);
    private RandomJitter overlay1XJitter = new RandomJitter(0, 1, .1f, 10000);
    private RandomJitter overlay2XJitter = new RandomJitter(0, 1, 1, 300);
    private RandomJitter overlay2YJitter = new RandomJitter(0, 1, 1, 300);

    public CameraFilterSepiaFilm() : base() { }

    public override bool Activate() {
      shader = LoadShaderFile("MovieTime.shader");
      vignette = LoadTextureFile("FilmVignette.png");
      overlay1 = LoadTextureFile("Scratches.png");
      overlay2 = LoadTextureFile("Dust.png");

      if (shader != null && vignette != null && overlay1 != null & overlay2 != null)
        return true;

      Deactivate();
      return false;
    }

    public override void Deactivate() {
      if (shader != null) MonoBehaviour.Destroy(shader);
      shader = null;
      if (vignette != null) MonoBehaviour.Destroy(vignette);
      vignette = null;
      if (overlay1 != null) MonoBehaviour.Destroy(overlay1);
      overlay1 = null;
      if (overlay2 != null) MonoBehaviour.Destroy(overlay2);
      overlay2 = null;
    }

    public override void OptionControls() {
      GUILayout.BeginVertical();
      contrast = GetSliderValue("Contrast:", contrast, 0, 4);
      brightness = GetSliderValue("Brightness:", brightness, 0, 2);
      vignetteAmount = GetSliderValue("Vignette:", vignetteAmount, 0, 1);
      overlay1Amount = GetSliderValue("Scratches:", overlay1Amount, 0, 1);
      overlay2Amount = GetSliderValue("Dust:", overlay2Amount, 0, 1);
      GUILayout.EndVertical();
    }

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      if (shader != null && vignette != null && overlay1 != null & overlay2 != null) {
        shader.SetTexture("_VignetteTex", vignette);
        shader.SetTexture("_Overlay1Tex", overlay1);
        shader.SetTexture("_Overlay2Tex", overlay2);

        shader.SetFloat("_Monochrome", 1);
        shader.SetColor("_MonoColor", new Color(.3f, .17f, .013f, 1));
        shader.SetFloat("_Contrast", contrast);
        shader.SetFloat("_Brightness", brightness);
        shader.SetFloat("_BrightnessJitter", brightnessJitter.NextValue());

        shader.SetFloat("_VignetteAmount", vignetteAmount);
        shader.SetFloat("_MainOffsetX", vignetteXJitter.NextValue());
        shader.SetFloat("_MainOffsetY", vignetteYJitter.NextValue());
        shader.SetFloat("_VignetteOffsetX", vignetteXJitter.Value());
        shader.SetFloat("_VignetteOffsetY", vignetteYJitter.Value());

        shader.SetFloat("_Overlay1Amount", overlay1Amount);
        shader.SetFloat("_Overlay1SpeedY", -50);
        shader.SetFloat("_Overlay1OffsetX", overlay1XJitter.NextValue());

        shader.SetFloat("_Overlay2Amount", overlay2Amount);
        shader.SetFloat("_Overlay2OffsetX", overlay2XJitter.NextValue());
        shader.SetFloat("_Overlay2OffsetY", overlay2YJitter.NextValue());

        Graphics.Blit(source, target, shader);
      } else {
        base.RenderImageWithFilter(source, target);
      }
    }

    public static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("CameraFilterSepiaFilm");
      contrast = settings.Get<float>("Contrast", contrast);
      brightness = settings.Get<float>("Brightness", brightness);
      vignetteAmount = settings.Get<float>("VignetteAmount", vignetteAmount);
      overlay1Amount = settings.Get<float>("Overlay1Amount", overlay1Amount);
      overlay2Amount = settings.Get<float>("Overlay2Amount", overlay2Amount);
    }

    public static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("CameraFilterSepiaFilm");
      settings.Set<float>("Contrast", contrast);
      settings.Set<float>("Brightness", brightness);
      settings.Set<float>("VignetteAmount", vignetteAmount);
      settings.Set<float>("Overlay1Amount", overlay1Amount);
      settings.Set<float>("Overlay2Amount", overlay2Amount);
    }
  }
}