// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 22.3KB

Shader "Custom/MovieTime" {
Properties {
 _MainTex ("Base Texture", 2D) = "white" {}
 _VignetteTex ("Vignette Texture", 2D) = "white" {}
 _Overlay1Tex ("Overlay 1 Texture", 2D) = "white" {}
 _Overlay2Tex ("Overlay 2 Texture", 2D) = "white" {}
 _Monochrome ("Monochrome", Float) = 1
 _MonoColor ("Monochrome Color", Color) = (0,0,0,0)
 _Contrast ("Contrast", Range(0,4)) = 2
 _Brightness ("Brightness", Range(0,2)) = 1
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
 //    d3d11_9x : 6 math
 //        d3d9 : 8 math
 //      opengl : 8 math
 // Stats for Fragment shader:
 //       d3d11 : 33 math, 4 texture
 //    d3d11_9x : 33 math, 4 texture
 //        d3d9 : 62 math, 4 texture
 //      opengl : 64 math, 4 texture
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
// Stats: 64 math, 4 textures
Vector 0 [_Time]
Float 1 [_Monochrome]
Vector 2 [_MonoColor]
Float 3 [_Contrast]
Float 4 [_Brightness]
Float 5 [_MainOffsetX]
Float 6 [_MainOffsetY]
Float 7 [_MainSpeedX]
Float 8 [_MainSpeedY]
Float 9 [_VignetteAmount]
Float 10 [_VignetteOffsetX]
Float 11 [_VignetteOffsetY]
Float 12 [_VignetteSpeedX]
Float 13 [_VignetteSpeedY]
Float 14 [_Overlay1Amount]
Float 15 [_Overlay1OffsetX]
Float 16 [_Overlay1OffsetY]
Float 17 [_Overlay1SpeedX]
Float 18 [_Overlay1SpeedY]
Float 19 [_Overlay2Amount]
Float 20 [_Overlay2OffsetY]
Float 21 [_Overlay2SpeedX]
Float 22 [_Overlay2SpeedY]
Float 23 [_ColorJitter]
Float 24 [_ContrastJitter]
Float 25 [_BrightnessJitter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[28] = { program.local[0..25],
		{ 1, 0, 0.5, 0.099975586 },
		{ 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ADD R0.x, fragment.texcoord[0], c[10];
MOV R0.y, c[12].x;
MAD R1.x, R0.y, c[0], R0;
ADD R0.x, fragment.texcoord[0].y, c[11];
MOV R0.y, c[13].x;
MAD R1.y, R0, c[0].x, R0.x;
ADD R0.x, fragment.texcoord[0], c[15];
MOV R0.y, c[17].x;
MAD R1.z, R0.y, c[0].x, R0.x;
ADD R0.x, fragment.texcoord[0].y, c[16];
MOV R0.y, c[18].x;
MAD R1.w, R0.y, c[0].x, R0.x;
ADD R0.x, fragment.texcoord[0], c[20];
MOV R0.y, c[21].x;
MAD R2.x, R0.y, c[0], R0;
ADD R0.x, fragment.texcoord[0].y, c[20];
MOV R0.y, c[22].x;
MAD R2.y, R0, c[0].x, R0.x;
ADD R0.x, fragment.texcoord[0].y, c[6];
MOV R0.y, c[8].x;
MAD R0.y, R0, c[0].x, R0.x;
MOV R0.z, c[7].x;
ADD R0.x, fragment.texcoord[0], c[5];
MAD R0.x, R0.z, c[0], R0;
MOV R3.w, c[23].x;
MOV R5.xyz, c[2];
MAD R5.xyz, R3.w, c[26].w, R5;
MOV R3.w, c[26].z;
MUL R3.w, R3, c[24].x;
TEX R0, R0, texture[0], 2D;
TEX R3.xyz, R2, texture[3], 2D;
TEX R2.xyz, R1.zwzw, texture[2], 2D;
TEX R1.xyz, R1, texture[1], 2D;
ABS R1.w, c[1].x;
DP3 R2.w, R0, c[27];
CMP R0.xyz, -R1.w, R2.w, R0;
ADD R4.xyz, R0, -c[26].z;
MUL R4.xyz, R4, c[3].x;
MUL R4.xyz, R4, c[24].x;
MUL R4.xyz, R4, c[26].z;
CMP R0.xyz, -R1.w, R4, R0;
MOV R2.w, c[25].x;
MAD R4.xyz, R2.w, c[4].x, R0;
CMP R0.xyz, -R1.w, R4, R0;
ADD R4.xyz, R0, R5;
CMP R0.xyz, -R1.w, R4, R0;
ADD R4.xyz, R0, -c[26].z;
CMP R1.w, -R1, c[26].x, c[26].y;
ABS R1.w, R1;
ADD R5.xyz, -R1, c[26].x;
MAD R4.xyz, R4, c[3].x, R3.w;
CMP R1.w, -R1, c[26].y, c[26].x;
CMP R0.xyz, -R1.w, R4, R0;
MAD R4.xyz, R2.w, c[4].x, R0;
CMP R0.xyz, -R1.w, R4, R0;
MAD R1.xyz, R5, c[9].x, R1;
MUL R0.xyz, R0, R1;
ADD R1.xyz, -R2, c[26].x;
MAD R1.xyz, R1, c[14].x, R2;
ADD R4.xyz, -R3, c[26].x;
MAD R2.xyz, R4, c[19].x, R3;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, R2;
MOV result.color.w, R0;
END
# 64 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 62 math, 4 textures
Vector 0 [_Time]
Float 1 [_Monochrome]
Vector 2 [_MonoColor]
Float 3 [_Contrast]
Float 4 [_Brightness]
Float 5 [_MainOffsetX]
Float 6 [_MainOffsetY]
Float 7 [_MainSpeedX]
Float 8 [_MainSpeedY]
Float 9 [_VignetteAmount]
Float 10 [_VignetteOffsetX]
Float 11 [_VignetteOffsetY]
Float 12 [_VignetteSpeedX]
Float 13 [_VignetteSpeedY]
Float 14 [_Overlay1Amount]
Float 15 [_Overlay1OffsetX]
Float 16 [_Overlay1OffsetY]
Float 17 [_Overlay1SpeedX]
Float 18 [_Overlay1SpeedY]
Float 19 [_Overlay2Amount]
Float 20 [_Overlay2OffsetY]
Float 21 [_Overlay2SpeedX]
Float 22 [_Overlay2SpeedY]
Float 23 [_ColorJitter]
Float 24 [_ContrastJitter]
Float 25 [_BrightnessJitter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c26, 0.00000000, 1.00000000, -0.50000000, 0.09997559
def c27, 0.29907227, 0.58691406, 0.11401367, 0.50000000
dcl t0.xy
add r1.x, t0, c10
mov r0.x, c0
mad r0.x, c12, r0, r1
add r2.x, t0.y, c11
mov r1.x, c0
mad r0.y, c13.x, r1.x, r2.x
add r2.x, t0, c5
mov r1.x, c0
mad r4.x, c7, r1, r2
add r2.x, t0.y, c6
mov r1.x, c0
mad r4.y, c8.x, r1.x, r2.x
add r2.x, t0, c15
mov r1.x, c0
mad r3.x, c17, r1, r2
add r2.x, t0.y, c16
mov r1.x, c0
mad r3.y, c18.x, r1.x, r2.x
add r2.x, t0.y, c20
mov r1.x, c0
mad r1.y, c22.x, r1.x, r2.x
add r2.x, t0, c20
mov r1.x, c0
mad r1.x, c21, r1, r2
mov_pp r0.w, c26
mov_pp r6.xyz, c2
mad_pp r6.xyz, c23.x, r0.w, r6
texld r2, r1, s3
texld r1, r4, s0
texld r4, r0, s1
texld r3, r3, s2
abs_pp r0.x, c1
dp3_pp r5.x, r1, c27
cmp_pp r1.xyz, -r0.x, r1, r5.x
add r5.xyz, r1, c26.z
mul r5.xyz, r5, c3.x
mul r5.xyz, r5, c24.x
mul r5.xyz, r5, c27.w
cmp_pp r1.xyz, -r0.x, r1, r5
mov_pp r5.x, c4
mad_pp r5.xyz, c25.x, r5.x, r1
cmp_pp r1.xyz, -r0.x, r1, r5
add_pp r5.xyz, r1, r6
cmp_pp r5.xyz, -r0.x, r1, r5
mov r1.x, c24
abs_pp r0.x, c1
cmp_pp r0.x, -r0, c26, c26.y
add r6.xyz, r5, c26.z
mul r1.x, c27.w, r1
mad r1.xyz, r6, c3.x, r1.x
abs_pp r0.x, r0
cmp_pp r5.xyz, -r0.x, r1, r5
mov_pp r1.x, c4
mad_pp r1.xyz, c25.x, r1.x, r5
cmp_pp r0.xyz, -r0.x, r1, r5
add_pp r6.xyz, -r4, c26.y
mad_pp r1.xyz, r6, c9.x, r4
mul_pp r0.xyz, r0, r1
add_pp r1.xyz, -r3, c26.y
mad_pp r1.xyz, r1, c14.x, r3
mul_pp r0.xyz, r0, r1
add_pp r3.xyz, -r2, c26.y
mad_pp r1.xyz, r3, c19.x, r2
mov_pp r0.w, r1
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 33 math, 4 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
ConstBuffer "$Globals" 144
Float 16 [_Monochrome]
Vector 32 [_MonoColor]
Float 48 [_Contrast]
Float 52 [_Brightness]
Float 56 [_MainOffsetX]
Float 60 [_MainOffsetY]
Float 64 [_MainSpeedX]
Float 68 [_MainSpeedY]
Float 72 [_VignetteAmount]
Float 76 [_VignetteOffsetX]
Float 80 [_VignetteOffsetY]
Float 84 [_VignetteSpeedX]
Float 88 [_VignetteSpeedY]
Float 92 [_Overlay1Amount]
Float 96 [_Overlay1OffsetX]
Float 100 [_Overlay1OffsetY]
Float 104 [_Overlay1SpeedX]
Float 108 [_Overlay1SpeedY]
Float 112 [_Overlay2Amount]
Float 120 [_Overlay2OffsetY]
Float 124 [_Overlay2SpeedX]
Float 128 [_Overlay2SpeedY]
Float 132 [_ColorJitter]
Float 136 [_ContrastJitter]
Float 140 [_BrightnessJitter]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedenoanlpkpecabhndddkhnlfammdnkhhmabaaaaaabiahaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfiagaaaa
eaaaaaaajgabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegbabaaaabaaaaaaogikcaaaaaaaaaaaadaaaaaadcaaaaaldcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaaegaabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaabaaaaaakbcaabaaaabaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaegacbaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaalpdiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaadaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckiacaaaaaaaaaaaaiaaaaaadiaaaaajccaabaaaabaaaaaabkiacaaaaaaaaaaa
adaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpbkaabaaaabaaaaaadcaaaaaoocaabaaaabaaaaaa
fgifcaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaaaamnmmmmdnmnmmmmdnmnmmmmdn
agijcaaaaaaaaaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaadpdcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
adaaaaaapgapbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaafgifcaaaaaaaaaaa
adaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaadjaaaaaiicaabaaa
aaaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaadhaaaaajhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaaakbabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaa
dkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaabkbabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaadcaaaaalccaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
ckiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaaaaaaaaaaaeaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaagaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
ogikcaaaaaaaaaaaagaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaalhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegbabaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaadcaaaaalbcaabaaaacaaaaaaakiacaaaabaaaaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaaakaabaaaabaaaaaadcaaaaalccaabaaaacaaaaaa
akiacaaaabaaaaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaabkaabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaa
aaaaaaaaahaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 33 math, 4 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
SetTexture 2 [_Overlay1Tex] 2D 2
SetTexture 3 [_Overlay2Tex] 2D 3
ConstBuffer "$Globals" 144
Float 16 [_Monochrome]
Vector 32 [_MonoColor]
Float 48 [_Contrast]
Float 52 [_Brightness]
Float 56 [_MainOffsetX]
Float 60 [_MainOffsetY]
Float 64 [_MainSpeedX]
Float 68 [_MainSpeedY]
Float 72 [_VignetteAmount]
Float 76 [_VignetteOffsetX]
Float 80 [_VignetteOffsetY]
Float 84 [_VignetteSpeedX]
Float 88 [_VignetteSpeedY]
Float 92 [_Overlay1Amount]
Float 96 [_Overlay1OffsetX]
Float 100 [_Overlay1OffsetY]
Float 104 [_Overlay1SpeedX]
Float 108 [_Overlay1SpeedY]
Float 112 [_Overlay2Amount]
Float 120 [_Overlay2OffsetY]
Float 124 [_Overlay2SpeedX]
Float 128 [_Overlay2SpeedY]
Float 132 [_ColorJitter]
Float 136 [_ContrastJitter]
Float 140 [_BrightnessJitter]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedchhcjdfipbjmjgbfhgpdekncaomjgnjbabaaaaaabaalaaaaaeaaaaaa
daaaaaaaceaeaaaaieakaaaanmakaaaaebgpgodjomadaaaaomadaaaaaaacpppp
kaadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaaaaaaaaa
abababaaacacacaaadadadaaaaaaabaaaiaaaaaaaaaaaaaaabaaaaaaabaaaiaa
aaaaaaaaaaacppppfbaaaaafajaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaalp
fbaaaaafakaaapkamnmmmmdnaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaacaaaaadaaaaaiiaaaaaaala
acaakkkaabaaaaacaaaaabiaaiaaaakaaeaaaaaeabaacbiaaaaaaaiaadaaaaka
aaaappiaacaaaaadaaaaaciaaaaafflaacaappkaaeaaaaaeabaacciaaaaaaaia
adaaffkaaaaaffiaacaaaaadaaaaaciaaaaaaalaadaappkaaeaaaaaeacaacbia
aaaaaaiaaeaaffkaaaaaffiaacaaaaadaaaaaciaaaaafflaaeaaaakaaeaaaaae
acaacciaaaaaaaiaaeaakkkaaaaaffiaacaaaaadaaaaaciaaaaaaalaafaaaaka
aeaaaaaeadaacbiaaaaaaaiaafaakkkaaaaaffiaacaaaaadaaaaaciaaaaaffla
afaaffkaaeaaaaaeadaacciaaaaaaaiaafaappkaaaaaffiaacaaaaadaaaaacia
aaaaaalaagaakkkaaeaaaaaeaeaacbiaaaaaaaiaagaappkaaaaaffiaacaaaaad
aaaaaciaaaaafflaagaakkkaaeaaaaaeaeaacciaaaaaaaiaahaaaakaaaaaffia
ecaaaaadaaaacpiaabaaoeiaaaaioekaecaaaaadabaacpiaacaaoeiaabaioeka
ecaaaaadacaacpiaadaaoeiaacaioekaecaaaaadadaacpiaaeaaoeiaadaioeka
aiaaaaadabaaciiaajaaoekaaaaaoeiaacaaaaadabaaaiiaabaappiaajaappka
afaaaaadabaaaiiaabaappiaacaaaakaafaaaaadabaaaiiaabaappiaahaakkka
abaaaaacacaaaiiaacaaffkaafaaaaadadaaciiaacaappiaahaappkaaeaaaaae
abaaciiaabaappiaajaappkbadaappiaabaaaaacadaaaiiaakaaaakaabaaaaac
aeaaagiaahaaoekaaeaaaaaeafaachiaaeaaffiaadaappiaabaaoekaacaaaaad
afaachiaabaappiaafaaoeiaacaaaaadagaaahiaaaaaoeiaajaappkaafaaaaad
abaaaiiaaeaakkiaajaappkbaeaaaaaeaeaachiaagaaoeiaacaaaakaabaappia
aeaaaaaeaeaachiaacaappiaahaappkaaeaaoeiaafaaaaadabaaaiiaaaaaaaka
aaaaaakafiaaaaaeaeaaahiaabaappibaeaaoeiaafaaoeiaacaaaaadafaaahia
abaaoeibakaaffkaaeaaaaaeabaaahiaadaakkkaafaaoeiaabaaoeiaafaaaaad
abaachiaabaaoeiaaeaaoeiaacaaaaadaeaaahiaacaaoeibakaaffkaaeaaaaae
acaaahiaaeaappkaaeaaoeiaacaaoeiaafaaaaadabaachiaabaaoeiaacaaoeia
acaaaaadacaaahiaadaaoeibakaaffkaaeaaaaaeacaaahiaagaaaakaacaaoeia
adaaoeiaafaaaaadaaaachiaabaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcfiagaaaaeaaaaaaajgabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaaaaaaaidcaabaaaaaaaaaaaegbabaaaabaaaaaaogikcaaaaaaaaaaa
adaaaaaadcaaaaaldcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaegacbaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaalpdiaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaadiaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaadiaaaaajccaabaaa
abaaaaaabkiacaaaaaaaaaaaadaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpbkaabaaaabaaaaaa
dcaaaaaoocaabaaaabaaaaaafgifcaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaaaa
mnmmmmdnmnmmmmdnmnmmmmdnagijcaaaaaaaaaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaafgifcaaaaaaaaaaaadaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaaa
aaaaaaaadjaaaaaiicaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaa
aaaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaaakbabaaaabaaaaaadkiacaaa
aaaaaaaaaeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaa
bkiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
bkbabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaadcaaaaalccaabaaaabaaaaaa
akiacaaaabaaaaaaaaaaaaaackiacaaaaaaaaaaaafaaaaaadkaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaakgikcaaa
aaaaaaaaaeaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaaldcaabaaaabaaaaaa
agiacaaaabaaaaaaaaaaaaaaogikcaaaaaaaaaaaagaaaaaaegaabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaa
aaaaaaaaafaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaa
egbabaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaadcaaaaalbcaabaaaacaaaaaa
akiacaaaabaaaaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakaabaaaabaaaaaa
dcaaaaalccaabaaaacaaaaaaakiacaaaabaaaaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaabkaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaak
hcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}