//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/Character_Eye" {
Properties {
[Header(Diffuse)] _MainTex ("Base Texture", 2D) = "white" { }
_NormalTex ("Normal Texture", 2D) = "bump" { }
_NormalIntensity ("Normal Intensity", Range(1, 5)) = 1
_parallax ("Parallax", Float) = 0.1
[Header(Spec)] _Roughness ("Roughness", Range(0, 1)) = 0.5
_Specshininess (" Spec Shininess", Range(0, 1)) = 0.2
_SpecIntensity ("Spec Intensity", Float) = 1
_ReflectIntensity ("Reflect Intensity", Float) = 1
_Reflectscale ("Reflect Scale ", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 58668
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = max(u_xlat12, 1.17549435e-38);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _MainLightPosition;
uniform 	mediump vec4 _MainLightColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM float _NormalIntensity;
	UNITY_UNIFORM float _SpecIntensity;
	UNITY_UNIFORM float _Specshininess;
	UNITY_UNIFORM float _ReflectIntensity;
	UNITY_UNIFORM float _Reflectscale;
	UNITY_UNIFORM float _Roughness;
	UNITY_UNIFORM float _parallax;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump samplerCube unity_SpecCube0;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _NormalTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat21;
mediump float u_xlat16_22;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.20000005, 2.20000005, 2.20000005);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.x = vs_TEXCOORD2.x;
    u_xlat0.y = vs_TEXCOORD3.x;
    u_xlat16_2.xyz = texture(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = u_xlat16_3.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_NormalIntensity);
    u_xlat16_4.xyz = u_xlat16_3.xxx * vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz * vec3(_NormalIntensity) + u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz * u_xlat16_3.zzz + u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.z = u_xlat2.x;
    u_xlat0.x = dot(u_xlat16_3.xyz, u_xlat0.xyz);
    u_xlat5.x = vs_TEXCOORD2.y;
    u_xlat5.y = vs_TEXCOORD3.y;
    u_xlat5.z = u_xlat2.y;
    u_xlat0.y = dot(u_xlat16_3.xyz, u_xlat5.xyz);
    u_xlat5.x = vs_TEXCOORD2.z;
    u_xlat5.y = vs_TEXCOORD3.z;
    u_xlat5.z = u_xlat2.z;
    u_xlat0.z = dot(u_xlat16_3.xyz, u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_22 = dot(u_xlat0.xyz, _MainLightPosition.xyz);
    u_xlat16_22 = u_xlat16_22 * 0.5 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22);
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_4.xyz = vs_TEXCOORD4.xyz * u_xlat0.xxx + _MainLightPosition.xyz;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_22 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_22 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat16_22 = max(u_xlat16_22, 9.99999975e-06);
    u_xlat21 = log2(u_xlat16_22);
    u_xlat5.x = _Specshininess * 150.0;
    u_xlat21 = u_xlat21 * u_xlat5.x;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = u_xlat21 * _SpecIntensity;
    u_xlat16_4.xyz = vec3(u_xlat21) * _MainLightColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainLightColor.xyz + u_xlat16_4.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_6.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_22 = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_22 = u_xlat16_22 + u_xlat16_22;
    u_xlat16_3.xyz = u_xlat2.xyz * (-vec3(u_xlat16_22)) + (-u_xlat0.xyz);
    u_xlat16_22 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_22);
    u_xlat0.x = u_xlat0.x * _Reflectscale;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat7 = (-_Roughness) * 0.699999988 + 1.70000005;
    u_xlat7 = u_xlat7 * _Roughness;
    u_xlat16_22 = u_xlat7 * 6.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat16_3.xyz, u_xlat16_22);
    u_xlat16_22 = u_xlat16_2.w + -1.0;
    u_xlat16_22 = unity_SpecCube0_HDR.w * u_xlat16_22 + 1.0;
    u_xlat16_22 = max(u_xlat16_22, 0.0);
    u_xlat16_22 = log2(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * unity_SpecCube0_HDR.y;
    u_xlat16_22 = exp2(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(vec3(_ReflectIntensity, _ReflectIntensity, _ReflectIntensity)) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 223
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %18 %90 %98 %138 %142 %176 %202 %208 %215 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate vs_TEXCOORD0 Location 9 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %18 Location 18 
                                                      OpDecorate %23 ArrayStride 23 
                                                      OpDecorate %24 ArrayStride 24 
                                                      OpDecorate %26 ArrayStride 26 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpMemberDecorate %27 1 Offset 27 
                                                      OpMemberDecorate %27 2 Offset 27 
                                                      OpMemberDecorate %27 3 RelaxedPrecision 
                                                      OpMemberDecorate %27 3 Offset 27 
                                                      OpMemberDecorate %27 4 RelaxedPrecision 
                                                      OpMemberDecorate %27 4 Offset 27 
                                                      OpMemberDecorate %27 5 RelaxedPrecision 
                                                      OpMemberDecorate %27 5 Offset 27 
                                                      OpMemberDecorate %27 6 Offset 27 
                                                      OpMemberDecorate %27 7 RelaxedPrecision 
                                                      OpMemberDecorate %27 7 Offset 27 
                                                      OpMemberDecorate %27 8 Offset 27 
                                                      OpMemberDecorate %27 9 Offset 27 
                                                      OpMemberDecorate %27 10 RelaxedPrecision 
                                                      OpMemberDecorate %27 10 Offset 27 
                                                      OpMemberDecorate %27 11 RelaxedPrecision 
                                                      OpMemberDecorate %27 11 Offset 27 
                                                      OpMemberDecorate %27 12 RelaxedPrecision 
                                                      OpMemberDecorate %27 12 Offset 27 
                                                      OpMemberDecorate %27 13 RelaxedPrecision 
                                                      OpMemberDecorate %27 13 Offset 27 
                                                      OpMemberDecorate %27 14 RelaxedPrecision 
                                                      OpMemberDecorate %27 14 Offset 27 
                                                      OpMemberDecorate %27 15 RelaxedPrecision 
                                                      OpMemberDecorate %27 15 Offset 27 
                                                      OpMemberDecorate %27 16 RelaxedPrecision 
                                                      OpMemberDecorate %27 16 Offset 27 
                                                      OpDecorate %27 Block 
                                                      OpDecorate %29 DescriptorSet 29 
                                                      OpDecorate %29 Binding 29 
                                                      OpDecorate %65 ArrayStride 65 
                                                      OpMemberDecorate %66 0 Offset 66 
                                                      OpMemberDecorate %66 1 Offset 66 
                                                      OpDecorate %66 Block 
                                                      OpDecorate %68 DescriptorSet 68 
                                                      OpDecorate %68 Binding 68 
                                                      OpMemberDecorate %88 0 BuiltIn 88 
                                                      OpMemberDecorate %88 1 BuiltIn 88 
                                                      OpMemberDecorate %88 2 BuiltIn 88 
                                                      OpDecorate %88 Block 
                                                      OpDecorate %98 Location 98 
                                                      OpDecorate vs_TEXCOORD1 Location 138 
                                                      OpDecorate %142 Location 142 
                                                      OpDecorate vs_TEXCOORD2 Location 176 
                                                      OpDecorate %200 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 202 
                                                      OpDecorate vs_TEXCOORD4 Location 208 
                                                      OpDecorate vs_TEXCOORD5 Location 215 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 2 
                                               %8 = OpTypePointer Output %7 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_2* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 3 
                                              %14 = OpTypePointer Private %13 
                               Private f32_3* %15 = OpVariable Private 
                                              %16 = OpTypeVector %6 4 
                                              %17 = OpTypePointer Input %16 
                                 Input f32_4* %18 = OpVariable Input 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 4 
                                              %23 = OpTypeArray %16 %22 
                                              %24 = OpTypeArray %16 %22 
                                          u32 %25 = OpConstant 2 
                                              %26 = OpTypeArray %16 %25 
                                              %27 = OpTypeStruct %23 %24 %16 %16 %16 %26 %16 %16 %16 %16 %16 %16 %16 %16 %16 %16 %16 
                                              %28 = OpTypePointer Uniform %27 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %29 = OpVariable Uniform 
                                              %30 = OpTypeInt 32 1 
                                          i32 %31 = OpConstant 0 
                                          i32 %32 = OpConstant 1 
                                              %33 = OpTypePointer Uniform %16 
                                          i32 %46 = OpConstant 2 
                                          i32 %56 = OpConstant 3 
                                              %61 = OpTypePointer Private %16 
                               Private f32_4* %62 = OpVariable Private 
                                              %65 = OpTypeArray %16 %22 
                                              %66 = OpTypeStruct %13 %65 
                                              %67 = OpTypePointer Uniform %66 
           Uniform struct {f32_3; f32_4[4];}* %68 = OpVariable Uniform 
                                          u32 %86 = OpConstant 1 
                                              %87 = OpTypeArray %6 %86 
                                              %88 = OpTypeStruct %16 %6 %87 
                                              %89 = OpTypePointer Output %88 
         Output struct {f32_4; f32; f32[1];}* %90 = OpVariable Output 
                                              %95 = OpTypePointer Output %16 
                                              %97 = OpTypePointer Input %13 
                                 Input f32_3* %98 = OpVariable Input 
                                         u32 %104 = OpConstant 0 
                                             %105 = OpTypePointer Private %6 
                                Private f32* %119 = OpVariable Private 
                                         f32 %126 = OpConstant 3.674022E-40 
                                             %137 = OpTypePointer Output %13 
                       Output f32_3* vs_TEXCOORD1 = OpVariable Output 
                              Private f32_3* %141 = OpVariable Private 
                                Input f32_4* %142 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                              Private f32_3* %178 = OpVariable Private 
                                         u32 %194 = OpConstant 3 
                                             %195 = OpTypePointer Input %6 
                                             %198 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                             %211 = OpTypePointer Uniform %13 
                       Output f32_3* vs_TEXCOORD5 = OpVariable Output 
                                             %217 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_2 %12 = OpLoad %11 
                                                      OpStore vs_TEXCOORD0 %12 
                                        f32_4 %19 = OpLoad %18 
                                        f32_3 %20 = OpVectorShuffle %19 %19 1 1 1 
                               Uniform f32_4* %34 = OpAccessChain %29 %31 %32 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_3 %37 = OpFMul %20 %36 
                                                      OpStore %15 %37 
                               Uniform f32_4* %38 = OpAccessChain %29 %31 %31 
                                        f32_4 %39 = OpLoad %38 
                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
                                        f32_4 %41 = OpLoad %18 
                                        f32_3 %42 = OpVectorShuffle %41 %41 0 0 0 
                                        f32_3 %43 = OpFMul %40 %42 
                                        f32_3 %44 = OpLoad %15 
                                        f32_3 %45 = OpFAdd %43 %44 
                                                      OpStore %15 %45 
                               Uniform f32_4* %47 = OpAccessChain %29 %31 %46 
                                        f32_4 %48 = OpLoad %47 
                                        f32_3 %49 = OpVectorShuffle %48 %48 0 1 2 
                                        f32_4 %50 = OpLoad %18 
                                        f32_3 %51 = OpVectorShuffle %50 %50 2 2 2 
                                        f32_3 %52 = OpFMul %49 %51 
                                        f32_3 %53 = OpLoad %15 
                                        f32_3 %54 = OpFAdd %52 %53 
                                                      OpStore %15 %54 
                                        f32_3 %55 = OpLoad %15 
                               Uniform f32_4* %57 = OpAccessChain %29 %31 %56 
                                        f32_4 %58 = OpLoad %57 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %55 %59 
                                                      OpStore %15 %60 
                                        f32_3 %63 = OpLoad %15 
                                        f32_4 %64 = OpVectorShuffle %63 %63 1 1 1 1 
                               Uniform f32_4* %69 = OpAccessChain %68 %32 %32 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpFMul %64 %70 
                                                      OpStore %62 %71 
                               Uniform f32_4* %72 = OpAccessChain %68 %32 %31 
                                        f32_4 %73 = OpLoad %72 
                                        f32_3 %74 = OpLoad %15 
                                        f32_4 %75 = OpVectorShuffle %74 %74 0 0 0 0 
                                        f32_4 %76 = OpFMul %73 %75 
                                        f32_4 %77 = OpLoad %62 
                                        f32_4 %78 = OpFAdd %76 %77 
                                                      OpStore %62 %78 
                               Uniform f32_4* %79 = OpAccessChain %68 %32 %46 
                                        f32_4 %80 = OpLoad %79 
                                        f32_3 %81 = OpLoad %15 
                                        f32_4 %82 = OpVectorShuffle %81 %81 2 2 2 2 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %62 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %62 %85 
                                        f32_4 %91 = OpLoad %62 
                               Uniform f32_4* %92 = OpAccessChain %68 %32 %56 
                                        f32_4 %93 = OpLoad %92 
                                        f32_4 %94 = OpFAdd %91 %93 
                                Output f32_4* %96 = OpAccessChain %90 %31 
                                                      OpStore %96 %94 
                                        f32_3 %99 = OpLoad %98 
                              Uniform f32_4* %100 = OpAccessChain %29 %32 %31 
                                       f32_4 %101 = OpLoad %100 
                                       f32_3 %102 = OpVectorShuffle %101 %101 0 1 2 
                                         f32 %103 = OpDot %99 %102 
                                Private f32* %106 = OpAccessChain %62 %104 
                                                      OpStore %106 %103 
                                       f32_3 %107 = OpLoad %98 
                              Uniform f32_4* %108 = OpAccessChain %29 %32 %32 
                                       f32_4 %109 = OpLoad %108 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %107 %110 
                                Private f32* %112 = OpAccessChain %62 %86 
                                                      OpStore %112 %111 
                                       f32_3 %113 = OpLoad %98 
                              Uniform f32_4* %114 = OpAccessChain %29 %32 %46 
                                       f32_4 %115 = OpLoad %114 
                                       f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
                                         f32 %117 = OpDot %113 %116 
                                Private f32* %118 = OpAccessChain %62 %25 
                                                      OpStore %118 %117 
                                       f32_4 %120 = OpLoad %62 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                       f32_4 %122 = OpLoad %62 
                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
                                         f32 %124 = OpDot %121 %123 
                                                      OpStore %119 %124 
                                         f32 %125 = OpLoad %119 
                                         f32 %127 = OpExtInst %1 40 %125 %126 
                                                      OpStore %119 %127 
                                         f32 %128 = OpLoad %119 
                                         f32 %129 = OpExtInst %1 32 %128 
                                                      OpStore %119 %129 
                                         f32 %130 = OpLoad %119 
                                       f32_3 %131 = OpCompositeConstruct %130 %130 %130 
                                       f32_4 %132 = OpLoad %62 
                                       f32_3 %133 = OpVectorShuffle %132 %132 0 1 2 
                                       f32_3 %134 = OpFMul %131 %133 
                                       f32_4 %135 = OpLoad %62 
                                       f32_4 %136 = OpVectorShuffle %135 %134 4 5 6 3 
                                                      OpStore %62 %136 
                                       f32_4 %139 = OpLoad %62 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                                      OpStore vs_TEXCOORD1 %140 
                                       f32_4 %143 = OpLoad %142 
                                       f32_3 %144 = OpVectorShuffle %143 %143 1 1 1 
                              Uniform f32_4* %145 = OpAccessChain %29 %31 %32 
                                       f32_4 %146 = OpLoad %145 
                                       f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
                                       f32_3 %148 = OpFMul %144 %147 
                                                      OpStore %141 %148 
                              Uniform f32_4* %149 = OpAccessChain %29 %31 %31 
                                       f32_4 %150 = OpLoad %149 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                       f32_4 %152 = OpLoad %142 
                                       f32_3 %153 = OpVectorShuffle %152 %152 0 0 0 
                                       f32_3 %154 = OpFMul %151 %153 
                                       f32_3 %155 = OpLoad %141 
                                       f32_3 %156 = OpFAdd %154 %155 
                                                      OpStore %141 %156 
                              Uniform f32_4* %157 = OpAccessChain %29 %31 %46 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_4 %160 = OpLoad %142 
                                       f32_3 %161 = OpVectorShuffle %160 %160 2 2 2 
                                       f32_3 %162 = OpFMul %159 %161 
                                       f32_3 %163 = OpLoad %141 
                                       f32_3 %164 = OpFAdd %162 %163 
                                                      OpStore %141 %164 
                                       f32_3 %165 = OpLoad %141 
                                       f32_3 %166 = OpLoad %141 
                                         f32 %167 = OpDot %165 %166 
                                                      OpStore %119 %167 
                                         f32 %168 = OpLoad %119 
                                         f32 %169 = OpExtInst %1 40 %168 %126 
                                                      OpStore %119 %169 
                                         f32 %170 = OpLoad %119 
                                         f32 %171 = OpExtInst %1 32 %170 
                                                      OpStore %119 %171 
                                         f32 %172 = OpLoad %119 
                                       f32_3 %173 = OpCompositeConstruct %172 %172 %172 
                                       f32_3 %174 = OpLoad %141 
                                       f32_3 %175 = OpFMul %173 %174 
                                                      OpStore %141 %175 
                                       f32_3 %177 = OpLoad %141 
                                                      OpStore vs_TEXCOORD2 %177 
                                       f32_4 %179 = OpLoad %62 
                                       f32_3 %180 = OpVectorShuffle %179 %179 2 0 1 
                                       f32_3 %181 = OpLoad %141 
                                       f32_3 %182 = OpVectorShuffle %181 %181 1 2 0 
                                       f32_3 %183 = OpFMul %180 %182 
                                                      OpStore %178 %183 
                                       f32_4 %184 = OpLoad %62 
                                       f32_3 %185 = OpVectorShuffle %184 %184 1 2 0 
                                       f32_3 %186 = OpLoad %141 
                                       f32_3 %187 = OpVectorShuffle %186 %186 2 0 1 
                                       f32_3 %188 = OpFMul %185 %187 
                                       f32_3 %189 = OpLoad %178 
                                       f32_3 %190 = OpFNegate %189 
                                       f32_3 %191 = OpFAdd %188 %190 
                                       f32_4 %192 = OpLoad %62 
                                       f32_4 %193 = OpVectorShuffle %192 %191 4 5 6 3 
                                                      OpStore %62 %193 
                                  Input f32* %196 = OpAccessChain %142 %194 
                                         f32 %197 = OpLoad %196 
                                Uniform f32* %199 = OpAccessChain %29 %56 %194 
                                         f32 %200 = OpLoad %199 
                                         f32 %201 = OpFMul %197 %200 
                                                      OpStore %119 %201 
                                         f32 %203 = OpLoad %119 
                                       f32_3 %204 = OpCompositeConstruct %203 %203 %203 
                                       f32_4 %205 = OpLoad %62 
                                       f32_3 %206 = OpVectorShuffle %205 %205 0 1 2 
                                       f32_3 %207 = OpFMul %204 %206 
                                                      OpStore vs_TEXCOORD3 %207 
                                       f32_3 %209 = OpLoad %15 
                                       f32_3 %210 = OpFNegate %209 
                              Uniform f32_3* %212 = OpAccessChain %68 %31 
                                       f32_3 %213 = OpLoad %212 
                                       f32_3 %214 = OpFAdd %210 %213 
                                                      OpStore vs_TEXCOORD4 %214 
                                       f32_3 %216 = OpLoad %15 
                                                      OpStore vs_TEXCOORD5 %216 
                                 Output f32* %218 = OpAccessChain %90 %31 %86 
                                         f32 %219 = OpLoad %218 
                                         f32 %220 = OpFNegate %219 
                                 Output f32* %221 = OpAccessChain %90 %31 %86 
                                                      OpStore %221 %220 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 498
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %22 %45 %53 %118 %196 %469 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %12 DescriptorSet 12 
                                                      OpDecorate %12 Binding 12 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 RelaxedPrecision 
                                                      OpDecorate %16 DescriptorSet 16 
                                                      OpDecorate %16 Binding 16 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 22 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %27 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpDecorate %32 RelaxedPrecision 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %35 RelaxedPrecision 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %40 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD2 Location 45 
                                                      OpDecorate vs_TEXCOORD3 Location 53 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 DescriptorSet 62 
                                                      OpDecorate %62 Binding 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %70 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %75 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %81 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %88 RelaxedPrecision 
                                                      OpMemberDecorate %89 0 Offset 89 
                                                      OpMemberDecorate %89 1 Offset 89 
                                                      OpMemberDecorate %89 2 Offset 89 
                                                      OpMemberDecorate %89 3 Offset 89 
                                                      OpMemberDecorate %89 4 Offset 89 
                                                      OpMemberDecorate %89 5 Offset 89 
                                                      OpMemberDecorate %89 6 Offset 89 
                                                      OpDecorate %89 Block 
                                                      OpDecorate %91 DescriptorSet 91 
                                                      OpDecorate %91 Binding 91 
                                                      OpDecorate %97 RelaxedPrecision 
                                                      OpDecorate %98 RelaxedPrecision 
                                                      OpDecorate %101 RelaxedPrecision 
                                                      OpDecorate %102 RelaxedPrecision 
                                                      OpDecorate %107 RelaxedPrecision 
                                                      OpDecorate %108 RelaxedPrecision 
                                                      OpDecorate %111 RelaxedPrecision 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 118 
                                                      OpDecorate %120 RelaxedPrecision 
                                                      OpDecorate %121 RelaxedPrecision 
                                                      OpDecorate %128 RelaxedPrecision 
                                                      OpDecorate %130 RelaxedPrecision 
                                                      OpDecorate %135 RelaxedPrecision 
                                                      OpDecorate %149 RelaxedPrecision 
                                                      OpDecorate %162 RelaxedPrecision 
                                                      OpDecorate %176 RelaxedPrecision 
                                                      OpMemberDecorate %178 0 Offset 178 
                                                      OpMemberDecorate %178 1 RelaxedPrecision 
                                                      OpMemberDecorate %178 1 Offset 178 
                                                      OpDecorate %178 Block 
                                                      OpDecorate %180 DescriptorSet 180 
                                                      OpDecorate %180 Binding 180 
                                                      OpDecorate %186 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %189 RelaxedPrecision 
                                                      OpDecorate %190 RelaxedPrecision 
                                                      OpDecorate %191 RelaxedPrecision 
                                                      OpDecorate %192 RelaxedPrecision 
                                                      OpDecorate %193 RelaxedPrecision 
                                                      OpDecorate %194 RelaxedPrecision 
                                                      OpDecorate %195 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 196 
                                                      OpDecorate %219 RelaxedPrecision 
                                                      OpDecorate %220 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %223 RelaxedPrecision 
                                                      OpDecorate %224 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %226 RelaxedPrecision 
                                                      OpDecorate %227 RelaxedPrecision 
                                                      OpDecorate %228 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %235 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %238 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %241 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %261 RelaxedPrecision 
                                                      OpDecorate %263 RelaxedPrecision 
                                                      OpDecorate %264 RelaxedPrecision 
                                                      OpDecorate %265 RelaxedPrecision 
                                                      OpDecorate %268 RelaxedPrecision 
                                                      OpDecorate %270 RelaxedPrecision 
                                                      OpDecorate %271 RelaxedPrecision 
                                                      OpDecorate %272 RelaxedPrecision 
                                                      OpDecorate %273 RelaxedPrecision 
                                                      OpDecorate %274 RelaxedPrecision 
                                                      OpDecorate %275 RelaxedPrecision 
                                                      OpDecorate %286 RelaxedPrecision 
                                                      OpDecorate %287 RelaxedPrecision 
                                                      OpDecorate %294 RelaxedPrecision 
                                                      OpDecorate %296 ArrayStride 296 
                                                      OpDecorate %297 ArrayStride 297 
                                                      OpDecorate %298 ArrayStride 298 
                                                      OpMemberDecorate %299 0 Offset 299 
                                                      OpMemberDecorate %299 1 Offset 299 
                                                      OpMemberDecorate %299 2 Offset 299 
                                                      OpMemberDecorate %299 3 RelaxedPrecision 
                                                      OpMemberDecorate %299 3 Offset 299 
                                                      OpMemberDecorate %299 4 RelaxedPrecision 
                                                      OpMemberDecorate %299 4 Offset 299 
                                                      OpMemberDecorate %299 5 RelaxedPrecision 
                                                      OpMemberDecorate %299 5 Offset 299 
                                                      OpMemberDecorate %299 6 Offset 299 
                                                      OpMemberDecorate %299 7 RelaxedPrecision 
                                                      OpMemberDecorate %299 7 Offset 299 
                                                      OpMemberDecorate %299 8 Offset 299 
                                                      OpMemberDecorate %299 9 Offset 299 
                                                      OpMemberDecorate %299 10 RelaxedPrecision 
                                                      OpMemberDecorate %299 10 Offset 299 
                                                      OpMemberDecorate %299 11 RelaxedPrecision 
                                                      OpMemberDecorate %299 11 Offset 299 
                                                      OpMemberDecorate %299 12 RelaxedPrecision 
                                                      OpMemberDecorate %299 12 Offset 299 
                                                      OpMemberDecorate %299 13 RelaxedPrecision 
                                                      OpMemberDecorate %299 13 Offset 299 
                                                      OpMemberDecorate %299 14 RelaxedPrecision 
                                                      OpMemberDecorate %299 14 Offset 299 
                                                      OpMemberDecorate %299 15 RelaxedPrecision 
                                                      OpMemberDecorate %299 15 Offset 299 
                                                      OpMemberDecorate %299 16 RelaxedPrecision 
                                                      OpMemberDecorate %299 16 Offset 299 
                                                      OpDecorate %299 Block 
                                                      OpDecorate %301 DescriptorSet 301 
                                                      OpDecorate %301 Binding 301 
                                                      OpDecorate %304 RelaxedPrecision 
                                                      OpDecorate %305 RelaxedPrecision 
                                                      OpDecorate %306 RelaxedPrecision 
                                                      OpDecorate %310 RelaxedPrecision 
                                                      OpDecorate %311 RelaxedPrecision 
                                                      OpDecorate %312 RelaxedPrecision 
                                                      OpDecorate %316 RelaxedPrecision 
                                                      OpDecorate %317 RelaxedPrecision 
                                                      OpDecorate %318 RelaxedPrecision 
                                                      OpDecorate %322 RelaxedPrecision 
                                                      OpDecorate %323 RelaxedPrecision 
                                                      OpDecorate %324 RelaxedPrecision 
                                                      OpDecorate %325 RelaxedPrecision 
                                                      OpDecorate %326 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %328 RelaxedPrecision 
                                                      OpDecorate %335 RelaxedPrecision 
                                                      OpDecorate %341 RelaxedPrecision 
                                                      OpDecorate %347 RelaxedPrecision 
                                                      OpDecorate %351 RelaxedPrecision 
                                                      OpDecorate %352 RelaxedPrecision 
                                                      OpDecorate %353 RelaxedPrecision 
                                                      OpDecorate %354 RelaxedPrecision 
                                                      OpDecorate %357 RelaxedPrecision 
                                                      OpDecorate %358 RelaxedPrecision 
                                                      OpDecorate %360 RelaxedPrecision 
                                                      OpDecorate %363 RelaxedPrecision 
                                                      OpDecorate %364 RelaxedPrecision 
                                                      OpDecorate %365 RelaxedPrecision 
                                                      OpDecorate %366 RelaxedPrecision 
                                                      OpDecorate %367 RelaxedPrecision 
                                                      OpDecorate %368 RelaxedPrecision 
                                                      OpDecorate %374 RelaxedPrecision 
                                                      OpDecorate %375 RelaxedPrecision 
                                                      OpDecorate %376 RelaxedPrecision 
                                                      OpDecorate %379 RelaxedPrecision 
                                                      OpDecorate %390 RelaxedPrecision 
                                                      OpDecorate %391 RelaxedPrecision 
                                                      OpDecorate %392 RelaxedPrecision 
                                                      OpDecorate %393 RelaxedPrecision 
                                                      OpDecorate %394 RelaxedPrecision 
                                                      OpDecorate %395 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %427 RelaxedPrecision 
                                                      OpDecorate %427 DescriptorSet 427 
                                                      OpDecorate %427 Binding 427 
                                                      OpDecorate %428 RelaxedPrecision 
                                                      OpDecorate %429 RelaxedPrecision 
                                                      OpDecorate %429 DescriptorSet 429 
                                                      OpDecorate %429 Binding 429 
                                                      OpDecorate %430 RelaxedPrecision 
                                                      OpDecorate %433 RelaxedPrecision 
                                                      OpDecorate %434 RelaxedPrecision 
                                                      OpDecorate %435 RelaxedPrecision 
                                                      OpDecorate %437 RelaxedPrecision 
                                                      OpDecorate %438 RelaxedPrecision 
                                                      OpDecorate %441 RelaxedPrecision 
                                                      OpDecorate %442 RelaxedPrecision 
                                                      OpDecorate %443 RelaxedPrecision 
                                                      OpDecorate %444 RelaxedPrecision 
                                                      OpDecorate %445 RelaxedPrecision 
                                                      OpDecorate %446 RelaxedPrecision 
                                                      OpDecorate %447 RelaxedPrecision 
                                                      OpDecorate %448 RelaxedPrecision 
                                                      OpDecorate %449 RelaxedPrecision 
                                                      OpDecorate %451 RelaxedPrecision 
                                                      OpDecorate %452 RelaxedPrecision 
                                                      OpDecorate %453 RelaxedPrecision 
                                                      OpDecorate %454 RelaxedPrecision 
                                                      OpDecorate %455 RelaxedPrecision 
                                                      OpDecorate %457 RelaxedPrecision 
                                                      OpDecorate %458 RelaxedPrecision 
                                                      OpDecorate %459 RelaxedPrecision 
                                                      OpDecorate %460 RelaxedPrecision 
                                                      OpDecorate %461 RelaxedPrecision 
                                                      OpDecorate %462 RelaxedPrecision 
                                                      OpDecorate %463 RelaxedPrecision 
                                                      OpDecorate %466 RelaxedPrecision 
                                                      OpDecorate %469 RelaxedPrecision 
                                                      OpDecorate %469 Location 469 
                                                      OpDecorate %470 RelaxedPrecision 
                                                      OpDecorate %478 RelaxedPrecision 
                                                      OpDecorate %479 RelaxedPrecision 
                                                      OpDecorate %480 RelaxedPrecision 
                                                      OpDecorate %481 RelaxedPrecision 
                                                      OpDecorate %482 RelaxedPrecision 
                                                      OpDecorate %483 RelaxedPrecision 
                                                      OpDecorate %484 RelaxedPrecision 
                                                      OpDecorate %485 RelaxedPrecision 
                                                      OpDecorate %488 RelaxedPrecision 
                                                      OpDecorate %489 RelaxedPrecision 
                                                      OpDecorate %490 RelaxedPrecision 
                                                      OpDecorate %491 RelaxedPrecision 
                                                      OpDecorate %492 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypePointer UniformConstant %10 
         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                              %14 = OpTypeSampler 
                                              %15 = OpTypePointer UniformConstant %14 
                     UniformConstant sampler* %16 = OpVariable UniformConstant 
                                              %18 = OpTypeSampledImage %10 
                                              %20 = OpTypeVector %6 2 
                                              %21 = OpTypePointer Input %20 
                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                              %24 = OpTypeVector %6 4 
                               Private f32_3* %27 = OpVariable Private 
                                          f32 %30 = OpConstant 3.674022E-40 
                                          f32 %31 = OpConstant 3.674022E-40 
                                          f32 %38 = OpConstant 3.674022E-40 
                                        f32_3 %39 = OpConstantComposite %38 %38 %38 
                               Private f32_3* %43 = OpVariable Private 
                                              %44 = OpTypePointer Input %7 
                        Input f32_3* vs_TEXCOORD2 = OpVariable Input 
                                              %46 = OpTypeInt 32 0 
                                          u32 %47 = OpConstant 0 
                                              %48 = OpTypePointer Input %6 
                                              %51 = OpTypePointer Private %6 
                        Input f32_3* vs_TEXCOORD3 = OpVariable Input 
                                          u32 %56 = OpConstant 1 
                                              %58 = OpTypePointer Private %24 
                               Private f32_4* %59 = OpVariable Private 
         UniformConstant read_only Texture2D* %60 = OpVariable UniformConstant 
                     UniformConstant sampler* %62 = OpVariable UniformConstant 
                               Private f32_3* %70 = OpVariable Private 
                                          f32 %73 = OpConstant 3.674022E-40 
                                        f32_3 %74 = OpConstantComposite %73 %73 %73 
                                          f32 %76 = OpConstant 3.674022E-40 
                                        f32_3 %77 = OpConstantComposite %76 %76 %76 
                               Private f32_4* %79 = OpVariable Private 
                               Private f32_4* %86 = OpVariable Private 
                                              %89 = OpTypeStruct %6 %6 %6 %6 %6 %6 %6 
                                              %90 = OpTypePointer Uniform %89 
Uniform struct {f32; f32; f32; f32; f32; f32; f32;}* %91 = OpVariable Uniform 
                                              %92 = OpTypeInt 32 1 
                                          i32 %93 = OpConstant 0 
                                              %94 = OpTypePointer Uniform %6 
                        Input f32_3* vs_TEXCOORD1 = OpVariable Input 
                                       f32_3 %129 = OpConstantComposite %76 %76 %31 
                                         u32 %133 = OpConstant 2 
                              Private f32_3* %139 = OpVariable Private 
                                Private f32* %166 = OpVariable Private 
                                Private f32* %176 = OpVariable Private 
                                             %178 = OpTypeStruct %24 %24 
                                             %179 = OpTypePointer Uniform %178 
             Uniform struct {f32_4; f32_4;}* %180 = OpVariable Uniform 
                                             %181 = OpTypePointer Uniform %24 
                                         f32 %187 = OpConstant 3.674022E-40 
                        Input f32_3* vs_TEXCOORD4 = OpVariable Input 
                                         f32 %239 = OpConstant 3.674022E-40 
                                         i32 %243 = OpConstant 2 
                                         f32 %246 = OpConstant 3.674022E-40 
                                         i32 %256 = OpConstant 1 
                              Private f32_3* %294 = OpVariable Private 
                                         u32 %295 = OpConstant 4 
                                             %296 = OpTypeArray %24 %295 
                                             %297 = OpTypeArray %24 %295 
                                             %298 = OpTypeArray %24 %133 
                                             %299 = OpTypeStruct %296 %297 %24 %24 %24 %298 %24 %24 %24 %24 %24 %24 %24 %24 %24 %24 %24 
                                             %300 = OpTypePointer Uniform %299 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %301 = OpVariable Uniform 
                                         i32 %302 = OpConstant 13 
                                         i32 %308 = OpConstant 14 
                                         i32 %314 = OpConstant 15 
                                         i32 %320 = OpConstant 16 
                                         u32 %331 = OpConstant 3 
                                         i32 %333 = OpConstant 10 
                                         i32 %339 = OpConstant 11 
                                         i32 %345 = OpConstant 12 
                                       f32_3 %359 = OpConstantComposite %30 %30 %30 
                                         i32 %400 = OpConstant 4 
                                Private f32* %409 = OpVariable Private 
                                         i32 %410 = OpConstant 5 
                                         f32 %414 = OpConstant 3.674022E-40 
                                         f32 %416 = OpConstant 3.674022E-40 
                                         f32 %423 = OpConstant 3.674022E-40 
                                             %425 = OpTypeImage %6 Cube 0 0 0 1 Unknown 
                                             %426 = OpTypePointer UniformConstant %425 
      UniformConstant read_only TextureCube* %427 = OpVariable UniformConstant 
                    UniformConstant sampler* %429 = OpVariable UniformConstant 
                                             %431 = OpTypeSampledImage %425 
                                         i32 %439 = OpConstant 7 
                                             %468 = OpTypePointer Output %24 
                               Output f32_4* %469 = OpVariable Output 
                                         i32 %471 = OpConstant 3 
                                             %495 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                          read_only Texture2D %13 = OpLoad %12 
                                      sampler %17 = OpLoad %16 
                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
                                        f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                                        f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                                      OpStore %9 %26 
                                        f32_3 %28 = OpLoad %9 
                                                      OpStore %27 %28 
                                        f32_3 %29 = OpLoad %27 
                                        f32_3 %32 = OpCompositeConstruct %30 %30 %30 
                                        f32_3 %33 = OpCompositeConstruct %31 %31 %31 
                                        f32_3 %34 = OpExtInst %1 43 %29 %32 %33 
                                                      OpStore %27 %34 
                                        f32_3 %35 = OpLoad %27 
                                        f32_3 %36 = OpExtInst %1 30 %35 
                                                      OpStore %27 %36 
                                        f32_3 %37 = OpLoad %27 
                                        f32_3 %40 = OpFMul %37 %39 
                                                      OpStore %27 %40 
                                        f32_3 %41 = OpLoad %27 
                                        f32_3 %42 = OpExtInst %1 29 %41 
                                                      OpStore %27 %42 
                                   Input f32* %49 = OpAccessChain vs_TEXCOORD2 %47 
                                          f32 %50 = OpLoad %49 
                                 Private f32* %52 = OpAccessChain %43 %47 
                                                      OpStore %52 %50 
                                   Input f32* %54 = OpAccessChain vs_TEXCOORD3 %47 
                                          f32 %55 = OpLoad %54 
                                 Private f32* %57 = OpAccessChain %43 %56 
                                                      OpStore %57 %55 
                          read_only Texture2D %61 = OpLoad %60 
                                      sampler %63 = OpLoad %62 
                   read_only Texture2DSampled %64 = OpSampledImage %61 %63 
                                        f32_2 %65 = OpLoad vs_TEXCOORD0 
                                        f32_4 %66 = OpImageSampleImplicitLod %64 %65 
                                        f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
                                        f32_4 %68 = OpLoad %59 
                                        f32_4 %69 = OpVectorShuffle %68 %67 4 5 6 3 
                                                      OpStore %59 %69 
                                        f32_4 %71 = OpLoad %59 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %75 = OpFMul %72 %74 
                                        f32_3 %78 = OpFAdd %75 %77 
                                                      OpStore %70 %78 
                                        f32_3 %80 = OpLoad %70 
                                        f32_3 %81 = OpVectorShuffle %80 %80 1 1 1 
                                        f32_3 %82 = OpLoad vs_TEXCOORD3 
                                        f32_3 %83 = OpFMul %81 %82 
                                        f32_4 %84 = OpLoad %79 
                                        f32_4 %85 = OpVectorShuffle %84 %83 4 5 6 3 
                                                      OpStore %79 %85 
                                        f32_4 %87 = OpLoad %79 
                                        f32_3 %88 = OpVectorShuffle %87 %87 0 1 2 
                                 Uniform f32* %95 = OpAccessChain %91 %93 
                                          f32 %96 = OpLoad %95 
                                        f32_3 %97 = OpCompositeConstruct %96 %96 %96 
                                        f32_3 %98 = OpFMul %88 %97 
                                        f32_4 %99 = OpLoad %86 
                                       f32_4 %100 = OpVectorShuffle %99 %98 4 5 6 3 
                                                      OpStore %86 %100 
                                       f32_3 %101 = OpLoad %70 
                                       f32_3 %102 = OpVectorShuffle %101 %101 0 0 0 
                                       f32_3 %103 = OpLoad vs_TEXCOORD2 
                                       f32_3 %104 = OpFMul %102 %103 
                                       f32_4 %105 = OpLoad %79 
                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
                                                      OpStore %79 %106 
                                       f32_4 %107 = OpLoad %79 
                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
                                Uniform f32* %109 = OpAccessChain %91 %93 
                                         f32 %110 = OpLoad %109 
                                       f32_3 %111 = OpCompositeConstruct %110 %110 %110 
                                       f32_3 %112 = OpFMul %108 %111 
                                       f32_4 %113 = OpLoad %86 
                                       f32_3 %114 = OpVectorShuffle %113 %113 0 1 2 
                                       f32_3 %115 = OpFAdd %112 %114 
                                       f32_4 %116 = OpLoad %86 
                                       f32_4 %117 = OpVectorShuffle %116 %115 4 5 6 3 
                                                      OpStore %86 %117 
                                       f32_3 %119 = OpLoad vs_TEXCOORD1 
                                       f32_3 %120 = OpLoad %70 
                                       f32_3 %121 = OpVectorShuffle %120 %120 2 2 2 
                                       f32_3 %122 = OpFMul %119 %121 
                                       f32_4 %123 = OpLoad %86 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                       f32_3 %125 = OpFAdd %122 %124 
                                       f32_4 %126 = OpLoad %86 
                                       f32_4 %127 = OpVectorShuffle %126 %125 4 5 6 3 
                                                      OpStore %86 %127 
                                       f32_3 %128 = OpLoad %70 
                                       f32_3 %130 = OpFMul %128 %129 
                                                      OpStore %70 %130 
                                Private f32* %131 = OpAccessChain %86 %47 
                                         f32 %132 = OpLoad %131 
                                Private f32* %134 = OpAccessChain %43 %133 
                                                      OpStore %134 %132 
                                       f32_3 %135 = OpLoad %70 
                                       f32_3 %136 = OpLoad %43 
                                         f32 %137 = OpDot %135 %136 
                                Private f32* %138 = OpAccessChain %43 %47 
                                                      OpStore %138 %137 
                                  Input f32* %140 = OpAccessChain vs_TEXCOORD2 %56 
                                         f32 %141 = OpLoad %140 
                                Private f32* %142 = OpAccessChain %139 %47 
                                                      OpStore %142 %141 
                                  Input f32* %143 = OpAccessChain vs_TEXCOORD3 %56 
                                         f32 %144 = OpLoad %143 
                                Private f32* %145 = OpAccessChain %139 %56 
                                                      OpStore %145 %144 
                                Private f32* %146 = OpAccessChain %86 %56 
                                         f32 %147 = OpLoad %146 
                                Private f32* %148 = OpAccessChain %139 %133 
                                                      OpStore %148 %147 
                                       f32_3 %149 = OpLoad %70 
                                       f32_3 %150 = OpLoad %139 
                                         f32 %151 = OpDot %149 %150 
                                Private f32* %152 = OpAccessChain %43 %56 
                                                      OpStore %152 %151 
                                  Input f32* %153 = OpAccessChain vs_TEXCOORD2 %133 
                                         f32 %154 = OpLoad %153 
                                Private f32* %155 = OpAccessChain %139 %47 
                                                      OpStore %155 %154 
                                  Input f32* %156 = OpAccessChain vs_TEXCOORD3 %133 
                                         f32 %157 = OpLoad %156 
                                Private f32* %158 = OpAccessChain %139 %56 
                                                      OpStore %158 %157 
                                Private f32* %159 = OpAccessChain %86 %133 
                                         f32 %160 = OpLoad %159 
                                Private f32* %161 = OpAccessChain %139 %133 
                                                      OpStore %161 %160 
                                       f32_3 %162 = OpLoad %70 
                                       f32_3 %163 = OpLoad %139 
                                         f32 %164 = OpDot %162 %163 
                                Private f32* %165 = OpAccessChain %43 %133 
                                                      OpStore %165 %164 
                                       f32_3 %167 = OpLoad %43 
                                       f32_3 %168 = OpLoad %43 
                                         f32 %169 = OpDot %167 %168 
                                                      OpStore %166 %169 
                                         f32 %170 = OpLoad %166 
                                         f32 %171 = OpExtInst %1 32 %170 
                                                      OpStore %166 %171 
                                         f32 %172 = OpLoad %166 
                                       f32_3 %173 = OpCompositeConstruct %172 %172 %172 
                                       f32_3 %174 = OpLoad %43 
                                       f32_3 %175 = OpFMul %173 %174 
                                                      OpStore %43 %175 
                                       f32_3 %177 = OpLoad %43 
                              Uniform f32_4* %182 = OpAccessChain %180 %93 
                                       f32_4 %183 = OpLoad %182 
                                       f32_3 %184 = OpVectorShuffle %183 %183 0 1 2 
                                         f32 %185 = OpDot %177 %184 
                                                      OpStore %176 %185 
                                         f32 %186 = OpLoad %176 
                                         f32 %188 = OpFMul %186 %187 
                                         f32 %189 = OpFAdd %188 %187 
                                                      OpStore %176 %189 
                                         f32 %190 = OpLoad %176 
                                         f32 %191 = OpExtInst %1 43 %190 %30 %31 
                                                      OpStore %176 %191 
                                       f32_3 %192 = OpLoad %27 
                                         f32 %193 = OpLoad %176 
                                       f32_3 %194 = OpCompositeConstruct %193 %193 %193 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %70 %195 
                                       f32_3 %197 = OpLoad vs_TEXCOORD4 
                                       f32_3 %198 = OpLoad vs_TEXCOORD4 
                                         f32 %199 = OpDot %197 %198 
                                Private f32* %200 = OpAccessChain %43 %47 
                                                      OpStore %200 %199 
                                Private f32* %201 = OpAccessChain %43 %47 
                                         f32 %202 = OpLoad %201 
                                         f32 %203 = OpExtInst %1 32 %202 
                                Private f32* %204 = OpAccessChain %43 %47 
                                                      OpStore %204 %203 
                                       f32_3 %205 = OpLoad vs_TEXCOORD4 
                                       f32_3 %206 = OpLoad %43 
                                       f32_3 %207 = OpVectorShuffle %206 %206 0 0 0 
                                       f32_3 %208 = OpFMul %205 %207 
                              Uniform f32_4* %209 = OpAccessChain %180 %93 
                                       f32_4 %210 = OpLoad %209 
                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
                                       f32_3 %212 = OpFAdd %208 %211 
                                       f32_4 %213 = OpLoad %79 
                                       f32_4 %214 = OpVectorShuffle %213 %212 4 5 6 3 
                                                      OpStore %79 %214 
                                       f32_3 %215 = OpLoad %43 
                                       f32_3 %216 = OpVectorShuffle %215 %215 0 0 0 
                                       f32_3 %217 = OpLoad vs_TEXCOORD4 
                                       f32_3 %218 = OpFMul %216 %217 
                                                      OpStore %43 %218 
                                       f32_4 %219 = OpLoad %79 
                                       f32_3 %220 = OpVectorShuffle %219 %219 0 1 2 
                                       f32_4 %221 = OpLoad %79 
                                       f32_3 %222 = OpVectorShuffle %221 %221 0 1 2 
                                         f32 %223 = OpDot %220 %222 
                                                      OpStore %176 %223 
                                         f32 %224 = OpLoad %176 
                                         f32 %225 = OpExtInst %1 32 %224 
                                                      OpStore %176 %225 
                                         f32 %226 = OpLoad %176 
                                       f32_3 %227 = OpCompositeConstruct %226 %226 %226 
                                       f32_4 %228 = OpLoad %79 
                                       f32_3 %229 = OpVectorShuffle %228 %228 0 1 2 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %79 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 5 6 3 
                                                      OpStore %79 %232 
                                       f32_4 %233 = OpLoad %86 
                                       f32_3 %234 = OpVectorShuffle %233 %233 0 1 2 
                                       f32_4 %235 = OpLoad %79 
                                       f32_3 %236 = OpVectorShuffle %235 %235 0 1 2 
                                         f32 %237 = OpDot %234 %236 
                                                      OpStore %176 %237 
                                         f32 %238 = OpLoad %176 
                                         f32 %240 = OpExtInst %1 40 %238 %239 
                                                      OpStore %176 %240 
                                         f32 %241 = OpLoad %176 
                                         f32 %242 = OpExtInst %1 30 %241 
                                                      OpStore %166 %242 
                                Uniform f32* %244 = OpAccessChain %91 %243 
                                         f32 %245 = OpLoad %244 
                                         f32 %247 = OpFMul %245 %246 
                                Private f32* %248 = OpAccessChain %139 %47 
                                                      OpStore %248 %247 
                                         f32 %249 = OpLoad %166 
                                Private f32* %250 = OpAccessChain %139 %47 
                                         f32 %251 = OpLoad %250 
                                         f32 %252 = OpFMul %249 %251 
                                                      OpStore %166 %252 
                                         f32 %253 = OpLoad %166 
                                         f32 %254 = OpExtInst %1 29 %253 
                                                      OpStore %166 %254 
                                         f32 %255 = OpLoad %166 
                                Uniform f32* %257 = OpAccessChain %91 %256 
                                         f32 %258 = OpLoad %257 
                                         f32 %259 = OpFMul %255 %258 
                                                      OpStore %166 %259 
                                         f32 %260 = OpLoad %166 
                                       f32_3 %261 = OpCompositeConstruct %260 %260 %260 
                              Uniform f32_4* %262 = OpAccessChain %180 %256 
                                       f32_4 %263 = OpLoad %262 
                                       f32_3 %264 = OpVectorShuffle %263 %263 0 1 2 
                                       f32_3 %265 = OpFMul %261 %264 
                                       f32_4 %266 = OpLoad %79 
                                       f32_4 %267 = OpVectorShuffle %266 %265 4 5 6 3 
                                                      OpStore %79 %267 
                                       f32_3 %268 = OpLoad %70 
                              Uniform f32_4* %269 = OpAccessChain %180 %256 
                                       f32_4 %270 = OpLoad %269 
                                       f32_3 %271 = OpVectorShuffle %270 %270 0 1 2 
                                       f32_3 %272 = OpFMul %268 %271 
                                       f32_4 %273 = OpLoad %79 
                                       f32_3 %274 = OpVectorShuffle %273 %273 0 1 2 
                                       f32_3 %275 = OpFAdd %272 %274 
                                                      OpStore %70 %275 
                                Private f32* %276 = OpAccessChain %86 %56 
                                         f32 %277 = OpLoad %276 
                                Private f32* %278 = OpAccessChain %86 %56 
                                         f32 %279 = OpLoad %278 
                                         f32 %280 = OpFMul %277 %279 
                                                      OpStore %176 %280 
                                Private f32* %281 = OpAccessChain %86 %47 
                                         f32 %282 = OpLoad %281 
                                Private f32* %283 = OpAccessChain %86 %47 
                                         f32 %284 = OpLoad %283 
                                         f32 %285 = OpFMul %282 %284 
                                         f32 %286 = OpLoad %176 
                                         f32 %287 = OpFNegate %286 
                                         f32 %288 = OpFAdd %285 %287 
                                                      OpStore %176 %288 
                                       f32_4 %289 = OpLoad %86 
                                       f32_4 %290 = OpVectorShuffle %289 %289 1 2 2 0 
                                       f32_4 %291 = OpLoad %86 
                                       f32_4 %292 = OpVectorShuffle %291 %291 0 1 2 2 
                                       f32_4 %293 = OpFMul %290 %292 
                                                      OpStore %79 %293 
                              Uniform f32_4* %303 = OpAccessChain %301 %302 
                                       f32_4 %304 = OpLoad %303 
                                       f32_4 %305 = OpLoad %79 
                                         f32 %306 = OpDot %304 %305 
                                Private f32* %307 = OpAccessChain %294 %47 
                                                      OpStore %307 %306 
                              Uniform f32_4* %309 = OpAccessChain %301 %308 
                                       f32_4 %310 = OpLoad %309 
                                       f32_4 %311 = OpLoad %79 
                                         f32 %312 = OpDot %310 %311 
                                Private f32* %313 = OpAccessChain %294 %56 
                                                      OpStore %313 %312 
                              Uniform f32_4* %315 = OpAccessChain %301 %314 
                                       f32_4 %316 = OpLoad %315 
                                       f32_4 %317 = OpLoad %79 
                                         f32 %318 = OpDot %316 %317 
                                Private f32* %319 = OpAccessChain %294 %133 
                                                      OpStore %319 %318 
                              Uniform f32_4* %321 = OpAccessChain %301 %320 
                                       f32_4 %322 = OpLoad %321 
                                       f32_3 %323 = OpVectorShuffle %322 %322 0 1 2 
                                         f32 %324 = OpLoad %176 
                                       f32_3 %325 = OpCompositeConstruct %324 %324 %324 
                                       f32_3 %326 = OpFMul %323 %325 
                                       f32_3 %327 = OpLoad %294 
                                       f32_3 %328 = OpFAdd %326 %327 
                                       f32_4 %329 = OpLoad %79 
                                       f32_4 %330 = OpVectorShuffle %329 %328 4 5 6 3 
                                                      OpStore %79 %330 
                                Private f32* %332 = OpAccessChain %86 %331 
                                                      OpStore %332 %31 
                              Uniform f32_4* %334 = OpAccessChain %301 %333 
                                       f32_4 %335 = OpLoad %334 
                                       f32_4 %336 = OpLoad %86 
                                         f32 %337 = OpDot %335 %336 
                                Private f32* %338 = OpAccessChain %294 %47 
                                                      OpStore %338 %337 
                              Uniform f32_4* %340 = OpAccessChain %301 %339 
                                       f32_4 %341 = OpLoad %340 
                                       f32_4 %342 = OpLoad %86 
                                         f32 %343 = OpDot %341 %342 
                                Private f32* %344 = OpAccessChain %294 %56 
                                                      OpStore %344 %343 
                              Uniform f32_4* %346 = OpAccessChain %301 %345 
                                       f32_4 %347 = OpLoad %346 
                                       f32_4 %348 = OpLoad %86 
                                         f32 %349 = OpDot %347 %348 
                                Private f32* %350 = OpAccessChain %294 %133 
                                                      OpStore %350 %349 
                                       f32_4 %351 = OpLoad %79 
                                       f32_3 %352 = OpVectorShuffle %351 %351 0 1 2 
                                       f32_3 %353 = OpLoad %294 
                                       f32_3 %354 = OpFAdd %352 %353 
                                       f32_4 %355 = OpLoad %79 
                                       f32_4 %356 = OpVectorShuffle %355 %354 4 5 6 3 
                                                      OpStore %79 %356 
                                       f32_4 %357 = OpLoad %79 
                                       f32_3 %358 = OpVectorShuffle %357 %357 0 1 2 
                                       f32_3 %360 = OpExtInst %1 40 %358 %359 
                                       f32_4 %361 = OpLoad %79 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 6 3 
                                                      OpStore %79 %362 
                                       f32_4 %363 = OpLoad %79 
                                       f32_3 %364 = OpVectorShuffle %363 %363 0 1 2 
                                       f32_3 %365 = OpLoad %27 
                                       f32_3 %366 = OpFMul %364 %365 
                                       f32_3 %367 = OpLoad %70 
                                       f32_3 %368 = OpFAdd %366 %367 
                                                      OpStore %27 %368 
                                       f32_3 %369 = OpLoad %43 
                                       f32_3 %370 = OpFNegate %369 
                                       f32_4 %371 = OpLoad %86 
                                       f32_3 %372 = OpVectorShuffle %371 %371 0 1 2 
                                         f32 %373 = OpDot %370 %372 
                                                      OpStore %176 %373 
                                         f32 %374 = OpLoad %176 
                                         f32 %375 = OpLoad %176 
                                         f32 %376 = OpFAdd %374 %375 
                                                      OpStore %176 %376 
                                       f32_4 %377 = OpLoad %86 
                                       f32_3 %378 = OpVectorShuffle %377 %377 0 1 2 
                                         f32 %379 = OpLoad %176 
                                       f32_3 %380 = OpCompositeConstruct %379 %379 %379 
                                       f32_3 %381 = OpFNegate %380 
                                       f32_3 %382 = OpFMul %378 %381 
                                       f32_3 %383 = OpLoad %43 
                                       f32_3 %384 = OpFNegate %383 
                                       f32_3 %385 = OpFAdd %382 %384 
                                                      OpStore %70 %385 
                                       f32_4 %386 = OpLoad %86 
                                       f32_3 %387 = OpVectorShuffle %386 %386 0 1 2 
                                       f32_3 %388 = OpLoad %43 
                                         f32 %389 = OpDot %387 %388 
                                                      OpStore %176 %389 
                                         f32 %390 = OpLoad %176 
                                         f32 %391 = OpFNegate %390 
                                         f32 %392 = OpFAdd %391 %31 
                                                      OpStore %176 %392 
                                         f32 %393 = OpLoad %176 
                                         f32 %394 = OpExtInst %1 43 %393 %30 %31 
                                                      OpStore %176 %394 
                                         f32 %395 = OpLoad %176 
                                         f32 %396 = OpExtInst %1 30 %395 
                                Private f32* %397 = OpAccessChain %43 %47 
                                                      OpStore %397 %396 
                                Private f32* %398 = OpAccessChain %43 %47 
                                         f32 %399 = OpLoad %398 
                                Uniform f32* %401 = OpAccessChain %91 %400 
                                         f32 %402 = OpLoad %401 
                                         f32 %403 = OpFMul %399 %402 
                                Private f32* %404 = OpAccessChain %43 %47 
                                                      OpStore %404 %403 
                                Private f32* %405 = OpAccessChain %43 %47 
                                         f32 %406 = OpLoad %405 
                                         f32 %407 = OpExtInst %1 29 %406 
                                Private f32* %408 = OpAccessChain %43 %47 
                                                      OpStore %408 %407 
                                Uniform f32* %411 = OpAccessChain %91 %410 
                                         f32 %412 = OpLoad %411 
                                         f32 %413 = OpFNegate %412 
                                         f32 %415 = OpFMul %413 %414 
                                         f32 %417 = OpFAdd %415 %416 
                                                      OpStore %409 %417 
                                         f32 %418 = OpLoad %409 
                                Uniform f32* %419 = OpAccessChain %91 %410 
                                         f32 %420 = OpLoad %419 
                                         f32 %421 = OpFMul %418 %420 
                                                      OpStore %409 %421 
                                         f32 %422 = OpLoad %409 
                                         f32 %424 = OpFMul %422 %423 
                                                      OpStore %176 %424 
                       read_only TextureCube %428 = OpLoad %427 
                                     sampler %430 = OpLoad %429 
                read_only TextureCubeSampled %432 = OpSampledImage %428 %430 
                                       f32_3 %433 = OpLoad %70 
                                         f32 %434 = OpLoad %176 
                                       f32_4 %435 = OpImageSampleExplicitLod %432 %433 Lod %24 
                                                      OpStore %59 %435 
                                Private f32* %436 = OpAccessChain %59 %331 
                                         f32 %437 = OpLoad %436 
                                         f32 %438 = OpFAdd %437 %76 
                                                      OpStore %176 %438 
                                Uniform f32* %440 = OpAccessChain %301 %439 %331 
                                         f32 %441 = OpLoad %440 
                                         f32 %442 = OpLoad %176 
                                         f32 %443 = OpFMul %441 %442 
                                         f32 %444 = OpFAdd %443 %31 
                                                      OpStore %176 %444 
                                         f32 %445 = OpLoad %176 
                                         f32 %446 = OpExtInst %1 40 %445 %30 
                                                      OpStore %176 %446 
                                         f32 %447 = OpLoad %176 
                                         f32 %448 = OpExtInst %1 30 %447 
                                                      OpStore %176 %448 
                                         f32 %449 = OpLoad %176 
                                Uniform f32* %450 = OpAccessChain %301 %439 %56 
                                         f32 %451 = OpLoad %450 
                                         f32 %452 = OpFMul %449 %451 
                                                      OpStore %176 %452 
                                         f32 %453 = OpLoad %176 
                                         f32 %454 = OpExtInst %1 29 %453 
                                                      OpStore %176 %454 
                                         f32 %455 = OpLoad %176 
                                Uniform f32* %456 = OpAccessChain %301 %439 %47 
                                         f32 %457 = OpLoad %456 
                                         f32 %458 = OpFMul %455 %457 
                                                      OpStore %176 %458 
                                       f32_4 %459 = OpLoad %59 
                                       f32_3 %460 = OpVectorShuffle %459 %459 0 1 2 
                                         f32 %461 = OpLoad %176 
                                       f32_3 %462 = OpCompositeConstruct %461 %461 %461 
                                       f32_3 %463 = OpFMul %460 %462 
                                                      OpStore %70 %463 
                                       f32_3 %464 = OpLoad %43 
                                       f32_3 %465 = OpVectorShuffle %464 %464 0 0 0 
                                       f32_3 %466 = OpLoad %70 
                                       f32_3 %467 = OpFMul %465 %466 
                                                      OpStore %70 %467 
                                       f32_3 %470 = OpLoad %70 
                                Uniform f32* %472 = OpAccessChain %91 %471 
                                         f32 %473 = OpLoad %472 
                                Uniform f32* %474 = OpAccessChain %91 %471 
                                         f32 %475 = OpLoad %474 
                                Uniform f32* %476 = OpAccessChain %91 %471 
                                         f32 %477 = OpLoad %476 
                                       f32_3 %478 = OpCompositeConstruct %473 %475 %477 
                                         f32 %479 = OpCompositeExtract %478 0 
                                         f32 %480 = OpCompositeExtract %478 1 
                                         f32 %481 = OpCompositeExtract %478 2 
                                       f32_3 %482 = OpCompositeConstruct %479 %480 %481 
                                       f32_3 %483 = OpFMul %470 %482 
                                       f32_3 %484 = OpLoad %27 
                                       f32_3 %485 = OpFAdd %483 %484 
                                       f32_4 %486 = OpLoad %469 
                                       f32_4 %487 = OpVectorShuffle %486 %485 4 5 6 3 
                                                      OpStore %469 %487 
                                       f32_4 %488 = OpLoad %469 
                                       f32_3 %489 = OpVectorShuffle %488 %488 0 1 2 
                                       f32_3 %490 = OpCompositeConstruct %30 %30 %30 
                                       f32_3 %491 = OpCompositeConstruct %31 %31 %31 
                                       f32_3 %492 = OpExtInst %1 43 %489 %490 %491 
                                       f32_4 %493 = OpLoad %469 
                                       f32_4 %494 = OpVectorShuffle %493 %492 4 5 6 3 
                                                      OpStore %469 %494 
                                 Output f32* %496 = OpAccessChain %469 %331 
                                                      OpStore %496 %31 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "vulkan " {
""
}
}
}
}
}