// CameraFilterBlackAndWhiteFilm.cs
//
// Author: Marc Bernier
//   Date: 2014-11-16

using UnityEngine;

namespace MovieTime {
  public class CameraFilterBlackAndWhiteFilm : CameraFilter {
    private static float contrast = 4;
    private static float brightness = .41f;

    private static float overlay1XSpeed = 0;
    private static float overlay1YSpeed = -50;
    private static float overlay2XSpeed = 0;
    private static float overlay2YSpeed = 0;

    private static float vignetteAmount = .45f;
    private static float overlay1Amount = .6f;
    private static float overlay2Amount = .65f;

    private Material shader = null;

    private Texture2D vignette = null;
    private Texture2D overlay1 = null;
    private Texture2D overlay2 = null;

    public CameraFilterBlackAndWhiteFilm() : base() { }

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

    private float jitterState = 0;

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      if (shader != null && vignette != null && overlay1 != null && overlay2 != null) {
        shader.SetTexture("_VignetteTex", vignette);
        shader.SetTexture("_Overlay1Tex", overlay1);
        shader.SetTexture("_Overlay2Tex", overlay2);

        shader.SetFloat("_Monochrome", 1);
        shader.SetColor("_MonoColor", new Color(.5f, .5f, .5f, 1));
        shader.SetFloat("_Contrast", contrast);
        shader.SetFloat("_Brightness", brightness);

        shader.SetFloat("_XSpeedOverlay1", overlay1XSpeed);
        shader.SetFloat("_YSpeedOverlay1", overlay1YSpeed);
        shader.SetFloat("_XSpeedOverlay2", overlay2XSpeed);
        shader.SetFloat("_YSpeedOverlay2", overlay2YSpeed);

        shader.SetFloat("_VignetteAmount", vignetteAmount);
        shader.SetFloat("_Overlay1Amount", overlay1Amount);
        shader.SetFloat("_Overlay2Amount", overlay2Amount);

        jitterState = RandomJitterState(jitterState, -.001f, .001f, .0005f);

        shader.SetFloat("_MainTexJitter", jitterState);
        shader.SetFloat("_VignetteJitter", jitterState);
        shader.SetFloat("_Overlay1Jitter", RandomJitter(-.25f, .25f));
        shader.SetFloat("_Overlay2Jitter", RandomJitter(-.25f, .25f));
        shader.SetFloat("_BrightnessJitter", RandomJitter(.95f, 1.05f));

        Graphics.Blit(source, target, shader);
      } else {
        base.RenderImageWithFilter(source, target);
      }
    }

    public static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("CameraFilterBlackAndWhiteFilm");
      contrast = settings.Get<float>("Contrast", contrast);
      brightness = settings.Get<float>("Brightness", brightness);
      overlay1XSpeed = settings.Get<float>("Overlay1XSpeed", overlay1XSpeed);
      overlay1YSpeed = settings.Get<float>("Overlay1YSpeed", overlay1YSpeed);
      overlay2XSpeed = settings.Get<float>("Overlay2XSpeed", overlay2XSpeed);
      overlay2YSpeed = settings.Get<float>("Overlay2YSpeed", overlay2YSpeed);
      vignetteAmount = settings.Get<float>("VignetteAmount", vignetteAmount);
      overlay1Amount = settings.Get<float>("Overlay1Amount", overlay1Amount);
      overlay2Amount = settings.Get<float>("Overlay2Amount", overlay2Amount);
    }

    public static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("CameraFilterBlackAndWhiteFilm");
      settings.Set<float>("Contrast", contrast);
      settings.Set<float>("Brightness", brightness);
      settings.Set<float>("Overlay1XSpeed", overlay1XSpeed);
      settings.Set<float>("Overlay1YSpeed", overlay1YSpeed);
      settings.Set<float>("Overlay2XSpeed", overlay2XSpeed);
      settings.Set<float>("Overlay2YSpeed", overlay2YSpeed);
      settings.Set<float>("VignetteAmount", vignetteAmount);
      settings.Set<float>("Overlay1Amount", overlay1Amount);
      settings.Set<float>("Overlay2Amount", overlay2Amount);
    }
  }
}