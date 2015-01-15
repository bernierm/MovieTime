// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 15.8KB

Shader "Custom/MovieTime" {
Properties {
 _MainTex ("Base Texture", 2D) = "white" {}
 _TitleTex ("Title Texture", 2D) = "black" {}
 _VignetteTex ("Vignette Texture", 2D) = "white" {}
 _Overlay1Tex ("Overlay 1 Texture", 2D) = "white" {}
 _Overlay2Tex ("Overlay 2 Texture", 2D) = "white" {}
 _Monochrome ("Monochrome", Float) = 1
 _MonoColor ("Monochrome Color", Color) = (0,0,0,0)
 _Contrast ("Contrast", Range(0,4)) = 2
 _Brightness ("Brightness", Range(0,2)) = 1
 _Title ("Overlay Title", Float) = 0
 _MainOffsetX ("Main Offset X", Range(0,1)) = 0
 _MainOffsetY ("Main Offset Y", Range(0,1)) = 0
 _MainSpeedX ("Main Speed X", Float) = 0
 _MainSpeedY ("Main Speed Y", Float) = 0
 _VignetteAmount ("Vignette Amount", Range(0,1)) = 1
 _VignetteOffsetX ("Vignette Offset X", Range(0,1)) = 0
 _VignetteOffsetY ("Vignette Offset Y", Range(0,1)) = 0
 _VignetteSpeedX ("Vignette Speed X", Float) = 0
 _VignetteSpeedY ("Vignette Speed Y", Float) = 0
 _Overlay1Amount ("Overlay 1 Amount", Range(0,1)) = 1
 _Overlay1OffsetX ("Overlay 1 Offset X", Range(0,1)) = 0
 _Overlay1OffsetY ("Overlay 1 Offset Y", Range(0,1)) = 0
 _Overlay1SpeedX ("Overlay 1 Speed X", Float) = 0
 _Overlay1SpeedY ("Overlay 1 Speed Y", Float) = 0
 _Overlay2Amount ("Overlay 2 Amount", Range(0,1)) = 1
 _Overlay2OffsetX ("Overlay 2 Offset X", Range(0,1)) = 0
 _Overlay2OffsetY ("Overlay 2 Offset Y", Range(0,1)) = 0
 _Overlay2SpeedX ("Overlay 2 Speed X", Float) = 0
 _Overlay2SpeedY ("Overlay 2 Speed Y", Float) = 0
 _ColorJitter ("Color Jitter", Range(0.9,1.1)) = 1
 _ContrastJitter ("Contrast Jitter", Range(0.9,1.1)) = 1
 _BrightnessJitter ("Brightness Jitter", Range(0.9,1.1)) = 1
}
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 6 math
 //        d3d9 : 8 math
 //      opengl : 8 math
 // Stats for Fragment shader:
 //       d3d11 : 42 math, 5 texture
 //        d3d9 : 78 math, 5 texture
 //      opengl : 81 math, 5 texture
 Pass {
Program "vp" {
SubProgram "opengl " {
// Stats: 8 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
def c8, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c8.x
mov r0.xy, v1
dp4 o1.y, r0, c5
dp4 o1.x, r0, c4
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
// Stats: 81 math, 5 textures
Vector 0 [_Time]
Float 1 [_Monochrome]
Vector 2 [_MonoColor]
Float 3 [_Contrast]
Float 4 [_Brightness]
Float 5 [_Title]
Float 6 [_MainOffsetX]
Float 7 [_MainOffsetY]
Float 8 [_MainSpeedX]
Float 9 [_MainSpeedY]
Float 10 [_VignetteAmount]
Float 11 [_VignetteOffsetX]
Float 12 [_VignetteOffsetY]
Float 13 [_VignetteSpeedX]
Float 14 [_VignetteSpeedY]
Float 15 [_Overlay1Amount]
Float 16 [_Overlay1OffsetX]
Float 17 [_Overlay1OffsetY]
Float 18 [_Overlay1SpeedX]
Float 19 [_Overlay1SpeedY]
Float 20 [_Overlay2Amount]
Float 21 [_Overlay2OffsetY]
Float 22 [_Overlay2SpeedX]
Float 23 [_Overlay2SpeedY]
Float 24 [_ColorJitter]
Float 25 [_ContrastJitter]
Float 26 [_BrightnessJitter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_TitleTex] 2D 1
SetTexture 2 [_VignetteTex] 2D 2
SetTexture 3 [_Overlay1Tex] 2D 3
SetTexture 4 [_Overlay2Tex] 2D 4
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[29] = { program.local[0..26],
		{ 1, 0, 0.5, 0.099975586 },
		{ 0.29907227, 0.58691406, 0.14404297, 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
ABS R0.w, c[1].x;
MOV R2.w, c[26].x;
ADD R0.x, fragment.texcoord[0].y, c[7];
MOV R0.y, c[9].x;
MAD R3.y, R0, c[0].x, R0.x;
ADD R0.x, fragment.texcoord[0], c[6];
MOV R0.y, c[8].x;
MAD R3.x, R0.y, c[0], R0;
TEX R1, R3, texture[0], 2D;
DP3 R0.x, R1, c[28].xyww;
CMP R0.xyz, -R0.w, R0.x, R1;
ADD R1.xyz, R0, -c[27].z;
MUL R1.xyz, R1, c[3].x;
MUL R1.xyz, R1, c[25].x;
MUL R1.xyz, R1, c[27].z;
CMP R0.xyz, -R0.w, R1, R0;
MAD R1.xyz, R2.w, c[4].x, R0;
CMP R0.xyz, -R0.w, R1, R0;
MOV R3.z, c[24].x;
MOV R2.xyz, c[2];
MAD R2.xyz, R3.z, c[27].w, R2;
ADD R1.xyz, R0, R2;
CMP R0.xyz, -R0.w, R1, R0;
MOV R2.x, c[27].z;
CMP R0.w, -R0, c[27].x, c[27].y;
ABS R0.w, R0;
CMP R0.w, -R0, c[27].y, c[27].x;
ADD R1.xyz, R0, -c[27].z;
MUL R2.x, R2, c[25];
MAD R1.xyz, R1, c[3].x, R2.x;
CMP R0.xyz, -R0.w, R1, R0;
MAD R1.xyz, R2.w, c[4].x, R0;
CMP R1.xyz, -R0.w, R1, R0;
TEX R0, R3, texture[1], 2D;
ABS R2.x, c[5];
CMP R2.x, -R2, c[27], c[27].y;
SGE R2.y, R0.w, c[27].x;
MUL R2.y, R2.x, R2;
CMP R1.xyz, -R2.y, R0, R1;
SLT R2.z, c[27].y, R0.w;
DP3 R3.x, R1, c[28];
MUL R2.z, R2.x, R2;
ABS R2.y, R2;
CMP R2.x, -R2.y, c[27].y, c[27];
MUL R2.w, R2.x, R2.z;
CMP R2.xyz, -R2.w, R3.x, R1;
ADD R3.x, -R0.w, c[27];
MUL R3.xyz, R2, R3.x;
MAD R0.xyz, R0, R0.w, -R3;
CMP R0.xyz, -R2.w, R0, R2;
ADD R1.x, fragment.texcoord[0].y, c[12];
MOV R1.y, c[14].x;
MAD R1.y, R1, c[0].x, R1.x;
MOV R1.z, c[13].x;
ADD R1.x, fragment.texcoord[0], c[11];
MAD R1.x, R1.z, c[0], R1;
TEX R1.xyz, R1, texture[2], 2D;
ADD R4.xyz, -R1, c[27].x;
MAD R1.xyz, R4, c[10].x, R1;
MUL R2.xyz, R0, R1;
ADD R0.x, fragment.texcoord[0].y, c[17];
MOV R0.y, c[19].x;
MAD R0.y, R0, c[0].x, R0.x;
MOV R0.z, c[18].x;
ADD R0.x, fragment.texcoord[0], c[16];
MAD R0.x, R0.z, c[0], R0;
TEX R0.xyz, R0, texture[3], 2D;
ADD R3.xyz, -R0, c[27].x;
MAD R0.xyz, R3, c[15].x, R0;
ADD R0.w, fragment.texcoord[0].y, c[21].x;
MOV R1.x, c[23];
MAD R1.y, R1.x, c[0].x, R0.w;
ADD R0.w, fragment.texcoord[0].x, c[21].x;
MOV R1.x, c[22];
MAD R1.x, R1, c[0], R0.w;
TEX R1.xyz, R1, texture[4], 2D;
ADD R4.xyz, -R1, c[27].x;
MAD R1.xyz, R4, c[20].x, R1;
MUL R0.xyz, R2, R0;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R1;
END
# 81 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 78 math, 5 textures
Vector 0 [_Time]
Float 1 [_Monochrome]
Vector 2 [_MonoColor]
Float 3 [_Contrast]
Float 4 [_Brightness]
Float 5 [_Title]
Float 6 [_MainOffsetX]
Float 7 [_MainOffsetY]
Float 8 [_MainSpeedX]
Float 9 [_MainSpeedY]
Float 10 [_VignetteAmount]
Float 11 [_VignetteOffsetX]
Float 12 [_VignetteOffsetY]
Float 13 [_VignetteSpeedX]
Float 14 [_VignetteSpeedY]
Float 15 [_Overlay1Amount]
Float 16 [_Overlay1OffsetX]
Float 17 [_Overlay1OffsetY]
Float 18 [_Overlay1SpeedX]
Float 19 [_Overlay1SpeedY]
Float 20 [_Overlay2Amount]
Float 21 [_Overlay2OffsetY]
Float 22 [_Overlay2SpeedX]
Float 23 [_Overlay2SpeedY]
Float 24 [_ColorJitter]
Float 25 [_ContrastJitter]
Float 26 [_BrightnessJitter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_TitleTex] 2D 1
SetTexture 2 [_VignetteTex] 2D 2
SetTexture 3 [_Overlay1Tex] 2D 3
SetTexture 4 [_Overlay2Tex] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c27, 0.00000000, 1.00000000, -1.00000000, -0.50000000
def c28, 0.29907227, 0.58691406, 0.11401367, 0.09997559
def c29, 0.50000000, 0.29907227, 0.58691406, 0.14404297
dcl_texcoord0 v0.xy
mov r0.x, c0
add r0.y, v0, c7.x
mad r0.y, c9.x, r0.x, r0
add r0.z, v0.x, c6.x
mov r0.x, c0
mad r0.x, c8, r0, r0.z
texld r1, r0, s0
abs_pp r0.z, c1.x
dp3_pp r0.w, r1, c28
cmp_pp r1.xyz, -r0.z, r1, r0.w
add r2.xyz, r1, c27.w
mul r2.xyz, r2, c3.x
mul r2.xyz, r2, c25.x
mul r2.xyz, r2, c29.x
cmp_pp r2.xyz, -r0.z, r1, r2
mov_pp r0.w, c4.x
mad_pp r1.xyz, c26.x, r0.w, r2
cmp_pp r1.xyz, -r0.z, r2, r1
mov_pp r0.w, c28
mov_pp r3.xyz, c2
mad_pp r3.xyz, c24.x, r0.w, r3
add_pp r2.xyz, r1, r3
cmp_pp r1.xyz, -r0.z, r1, r2
mov r0.w, c25.x
abs_pp r0.z, c1.x
cmp_pp r0.z, -r0, c27.x, c27.y
abs_pp r2.w, r0.z
add r2.xyz, r1, c27.w
mul r0.w, c29.x, r0
mad r2.xyz, r2, c3.x, r0.w
cmp_pp r1.xyz, -r2.w, r2, r1
mov_pp r0.z, c4.x
mad_pp r2.xyz, c26.x, r0.z, r1
cmp_pp r1.xyz, -r2.w, r2, r1
texld r0, r0, s1
add_pp r2.y, r0.w, c27.z
abs r2.x, c5
cmp r2.x, -r2, c27, c27.y
cmp_pp r2.z, -r0.w, c27.x, c27.y
cmp_pp r2.y, r2, c27, c27.x
mul_pp r2.y, r2.x, r2
cmp_pp r1.xyz, -r2.y, r1, r0
dp3_pp r3.x, r1, c29.yzww
mul_pp r2.z, r2.x, r2
abs_pp r2.y, r2
cmp_pp r2.x, -r2.y, c27.y, c27
mul_pp r2.w, r2.x, r2.z
cmp_pp r2.xyz, -r2.w, r1, r3.x
add_pp r3.x, -r0.w, c27.y
mul_pp r3.xyz, r2, r3.x
mad_pp r0.xyz, r0, r0.w, -r3
cmp_pp r0.xyz, -r2.w, r2, r0
mov r1.x, c0
add r1.y, v0, c12.x
mad r1.y, c14.x, r1.x, r1
add r1.z, v0.x, c11.x
mov r1.x, c0
mad r1.x, c13, r1, r1.z
texld r1.xyz, r1, s2
add_pp r4.xyz, -r1, c27.y
mad_pp r1.xyz, r4, c10.x, r1
mul_pp r2.xyz, r0, r1
mov r0.x, c0
add r0.y, v0, c17.x
mad r0.y, c19.x, r0.x, r0
add r0.z, v0.x, c16.x
mov r0.x, c0
mad r0.x, c18, r0, r0.z
texld r0.xyz, r0, s3
add_pp r3.xyz, -r0, c27.y
mad_pp r0.xyz, r3, c15.x, r0
add r1.x, v0.y, c21
mov r0.w, c0.x
mad r1.y, c23.x, r0.w, r1.x
add r1.x, v0, c21
mov r0.w, c0.x
mad r1.x, c22, r0.w, r1
texld r1.xyz, r1, s4
add_pp r4.xyz, -r1, c27.y
mad_pp r1.xyz, r4, c20.x, r1
mul_pp r0.xyz, r2, r0
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r1
"
}
SubProgram "d3d11 " {
// Stats: 42 math, 5 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_TitleTex] 2D 1
SetTexture 2 [_VignetteTex] 2D 2
SetTexture 3 [_Overlay1Tex] 2D 3
SetTexture 4 [_Overlay2Tex] 2D 4
ConstBuffer "$Globals" 160
Float 16 [_Monochrome]
Vector 32 [_MonoColor]
Float 48 [_Contrast]
Float 52 [_Brightness]
Float 56 [_Title]
Float 60 [_MainOffsetX]
Float 64 [_MainOffsetY]
Float 68 [_MainSpeedX]
Float 72 [_MainSpeedY]
Float 76 [_VignetteAmount]
Float 80 [_VignetteOffsetX]
Float 84 [_VignetteOffsetY]
Float 88 [_VignetteSpeedX]
Float 92 [_VignetteSpeedY]
Float 96 [_Overlay1Amount]
Float 100 [_Overlay1OffsetX]
Float 104 [_Overlay1OffsetY]
Float 108 [_Overlay1SpeedX]
Float 112 [_Overlay1SpeedY]
Float 116 [_Overlay2Amount]
Float 124 [_Overlay2OffsetY]
Float 128 [_Overlay2SpeedX]
Float 132 [_Overlay2SpeedY]
Float 136 [_ColorJitter]
Float 140 [_ContrastJitter]
Float 144 [_BrightnessJitter]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpipcalgpdjeblipeggfbhglbffcelimcabaaaaaalmaiaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmahaaaa
eaaaaaaappabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akbabaaaabaaaaaadkiacaaaaaaaaaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaa
akiacaaaabaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaaakaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkbabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaa
dcaaaaalccaabaaaaaaaaaaaakiacaaaabaaaaaaaaaaaaaackiacaaaaaaaaaaa
aeaaaaaackaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaabaaaaaakbcaabaaaacaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaegacbaaaabaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaalpdiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaadiaaaaaibcaabaaa
acaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaaaiaaaaaadiaaaaajccaabaaa
acaaaaaabkiacaaaaaaaaaaaadaaaaaaakiacaaaaaaaaaaaajaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadpbkaabaaaacaaaaaa
dcaaaaaoocaabaaaacaaaaaakgikcaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaaaa
mnmmmmdnmnmmmmdnmnmmmmdnagijcaaaaaaaaaaaacaaaaaaaaaaaaahhcaabaaa
acaaaaaajgahbaaaacaaaaaaagaabaaaacaaaaaadjaaaaaiicaabaaaacaaaaaa
akiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaafgifcaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaegacbaaa
abaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaakicaabaaaabaaaaaaaceaaaaaihbgjjdokcefbgdp
lmhebddoaaaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaapgapbaiaebaaaaaaabaaaaaadbaaaaahicaabaaaabaaaaaa
abeaaaaaaaaaaaaadkaabaaaaaaaaaaadjaaaaaiicaabaaaacaaaaaackiacaaa
aaaaaaaaadaaaaaaabeaaaaaaaaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaabnaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaacaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegbabaaaabaaaaaa
egiacaaaaaaaaaaaafaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaaogikcaaaaaaaaaaaafaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegbabaaaabaaaaaa
jgifcaaaaaaaaaaaagaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaabaaaaaa
aaaaaaaadkiacaaaaaaaaaaaagaaaaaaakaabaaaabaaaaaadcaaaaalccaabaaa
acaaaaaaakiacaaaabaaaaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaa
agiacaaaaaaaaaaaagaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaidcaabaaa
abaaaaaaegbabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaadcaaaaaldcaabaaa
abaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaaaaaaaaaaaiaaaaaaegaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaa
fgifcaaaaaaaaaaaahaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}