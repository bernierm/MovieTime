// CameraFilterNormal.cs
//
// Author: Marc Bernier
//   Date: 2014-11-15

using UnityEngine;

namespace MovieTime {
  public class CameraFilterNormal : CameraFilter {

    public CameraFilterNormal() : base() { }

    public override bool Activate() {
      return true;
    }

    public override void RenderImageWithFilter(RenderTexture source, RenderTexture target) {
      Graphics.Blit(source, target);
    }
  }
}