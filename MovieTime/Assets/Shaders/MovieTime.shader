// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 19.7KB

Shader "Custom/MovieTime" {
Properties {
 _MainTex ("Base Texture", 2D) = "white" {}
 _VignetteTex ("Vignette Texture", 2D) = "white" {}
 _Overlay1Tex ("Overlay 1 Texture", 2D) = "white" {}
 _Overlay2Tex ("Overlay 2 Texture", 2D) = "white" {}
 _MonoColor ("Monochrome Color", Color) = (0,0,0,0)
 _Contrast ("Contrast", Range(0,4)) = 2
 _Brightness ("Brightness", Range(0,2)) = 1
 _XSpeedOverlay1 ("Overlay 1 X Speed", Float) = 0
 _YSpeedOverlay1 ("Overlay 1 Y Speed", Float) = 0
 _XSpeedOverlay2 ("Overlay 2 X Speed", Float) = 0
 _YSpeedOverlay2 ("Overlay 2 Y Speed", Float) = 0
 _Monochrome ("Monochrome", Float) = 1
 _VignetteAmount ("Vignette Amount", Range(0,1)) = 1
 _Overlay1Amount ("Overlay 1 Amount", Range(0,1)) = 1
 _Overlay2Amount ("Overlay 2 Amount", Range(0,1)) = 1
 _MainTexJitter ("Base Texture Jitter", Range(0,1)) = 0
 _VignetteJitter ("Vignette Jitter", Range(0,1)) = 0
 _Overlay1Jitter ("Overlay 1 Jitter", Range(0,1)) = 0
 _Overlay2Jitter ("Overlay 2 Jitter", Range(0,1)) = 0
 _ColorJitter ("Color Jitter", Range(0.9,1.1)) = 1
 _ContrastJitter ("Contrast Jitter", Range(0.9,1.1)) = 1
 _BrightnessJitter ("Brightness Jitter", Range(0.9,1.1)) = 1
}
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 6 math
 //    d3d11_9x : 6 math
 //        d3d9 : 8 math
 //      opengl : 8 math
 // Stats for Fragment shader:
 //       d3d11 : 27 math, 4 texture
 //    d3d11_9x : 27 math, 4 texture
 //        d3d9 : 51 math, 4 texture
 //      opengl : 52 math, 4 texture
 Pass {
Program "vp" {
SubProgram "opengl " {
// Stats: 8 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[9] = { { 0 },
		state.matrix.mvp,
		state.matrix.texture[0] };
TEMP R0;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[0].y, R0, c[6];
DP4 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
"vs_2_0
def c8, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c8.x
mov r0.xy, v1
dp4 oT0.y, r0, c5
dp4 oT0.x, r0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0
eefiecedeedelkdobbmimfefjdhgabnhlefmpcmlabaaaaaaciacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceiabaaaa
eaaaabaafcaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaccaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaafgbfbaaaabaaaaaaegiacaaaabaaaaaacbaaaaaadcaaaaak
dccabaaaabaaaaaaegiacaaaabaaaaaacaaaaaaaagbabaaaabaaaaaaegaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 6 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0_level_9_1
eefieceddhnbicbokkmhnihbiniipgnpnicndjjjabaaaaaaceadaaaaaeaaaaaa
daaaaaaaciabaaaahiacaaaammacaaaaebgpgodjpaaaaaaapaaaaaaaaaacpopp
laaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaabaacaaaacaaafaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaadiaabaaffja
agaaoekaaeaaaaaeaaaaadoaafaaoekaabaaaajaaaaaoeiaafaaaaadaaaaapia
aaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefceiabaaaaeaaaabaafcaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaccaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaabaaaaaa
egiacaaaabaaaaaacbaaaaaadcaaaaakdccabaaaabaaaaaaegiacaaaabaaaaaa
caaaaaaaagbabaaaabaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 52 math, 4 textures
Vector 0 [_Time]
Vector 1 [_SinTime]
Vector 2 [_MonoColor]
Float 3 [_Contrast]
Float 4 [_Brightness]
Float 5 [_XSpeedOverlay1]
Float 6 [_YSpeedOverlay1]
Float 7 [_XSpeedOverlay2]
Float 8 [_YSpeedOverlay2]
Float 9 [_Monochrome]
Float 10 [_VignetteAmount]
Float 11 [_Overlay1Amount]
Float 12 [_Overlay2Amount]
Float 13 [_MainTexJitter]
Float 14 [_VignetteJitter]
Float 15 [_Overlay1Jitter]
Float 16 [_Overlay2Jitter]
Float 17 [_ColorJitter]
Float 18 [_ContrastJitter]
Float 19 [_BrightnessJitter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[22] = { program.local[0..19],
		{ 1, 0, 0.5, 0.099975586 },
		{ 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0.x, c[1].z;
MUL R0.y, R0.x, c[15].x;
MUL R0.x, R0, c[16];
MAD R1.z, R0.y, c[5].x, fragment.texcoord[0].x;
MOV R0.y, c[6].x;
MAD R1.w, R0.y, c[0].x, fragment.texcoord[0].y;
MAD R2.x, R0, c[7], fragment.texcoord[0];
MAD R2.y, R0.x, c[8].x, fragment.texcoord[0];
MOV R3.w, c[17].x;
MOV R5.xyz, c[2];
MAD R5.xyz, R3.w, c[20].w, R5;
MOV R3.w, c[20].z;
MOV R1.x, fragment.texcoord[0];
ADD R1.y, fragment.texcoord[0], c[14].x;
ADD R0.y, fragment.texcoord[0], c[13].x;
MOV R0.x, fragment.texcoord[0];
MUL R3.w, R3, c[18].x;
TEX R0, R0, texture[0], 2D;
TEX R3.xyz, R2, texture[3], 2D;
TEX R2.xyz, R1.zwzw, texture[2], 2D;
TEX R1.xyz, R1, texture[1], 2D;
ABS R1.w, c[9].x;
DP3 R2.w, R0, c[21];
CMP R0.xyz, -R1.w, R2.w, R0;
ADD R4.xyz, R0, -c[20].z;
MUL R4.xyz, R4, c[3].x;
MUL R4.xyz, R4, c[18].x;
MUL R4.xyz, R4, c[20].z;
CMP R0.xyz, -R1.w, R4, R0;
MOV R2.w, c[19].x;
MAD R4.xyz, R2.w, c[4].x, R0;
CMP R0.xyz, -R1.w, R4, R0;
ADD R4.xyz, R0, R5;
CMP R0.xyz, -R1.w, R4, R0;
ADD R4.xyz, R0, -c[20].z;
CMP R1.w, -R1, c[20].x, c[20].y;
ABS R1.w, R1;
ADD R5.xyz, -R1, c[20].x;
MAD R4.xyz, R4, c[3].x, R3.w;
CMP R1.w, -R1, c[20].y, c[20].x;
CMP R0.xyz, -R1.w, R4, R0;
MAD R4.xyz, R2.w, c[4].x, R0;
CMP R0.xyz, -R1.w, R4, R0;
MAD R1.xyz, R5, c[10].x, R1;
MUL R0.xyz, R0, R1;
ADD R1.xyz, -R2, c[20].x;
MAD R1.xyz, R1, c[11].x, R2;
ADD R4.xyz, -R3, c[20].x;
MAD R2.xyz, R4, c[12].x, R3;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, R2;
MOV result.color.w, R0;
END
# 52 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 51 math, 4 textures
Vector 0 [_Time]
Vector 1 [_SinTime]
Vector 2 [_MonoColor]
Float 3 [_Contrast]
Float 4 [_Brightness]
Float 5 [_XSpeedOverlay1]
Float 6 [_YSpeedOverlay1]
Float 7 [_XSpeedOverlay2]
Float 8 [_YSpeedOverlay2]
Float 9 [_Monochrome]
Float 10 [_VignetteAmount]
Float 11 [_Overlay1Amount]
Float 12 [_Overlay2Amount]
Float 13 [_MainTexJitter]
Float 14 [_VignetteJitter]
Float 15 [_Overlay1Jitter]
Float 16 [_Overlay2Jitter]
Float 17 [_ColorJitter]
Float 18 [_ContrastJitter]
Float 19 [_BrightnessJitter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c20, 0.00000000, 1.00000000, -0.50000000, 0.09997559
def c21, 0.29907227, 0.58691406, 0.11401367, 0.50000000
dcl t0.xy
mov r2.x, c0
mov r1.x, c15
mul r1.x, c1.z, r1
mad r3.x, r1, c5, t0
mad r3.y, c6.x, r2.x, t0
mov r1.x, c16
mul r1.x, c1.z, r1
mad r1.y, r1.x, c8.x, t0
mad r1.x, r1, c7, t0
mov_pp r0.x, t0
add_pp r0.y, t0, c14.x
mov_pp r4.x, t0
add_pp r4.y, t0, c13.x
mov_pp r0.w, c20
mov_pp r6.xyz, c2
mad_pp r6.xyz, c17.x, r0.w, r6
texld r2, r1, s3
texld r1, r4, s0
texld r4, r0, s1
texld r3, r3, s2
abs_pp r0.x, c9
dp3_pp r5.x, r1, c21
cmp_pp r1.xyz, -r0.x, r1, r5.x
add r5.xyz, r1, c20.z
mul r5.xyz, r5, c3.x
mul r5.xyz, r5, c18.x
mul r5.xyz, r5, c21.w
cmp_pp r1.xyz, -r0.x, r1, r5
mov_pp r5.x, c4
mad_pp r5.xyz, c19.x, r5.x, r1
cmp_pp r1.xyz, -r0.x, r1, r5
add_pp r5.xyz, r1, r6
cmp_pp r5.xyz, -r0.x, r1, r5
mov r1.x, c18
abs_pp r0.x, c9
cmp_pp r0.x, -r0, c20, c20.y
add r6.xyz, r5, c20.z
mul r1.x, c21.w, r1
mad r1.xyz, r6, c3.x, r1.x
abs_pp r0.x, r0
cmp_pp r5.xyz, -r0.x, r1, r5
mov_pp r1.x, c4
mad_pp r1.xyz, c19.x, r1.x, r5
cmp_pp r0.xyz, -r0.x, r1, r5
add_pp r6.xyz, -r4, c20.y
mad_pp r1.xyz, r6, c10.x, r4
mul_pp r0.xyz, r0, r1
add_pp r1.xyz, -r3, c20.y
mad_pp r1.xyz, r1, c11.x, r3
mul_pp r0.xyz, r0, r1
add_pp r3.xyz, -r2, c20.y
mad_pp r1.xyz, r3, c12.x, r2
mov_pp r0.w, r1
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 27 math, 4 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
ConstBuffer "$Globals" 112
Vector 16 [_MonoColor]
Float 32 [_Contrast]
Float 36 [_Brightness]
Float 40 [_XSpeedOverlay1]
Float 44 [_YSpeedOverlay1]
Float 48 [_XSpeedOverlay2]
Float 52 [_YSpeedOverlay2]
Float 56 [_Monochrome]
Float 60 [_VignetteAmount]
Float 64 [_Overlay1Amount]
Float 68 [_Overlay2Amount]
Float 72 [_MainTexJitter]
Float 76 [_VignetteJitter]
Float 80 [_Overlay1Jitter]
Float 84 [_Overlay2Jitter]
Float 88 [_ColorJitter]
Float 92 [_ContrastJitter]
Float 96 [_BrightnessJitter]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 16 [_SinTime]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkliammjodjpdniokllalpfbjpjhmkfaaabaaaaaaeeagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieafaaaa
eaaaaaaagbabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaajbcaabaaa
aaaaaaaabkiacaaaaaaaaaaaacaaaaaaakiacaaaaaaaaaaaagaaaaaaaaaaaaai
dcaabaaaabaaaaaafgbfbaaaabaaaaaaogikcaaaaaaaaaaaaeaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaabaaaaaakccaabaaa
aaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaegacbaaaacaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaalpdiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpakaabaaaaaaaaaaa
dcaaaaaoocaabaaaaaaaaaaakgikcaaaaaaaaaaaafaaaaaaaceaaaaaaaaaaaaa
mnmmmmdnmnmmmmdnmnmmmmdnagijcaaaaaaaaaaaabaaaaaaaaaaaaahhcaabaaa
aaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadjaaaaaiicaabaaaaaaaaaaa
ckiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkiacaaa
aaaaaaaaafaaaaaaabeaaaaaaaaaaadpdcaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaagiacaaaaaaaaaaaacaaaaaapgapbaaaabaaaaaadcaaaaalhcaabaaa
acaaaaaafgifcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaaegacbaaa
acaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalccaabaaa
abaaaaaaakiacaaaabaaaaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaabkbabaaa
abaaaaaadiaaaaajmcaabaaaabaaaaaaagiecaaaaaaaaaaaafaaaaaakgikcaaa
abaaaaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaaabaaaaaackiacaaa
aaaaaaaaacaaaaaaakbabaaaabaaaaaadcaaaaakmcaabaaaabaaaaaapgapbaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaa
aeaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaak
hcaabaaaabaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 27 math, 4 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
ConstBuffer "$Globals" 112
Vector 16 [_MonoColor]
Float 32 [_Contrast]
Float 36 [_Brightness]
Float 40 [_XSpeedOverlay1]
Float 44 [_YSpeedOverlay1]
Float 48 [_XSpeedOverlay2]
Float 52 [_YSpeedOverlay2]
Float 56 [_Monochrome]
Float 60 [_VignetteAmount]
Float 64 [_Overlay1Amount]
Float 68 [_Overlay2Amount]
Float 72 [_MainTexJitter]
Float 76 [_VignetteJitter]
Float 80 [_Overlay1Jitter]
Float 84 [_Overlay2Jitter]
Float 88 [_ColorJitter]
Float 92 [_ContrastJitter]
Float 96 [_BrightnessJitter]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 16 [_SinTime]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedjbnniljmafjfjnpmehlcakjngfdgoaaiabaaaaaaliajaaaaaeaaaaaa
daaaaaaakaadaaaacmajaaaaieajaaaaebgpgodjgiadaaaagiadaaaaaaacpppp
bmadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaaaaaaaaa
abababaaacacacaaadadadaaaaaaabaaagaaaaaaaaaaaaaaabaaaaaaacaaagaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaalp
fbaaaaafajaaapkamnmmmmdnaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaacaaaaadaaaacciaaaaaffla
adaakkkaabaaaaacaaaaabiaaaaaaalaacaaaaadabaacciaaaaafflaadaappka
abaaaaacabaaabiaaaaaaalaabaaaaacacaaapiaaeaaoekaafaaaaadaaaaaeia
acaaaaiaahaakkkaaeaaaaaeadaacbiaaaaakkiaabaakkkaaaaaaalaabaaaaac
aeaaakiaabaaoekaaeaaaaaeadaacciaagaaaakaaeaappiaaaaafflaafaaaaad
aaaaaeiaacaaffiaahaakkkaaeaaaaaeacaacbiaaaaakkiaacaaaakaaaaaaala
aeaaaaaeacaacciaaaaakkiaacaaffkaaaaafflaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadabaacpiaabaaoeiaabaioekaecaaaaadadaacpiaadaaoeia
acaioekaecaaaaadafaacpiaacaaoeiaadaioekaaiaaaaadabaaciiaaiaaoeka
aaaaoeiaacaaaaadabaaaiiaabaappiaaiaappkaafaaaaadabaaaiiaabaappia
abaaaakaafaaaaadabaaaiiaabaappiaaeaappkaafaaaaadadaaciiaaeaaffia
afaaaakaaeaaaaaeabaaciiaabaappiaaiaappkbadaappiaabaaaaacadaaaiia
ajaaaakaaeaaaaaeacaachiaacaakkiaadaappiaaaaaoekaacaaaaadacaachia
abaappiaacaaoeiaacaaaaadagaaahiaaaaaoeiaaiaappkaafaaaaadabaaaiia
acaappiaaiaappkbaeaaaaaeagaachiaagaaoeiaabaaaakaabaappiaaeaaaaae
aeaachiaaeaaffiaafaaaakaagaaoeiaafaaaaadabaaaiiaacaakkkaacaakkka
fiaaaaaeacaachiaabaappibaeaaoeiaacaaoeiaacaaaaadaeaachiaabaaoeib
ajaaffkaaeaaaaaeabaachiaacaappkaaeaaoeiaabaaoeiaafaaaaadabaachia
abaaoeiaacaaoeiaacaaaaadacaachiaadaaoeibajaaffkaaeaaaaaeacaachia
adaaaakaacaaoeiaadaaoeiaafaaaaadabaachiaabaaoeiaacaaoeiaacaaaaad
acaachiaafaaoeibajaaffkaaeaaaaaeacaachiaadaaffkaacaaoeiaafaaoeia
afaaaaadaaaachiaabaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcieafaaaaeaaaaaaagbabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
diaaaaajbcaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaaakiacaaaaaaaaaaa
agaaaaaaaaaaaaaidcaabaaaabaaaaaafgbfbaaaabaaaaaaogikcaaaaaaaaaaa
aeaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
baaaaaakccaabaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
egacbaaaacaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaalpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadp
akaabaaaaaaaaaaadcaaaaaoocaabaaaaaaaaaaakgikcaaaaaaaaaaaafaaaaaa
aceaaaaaaaaaaaaamnmmmmdnmnmmmmdnmnmmmmdnagijcaaaaaaaaaaaabaaaaaa
aaaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaadjaaaaai
icaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaak
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaiicaabaaa
abaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaadpdcaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaagiacaaaaaaaaaaaacaaaaaapgapbaaaabaaaaaa
dcaaaaalhcaabaaaacaaaaaafgifcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
agaaaaaaegacbaaaacaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaak
hcaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalccaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaadkiacaaaaaaaaaaa
acaaaaaabkbabaaaabaaaaaadiaaaaajmcaabaaaabaaaaaaagiecaaaaaaaaaaa
afaaaaaakgikcaaaabaaaaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaa
abaaaaaackiacaaaaaaaaaaaacaaaaaaakbabaaaabaaaaaadcaaaaakmcaabaaa
abaaaaaapgapbaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaaagbebaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaakhcaabaaaabaaaaaafgifcaaaaaaaaaaaaeaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}