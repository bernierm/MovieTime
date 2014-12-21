// CameraFilterBlackAndWhiteHiResTV.cs
//
// Author: Marc Bernier
//   Date: 2014-11-18

using UnityEngine;

namespace MovieTime {
  public class CameraFilterBlackAndWhiteHiResTV : CameraFilter {
    private static float contrast = 4;
    private static float brightness = .31f;

    private static float vignetteAmount = .75f;
    private static float overlay1Amount = .86f;
    private static float overlay2Amount = .86f;
    private static int rollFrequency = 20;
    private static float rollSpeed = .04f;

    private Material shader = null;

    private Texture2D vignette = null;
    private Texture2D overlay1 = null;
    private Texture2D overlay2 = null;

    private RandomJitter overlay2Jitter = new RandomJitter(0, 1, 1, 0);
    private VHoldRoller vHoldRoller = new VHoldRoller();

    public CameraFilterBlackAndWhiteHiResTV() : base() { }

    public override bool Activate() {
      shader = LoadShaderFile("MovieTime.shader");
      vignette = LoadTextureFile("VHold.png");
      overlay1 = LoadTextureFile("CRTMesh.png");
      overlay2 = LoadTextureFile("Noise.png");

      if (shader != null && vignette != null && overlay1 != null && overlay2 != null) {
        vignette.wrapMode = TextureWrapMode.Repeat;
        overlay2.wrapMode = TextureWrapMode.Repeat;
        vHoldRoller.SetRollSpeed(rollSpeed);
        vHoldRoller.SetRollFrequency(rollFrequency);
        return true;
      }

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
      overlay1Amount = GetSliderValue("CRT Mesh:", overlay1Amount, 0, 1);
      overlay2Amount = GetSliderValue("Snow:", overlay2Amount, 0, 1);
      vignetteAmount = GetSliderValue("V-Hold Bar:", vignetteAmount, 0, 1);
      rollSpeed = GetSliderValue("V-Hold Speed:", rollSpeed, -.05f, .05f);
      rollFrequency = (int)GetSliderValue("V-Hold Frequency:", rollFrequency, 0, 30);
      GUILayout.EndVertical();

      vHoldRoller.SetRollSpeed(rollSpeed);
      vHoldRoller.SetRollFrequency(rollFrequency);
    }

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      if (shader != null && overlay1 != null && overlay2 != null) {
        shader.SetTexture("_VignetteTex", vignette);
        shader.SetTexture("_Overlay1Tex", overlay1);
        shader.SetTexture("_Overlay2Tex", overlay2);

        shader.SetFloat("_Monochrome", 1);
        shader.SetColor("_MonoColor", new Color(.5f, .5f, .5f, 1));
        shader.SetFloat("_Contrast", contrast);
        shader.SetFloat("_Brightness", brightness);

        source.wrapMode = TextureWrapMode.Repeat;
        shader.SetFloat("_VignetteAmount", vignetteAmount);
        shader.SetFloat("_VignetteOffsetY", vHoldRoller.CalculcateRollOffset());
        shader.SetFloat("_MainOffsetY", vHoldRoller.CalculcateRollOffset());

        shader.SetFloat("_Overlay1Amount", overlay1Amount);

        shader.SetFloat("_Overlay2Amount", overlay2Amount);
        shader.SetFloat("_Overlay2OffsetX", overlay2Jitter.NextValue());
        shader.SetFloat("_Overlay2OffsetY", overlay2Jitter.NextValue());

        Graphics.Blit(source, target, shader);
      } else {
        base.RenderImageWithFilter(source, target);
      }
    }

    public static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("CameraFilterBlackAndWhiteHiResTV");
      contrast = settings.Get<float>("Contrast", contrast);
      brightness = settings.Get<float>("Brightness", brightness);
      vignetteAmount = settings.Get<float>("VignetteAmount", vignetteAmount);
      overlay1Amount = settings.Get<float>("Overlay1Amount", overlay1Amount);
      overlay2Amount = settings.Get<float>("Overlay2Amount", overlay2Amount);
      rollFrequency = settings.Get<int>("RollFrequency", rollFrequency);
      rollSpeed = settings.Get<float>("RollSpeed", rollSpeed);
    }

    public static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("CameraFilterBlackAndWhiteHiResTV");
      settings.Set<float>("Contrast", contrast);
      settings.Set<float>("Brightness", brightness);
      settings.Set<float>("VignetteAmount", vignetteAmount);
      settings.Set<float>("Overlay1Amount", overlay1Amount);
      settings.Set<float>("Overlay2Amount", overlay2Amount);
      settings.Set<int>("RollFrequency", rollFrequency);
      settings.Set<float>("RollSpeed", rollSpeed);
    }
  }
}