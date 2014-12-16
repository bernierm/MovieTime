﻿// CameraFilterColorLoResTV.cs
//
// Author: Marc Bernier
//   Date: 2014-11-18

using System;
using UnityEngine;

namespace MovieTime {
  public class CameraFilterColorLoResTV : CameraFilter {
    private static float brightness = .56f;

    private static float vignetteAmount = .9f;
    private static float overlay1Amount = .4f;
    private static float overlay2Amount = .56f;
    private static int rollFrequency = 25;
    private static float rollSpeed = .01f;

    private Material shader = null;

    private Texture2D vignette = null;
    private Texture2D overlay1 = null;
    private Texture2D overlay2 = null;

    private DateTime rollTime = DateTime.Now;
    private bool rolling = false;
    private float rollOffset = 0;

    public CameraFilterColorLoResTV() : base() { }

    public override bool Activate() {
      shader = LoadShaderFile("MovieTime.shader");
      vignette = LoadTextureFile("VHold.png");
      overlay1 = LoadTextureFile("CRTMesh.png");
      overlay2 = LoadTextureFile("Noise.png");

      if (shader != null && vignette != null && overlay1 != null && overlay2 != null)
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
      brightness = GetSliderValue("Brightness:", brightness, 0, 2);
      overlay1Amount = GetSliderValue("CRT Mesh:", overlay1Amount, 0, 1);
      overlay2Amount = GetSliderValue("Snow:", overlay2Amount, 0, 1);
      vignetteAmount = GetSliderValue("V-Hold Bar:", vignetteAmount, 0, 1);
      rollSpeed = GetSliderValue("V-Hold Speed:", rollSpeed, -.05f, .05f);
      rollFrequency = (int)GetSliderValue("V-Hold Frequency:", rollFrequency, 0, 30);
      GUILayout.EndVertical();
    }

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      if (shader != null && overlay1 != null && overlay2 != null) {
        shader.SetTexture("_VignetteTex", vignette);
        shader.SetTexture("_Overlay1Tex", overlay1);
        shader.SetTexture("_Overlay2Tex", overlay2);

        shader.SetFloat("_Monochrome", 0);
        shader.SetFloat("_Brightness", brightness);

        shader.SetFloat("_VignetteAmount", vignetteAmount);
        shader.SetFloat("_Overlay1Amount", overlay1Amount);
        shader.SetFloat("_Overlay2Amount", overlay2Amount);

        if (!rolling && rollFrequency > 0 && (DateTime.Now - rollTime).TotalSeconds >= rollFrequency) {
          rolling = true;
          rollOffset = 0;
        } else if (rolling && rollOffset >= 1) {
          rolling = false;
          rollTime = DateTime.Now;
        }

        if (rolling) {
          rollOffset += rollSpeed;
          shader.SetFloat("_VignetteJitter", rollOffset);
          shader.SetFloat("_MainTexJitter", rollOffset);
        }

        vignette.wrapMode = TextureWrapMode.Repeat;
        source.wrapMode = TextureWrapMode.Repeat;

        Graphics.Blit(source, target, shader);
      } else {
        base.RenderImageWithFilter(source, target);
      }
    }

    public static void LoadSettings(LoadSettings settings) {
      settings.SelectNode("CameraFilterColorLoResTV");
      brightness = settings.Get<float>("Brightness", brightness);
      vignetteAmount = settings.Get<float>("VignetteAmount", vignetteAmount);
      overlay1Amount = settings.Get<float>("Overlay1Amount", overlay1Amount);
      overlay2Amount = settings.Get<float>("Overlay2Amount", overlay2Amount);
      rollFrequency = settings.Get<int>("RollFrequency", rollFrequency);
      rollSpeed = settings.Get<float>("RollSpeed", rollSpeed);
    }

    public static void SaveSettings(SaveSettings settings) {
      settings.SelectNode("CameraFilterColorLoResTV");
      settings.Set<float>("Brightness", brightness);
      settings.Set<float>("VignetteAmount", vignetteAmount);
      settings.Set<float>("Overlay1Amount", overlay1Amount);
      settings.Set<float>("Overlay2Amount", overlay2Amount);
      settings.Set<int>("RollFrequency", rollFrequency);
      settings.Set<float>("RollSpeed", rollSpeed);
    }
  }
}