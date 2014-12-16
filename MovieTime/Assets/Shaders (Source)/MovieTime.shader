Shader "Custom/MovieTime" {
	Properties {
		_MainTex("Base Texture", 2D)="white" {}
		_VignetteTex("Vignette Texture", 2D)="white" {}
		_Overlay1Tex("Overlay 1 Texture", 2D)="white" {}
		_Overlay2Tex("Overlay 2 Texture", 2D)="white" {}

		_MonoColor("Monochrome Color", Color)=(0,0,0,0)
		_Contrast("Contrast", Range(0,4))=2
		_Brightness("Brightness", Range(0,2))=1

		_XSpeedOverlay1("Overlay 1 X Speed", Float)=0
		_YSpeedOverlay1("Overlay 1 Y Speed", Float)=0
		_XSpeedOverlay2("Overlay 2 X Speed", Float)=0
		_YSpeedOverlay2("Overlay 2 Y Speed", Float)=0

		_Monochrome("Monochrome", Float) = 1
		_VignetteAmount("Vignette Amount", Range(0,1)) = 1
		_Overlay1Amount("Overlay 1 Amount", Range(0,1)) = 1
		_Overlay2Amount("Overlay 2 Amount", Range(0,1)) = 1

		_MainTexJitter("Base Texture Jitter", Range(0,1))=0
		_VignetteJitter("Vignette Jitter", Range(0,1))=0
		_Overlay1Jitter("Overlay 1 Jitter", Range(0,1))=0
		_Overlay2Jitter("Overlay 2 Jitter", Range(0,1))=0

		_ColorJitter("Color Jitter", Range(.9,1.1))=1
		_ContrastJitter("Contrast Jitter", Range(.9,1.1))=1
		_BrightnessJitter("Brightness Jitter", Range(.9,1.1))=1
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform sampler2D _VignetteTex;
			uniform sampler2D _Overlay1Tex;
			uniform sampler2D _Overlay2Tex;

			fixed4 _MonoColor;
			fixed _Contrast;
			fixed _Brightness;

			fixed _XSpeedOverlay1;
			fixed _YSpeedOverlay1;
			fixed _XSpeedOverlay2;
			fixed _YSpeedOverlay2;

			fixed _Monochrome;
			fixed _VignetteAmount;
			fixed _Overlay1Amount;
			fixed _Overlay2Amount;

			fixed _MainTexJitter;
			fixed _VignetteJitter;
			fixed _Overlay1Jitter;
			fixed _Overlay2Jitter;

			fixed _ColorJitter;
			fixed _ContrastJitter;
			fixed _BrightnessJitter;

			fixed4 frag(v2f_img i) : COLOR {
				fixed3 constantWhite = fixed3(1,1,1);

				half2 renderTexUV = half2(i.uv.x, i.uv.y+(_MainTexJitter * _SinTime.z * 0.005));
				fixed4 renderTex = tex2D(_MainTex, renderTexUV);

				fixed4 vignetteTex = tex2D(_VignetteTex, i.uv);

				half2 overlay1UV = half2(i.uv.x + (_Overlay1Jitter * _SinTime.z * _XSpeedOverlay1), i.uv.y + (_Time.x * _YSpeedOverlay1));
				fixed4 overlay1Tex = tex2D(_Overlay1Tex, overlay1UV);

				half2 overlay2UV = half2(i.uv.x + (_Overlay2Jitter * _SinTime.z * _XSpeedOverlay2), i.uv.y + (_Overlay2Jitter * _SinTime.z * _YSpeedOverlay2));
				fixed4 overlay2Tex = tex2D(_Overlay2Tex, overlay2UV);

				if (_Monochrome!=0) {
					renderTex.rgb = dot(fixed3(0.299, 0.587, 0.114), renderTex.rgb);
					renderTex.rgb = (renderTex.rgb - 0.5f) * _Contrast * _ContrastJitter * 0.5f;
					renderTex.rgb += _Brightness * _BrightnessJitter;
					renderTex.rgb += lerp(_MonoColor, _MonoColor + fixed4(0.1f, 0.1f, 0.1f, 0.1f), _ColorJitter);
				} else {
					/*renderTex.rgb /= renderTex.a;*/
					/*renderTex.rgb = (renderTex.rgb - 0.5f) * _Contrast + _ContrastJitter * 0.5f;*/
					renderTex.rgb += _Brightness/* * _BrightnessJitter*/;
					/*renderTex.rgb *= renderTex.a * _ColorJitter;*/
					/*renderTex.rgb *= renderTex.a;*/
				}

				renderTex.rgb *= lerp(vignetteTex.rgb, constantWhite, _VignetteAmount);
				renderTex.rgb *= lerp(overlay1Tex.rgb, constantWhite, _Overlay1Amount);
				renderTex.rgb *= lerp(overlay2Tex.rgb, constantWhite, _Overlay2Amount);
				return renderTex;
			}
			ENDCG
		}
	} 
	FallBack "Diffuse"
}