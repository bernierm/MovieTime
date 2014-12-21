// CameraFilter.cs
//
// Author: Marc Bernier
//   Date: 2014-11-14

using System;
using System.IO;

using UnityEngine;

namespace MovieTime {

  // Base class for camera filters
  public class CameraFilter {
    public enum eCameraMode {
      Normal = 0,
      SepiaFilm = 1,
      BlackAndWhiteFilm = 2,
      BlackAndWhiteLoResTV = 3,
      BlackAndWhiteHiResTV = 4,
      ColorFilm = 5,
      ColorLoResTV = 6,
      ColorHiResTV = 7,
      NightVision = 8
    }

    // CameraFilter class factory:
    public static CameraFilter CreateFilter(eCameraMode cameraMode) {
      switch (cameraMode) {
      case eCameraMode.Normal:
        return new CameraFilterNormal();
      case eCameraMode.SepiaFilm:
        return new CameraFilterSepiaFilm();
      case eCameraMode.BlackAndWhiteFilm:
        return new CameraFilterBlackAndWhiteFilm();
      case eCameraMode.BlackAndWhiteLoResTV:
        return new CameraFilterBlackAndWhiteLoResTV();
      case eCameraMode.BlackAndWhiteHiResTV:
        return new CameraFilterBlackAndWhiteHiResTV();
      case eCameraMode.ColorFilm:
        return new CameraFilterColorFilm();
      case eCameraMode.ColorLoResTV:
        return new CameraFilterColorLoResTV();
      case eCameraMode.ColorHiResTV:
        return new CameraFilterColorHiResTV();
      case eCameraMode.NightVision:
        return new CameraFilterNightVision();
      }
      return null;
    }

    public static void LoadAllSettings(LoadSettings settings) {
      CameraFilterNormal.LoadSettings(settings);
      CameraFilterSepiaFilm.LoadSettings(settings);
      CameraFilterBlackAndWhiteFilm.LoadSettings(settings);
      CameraFilterBlackAndWhiteLoResTV.LoadSettings(settings);
      CameraFilterBlackAndWhiteHiResTV.LoadSettings(settings);
      CameraFilterColorFilm.LoadSettings(settings);
      CameraFilterColorLoResTV.LoadSettings(settings);
      CameraFilterColorHiResTV.LoadSettings(settings);
      CameraFilterNightVision.LoadSettings(settings);
    }

    public static void SaveAllSettings(SaveSettings settings) {
      CameraFilterNormal.SaveSettings(settings);
      CameraFilterSepiaFilm.SaveSettings(settings);
      CameraFilterBlackAndWhiteFilm.SaveSettings(settings);
      CameraFilterBlackAndWhiteLoResTV.SaveSettings(settings);
      CameraFilterBlackAndWhiteHiResTV.SaveSettings(settings);
      CameraFilterColorFilm.SaveSettings(settings);
      CameraFilterColorLoResTV.SaveSettings(settings);
      CameraFilterColorHiResTV.SaveSettings(settings);
      CameraFilterNightVision.SaveSettings(settings);
    }

    public CameraFilter() { }

    public virtual bool Activate() { return false; }

    public virtual void Deactivate() { }

    public virtual void OptionControls() { }

    public virtual void LateUpdate(bool cameraActivated) { }

    public virtual void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      Graphics.Blit(source, target);
    }

    protected bool GetToggleValue(string label, bool value) {
      GUILayout.BeginHorizontal();
      bool retVal = GUILayout.Toggle(value, label);
      GUILayout.EndHorizontal();
      return retVal;
    }

    protected float GetSliderValue(string label, float value, float leftValue, float rightValue) {
      GUILayout.BeginHorizontal();
      GUILayout.Label(label);
      float retVal = GUILayout.HorizontalSlider(value, leftValue, rightValue);
      GUILayout.Label(string.Format("{0:0.00}", value));
      GUILayout.EndHorizontal();
      return retVal;
    }

    public static Material LoadShaderFile(string fileName) {
      try {
        string path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/Shaders/" + fileName;

        StreamReader reader = new StreamReader(path);
        string shader = reader.ReadToEnd();
        reader.Close();
        return new Material(shader);
      } catch (Exception ex) {
        Debug.Log(string.Format("MovieTime: LoadShaderFile exception: {0}", ex.Message));
      }
      return null;
    }

    public static Texture2D LoadTextureFile(string fileName) {
      try {
        string path;

        if (Screen.height <= 850)
          path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/Textures/Low/" + fileName;
        else if (Screen.height <= 1000)
          path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/Textures/Medium/" + fileName;
        else
          path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/Textures/High/" + fileName;

        if (!File.Exists(path))
          path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/Textures/" + fileName;

        byte[] texture = File.ReadAllBytes(path);
        Texture2D retVal = new Texture2D(1, 1);
        retVal.LoadImage(texture);
        return retVal;
      } catch (Exception ex) {
        Debug.Log(string.Format("MovieTime: LoadTextureFile exception: {0}", ex.Message));
      }
      return null;
    }
  }
}