// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 14.0KB

Shader "Custom/NightVision" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _ScanLineTex ("Scan Line Texture", 2D) = "white" {}
 _NoiseTex ("Noise Texture", 2D) = "white" {}
 _NoiseXSpeed ("Noise X Speed", Float) = 100
 _NoiseYSpeed ("Noise Y Speed", Float) = 100
 _ScanLineTileAmount ("Scan Line Tile Amount", Float) = 4
 _VisionColor ("Night Vision Color", Color) = (1,1,1,1)
 _Contrast ("Contrast", Range(0,4)) = 2
 _Brightness ("Brightness", Range(0,2)) = 1
 _RandomValue ("Random Value", Float) = 0
 _Distortion ("Distortion", Float) = 0.2
}
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 6 math
 //    d3d11_9x : 6 math
 //        d3d9 : 8 math
 //      opengl : 8 math
 // Stats for Fragment shader:
 //       d3d11 : 18 math, 3 texture
 //    d3d11_9x : 18 math, 3 texture
 //        d3d9 : 37 math, 3 texture
 //      opengl : 27 math, 3 texture
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
// Stats: 27 math, 3 textures
Vector 0 [_Time]
Vector 1 [_SinTime]
Vector 2 [_VisionColor]
Float 3 [_NoiseXSpeed]
Float 4 [_NoiseYSpeed]
Float 5 [_ScanLineTileAmount]
Float 6 [_Contrast]
Float 7 [_Brightness]
Float 8 [_RandomValue]
Float 9 [_Distortion]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ScanLineTex] 2D 1
SetTexture 2 [_NoiseTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[12] = { program.local[0..9],
		{ 0.5, 1, 2 },
		{ 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R0.xy, fragment.texcoord[0], -c[10].x;
MUL R0.z, R0.y, R0.y;
MAD R0.z, R0.x, R0.x, R0;
RSQ R0.w, R0.z;
RCP R0.w, R0.w;
MUL R0.w, R0, c[9].x;
MAD R0.z, R0, R0.w, c[10].y;
MAD R1.zw, R0.z, R0.xyxy, c[10].x;
MOV R0.w, c[4].x;
MOV R0.z, c[1];
MUL R0.z, R0, c[8].x;
MAD R1.x, R0.z, c[3], fragment.texcoord[0];
MAD R1.y, R0.w, c[0].x, fragment.texcoord[0];
MUL R0.xy, fragment.texcoord[0], c[5].x;
TEX R2.xyz, R1.zwzw, texture[0], 2D;
TEX R1, R1, texture[2], 2D;
TEX R0, R0, texture[1], 2D;
DP3 R3.x, R2, c[11];
MUL R0, R0, R1;
MOV R2, c[2];
ADD R3.x, R3, c[7];
MAD R2, R3.x, c[10].z, R2;
POW R1.x, R2.x, c[6].x;
POW R1.y, R2.y, c[6].x;
POW R1.z, R2.z, c[6].x;
POW R1.w, R2.w, c[6].x;
MUL result.color, R1, R0;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 37 math, 3 textures
Vector 0 [_Time]
Vector 1 [_SinTime]
Vector 2 [_VisionColor]
Float 3 [_NoiseXSpeed]
Float 4 [_NoiseYSpeed]
Float 5 [_ScanLineTileAmount]
Float 6 [_Contrast]
Float 7 [_Brightness]
Float 8 [_RandomValue]
Float 9 [_Distortion]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ScanLineTex] 2D 1
SetTexture 2 [_NoiseTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c10, -0.50000000, 1.00000000, 0.50000000, 2.00000000
def c11, 0.29907227, 0.58691406, 0.11401367, 0
dcl t0.xy
add r2.xy, t0, c10.x
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, r0
rsq r1.x, r0.x
rcp r1.x, r1.x
mul r1.x, r1, c9
mad r0.x, r0, r1, c10.y
mad r3.xy, r0.x, r2, c10.z
mov r0.x, c8
mul r1.x, c1.z, r0
mov r0.x, c0
mad r1.y, c4.x, r0.x, t0
mul_pp r2.xy, t0, c5.x
mad r1.x, r1, c3, t0
texld r0, r3, s0
texld r2, r2, s1
texld r1, r1, s2
dp3_pp r0.x, r0, c11
mov_pp r3, c2
add_pp r0.x, r0, c7
mad_pp r0, r0.x, c10.w, r3
pow_pp r3.x, r0.y, c6.x
mov_pp r0.y, r3.x
pow_pp r3.x, r0.w, c6.x
mul_pp r1, r2, r1
pow_pp r2.x, r0.x, c6.x
mov_pp r0.x, r2.x
pow_pp r2.x, r0.z, c6.x
mov_pp r0.z, r2.x
mov_pp r0.w, r3.x
mul_pp r0, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 18 math, 3 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ScanLineTex] 2D 1
SetTexture 2 [_NoiseTex] 2D 2
ConstBuffer "$Globals" 64
Vector 16 [_VisionColor]
Float 32 [_NoiseXSpeed]
Float 36 [_NoiseYSpeed]
Float 40 [_ScanLineTileAmount]
Float 44 [_Contrast]
Float 48 [_Brightness]
Float 52 [_RandomValue]
Float 56 [_Distortion]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 16 [_SinTime]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddcoicbonfhdconakjmiakmbjhkanmifnabaaaaaacmaeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmadaaaa
eaaaaaaanlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaa
aaaaaaaaapaaaaahecaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
elaaaaaficaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaamdcaabaaa
aaaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadcaaaaanpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegiocaaa
aaaaaaaaabaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaapgipcaaaaaaaaaaaacaaaaaabjaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaaabaaaaaabkiacaaa
aaaaaaaaadaaaaaackiacaaaabaaaaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaakbabaaaabaaaaaadcaaaaal
ccaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaaidcaabaaaacaaaaaaegbabaaaabaaaaaa
kgikcaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 18 math, 3 textures
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ScanLineTex] 2D 1
SetTexture 2 [_NoiseTex] 2D 2
ConstBuffer "$Globals" 64
Vector 16 [_VisionColor]
Float 32 [_NoiseXSpeed]
Float 36 [_NoiseYSpeed]
Float 40 [_ScanLineTileAmount]
Float 44 [_Contrast]
Float 48 [_Brightness]
Float 52 [_RandomValue]
Float 56 [_Distortion]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
Vector 16 [_SinTime]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedejodehbkcbgmjfnhkfommiofehangndcabaaaaaaniagaaaaaeaaaaaa
daaaaaaaniacaaaaemagaaaakeagaaaaebgpgodjkaacaaaakaacaaaaaaacpppp
fiacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaabaaadaaaaaaaaaaaaaaabaaaaaaacaaadaaaaaaaaaa
aaacppppfbaaaaafafaaapkaaaaaaalpaaaaiadpaaaaaadpaaaaaaeafbaaaaaf
agaaapkaihbgjjdokcefbgdpnfhiojdnaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaabaaaaacaaaaaiiaacaaffkaafaaaaadaaaaabiaaaaappiaaeaakkka
aeaaaaaeaaaacbiaaaaaaaiaabaaaakaaaaaaalaabaaaaacabaaaiiaabaaffka
aeaaaaaeaaaacciaadaaaakaabaappiaaaaafflaafaaaaadabaacdiaaaaaoela
abaakkkaacaaaaadaaaaamiaaaaabllaafaaaakaafaaaaadabaaaeiaaaaakkia
aaaakkiaaeaaaaaeabaaaeiaaaaappiaaaaappiaabaakkiaahaaaaacabaaaiia
abaakkiaagaaaaacabaaaiiaabaappiaafaaaaadabaaaiiaabaappiaacaakkka
aeaaaaaeabaaaeiaabaakkiaabaappiaafaaffkaaeaaaaaeacaacdiaabaakkia
aaaabliaafaakkkaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadabaacpia
abaaoeiaabaioekaecaaaaadacaacpiaacaaoeiaaaaioekaafaaaaadaaaacpia
aaaaoeiaabaaoeiaaiaaaaadabaacbiaagaaoekaacaaoeiaacaaaaadabaacbia
abaaaaiaacaaaakaabaaaaacabaaaiiaafaappkaaeaaaaaeabaacpiaabaaaaia
abaappiaaaaaoekaapaaaaacacaacbiaabaaaaiaapaaaaacacaacciaabaaffia
apaaaaacacaaceiaabaakkiaapaaaaacacaaciiaabaappiaafaaaaadabaacpia
acaaoeiaabaappkaaoaaaaacacaacbiaabaaaaiaaoaaaaacacaacciaabaaffia
aoaaaaacacaaceiaabaakkiaaoaaaaacacaaciiaabaappiaafaaaaadaaaacpia
aaaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgmadaaaa
eaaaaaaanlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaa
aaaaaaaaapaaaaahecaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
elaaaaaficaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaamdcaabaaa
aaaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadcaaaaanpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegiocaaa
aaaaaaaaabaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaapgipcaaaaaaaaaaaacaaaaaabjaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajbcaabaaaabaaaaaabkiacaaa
aaaaaaaaadaaaaaackiacaaaabaaaaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaakbabaaaabaaaaaadcaaaaal
ccaabaaaabaaaaaaakiacaaaabaaaaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaaidcaabaaaacaaaaaaegbabaaaabaaaaaa
kgikcaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
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