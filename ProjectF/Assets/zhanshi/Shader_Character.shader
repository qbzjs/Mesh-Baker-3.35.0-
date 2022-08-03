//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shader/Character" {
Properties {
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 0
_MainTex ("Main Texture", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_MatCap ("Mat Texture", 2D) = "white" { }
_MatColor ("Mat Color", Color) = (1,1,1,1)
_MatnormalIntenstiy ("Mat Normal Intensity", Float) = 1
_Normal ("Normal Map", 2D) = "bump" { }
_NormalIntensity ("Normal Intensity", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
 Pass {
  Tags { "LIGHTMODE" = "UniversalForward" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  Stencil {
   Ref 1
   Comp Always
   Pass Replace
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 42259
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _CharacterAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _MainColor;
	UNITY_UNIFORM vec4 _MatColor;
	UNITY_UNIFORM float _MatnormalIntenstiy;
	UNITY_UNIFORM float _NormalIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MatCap;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _Normal;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec2 u_xlat8;
uvec2 u_xlatu8;
float u_xlat24;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.xy = u_xlat8.xy * _ScreenParams.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
    u_xlat8.xy = fract(abs(u_xlat8.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat8;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
        u_xlat8 = hlslcc_movcTemp;
    }
    u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
    u_xlatu8.xy = uvec2(u_xlat8.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu8.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.yxz;
    u_xlat1.x = u_xlat0.z;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat1.y = u_xlat2.z;
    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
    u_xlat1.z = u_xlat3.z;
    u_xlat16_4.xyz = texture(_Normal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xy = u_xlat16_5.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat6.xy = u_xlat4.xy;
    u_xlat6.z = u_xlat16_5.z;
    u_xlat1.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat7.x = u_xlat0.y;
    u_xlat7.y = u_xlat2.x;
    u_xlat0.y = u_xlat2.y;
    u_xlat7.z = u_xlat3.x;
    u_xlat0.z = u_xlat3.y;
    u_xlat4.z = u_xlat6.z;
    u_xlat1.y = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MatCap, u_xlat16_5.xy);
    u_xlat0.xyz = u_xlat16_0.xyz * _MatColor.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * vec3(_MatnormalIntenstiy) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_1.www * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 472
; Schema: 0
                                                   OpCapability Shader 
                                            %1 = OpExtInstImport "GLSL.std.450" 
                                                   OpMemoryModel Logical GLSL450 
                                                   OpEntryPoint Fragment %4 "main" %31 %224 %244 %259 %285 %462 
                                                   OpExecutionMode %4 OriginUpperLeft 
                                                   OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                   OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                   OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                   OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                   OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                   OpDecorate %12 ArrayStride 12 
                                                   OpMemberDecorate %13 0 Offset 13 
                                                   OpMemberDecorate %13 1 Offset 13 
                                                   OpMemberDecorate %13 2 Offset 13 
                                                   OpDecorate %13 Block 
                                                   OpDecorate %15 DescriptorSet 15 
                                                   OpDecorate %15 Binding 15 
                                                   OpDecorate vs_TEXCOORD5 Location 31 
                                                   OpDecorate vs_TEXCOORD3 Location 224 
                                                   OpDecorate vs_TEXCOORD4 Location 244 
                                                   OpDecorate vs_TEXCOORD2 Location 259 
                                                   OpDecorate %273 RelaxedPrecision 
                                                   OpDecorate %276 RelaxedPrecision 
                                                   OpDecorate %276 DescriptorSet 276 
                                                   OpDecorate %276 Binding 276 
                                                   OpDecorate %277 RelaxedPrecision 
                                                   OpDecorate %280 RelaxedPrecision 
                                                   OpDecorate %280 DescriptorSet 280 
                                                   OpDecorate %280 Binding 280 
                                                   OpDecorate %281 RelaxedPrecision 
                                                   OpDecorate vs_TEXCOORD0 Location 285 
                                                   OpDecorate %288 RelaxedPrecision 
                                                   OpDecorate %289 RelaxedPrecision 
                                                   OpDecorate %290 RelaxedPrecision 
                                                   OpDecorate %293 RelaxedPrecision 
                                                   OpDecorate %296 RelaxedPrecision 
                                                   OpDecorate %298 RelaxedPrecision 
                                                   OpDecorate %299 RelaxedPrecision 
                                                   OpMemberDecorate %300 0 Offset 300 
                                                   OpMemberDecorate %300 1 Offset 300 
                                                   OpMemberDecorate %300 2 Offset 300 
                                                   OpMemberDecorate %300 3 Offset 300 
                                                   OpDecorate %300 Block 
                                                   OpDecorate %302 DescriptorSet 302 
                                                   OpDecorate %302 Binding 302 
                                                   OpDecorate %308 RelaxedPrecision 
                                                   OpDecorate %309 RelaxedPrecision 
                                                   OpDecorate %310 RelaxedPrecision 
                                                   OpDecorate %311 RelaxedPrecision 
                                                   OpDecorate %312 RelaxedPrecision 
                                                   OpDecorate %321 RelaxedPrecision 
                                                   OpDecorate %403 RelaxedPrecision 
                                                   OpDecorate %404 RelaxedPrecision 
                                                   OpDecorate %407 RelaxedPrecision 
                                                   OpDecorate %408 RelaxedPrecision 
                                                   OpDecorate %411 RelaxedPrecision 
                                                   OpDecorate %412 RelaxedPrecision 
                                                   OpDecorate %412 DescriptorSet 412 
                                                   OpDecorate %412 Binding 412 
                                                   OpDecorate %413 RelaxedPrecision 
                                                   OpDecorate %414 RelaxedPrecision 
                                                   OpDecorate %414 DescriptorSet 414 
                                                   OpDecorate %414 Binding 414 
                                                   OpDecorate %415 RelaxedPrecision 
                                                   OpDecorate %417 RelaxedPrecision 
                                                   OpDecorate %418 RelaxedPrecision 
                                                   OpDecorate %419 RelaxedPrecision 
                                                   OpDecorate %420 RelaxedPrecision 
                                                   OpDecorate %421 RelaxedPrecision 
                                                   OpDecorate %428 RelaxedPrecision 
                                                   OpDecorate %429 RelaxedPrecision 
                                                   OpDecorate %432 RelaxedPrecision 
                                                   OpDecorate %433 RelaxedPrecision 
                                                   OpDecorate %438 RelaxedPrecision 
                                                   OpDecorate %439 RelaxedPrecision 
                                                   OpDecorate %439 DescriptorSet 439 
                                                   OpDecorate %439 Binding 439 
                                                   OpDecorate %440 RelaxedPrecision 
                                                   OpDecorate %441 RelaxedPrecision 
                                                   OpDecorate %441 DescriptorSet 441 
                                                   OpDecorate %441 Binding 441 
                                                   OpDecorate %442 RelaxedPrecision 
                                                   OpDecorate %446 RelaxedPrecision 
                                                   OpDecorate %447 RelaxedPrecision 
                                                   OpDecorate %448 RelaxedPrecision 
                                                   OpDecorate %449 RelaxedPrecision 
                                                   OpDecorate %453 RelaxedPrecision 
                                                   OpDecorate %454 RelaxedPrecision 
                                                   OpDecorate %462 RelaxedPrecision 
                                                   OpDecorate %462 Location 462 
                                                   OpDecorate %463 RelaxedPrecision 
                                            %2 = OpTypeVoid 
                                            %3 = OpTypeFunction %2 
                                            %6 = OpTypeFloat 32 
                                            %7 = OpTypeVector %6 4 
                                            %8 = OpTypePointer Private %7 
                             Private f32_4* %9 = OpVariable Private 
                                           %10 = OpTypeInt 32 0 
                                       u32 %11 = OpConstant 4 
                                           %12 = OpTypeArray %7 %11 
                                           %13 = OpTypeStruct %7 %12 %6 
                                           %14 = OpTypePointer Uniform %13 
   Uniform struct {f32_4; f32_4[4]; f32;}* %15 = OpVariable Uniform 
                                           %16 = OpTypeInt 32 1 
                                       i32 %17 = OpConstant 2 
                                           %18 = OpTypePointer Uniform %6 
                                       f32 %22 = OpConstant 3.674022E-40 
                                       u32 %24 = OpConstant 0 
                                           %25 = OpTypePointer Private %6 
                                           %27 = OpTypeVector %6 2 
                                           %28 = OpTypePointer Private %27 
                            Private f32_2* %29 = OpVariable Private 
                                           %30 = OpTypePointer Input %7 
                     Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                       i32 %38 = OpConstant 0 
                                           %39 = OpTypePointer Uniform %7 
                                       f32 %45 = OpConstant 3.674022E-40 
                                     f32_2 %46 = OpConstantComposite %45 %45 
                                           %48 = OpTypeBool 
                                           %49 = OpTypeVector %48 2 
                                           %50 = OpTypePointer Private %49 
                           Private bool_2* %51 = OpVariable Private 
                                           %57 = OpTypeVector %48 4 
                                           %63 = OpTypePointer Function %27 
                                           %66 = OpTypePointer Private %48 
                                           %69 = OpTypePointer Function %6 
                                       u32 %81 = OpConstant 1 
                                       f32 %97 = OpConstant 3.674022E-40 
                                     f32_2 %98 = OpConstantComposite %97 %97 
                                          %100 = OpTypeVector %10 2 
                                          %101 = OpTypePointer Private %100 
                           Private u32_2* %102 = OpVariable Private 
                           Private f32_4* %105 = OpVariable Private 
                                      f32 %106 = OpConstant 3.674022E-40 
                                      f32 %107 = OpConstant 3.674022E-40 
                                      f32 %108 = OpConstant 3.674022E-40 
                                      f32 %109 = OpConstant 3.674022E-40 
                                    f32_4 %110 = OpConstantComposite %106 %107 %108 %109 
                                          %111 = OpTypeVector %10 4 
                                          %112 = OpTypeArray %111 %11 
                                      u32 %113 = OpConstant 1065353216 
                                    u32_4 %114 = OpConstantComposite %113 %24 %24 %24 
                                    u32_4 %115 = OpConstantComposite %24 %113 %24 %24 
                                    u32_4 %116 = OpConstantComposite %24 %24 %113 %24 
                                    u32_4 %117 = OpConstantComposite %24 %24 %24 %113 
                                 u32_4[4] %118 = OpConstantComposite %114 %115 %116 %117 
                                          %119 = OpTypePointer Private %10 
                                          %123 = OpTypePointer Function %112 
                                          %125 = OpTypePointer Function %111 
                                      f32 %131 = OpConstant 3.674022E-40 
                                      f32 %132 = OpConstant 3.674022E-40 
                                      f32 %133 = OpConstant 3.674022E-40 
                                      f32 %134 = OpConstant 3.674022E-40 
                                    f32_4 %135 = OpConstantComposite %131 %132 %133 %134 
                                      f32 %145 = OpConstant 3.674022E-40 
                                      f32 %146 = OpConstant 3.674022E-40 
                                      f32 %147 = OpConstant 3.674022E-40 
                                      f32 %148 = OpConstant 3.674022E-40 
                                    f32_4 %149 = OpConstantComposite %145 %146 %147 %148 
                                      u32 %158 = OpConstant 2 
                                      f32 %160 = OpConstant 3.674022E-40 
                                      f32 %161 = OpConstant 3.674022E-40 
                                      f32 %162 = OpConstant 3.674022E-40 
                                      f32 %163 = OpConstant 3.674022E-40 
                                    f32_4 %164 = OpConstantComposite %160 %161 %162 %163 
                                      u32 %173 = OpConstant 3 
                                          %188 = OpTypePointer Private %57 
                          Private bool_4* %189 = OpVariable Private 
                                      f32 %191 = OpConstant 3.674022E-40 
                                    f32_4 %192 = OpConstantComposite %191 %191 %191 %191 
                                      i32 %214 = OpConstant 1 
                                      i32 %216 = OpConstant -1 
                                          %222 = OpTypeVector %6 3 
                                          %223 = OpTypePointer Input %222 
                     Input f32_3* vs_TEXCOORD3 = OpVariable Input 
                             Private f32* %243 = OpVariable Private 
                     Input f32_3* vs_TEXCOORD4 = OpVariable Input 
                                          %250 = OpTypePointer Private %222 
                           Private f32_3* %251 = OpVariable Private 
                     Input f32_3* vs_TEXCOORD2 = OpVariable Input 
                           Private f32_3* %265 = OpVariable Private 
                           Private f32_3* %273 = OpVariable Private 
                                          %274 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                          %275 = OpTypePointer UniformConstant %274 
     UniformConstant read_only Texture2D* %276 = OpVariable UniformConstant 
                                          %278 = OpTypeSampler 
                                          %279 = OpTypePointer UniformConstant %278 
                 UniformConstant sampler* %280 = OpVariable UniformConstant 
                                          %282 = OpTypeSampledImage %274 
                                          %284 = OpTypePointer Input %27 
                     Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                           Private f32_3* %289 = OpVariable Private 
                                      f32 %291 = OpConstant 3.674022E-40 
                                    f32_3 %292 = OpConstantComposite %291 %291 %291 
                                      f32 %294 = OpConstant 3.674022E-40 
                                    f32_3 %295 = OpConstantComposite %294 %294 %294 
                           Private f32_3* %297 = OpVariable Private 
                                          %300 = OpTypeStruct %7 %7 %6 %6 
                                          %301 = OpTypePointer Uniform %300 
Uniform struct {f32_4; f32_4; f32; f32;}* %302 = OpVariable Uniform 
                                      i32 %303 = OpConstant 3 
                           Private f32_3* %315 = OpVariable Private 
                           Private f32_3* %328 = OpVariable Private 
                                      f32 %405 = OpConstant 3.674022E-40 
                                    f32_2 %406 = OpConstantComposite %405 %405 
                           Private f32_4* %411 = OpVariable Private 
     UniformConstant read_only Texture2D* %412 = OpVariable UniformConstant 
                 UniformConstant sampler* %414 = OpVariable UniformConstant 
                           Private f32_4* %438 = OpVariable Private 
     UniformConstant read_only Texture2D* %439 = OpVariable UniformConstant 
                 UniformConstant sampler* %441 = OpVariable UniformConstant 
                                          %461 = OpTypePointer Output %7 
                            Output f32_4* %462 = OpVariable Output 
                                          %469 = OpTypePointer Output %6 
                                       void %4 = OpFunction None %3 
                                            %5 = OpLabel 
                           Function f32_2* %64 = OpVariable Function 
                             Function f32* %70 = OpVariable Function 
                             Function f32* %84 = OpVariable Function 
                       Function u32_4[4]* %124 = OpVariable Function 
                       Function u32_4[4]* %139 = OpVariable Function 
                       Function u32_4[4]* %153 = OpVariable Function 
                       Function u32_4[4]* %168 = OpVariable Function 
                       Function u32_4[4]* %180 = OpVariable Function 
                              Uniform f32* %19 = OpAccessChain %15 %17 
                                       f32 %20 = OpLoad %19 
                                       f32 %21 = OpFNegate %20 
                                       f32 %23 = OpFAdd %21 %22 
                              Private f32* %26 = OpAccessChain %9 %24 
                                                   OpStore %26 %23 
                                     f32_4 %32 = OpLoad vs_TEXCOORD5 
                                     f32_2 %33 = OpVectorShuffle %32 %32 0 1 
                                     f32_4 %34 = OpLoad vs_TEXCOORD5 
                                     f32_2 %35 = OpVectorShuffle %34 %34 3 3 
                                     f32_2 %36 = OpFDiv %33 %35 
                                                   OpStore %29 %36 
                                     f32_2 %37 = OpLoad %29 
                            Uniform f32_4* %40 = OpAccessChain %15 %38 
                                     f32_4 %41 = OpLoad %40 
                                     f32_2 %42 = OpVectorShuffle %41 %41 0 1 
                                     f32_2 %43 = OpFMul %37 %42 
                                                   OpStore %29 %43 
                                     f32_2 %44 = OpLoad %29 
                                     f32_2 %47 = OpFMul %44 %46 
                                                   OpStore %29 %47 
                                     f32_2 %52 = OpLoad %29 
                                     f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                     f32_2 %54 = OpLoad %29 
                                     f32_4 %55 = OpVectorShuffle %54 %54 0 1 0 0 
                                     f32_4 %56 = OpFNegate %55 
                                    bool_4 %58 = OpFOrdGreaterThanEqual %53 %56 
                                    bool_2 %59 = OpVectorShuffle %58 %58 0 1 
                                                   OpStore %51 %59 
                                     f32_2 %60 = OpLoad %29 
                                     f32_2 %61 = OpExtInst %1 4 %60 
                                     f32_2 %62 = OpExtInst %1 10 %61 
                                                   OpStore %29 %62 
                                     f32_2 %65 = OpLoad %29 
                                                   OpStore %64 %65 
                             Private bool* %67 = OpAccessChain %51 %24 
                                      bool %68 = OpLoad %67 
                                                   OpSelectionMerge %72 None 
                                                   OpBranchConditional %68 %71 %75 
                                           %71 = OpLabel 
                              Private f32* %73 = OpAccessChain %29 %24 
                                       f32 %74 = OpLoad %73 
                                                   OpStore %70 %74 
                                                   OpBranch %72 
                                           %75 = OpLabel 
                              Private f32* %76 = OpAccessChain %29 %24 
                                       f32 %77 = OpLoad %76 
                                       f32 %78 = OpFNegate %77 
                                                   OpStore %70 %78 
                                                   OpBranch %72 
                                           %72 = OpLabel 
                                       f32 %79 = OpLoad %70 
                             Function f32* %80 = OpAccessChain %64 %24 
                                                   OpStore %80 %79 
                             Private bool* %82 = OpAccessChain %51 %81 
                                      bool %83 = OpLoad %82 
                                                   OpSelectionMerge %86 None 
                                                   OpBranchConditional %83 %85 %89 
                                           %85 = OpLabel 
                              Private f32* %87 = OpAccessChain %29 %81 
                                       f32 %88 = OpLoad %87 
                                                   OpStore %84 %88 
                                                   OpBranch %86 
                                           %89 = OpLabel 
                              Private f32* %90 = OpAccessChain %29 %81 
                                       f32 %91 = OpLoad %90 
                                       f32 %92 = OpFNegate %91 
                                                   OpStore %84 %92 
                                                   OpBranch %86 
                                           %86 = OpLabel 
                                       f32 %93 = OpLoad %84 
                             Function f32* %94 = OpAccessChain %64 %81 
                                                   OpStore %94 %93 
                                     f32_2 %95 = OpLoad %64 
                                                   OpStore %29 %95 
                                     f32_2 %96 = OpLoad %29 
                                     f32_2 %99 = OpFMul %96 %98 
                                                   OpStore %29 %99 
                                    f32_2 %103 = OpLoad %29 
                                    u32_2 %104 = OpConvertFToU %103 
                                                   OpStore %102 %104 
                             Private u32* %120 = OpAccessChain %102 %24 
                                      u32 %121 = OpLoad %120 
                                      i32 %122 = OpBitcast %121 
                                                   OpStore %124 %118 
                          Function u32_4* %126 = OpAccessChain %124 %122 
                                    u32_4 %127 = OpLoad %126 
                                    f32_4 %128 = OpBitcast %127 
                                      f32 %129 = OpDot %110 %128 
                             Private f32* %130 = OpAccessChain %105 %24 
                                                   OpStore %130 %129 
                             Private u32* %136 = OpAccessChain %102 %24 
                                      u32 %137 = OpLoad %136 
                                      i32 %138 = OpBitcast %137 
                                                   OpStore %139 %118 
                          Function u32_4* %140 = OpAccessChain %139 %138 
                                    u32_4 %141 = OpLoad %140 
                                    f32_4 %142 = OpBitcast %141 
                                      f32 %143 = OpDot %135 %142 
                             Private f32* %144 = OpAccessChain %105 %81 
                                                   OpStore %144 %143 
                             Private u32* %150 = OpAccessChain %102 %24 
                                      u32 %151 = OpLoad %150 
                                      i32 %152 = OpBitcast %151 
                                                   OpStore %153 %118 
                          Function u32_4* %154 = OpAccessChain %153 %152 
                                    u32_4 %155 = OpLoad %154 
                                    f32_4 %156 = OpBitcast %155 
                                      f32 %157 = OpDot %149 %156 
                             Private f32* %159 = OpAccessChain %105 %158 
                                                   OpStore %159 %157 
                             Private u32* %165 = OpAccessChain %102 %24 
                                      u32 %166 = OpLoad %165 
                                      i32 %167 = OpBitcast %166 
                                                   OpStore %168 %118 
                          Function u32_4* %169 = OpAccessChain %168 %167 
                                    u32_4 %170 = OpLoad %169 
                                    f32_4 %171 = OpBitcast %170 
                                      f32 %172 = OpDot %164 %171 
                             Private f32* %174 = OpAccessChain %105 %173 
                                                   OpStore %174 %172 
                                    f32_4 %175 = OpLoad %105 
                                    f32_4 %176 = OpFNegate %175 
                             Private u32* %177 = OpAccessChain %102 %81 
                                      u32 %178 = OpLoad %177 
                                      i32 %179 = OpBitcast %178 
                                                   OpStore %180 %118 
                          Function u32_4* %181 = OpAccessChain %180 %179 
                                    u32_4 %182 = OpLoad %181 
                                    f32_4 %183 = OpBitcast %182 
                                    f32_4 %184 = OpFMul %176 %183 
                                    f32_4 %185 = OpLoad %9 
                                    f32_4 %186 = OpVectorShuffle %185 %185 0 0 0 0 
                                    f32_4 %187 = OpFAdd %184 %186 
                                                   OpStore %9 %187 
                                    f32_4 %190 = OpLoad %9 
                                   bool_4 %193 = OpFOrdLessThan %190 %192 
                                                   OpStore %189 %193 
                            Private bool* %194 = OpAccessChain %189 %158 
                                     bool %195 = OpLoad %194 
                            Private bool* %196 = OpAccessChain %189 %24 
                                     bool %197 = OpLoad %196 
                                     bool %198 = OpLogicalOr %195 %197 
                            Private bool* %199 = OpAccessChain %189 %24 
                                                   OpStore %199 %198 
                            Private bool* %200 = OpAccessChain %189 %173 
                                     bool %201 = OpLoad %200 
                            Private bool* %202 = OpAccessChain %189 %81 
                                     bool %203 = OpLoad %202 
                                     bool %204 = OpLogicalOr %201 %203 
                            Private bool* %205 = OpAccessChain %189 %81 
                                                   OpStore %205 %204 
                            Private bool* %206 = OpAccessChain %189 %81 
                                     bool %207 = OpLoad %206 
                            Private bool* %208 = OpAccessChain %189 %24 
                                     bool %209 = OpLoad %208 
                                     bool %210 = OpLogicalOr %207 %209 
                            Private bool* %211 = OpAccessChain %189 %24 
                                                   OpStore %211 %210 
                            Private bool* %212 = OpAccessChain %189 %24 
                                     bool %213 = OpLoad %212 
                                      i32 %215 = OpSelect %213 %214 %38 
                                      i32 %217 = OpIMul %215 %216 
                                     bool %218 = OpINotEqual %217 %38 
                                                   OpSelectionMerge %220 None 
                                                   OpBranchConditional %218 %219 %220 
                                          %219 = OpLabel 
                                                   OpKill
                                          %220 = OpLabel 
                                    f32_3 %225 = OpLoad vs_TEXCOORD3 
                                    f32_3 %226 = OpLoad vs_TEXCOORD3 
                                      f32 %227 = OpDot %225 %226 
                             Private f32* %228 = OpAccessChain %9 %24 
                                                   OpStore %228 %227 
                             Private f32* %229 = OpAccessChain %9 %24 
                                      f32 %230 = OpLoad %229 
                                      f32 %231 = OpExtInst %1 32 %230 
                             Private f32* %232 = OpAccessChain %9 %24 
                                                   OpStore %232 %231 
                                    f32_4 %233 = OpLoad %9 
                                    f32_3 %234 = OpVectorShuffle %233 %233 0 0 0 
                                    f32_3 %235 = OpLoad vs_TEXCOORD3 
                                    f32_3 %236 = OpVectorShuffle %235 %235 1 0 2 
                                    f32_3 %237 = OpFMul %234 %236 
                                    f32_4 %238 = OpLoad %9 
                                    f32_4 %239 = OpVectorShuffle %238 %237 4 5 6 3 
                                                   OpStore %9 %239 
                             Private f32* %240 = OpAccessChain %9 %158 
                                      f32 %241 = OpLoad %240 
                             Private f32* %242 = OpAccessChain %105 %24 
                                                   OpStore %242 %241 
                                    f32_3 %245 = OpLoad vs_TEXCOORD4 
                                    f32_3 %246 = OpLoad vs_TEXCOORD4 
                                      f32 %247 = OpDot %245 %246 
                                                   OpStore %243 %247 
                                      f32 %248 = OpLoad %243 
                                      f32 %249 = OpExtInst %1 32 %248 
                                                   OpStore %243 %249 
                                      f32 %252 = OpLoad %243 
                                    f32_3 %253 = OpCompositeConstruct %252 %252 %252 
                                    f32_3 %254 = OpLoad vs_TEXCOORD4 
                                    f32_3 %255 = OpFMul %253 %254 
                                                   OpStore %251 %255 
                             Private f32* %256 = OpAccessChain %251 %158 
                                      f32 %257 = OpLoad %256 
                             Private f32* %258 = OpAccessChain %105 %81 
                                                   OpStore %258 %257 
                                    f32_3 %260 = OpLoad vs_TEXCOORD2 
                                    f32_3 %261 = OpLoad vs_TEXCOORD2 
                                      f32 %262 = OpDot %260 %261 
                                                   OpStore %243 %262 
                                      f32 %263 = OpLoad %243 
                                      f32 %264 = OpExtInst %1 32 %263 
                                                   OpStore %243 %264 
                                      f32 %266 = OpLoad %243 
                                    f32_3 %267 = OpCompositeConstruct %266 %266 %266 
                                    f32_3 %268 = OpLoad vs_TEXCOORD2 
                                    f32_3 %269 = OpFMul %267 %268 
                                                   OpStore %265 %269 
                             Private f32* %270 = OpAccessChain %265 %158 
                                      f32 %271 = OpLoad %270 
                             Private f32* %272 = OpAccessChain %105 %158 
                                                   OpStore %272 %271 
                      read_only Texture2D %277 = OpLoad %276 
                                  sampler %281 = OpLoad %280 
               read_only Texture2DSampled %283 = OpSampledImage %277 %281 
                                    f32_2 %286 = OpLoad vs_TEXCOORD0 
                                    f32_4 %287 = OpImageSampleImplicitLod %283 %286 
                                    f32_3 %288 = OpVectorShuffle %287 %287 0 1 2 
                                                   OpStore %273 %288 
                                    f32_3 %290 = OpLoad %273 
                                    f32_3 %293 = OpFMul %290 %292 
                                    f32_3 %296 = OpFAdd %293 %295 
                                                   OpStore %289 %296 
                                    f32_3 %298 = OpLoad %289 
                                    f32_2 %299 = OpVectorShuffle %298 %298 0 1 
                             Uniform f32* %304 = OpAccessChain %302 %303 
                                      f32 %305 = OpLoad %304 
                             Uniform f32* %306 = OpAccessChain %302 %303 
                                      f32 %307 = OpLoad %306 
                                    f32_2 %308 = OpCompositeConstruct %305 %307 
                                      f32 %309 = OpCompositeExtract %308 0 
                                      f32 %310 = OpCompositeExtract %308 1 
                                    f32_2 %311 = OpCompositeConstruct %309 %310 
                                    f32_2 %312 = OpFMul %299 %311 
                                    f32_3 %313 = OpLoad %297 
                                    f32_3 %314 = OpVectorShuffle %313 %312 3 4 2 
                                                   OpStore %297 %314 
                                    f32_3 %316 = OpLoad %297 
                                    f32_2 %317 = OpVectorShuffle %316 %316 0 1 
                                    f32_3 %318 = OpLoad %315 
                                    f32_3 %319 = OpVectorShuffle %318 %317 3 4 2 
                                                   OpStore %315 %319 
                             Private f32* %320 = OpAccessChain %289 %158 
                                      f32 %321 = OpLoad %320 
                             Private f32* %322 = OpAccessChain %315 %158 
                                                   OpStore %322 %321 
                                    f32_3 %323 = OpLoad %315 
                                    f32_4 %324 = OpLoad %105 
                                    f32_3 %325 = OpVectorShuffle %324 %324 0 1 2 
                                      f32 %326 = OpDot %323 %325 
                             Private f32* %327 = OpAccessChain %105 %158 
                                                   OpStore %327 %326 
                             Private f32* %329 = OpAccessChain %9 %81 
                                      f32 %330 = OpLoad %329 
                             Private f32* %331 = OpAccessChain %328 %24 
                                                   OpStore %331 %330 
                             Private f32* %332 = OpAccessChain %251 %24 
                                      f32 %333 = OpLoad %332 
                             Private f32* %334 = OpAccessChain %328 %81 
                                                   OpStore %334 %333 
                             Private f32* %335 = OpAccessChain %251 %81 
                                      f32 %336 = OpLoad %335 
                             Private f32* %337 = OpAccessChain %9 %81 
                                                   OpStore %337 %336 
                             Private f32* %338 = OpAccessChain %265 %24 
                                      f32 %339 = OpLoad %338 
                             Private f32* %340 = OpAccessChain %328 %158 
                                                   OpStore %340 %339 
                             Private f32* %341 = OpAccessChain %265 %81 
                                      f32 %342 = OpLoad %341 
                             Private f32* %343 = OpAccessChain %9 %158 
                                                   OpStore %343 %342 
                             Private f32* %344 = OpAccessChain %315 %158 
                                      f32 %345 = OpLoad %344 
                             Private f32* %346 = OpAccessChain %297 %158 
                                                   OpStore %346 %345 
                                    f32_3 %347 = OpLoad %315 
                                    f32_4 %348 = OpLoad %9 
                                    f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
                                      f32 %350 = OpDot %347 %349 
                             Private f32* %351 = OpAccessChain %105 %81 
                                                   OpStore %351 %350 
                                    f32_3 %352 = OpLoad %297 
                                    f32_3 %353 = OpLoad %328 
                                      f32 %354 = OpDot %352 %353 
                             Private f32* %355 = OpAccessChain %105 %24 
                                                   OpStore %355 %354 
                                    f32_4 %356 = OpLoad %105 
                                    f32_3 %357 = OpVectorShuffle %356 %356 0 1 2 
                                    f32_4 %358 = OpLoad %105 
                                    f32_3 %359 = OpVectorShuffle %358 %358 0 1 2 
                                      f32 %360 = OpDot %357 %359 
                             Private f32* %361 = OpAccessChain %9 %24 
                                                   OpStore %361 %360 
                             Private f32* %362 = OpAccessChain %9 %24 
                                      f32 %363 = OpLoad %362 
                                      f32 %364 = OpExtInst %1 32 %363 
                             Private f32* %365 = OpAccessChain %9 %24 
                                                   OpStore %365 %364 
                                    f32_4 %366 = OpLoad %9 
                                    f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
                                    f32_4 %368 = OpLoad %105 
                                    f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                    f32_3 %370 = OpFMul %367 %369 
                                    f32_4 %371 = OpLoad %9 
                                    f32_4 %372 = OpVectorShuffle %371 %370 4 5 6 3 
                                                   OpStore %9 %372 
                             Uniform f32* %373 = OpAccessChain %15 %214 %38 %24 
                                      f32 %374 = OpLoad %373 
                             Private f32* %375 = OpAccessChain %105 %24 
                                                   OpStore %375 %374 
                             Uniform f32* %376 = OpAccessChain %15 %214 %214 %24 
                                      f32 %377 = OpLoad %376 
                             Private f32* %378 = OpAccessChain %105 %81 
                                                   OpStore %378 %377 
                             Uniform f32* %379 = OpAccessChain %15 %214 %17 %24 
                                      f32 %380 = OpLoad %379 
                             Private f32* %381 = OpAccessChain %105 %158 
                                                   OpStore %381 %380 
                                    f32_4 %382 = OpLoad %105 
                                    f32_3 %383 = OpVectorShuffle %382 %382 0 1 2 
                                    f32_4 %384 = OpLoad %9 
                                    f32_3 %385 = OpVectorShuffle %384 %384 0 1 2 
                                      f32 %386 = OpDot %383 %385 
                             Private f32* %387 = OpAccessChain %289 %24 
                                                   OpStore %387 %386 
                             Uniform f32* %388 = OpAccessChain %15 %214 %38 %81 
                                      f32 %389 = OpLoad %388 
                             Private f32* %390 = OpAccessChain %105 %24 
                                                   OpStore %390 %389 
                             Uniform f32* %391 = OpAccessChain %15 %214 %214 %81 
                                      f32 %392 = OpLoad %391 
                             Private f32* %393 = OpAccessChain %105 %81 
                                                   OpStore %393 %392 
                             Uniform f32* %394 = OpAccessChain %15 %214 %17 %81 
                                      f32 %395 = OpLoad %394 
                             Private f32* %396 = OpAccessChain %105 %158 
                                                   OpStore %396 %395 
                                    f32_4 %397 = OpLoad %105 
                                    f32_3 %398 = OpVectorShuffle %397 %397 0 1 2 
                                    f32_4 %399 = OpLoad %9 
                                    f32_3 %400 = OpVectorShuffle %399 %399 0 1 2 
                                      f32 %401 = OpDot %398 %400 
                             Private f32* %402 = OpAccessChain %289 %81 
                                                   OpStore %402 %401 
                                    f32_3 %403 = OpLoad %289 
                                    f32_2 %404 = OpVectorShuffle %403 %403 0 1 
                                    f32_2 %407 = OpFMul %404 %406 
                                    f32_2 %408 = OpFAdd %407 %406 
                                    f32_3 %409 = OpLoad %289 
                                    f32_3 %410 = OpVectorShuffle %409 %408 3 4 2 
                                                   OpStore %289 %410 
                      read_only Texture2D %413 = OpLoad %412 
                                  sampler %415 = OpLoad %414 
               read_only Texture2DSampled %416 = OpSampledImage %413 %415 
                                    f32_3 %417 = OpLoad %289 
                                    f32_2 %418 = OpVectorShuffle %417 %417 0 1 
                                    f32_4 %419 = OpImageSampleImplicitLod %416 %418 
                                                   OpStore %411 %419 
                                    f32_4 %420 = OpLoad %411 
                                    f32_3 %421 = OpVectorShuffle %420 %420 0 1 2 
                           Uniform f32_4* %422 = OpAccessChain %302 %214 
                                    f32_4 %423 = OpLoad %422 
                                    f32_3 %424 = OpVectorShuffle %423 %423 0 1 2 
                                    f32_3 %425 = OpFMul %421 %424 
                                    f32_4 %426 = OpLoad %9 
                                    f32_4 %427 = OpVectorShuffle %426 %425 4 5 6 3 
                                                   OpStore %9 %427 
                                    f32_4 %428 = OpLoad %411 
                                    f32_3 %429 = OpVectorShuffle %428 %428 3 3 3 
                             Uniform f32* %430 = OpAccessChain %302 %17 
                                      f32 %431 = OpLoad %430 
                                    f32_3 %432 = OpCompositeConstruct %431 %431 %431 
                                    f32_3 %433 = OpFMul %429 %432 
                                    f32_4 %434 = OpLoad %9 
                                    f32_3 %435 = OpVectorShuffle %434 %434 0 1 2 
                                    f32_3 %436 = OpFNegate %435 
                                    f32_3 %437 = OpFAdd %433 %436 
                                                   OpStore %289 %437 
                      read_only Texture2D %440 = OpLoad %439 
                                  sampler %442 = OpLoad %441 
               read_only Texture2DSampled %443 = OpSampledImage %440 %442 
                                    f32_2 %444 = OpLoad vs_TEXCOORD0 
                                    f32_4 %445 = OpImageSampleImplicitLod %443 %444 
                                                   OpStore %438 %445 
                                    f32_4 %446 = OpLoad %438 
                                    f32_3 %447 = OpVectorShuffle %446 %446 3 3 3 
                                    f32_3 %448 = OpLoad %289 
                                    f32_3 %449 = OpFMul %447 %448 
                                    f32_4 %450 = OpLoad %9 
                                    f32_3 %451 = OpVectorShuffle %450 %450 0 1 2 
                                    f32_3 %452 = OpFAdd %449 %451 
                                                   OpStore %289 %452 
                                    f32_4 %453 = OpLoad %438 
                                    f32_3 %454 = OpVectorShuffle %453 %453 0 1 2 
                           Uniform f32_4* %455 = OpAccessChain %302 %38 
                                    f32_4 %456 = OpLoad %455 
                                    f32_3 %457 = OpVectorShuffle %456 %456 0 1 2 
                                    f32_3 %458 = OpFMul %454 %457 
                                    f32_4 %459 = OpLoad %9 
                                    f32_4 %460 = OpVectorShuffle %459 %458 4 5 6 3 
                                                   OpStore %9 %460 
                                    f32_3 %463 = OpLoad %289 
                                    f32_4 %464 = OpLoad %9 
                                    f32_3 %465 = OpVectorShuffle %464 %464 0 1 2 
                                    f32_3 %466 = OpFMul %463 %465 
                                    f32_4 %467 = OpLoad %462 
                                    f32_4 %468 = OpVectorShuffle %467 %466 4 5 6 3 
                                                   OpStore %462 %468 
                              Output f32* %470 = OpAccessChain %462 %173 
                                                   OpStore %470 %22 
                                                   OpReturn
                                                   OpFunctionEnd
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 472
; Schema: 0
                                                   OpCapability Shader 
                                            %1 = OpExtInstImport "GLSL.std.450" 
                                                   OpMemoryModel Logical GLSL450 
                                                   OpEntryPoint Fragment %4 "main" %31 %224 %244 %259 %285 %462 
                                                   OpExecutionMode %4 OriginUpperLeft 
                                                   OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                   OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                   OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                   OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                   OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                   OpDecorate %12 ArrayStride 12 
                                                   OpMemberDecorate %13 0 Offset 13 
                                                   OpMemberDecorate %13 1 Offset 13 
                                                   OpMemberDecorate %13 2 Offset 13 
                                                   OpDecorate %13 Block 
                                                   OpDecorate %15 DescriptorSet 15 
                                                   OpDecorate %15 Binding 15 
                                                   OpDecorate vs_TEXCOORD5 Location 31 
                                                   OpDecorate vs_TEXCOORD3 Location 224 
                                                   OpDecorate vs_TEXCOORD4 Location 244 
                                                   OpDecorate vs_TEXCOORD2 Location 259 
                                                   OpDecorate %273 RelaxedPrecision 
                                                   OpDecorate %276 RelaxedPrecision 
                                                   OpDecorate %276 DescriptorSet 276 
                                                   OpDecorate %276 Binding 276 
                                                   OpDecorate %277 RelaxedPrecision 
                                                   OpDecorate %280 RelaxedPrecision 
                                                   OpDecorate %280 DescriptorSet 280 
                                                   OpDecorate %280 Binding 280 
                                                   OpDecorate %281 RelaxedPrecision 
                                                   OpDecorate vs_TEXCOORD0 Location 285 
                                                   OpDecorate %288 RelaxedPrecision 
                                                   OpDecorate %289 RelaxedPrecision 
                                                   OpDecorate %290 RelaxedPrecision 
                                                   OpDecorate %293 RelaxedPrecision 
                                                   OpDecorate %296 RelaxedPrecision 
                                                   OpDecorate %298 RelaxedPrecision 
                                                   OpDecorate %299 RelaxedPrecision 
                                                   OpMemberDecorate %300 0 Offset 300 
                                                   OpMemberDecorate %300 1 Offset 300 
                                                   OpMemberDecorate %300 2 Offset 300 
                                                   OpMemberDecorate %300 3 Offset 300 
                                                   OpDecorate %300 Block 
                                                   OpDecorate %302 DescriptorSet 302 
                                                   OpDecorate %302 Binding 302 
                                                   OpDecorate %308 RelaxedPrecision 
                                                   OpDecorate %309 RelaxedPrecision 
                                                   OpDecorate %310 RelaxedPrecision 
                                                   OpDecorate %311 RelaxedPrecision 
                                                   OpDecorate %312 RelaxedPrecision 
                                                   OpDecorate %321 RelaxedPrecision 
                                                   OpDecorate %403 RelaxedPrecision 
                                                   OpDecorate %404 RelaxedPrecision 
                                                   OpDecorate %407 RelaxedPrecision 
                                                   OpDecorate %408 RelaxedPrecision 
                                                   OpDecorate %411 RelaxedPrecision 
                                                   OpDecorate %412 RelaxedPrecision 
                                                   OpDecorate %412 DescriptorSet 412 
                                                   OpDecorate %412 Binding 412 
                                                   OpDecorate %413 RelaxedPrecision 
                                                   OpDecorate %414 RelaxedPrecision 
                                                   OpDecorate %414 DescriptorSet 414 
                                                   OpDecorate %414 Binding 414 
                                                   OpDecorate %415 RelaxedPrecision 
                                                   OpDecorate %417 RelaxedPrecision 
                                                   OpDecorate %418 RelaxedPrecision 
                                                   OpDecorate %419 RelaxedPrecision 
                                                   OpDecorate %420 RelaxedPrecision 
                                                   OpDecorate %421 RelaxedPrecision 
                                                   OpDecorate %428 RelaxedPrecision 
                                                   OpDecorate %429 RelaxedPrecision 
                                                   OpDecorate %432 RelaxedPrecision 
                                                   OpDecorate %433 RelaxedPrecision 
                                                   OpDecorate %438 RelaxedPrecision 
                                                   OpDecorate %439 RelaxedPrecision 
                                                   OpDecorate %439 DescriptorSet 439 
                                                   OpDecorate %439 Binding 439 
                                                   OpDecorate %440 RelaxedPrecision 
                                                   OpDecorate %441 RelaxedPrecision 
                                                   OpDecorate %441 DescriptorSet 441 
                                                   OpDecorate %441 Binding 441 
                                                   OpDecorate %442 RelaxedPrecision 
                                                   OpDecorate %446 RelaxedPrecision 
                                                   OpDecorate %447 RelaxedPrecision 
                                                   OpDecorate %448 RelaxedPrecision 
                                                   OpDecorate %449 RelaxedPrecision 
                                                   OpDecorate %453 RelaxedPrecision 
                                                   OpDecorate %454 RelaxedPrecision 
                                                   OpDecorate %462 RelaxedPrecision 
                                                   OpDecorate %462 Location 462 
                                                   OpDecorate %463 RelaxedPrecision 
                                            %2 = OpTypeVoid 
                                            %3 = OpTypeFunction %2 
                                            %6 = OpTypeFloat 32 
                                            %7 = OpTypeVector %6 4 
                                            %8 = OpTypePointer Private %7 
                             Private f32_4* %9 = OpVariable Private 
                                           %10 = OpTypeInt 32 0 
                                       u32 %11 = OpConstant 4 
                                           %12 = OpTypeArray %7 %11 
                                           %13 = OpTypeStruct %7 %12 %6 
                                           %14 = OpTypePointer Uniform %13 
   Uniform struct {f32_4; f32_4[4]; f32;}* %15 = OpVariable Uniform 
                                           %16 = OpTypeInt 32 1 
                                       i32 %17 = OpConstant 2 
                                           %18 = OpTypePointer Uniform %6 
                                       f32 %22 = OpConstant 3.674022E-40 
                                       u32 %24 = OpConstant 0 
                                           %25 = OpTypePointer Private %6 
                                           %27 = OpTypeVector %6 2 
                                           %28 = OpTypePointer Private %27 
                            Private f32_2* %29 = OpVariable Private 
                                           %30 = OpTypePointer Input %7 
                     Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                       i32 %38 = OpConstant 0 
                                           %39 = OpTypePointer Uniform %7 
                                       f32 %45 = OpConstant 3.674022E-40 
                                     f32_2 %46 = OpConstantComposite %45 %45 
                                           %48 = OpTypeBool 
                                           %49 = OpTypeVector %48 2 
                                           %50 = OpTypePointer Private %49 
                           Private bool_2* %51 = OpVariable Private 
                                           %57 = OpTypeVector %48 4 
                                           %63 = OpTypePointer Function %27 
                                           %66 = OpTypePointer Private %48 
                                           %69 = OpTypePointer Function %6 
                                       u32 %81 = OpConstant 1 
                                       f32 %97 = OpConstant 3.674022E-40 
                                     f32_2 %98 = OpConstantComposite %97 %97 
                                          %100 = OpTypeVector %10 2 
                                          %101 = OpTypePointer Private %100 
                           Private u32_2* %102 = OpVariable Private 
                           Private f32_4* %105 = OpVariable Private 
                                      f32 %106 = OpConstant 3.674022E-40 
                                      f32 %107 = OpConstant 3.674022E-40 
                                      f32 %108 = OpConstant 3.674022E-40 
                                      f32 %109 = OpConstant 3.674022E-40 
                                    f32_4 %110 = OpConstantComposite %106 %107 %108 %109 
                                          %111 = OpTypeVector %10 4 
                                          %112 = OpTypeArray %111 %11 
                                      u32 %113 = OpConstant 1065353216 
                                    u32_4 %114 = OpConstantComposite %113 %24 %24 %24 
                                    u32_4 %115 = OpConstantComposite %24 %113 %24 %24 
                                    u32_4 %116 = OpConstantComposite %24 %24 %113 %24 
                                    u32_4 %117 = OpConstantComposite %24 %24 %24 %113 
                                 u32_4[4] %118 = OpConstantComposite %114 %115 %116 %117 
                                          %119 = OpTypePointer Private %10 
                                          %123 = OpTypePointer Function %112 
                                          %125 = OpTypePointer Function %111 
                                      f32 %131 = OpConstant 3.674022E-40 
                                      f32 %132 = OpConstant 3.674022E-40 
                                      f32 %133 = OpConstant 3.674022E-40 
                                      f32 %134 = OpConstant 3.674022E-40 
                                    f32_4 %135 = OpConstantComposite %131 %132 %133 %134 
                                      f32 %145 = OpConstant 3.674022E-40 
                                      f32 %146 = OpConstant 3.674022E-40 
                                      f32 %147 = OpConstant 3.674022E-40 
                                      f32 %148 = OpConstant 3.674022E-40 
                                    f32_4 %149 = OpConstantComposite %145 %146 %147 %148 
                                      u32 %158 = OpConstant 2 
                                      f32 %160 = OpConstant 3.674022E-40 
                                      f32 %161 = OpConstant 3.674022E-40 
                                      f32 %162 = OpConstant 3.674022E-40 
                                      f32 %163 = OpConstant 3.674022E-40 
                                    f32_4 %164 = OpConstantComposite %160 %161 %162 %163 
                                      u32 %173 = OpConstant 3 
                                          %188 = OpTypePointer Private %57 
                          Private bool_4* %189 = OpVariable Private 
                                      f32 %191 = OpConstant 3.674022E-40 
                                    f32_4 %192 = OpConstantComposite %191 %191 %191 %191 
                                      i32 %214 = OpConstant 1 
                                      i32 %216 = OpConstant -1 
                                          %222 = OpTypeVector %6 3 
                                          %223 = OpTypePointer Input %222 
                     Input f32_3* vs_TEXCOORD3 = OpVariable Input 
                             Private f32* %243 = OpVariable Private 
                     Input f32_3* vs_TEXCOORD4 = OpVariable Input 
                                          %250 = OpTypePointer Private %222 
                           Private f32_3* %251 = OpVariable Private 
                     Input f32_3* vs_TEXCOORD2 = OpVariable Input 
                           Private f32_3* %265 = OpVariable Private 
                           Private f32_3* %273 = OpVariable Private 
                                          %274 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                          %275 = OpTypePointer UniformConstant %274 
     UniformConstant read_only Texture2D* %276 = OpVariable UniformConstant 
                                          %278 = OpTypeSampler 
                                          %279 = OpTypePointer UniformConstant %278 
                 UniformConstant sampler* %280 = OpVariable UniformConstant 
                                          %282 = OpTypeSampledImage %274 
                                          %284 = OpTypePointer Input %27 
                     Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                           Private f32_3* %289 = OpVariable Private 
                                      f32 %291 = OpConstant 3.674022E-40 
                                    f32_3 %292 = OpConstantComposite %291 %291 %291 
                                      f32 %294 = OpConstant 3.674022E-40 
                                    f32_3 %295 = OpConstantComposite %294 %294 %294 
                           Private f32_3* %297 = OpVariable Private 
                                          %300 = OpTypeStruct %7 %7 %6 %6 
                                          %301 = OpTypePointer Uniform %300 
Uniform struct {f32_4; f32_4; f32; f32;}* %302 = OpVariable Uniform 
                                      i32 %303 = OpConstant 3 
                           Private f32_3* %315 = OpVariable Private 
                           Private f32_3* %328 = OpVariable Private 
                                      f32 %405 = OpConstant 3.674022E-40 
                                    f32_2 %406 = OpConstantComposite %405 %405 
                           Private f32_4* %411 = OpVariable Private 
     UniformConstant read_only Texture2D* %412 = OpVariable UniformConstant 
                 UniformConstant sampler* %414 = OpVariable UniformConstant 
                           Private f32_4* %438 = OpVariable Private 
     UniformConstant read_only Texture2D* %439 = OpVariable UniformConstant 
                 UniformConstant sampler* %441 = OpVariable UniformConstant 
                                          %461 = OpTypePointer Output %7 
                            Output f32_4* %462 = OpVariable Output 
                                          %469 = OpTypePointer Output %6 
                                       void %4 = OpFunction None %3 
                                            %5 = OpLabel 
                           Function f32_2* %64 = OpVariable Function 
                             Function f32* %70 = OpVariable Function 
                             Function f32* %84 = OpVariable Function 
                       Function u32_4[4]* %124 = OpVariable Function 
                       Function u32_4[4]* %139 = OpVariable Function 
                       Function u32_4[4]* %153 = OpVariable Function 
                       Function u32_4[4]* %168 = OpVariable Function 
                       Function u32_4[4]* %180 = OpVariable Function 
                              Uniform f32* %19 = OpAccessChain %15 %17 
                                       f32 %20 = OpLoad %19 
                                       f32 %21 = OpFNegate %20 
                                       f32 %23 = OpFAdd %21 %22 
                              Private f32* %26 = OpAccessChain %9 %24 
                                                   OpStore %26 %23 
                                     f32_4 %32 = OpLoad vs_TEXCOORD5 
                                     f32_2 %33 = OpVectorShuffle %32 %32 0 1 
                                     f32_4 %34 = OpLoad vs_TEXCOORD5 
                                     f32_2 %35 = OpVectorShuffle %34 %34 3 3 
                                     f32_2 %36 = OpFDiv %33 %35 
                                                   OpStore %29 %36 
                                     f32_2 %37 = OpLoad %29 
                            Uniform f32_4* %40 = OpAccessChain %15 %38 
                                     f32_4 %41 = OpLoad %40 
                                     f32_2 %42 = OpVectorShuffle %41 %41 0 1 
                                     f32_2 %43 = OpFMul %37 %42 
                                                   OpStore %29 %43 
                                     f32_2 %44 = OpLoad %29 
                                     f32_2 %47 = OpFMul %44 %46 
                                                   OpStore %29 %47 
                                     f32_2 %52 = OpLoad %29 
                                     f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                     f32_2 %54 = OpLoad %29 
                                     f32_4 %55 = OpVectorShuffle %54 %54 0 1 0 0 
                                     f32_4 %56 = OpFNegate %55 
                                    bool_4 %58 = OpFOrdGreaterThanEqual %53 %56 
                                    bool_2 %59 = OpVectorShuffle %58 %58 0 1 
                                                   OpStore %51 %59 
                                     f32_2 %60 = OpLoad %29 
                                     f32_2 %61 = OpExtInst %1 4 %60 
                                     f32_2 %62 = OpExtInst %1 10 %61 
                                                   OpStore %29 %62 
                                     f32_2 %65 = OpLoad %29 
                                                   OpStore %64 %65 
                             Private bool* %67 = OpAccessChain %51 %24 
                                      bool %68 = OpLoad %67 
                                                   OpSelectionMerge %72 None 
                                                   OpBranchConditional %68 %71 %75 
                                           %71 = OpLabel 
                              Private f32* %73 = OpAccessChain %29 %24 
                                       f32 %74 = OpLoad %73 
                                                   OpStore %70 %74 
                                                   OpBranch %72 
                                           %75 = OpLabel 
                              Private f32* %76 = OpAccessChain %29 %24 
                                       f32 %77 = OpLoad %76 
                                       f32 %78 = OpFNegate %77 
                                                   OpStore %70 %78 
                                                   OpBranch %72 
                                           %72 = OpLabel 
                                       f32 %79 = OpLoad %70 
                             Function f32* %80 = OpAccessChain %64 %24 
                                                   OpStore %80 %79 
                             Private bool* %82 = OpAccessChain %51 %81 
                                      bool %83 = OpLoad %82 
                                                   OpSelectionMerge %86 None 
                                                   OpBranchConditional %83 %85 %89 
                                           %85 = OpLabel 
                              Private f32* %87 = OpAccessChain %29 %81 
                                       f32 %88 = OpLoad %87 
                                                   OpStore %84 %88 
                                                   OpBranch %86 
                                           %89 = OpLabel 
                              Private f32* %90 = OpAccessChain %29 %81 
                                       f32 %91 = OpLoad %90 
                                       f32 %92 = OpFNegate %91 
                                                   OpStore %84 %92 
                                                   OpBranch %86 
                                           %86 = OpLabel 
                                       f32 %93 = OpLoad %84 
                             Function f32* %94 = OpAccessChain %64 %81 
                                                   OpStore %94 %93 
                                     f32_2 %95 = OpLoad %64 
                                                   OpStore %29 %95 
                                     f32_2 %96 = OpLoad %29 
                                     f32_2 %99 = OpFMul %96 %98 
                                                   OpStore %29 %99 
                                    f32_2 %103 = OpLoad %29 
                                    u32_2 %104 = OpConvertFToU %103 
                                                   OpStore %102 %104 
                             Private u32* %120 = OpAccessChain %102 %24 
                                      u32 %121 = OpLoad %120 
                                      i32 %122 = OpBitcast %121 
                                                   OpStore %124 %118 
                          Function u32_4* %126 = OpAccessChain %124 %122 
                                    u32_4 %127 = OpLoad %126 
                                    f32_4 %128 = OpBitcast %127 
                                      f32 %129 = OpDot %110 %128 
                             Private f32* %130 = OpAccessChain %105 %24 
                                                   OpStore %130 %129 
                             Private u32* %136 = OpAccessChain %102 %24 
                                      u32 %137 = OpLoad %136 
                                      i32 %138 = OpBitcast %137 
                                                   OpStore %139 %118 
                          Function u32_4* %140 = OpAccessChain %139 %138 
                                    u32_4 %141 = OpLoad %140 
                                    f32_4 %142 = OpBitcast %141 
                                      f32 %143 = OpDot %135 %142 
                             Private f32* %144 = OpAccessChain %105 %81 
                                                   OpStore %144 %143 
                             Private u32* %150 = OpAccessChain %102 %24 
                                      u32 %151 = OpLoad %150 
                                      i32 %152 = OpBitcast %151 
                                                   OpStore %153 %118 
                          Function u32_4* %154 = OpAccessChain %153 %152 
                                    u32_4 %155 = OpLoad %154 
                                    f32_4 %156 = OpBitcast %155 
                                      f32 %157 = OpDot %149 %156 
                             Private f32* %159 = OpAccessChain %105 %158 
                                                   OpStore %159 %157 
                             Private u32* %165 = OpAccessChain %102 %24 
                                      u32 %166 = OpLoad %165 
                                      i32 %167 = OpBitcast %166 
                                                   OpStore %168 %118 
                          Function u32_4* %169 = OpAccessChain %168 %167 
                                    u32_4 %170 = OpLoad %169 
                                    f32_4 %171 = OpBitcast %170 
                                      f32 %172 = OpDot %164 %171 
                             Private f32* %174 = OpAccessChain %105 %173 
                                                   OpStore %174 %172 
                                    f32_4 %175 = OpLoad %105 
                                    f32_4 %176 = OpFNegate %175 
                             Private u32* %177 = OpAccessChain %102 %81 
                                      u32 %178 = OpLoad %177 
                                      i32 %179 = OpBitcast %178 
                                                   OpStore %180 %118 
                          Function u32_4* %181 = OpAccessChain %180 %179 
                                    u32_4 %182 = OpLoad %181 
                                    f32_4 %183 = OpBitcast %182 
                                    f32_4 %184 = OpFMul %176 %183 
                                    f32_4 %185 = OpLoad %9 
                                    f32_4 %186 = OpVectorShuffle %185 %185 0 0 0 0 
                                    f32_4 %187 = OpFAdd %184 %186 
                                                   OpStore %9 %187 
                                    f32_4 %190 = OpLoad %9 
                                   bool_4 %193 = OpFOrdLessThan %190 %192 
                                                   OpStore %189 %193 
                            Private bool* %194 = OpAccessChain %189 %158 
                                     bool %195 = OpLoad %194 
                            Private bool* %196 = OpAccessChain %189 %24 
                                     bool %197 = OpLoad %196 
                                     bool %198 = OpLogicalOr %195 %197 
                            Private bool* %199 = OpAccessChain %189 %24 
                                                   OpStore %199 %198 
                            Private bool* %200 = OpAccessChain %189 %173 
                                     bool %201 = OpLoad %200 
                            Private bool* %202 = OpAccessChain %189 %81 
                                     bool %203 = OpLoad %202 
                                     bool %204 = OpLogicalOr %201 %203 
                            Private bool* %205 = OpAccessChain %189 %81 
                                                   OpStore %205 %204 
                            Private bool* %206 = OpAccessChain %189 %81 
                                     bool %207 = OpLoad %206 
                            Private bool* %208 = OpAccessChain %189 %24 
                                     bool %209 = OpLoad %208 
                                     bool %210 = OpLogicalOr %207 %209 
                            Private bool* %211 = OpAccessChain %189 %24 
                                                   OpStore %211 %210 
                            Private bool* %212 = OpAccessChain %189 %24 
                                     bool %213 = OpLoad %212 
                                      i32 %215 = OpSelect %213 %214 %38 
                                      i32 %217 = OpIMul %215 %216 
                                     bool %218 = OpINotEqual %217 %38 
                                                   OpSelectionMerge %220 None 
                                                   OpBranchConditional %218 %219 %220 
                                          %219 = OpLabel 
                                                   OpKill
                                          %220 = OpLabel 
                                    f32_3 %225 = OpLoad vs_TEXCOORD3 
                                    f32_3 %226 = OpLoad vs_TEXCOORD3 
                                      f32 %227 = OpDot %225 %226 
                             Private f32* %228 = OpAccessChain %9 %24 
                                                   OpStore %228 %227 
                             Private f32* %229 = OpAccessChain %9 %24 
                                      f32 %230 = OpLoad %229 
                                      f32 %231 = OpExtInst %1 32 %230 
                             Private f32* %232 = OpAccessChain %9 %24 
                                                   OpStore %232 %231 
                                    f32_4 %233 = OpLoad %9 
                                    f32_3 %234 = OpVectorShuffle %233 %233 0 0 0 
                                    f32_3 %235 = OpLoad vs_TEXCOORD3 
                                    f32_3 %236 = OpVectorShuffle %235 %235 1 0 2 
                                    f32_3 %237 = OpFMul %234 %236 
                                    f32_4 %238 = OpLoad %9 
                                    f32_4 %239 = OpVectorShuffle %238 %237 4 5 6 3 
                                                   OpStore %9 %239 
                             Private f32* %240 = OpAccessChain %9 %158 
                                      f32 %241 = OpLoad %240 
                             Private f32* %242 = OpAccessChain %105 %24 
                                                   OpStore %242 %241 
                                    f32_3 %245 = OpLoad vs_TEXCOORD4 
                                    f32_3 %246 = OpLoad vs_TEXCOORD4 
                                      f32 %247 = OpDot %245 %246 
                                                   OpStore %243 %247 
                                      f32 %248 = OpLoad %243 
                                      f32 %249 = OpExtInst %1 32 %248 
                                                   OpStore %243 %249 
                                      f32 %252 = OpLoad %243 
                                    f32_3 %253 = OpCompositeConstruct %252 %252 %252 
                                    f32_3 %254 = OpLoad vs_TEXCOORD4 
                                    f32_3 %255 = OpFMul %253 %254 
                                                   OpStore %251 %255 
                             Private f32* %256 = OpAccessChain %251 %158 
                                      f32 %257 = OpLoad %256 
                             Private f32* %258 = OpAccessChain %105 %81 
                                                   OpStore %258 %257 
                                    f32_3 %260 = OpLoad vs_TEXCOORD2 
                                    f32_3 %261 = OpLoad vs_TEXCOORD2 
                                      f32 %262 = OpDot %260 %261 
                                                   OpStore %243 %262 
                                      f32 %263 = OpLoad %243 
                                      f32 %264 = OpExtInst %1 32 %263 
                                                   OpStore %243 %264 
                                      f32 %266 = OpLoad %243 
                                    f32_3 %267 = OpCompositeConstruct %266 %266 %266 
                                    f32_3 %268 = OpLoad vs_TEXCOORD2 
                                    f32_3 %269 = OpFMul %267 %268 
                                                   OpStore %265 %269 
                             Private f32* %270 = OpAccessChain %265 %158 
                                      f32 %271 = OpLoad %270 
                             Private f32* %272 = OpAccessChain %105 %158 
                                                   OpStore %272 %271 
                      read_only Texture2D %277 = OpLoad %276 
                                  sampler %281 = OpLoad %280 
               read_only Texture2DSampled %283 = OpSampledImage %277 %281 
                                    f32_2 %286 = OpLoad vs_TEXCOORD0 
                                    f32_4 %287 = OpImageSampleImplicitLod %283 %286 
                                    f32_3 %288 = OpVectorShuffle %287 %287 0 1 2 
                                                   OpStore %273 %288 
                                    f32_3 %290 = OpLoad %273 
                                    f32_3 %293 = OpFMul %290 %292 
                                    f32_3 %296 = OpFAdd %293 %295 
                                                   OpStore %289 %296 
                                    f32_3 %298 = OpLoad %289 
                                    f32_2 %299 = OpVectorShuffle %298 %298 0 1 
                             Uniform f32* %304 = OpAccessChain %302 %303 
                                      f32 %305 = OpLoad %304 
                             Uniform f32* %306 = OpAccessChain %302 %303 
                                      f32 %307 = OpLoad %306 
                                    f32_2 %308 = OpCompositeConstruct %305 %307 
                                      f32 %309 = OpCompositeExtract %308 0 
                                      f32 %310 = OpCompositeExtract %308 1 
                                    f32_2 %311 = OpCompositeConstruct %309 %310 
                                    f32_2 %312 = OpFMul %299 %311 
                                    f32_3 %313 = OpLoad %297 
                                    f32_3 %314 = OpVectorShuffle %313 %312 3 4 2 
                                                   OpStore %297 %314 
                                    f32_3 %316 = OpLoad %297 
                                    f32_2 %317 = OpVectorShuffle %316 %316 0 1 
                                    f32_3 %318 = OpLoad %315 
                                    f32_3 %319 = OpVectorShuffle %318 %317 3 4 2 
                                                   OpStore %315 %319 
                             Private f32* %320 = OpAccessChain %289 %158 
                                      f32 %321 = OpLoad %320 
                             Private f32* %322 = OpAccessChain %315 %158 
                                                   OpStore %322 %321 
                                    f32_3 %323 = OpLoad %315 
                                    f32_4 %324 = OpLoad %105 
                                    f32_3 %325 = OpVectorShuffle %324 %324 0 1 2 
                                      f32 %326 = OpDot %323 %325 
                             Private f32* %327 = OpAccessChain %105 %158 
                                                   OpStore %327 %326 
                             Private f32* %329 = OpAccessChain %9 %81 
                                      f32 %330 = OpLoad %329 
                             Private f32* %331 = OpAccessChain %328 %24 
                                                   OpStore %331 %330 
                             Private f32* %332 = OpAccessChain %251 %24 
                                      f32 %333 = OpLoad %332 
                             Private f32* %334 = OpAccessChain %328 %81 
                                                   OpStore %334 %333 
                             Private f32* %335 = OpAccessChain %251 %81 
                                      f32 %336 = OpLoad %335 
                             Private f32* %337 = OpAccessChain %9 %81 
                                                   OpStore %337 %336 
                             Private f32* %338 = OpAccessChain %265 %24 
                                      f32 %339 = OpLoad %338 
                             Private f32* %340 = OpAccessChain %328 %158 
                                                   OpStore %340 %339 
                             Private f32* %341 = OpAccessChain %265 %81 
                                      f32 %342 = OpLoad %341 
                             Private f32* %343 = OpAccessChain %9 %158 
                                                   OpStore %343 %342 
                             Private f32* %344 = OpAccessChain %315 %158 
                                      f32 %345 = OpLoad %344 
                             Private f32* %346 = OpAccessChain %297 %158 
                                                   OpStore %346 %345 
                                    f32_3 %347 = OpLoad %315 
                                    f32_4 %348 = OpLoad %9 
                                    f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
                                      f32 %350 = OpDot %347 %349 
                             Private f32* %351 = OpAccessChain %105 %81 
                                                   OpStore %351 %350 
                                    f32_3 %352 = OpLoad %297 
                                    f32_3 %353 = OpLoad %328 
                                      f32 %354 = OpDot %352 %353 
                             Private f32* %355 = OpAccessChain %105 %24 
                                                   OpStore %355 %354 
                                    f32_4 %356 = OpLoad %105 
                                    f32_3 %357 = OpVectorShuffle %356 %356 0 1 2 
                                    f32_4 %358 = OpLoad %105 
                                    f32_3 %359 = OpVectorShuffle %358 %358 0 1 2 
                                      f32 %360 = OpDot %357 %359 
                             Private f32* %361 = OpAccessChain %9 %24 
                                                   OpStore %361 %360 
                             Private f32* %362 = OpAccessChain %9 %24 
                                      f32 %363 = OpLoad %362 
                                      f32 %364 = OpExtInst %1 32 %363 
                             Private f32* %365 = OpAccessChain %9 %24 
                                                   OpStore %365 %364 
                                    f32_4 %366 = OpLoad %9 
                                    f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
                                    f32_4 %368 = OpLoad %105 
                                    f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                    f32_3 %370 = OpFMul %367 %369 
                                    f32_4 %371 = OpLoad %9 
                                    f32_4 %372 = OpVectorShuffle %371 %370 4 5 6 3 
                                                   OpStore %9 %372 
                             Uniform f32* %373 = OpAccessChain %15 %214 %38 %24 
                                      f32 %374 = OpLoad %373 
                             Private f32* %375 = OpAccessChain %105 %24 
                                                   OpStore %375 %374 
                             Uniform f32* %376 = OpAccessChain %15 %214 %214 %24 
                                      f32 %377 = OpLoad %376 
                             Private f32* %378 = OpAccessChain %105 %81 
                                                   OpStore %378 %377 
                             Uniform f32* %379 = OpAccessChain %15 %214 %17 %24 
                                      f32 %380 = OpLoad %379 
                             Private f32* %381 = OpAccessChain %105 %158 
                                                   OpStore %381 %380 
                                    f32_4 %382 = OpLoad %105 
                                    f32_3 %383 = OpVectorShuffle %382 %382 0 1 2 
                                    f32_4 %384 = OpLoad %9 
                                    f32_3 %385 = OpVectorShuffle %384 %384 0 1 2 
                                      f32 %386 = OpDot %383 %385 
                             Private f32* %387 = OpAccessChain %289 %24 
                                                   OpStore %387 %386 
                             Uniform f32* %388 = OpAccessChain %15 %214 %38 %81 
                                      f32 %389 = OpLoad %388 
                             Private f32* %390 = OpAccessChain %105 %24 
                                                   OpStore %390 %389 
                             Uniform f32* %391 = OpAccessChain %15 %214 %214 %81 
                                      f32 %392 = OpLoad %391 
                             Private f32* %393 = OpAccessChain %105 %81 
                                                   OpStore %393 %392 
                             Uniform f32* %394 = OpAccessChain %15 %214 %17 %81 
                                      f32 %395 = OpLoad %394 
                             Private f32* %396 = OpAccessChain %105 %158 
                                                   OpStore %396 %395 
                                    f32_4 %397 = OpLoad %105 
                                    f32_3 %398 = OpVectorShuffle %397 %397 0 1 2 
                                    f32_4 %399 = OpLoad %9 
                                    f32_3 %400 = OpVectorShuffle %399 %399 0 1 2 
                                      f32 %401 = OpDot %398 %400 
                             Private f32* %402 = OpAccessChain %289 %81 
                                                   OpStore %402 %401 
                                    f32_3 %403 = OpLoad %289 
                                    f32_2 %404 = OpVectorShuffle %403 %403 0 1 
                                    f32_2 %407 = OpFMul %404 %406 
                                    f32_2 %408 = OpFAdd %407 %406 
                                    f32_3 %409 = OpLoad %289 
                                    f32_3 %410 = OpVectorShuffle %409 %408 3 4 2 
                                                   OpStore %289 %410 
                      read_only Texture2D %413 = OpLoad %412 
                                  sampler %415 = OpLoad %414 
               read_only Texture2DSampled %416 = OpSampledImage %413 %415 
                                    f32_3 %417 = OpLoad %289 
                                    f32_2 %418 = OpVectorShuffle %417 %417 0 1 
                                    f32_4 %419 = OpImageSampleImplicitLod %416 %418 
                                                   OpStore %411 %419 
                                    f32_4 %420 = OpLoad %411 
                                    f32_3 %421 = OpVectorShuffle %420 %420 0 1 2 
                           Uniform f32_4* %422 = OpAccessChain %302 %214 
                                    f32_4 %423 = OpLoad %422 
                                    f32_3 %424 = OpVectorShuffle %423 %423 0 1 2 
                                    f32_3 %425 = OpFMul %421 %424 
                                    f32_4 %426 = OpLoad %9 
                                    f32_4 %427 = OpVectorShuffle %426 %425 4 5 6 3 
                                                   OpStore %9 %427 
                                    f32_4 %428 = OpLoad %411 
                                    f32_3 %429 = OpVectorShuffle %428 %428 3 3 3 
                             Uniform f32* %430 = OpAccessChain %302 %17 
                                      f32 %431 = OpLoad %430 
                                    f32_3 %432 = OpCompositeConstruct %431 %431 %431 
                                    f32_3 %433 = OpFMul %429 %432 
                                    f32_4 %434 = OpLoad %9 
                                    f32_3 %435 = OpVectorShuffle %434 %434 0 1 2 
                                    f32_3 %436 = OpFNegate %435 
                                    f32_3 %437 = OpFAdd %433 %436 
                                                   OpStore %289 %437 
                      read_only Texture2D %440 = OpLoad %439 
                                  sampler %442 = OpLoad %441 
               read_only Texture2DSampled %443 = OpSampledImage %440 %442 
                                    f32_2 %444 = OpLoad vs_TEXCOORD0 
                                    f32_4 %445 = OpImageSampleImplicitLod %443 %444 
                                                   OpStore %438 %445 
                                    f32_4 %446 = OpLoad %438 
                                    f32_3 %447 = OpVectorShuffle %446 %446 3 3 3 
                                    f32_3 %448 = OpLoad %289 
                                    f32_3 %449 = OpFMul %447 %448 
                                    f32_4 %450 = OpLoad %9 
                                    f32_3 %451 = OpVectorShuffle %450 %450 0 1 2 
                                    f32_3 %452 = OpFAdd %449 %451 
                                                   OpStore %289 %452 
                                    f32_4 %453 = OpLoad %438 
                                    f32_3 %454 = OpVectorShuffle %453 %453 0 1 2 
                           Uniform f32_4* %455 = OpAccessChain %302 %38 
                                    f32_4 %456 = OpLoad %455 
                                    f32_3 %457 = OpVectorShuffle %456 %456 0 1 2 
                                    f32_3 %458 = OpFMul %454 %457 
                                    f32_4 %459 = OpLoad %9 
                                    f32_4 %460 = OpVectorShuffle %459 %458 4 5 6 3 
                                                   OpStore %9 %460 
                                    f32_3 %463 = OpLoad %289 
                                    f32_4 %464 = OpLoad %9 
                                    f32_3 %465 = OpVectorShuffle %464 %464 0 1 2 
                                    f32_3 %466 = OpFMul %463 %465 
                                    f32_4 %467 = OpLoad %462 
                                    f32_4 %468 = OpVectorShuffle %467 %466 4 5 6 3 
                                                   OpStore %462 %468 
                              Output f32* %470 = OpAccessChain %462 %173 
                                                   OpStore %470 %22 
                                                   OpReturn
                                                   OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _CharacterAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _MainColor;
	UNITY_UNIFORM vec4 _MatColor;
	UNITY_UNIFORM float _MatnormalIntenstiy;
	UNITY_UNIFORM float _NormalIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MatCap;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _Normal;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec2 u_xlat8;
uvec2 u_xlatu8;
float u_xlat24;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.xy = u_xlat8.xy * _ScreenParams.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
    u_xlat8.xy = fract(abs(u_xlat8.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat8;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
        u_xlat8 = hlslcc_movcTemp;
    }
    u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
    u_xlatu8.xy = uvec2(u_xlat8.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu8.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.yxz;
    u_xlat1.x = u_xlat0.z;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat1.y = u_xlat2.z;
    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
    u_xlat1.z = u_xlat3.z;
    u_xlat16_4.xyz = texture(_Normal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xy = u_xlat16_5.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat6.xy = u_xlat4.xy;
    u_xlat6.z = u_xlat16_5.z;
    u_xlat1.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat7.x = u_xlat0.y;
    u_xlat7.y = u_xlat2.x;
    u_xlat0.y = u_xlat2.y;
    u_xlat7.z = u_xlat3.x;
    u_xlat0.z = u_xlat3.y;
    u_xlat4.z = u_xlat6.z;
    u_xlat1.y = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MatCap, u_xlat16_5.xy);
    u_xlat0.xyz = u_xlat16_0.xyz * _MatColor.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * vec3(_MatnormalIntenstiy) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_1.www * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
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
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 472
; Schema: 0
                                                   OpCapability Shader 
                                            %1 = OpExtInstImport "GLSL.std.450" 
                                                   OpMemoryModel Logical GLSL450 
                                                   OpEntryPoint Fragment %4 "main" %31 %224 %244 %259 %285 %462 
                                                   OpExecutionMode %4 OriginUpperLeft 
                                                   OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                   OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                   OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                   OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                   OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                   OpDecorate %12 ArrayStride 12 
                                                   OpMemberDecorate %13 0 Offset 13 
                                                   OpMemberDecorate %13 1 Offset 13 
                                                   OpMemberDecorate %13 2 Offset 13 
                                                   OpDecorate %13 Block 
                                                   OpDecorate %15 DescriptorSet 15 
                                                   OpDecorate %15 Binding 15 
                                                   OpDecorate vs_TEXCOORD5 Location 31 
                                                   OpDecorate vs_TEXCOORD3 Location 224 
                                                   OpDecorate vs_TEXCOORD4 Location 244 
                                                   OpDecorate vs_TEXCOORD2 Location 259 
                                                   OpDecorate %273 RelaxedPrecision 
                                                   OpDecorate %276 RelaxedPrecision 
                                                   OpDecorate %276 DescriptorSet 276 
                                                   OpDecorate %276 Binding 276 
                                                   OpDecorate %277 RelaxedPrecision 
                                                   OpDecorate %280 RelaxedPrecision 
                                                   OpDecorate %280 DescriptorSet 280 
                                                   OpDecorate %280 Binding 280 
                                                   OpDecorate %281 RelaxedPrecision 
                                                   OpDecorate vs_TEXCOORD0 Location 285 
                                                   OpDecorate %288 RelaxedPrecision 
                                                   OpDecorate %289 RelaxedPrecision 
                                                   OpDecorate %290 RelaxedPrecision 
                                                   OpDecorate %293 RelaxedPrecision 
                                                   OpDecorate %296 RelaxedPrecision 
                                                   OpDecorate %298 RelaxedPrecision 
                                                   OpDecorate %299 RelaxedPrecision 
                                                   OpMemberDecorate %300 0 Offset 300 
                                                   OpMemberDecorate %300 1 Offset 300 
                                                   OpMemberDecorate %300 2 Offset 300 
                                                   OpMemberDecorate %300 3 Offset 300 
                                                   OpDecorate %300 Block 
                                                   OpDecorate %302 DescriptorSet 302 
                                                   OpDecorate %302 Binding 302 
                                                   OpDecorate %308 RelaxedPrecision 
                                                   OpDecorate %309 RelaxedPrecision 
                                                   OpDecorate %310 RelaxedPrecision 
                                                   OpDecorate %311 RelaxedPrecision 
                                                   OpDecorate %312 RelaxedPrecision 
                                                   OpDecorate %321 RelaxedPrecision 
                                                   OpDecorate %403 RelaxedPrecision 
                                                   OpDecorate %404 RelaxedPrecision 
                                                   OpDecorate %407 RelaxedPrecision 
                                                   OpDecorate %408 RelaxedPrecision 
                                                   OpDecorate %411 RelaxedPrecision 
                                                   OpDecorate %412 RelaxedPrecision 
                                                   OpDecorate %412 DescriptorSet 412 
                                                   OpDecorate %412 Binding 412 
                                                   OpDecorate %413 RelaxedPrecision 
                                                   OpDecorate %414 RelaxedPrecision 
                                                   OpDecorate %414 DescriptorSet 414 
                                                   OpDecorate %414 Binding 414 
                                                   OpDecorate %415 RelaxedPrecision 
                                                   OpDecorate %417 RelaxedPrecision 
                                                   OpDecorate %418 RelaxedPrecision 
                                                   OpDecorate %419 RelaxedPrecision 
                                                   OpDecorate %420 RelaxedPrecision 
                                                   OpDecorate %421 RelaxedPrecision 
                                                   OpDecorate %428 RelaxedPrecision 
                                                   OpDecorate %429 RelaxedPrecision 
                                                   OpDecorate %432 RelaxedPrecision 
                                                   OpDecorate %433 RelaxedPrecision 
                                                   OpDecorate %438 RelaxedPrecision 
                                                   OpDecorate %439 RelaxedPrecision 
                                                   OpDecorate %439 DescriptorSet 439 
                                                   OpDecorate %439 Binding 439 
                                                   OpDecorate %440 RelaxedPrecision 
                                                   OpDecorate %441 RelaxedPrecision 
                                                   OpDecorate %441 DescriptorSet 441 
                                                   OpDecorate %441 Binding 441 
                                                   OpDecorate %442 RelaxedPrecision 
                                                   OpDecorate %446 RelaxedPrecision 
                                                   OpDecorate %447 RelaxedPrecision 
                                                   OpDecorate %448 RelaxedPrecision 
                                                   OpDecorate %449 RelaxedPrecision 
                                                   OpDecorate %453 RelaxedPrecision 
                                                   OpDecorate %454 RelaxedPrecision 
                                                   OpDecorate %462 RelaxedPrecision 
                                                   OpDecorate %462 Location 462 
                                                   OpDecorate %463 RelaxedPrecision 
                                            %2 = OpTypeVoid 
                                            %3 = OpTypeFunction %2 
                                            %6 = OpTypeFloat 32 
                                            %7 = OpTypeVector %6 4 
                                            %8 = OpTypePointer Private %7 
                             Private f32_4* %9 = OpVariable Private 
                                           %10 = OpTypeInt 32 0 
                                       u32 %11 = OpConstant 4 
                                           %12 = OpTypeArray %7 %11 
                                           %13 = OpTypeStruct %7 %12 %6 
                                           %14 = OpTypePointer Uniform %13 
   Uniform struct {f32_4; f32_4[4]; f32;}* %15 = OpVariable Uniform 
                                           %16 = OpTypeInt 32 1 
                                       i32 %17 = OpConstant 2 
                                           %18 = OpTypePointer Uniform %6 
                                       f32 %22 = OpConstant 3.674022E-40 
                                       u32 %24 = OpConstant 0 
                                           %25 = OpTypePointer Private %6 
                                           %27 = OpTypeVector %6 2 
                                           %28 = OpTypePointer Private %27 
                            Private f32_2* %29 = OpVariable Private 
                                           %30 = OpTypePointer Input %7 
                     Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                       i32 %38 = OpConstant 0 
                                           %39 = OpTypePointer Uniform %7 
                                       f32 %45 = OpConstant 3.674022E-40 
                                     f32_2 %46 = OpConstantComposite %45 %45 
                                           %48 = OpTypeBool 
                                           %49 = OpTypeVector %48 2 
                                           %50 = OpTypePointer Private %49 
                           Private bool_2* %51 = OpVariable Private 
                                           %57 = OpTypeVector %48 4 
                                           %63 = OpTypePointer Function %27 
                                           %66 = OpTypePointer Private %48 
                                           %69 = OpTypePointer Function %6 
                                       u32 %81 = OpConstant 1 
                                       f32 %97 = OpConstant 3.674022E-40 
                                     f32_2 %98 = OpConstantComposite %97 %97 
                                          %100 = OpTypeVector %10 2 
                                          %101 = OpTypePointer Private %100 
                           Private u32_2* %102 = OpVariable Private 
                           Private f32_4* %105 = OpVariable Private 
                                      f32 %106 = OpConstant 3.674022E-40 
                                      f32 %107 = OpConstant 3.674022E-40 
                                      f32 %108 = OpConstant 3.674022E-40 
                                      f32 %109 = OpConstant 3.674022E-40 
                                    f32_4 %110 = OpConstantComposite %106 %107 %108 %109 
                                          %111 = OpTypeVector %10 4 
                                          %112 = OpTypeArray %111 %11 
                                      u32 %113 = OpConstant 1065353216 
                                    u32_4 %114 = OpConstantComposite %113 %24 %24 %24 
                                    u32_4 %115 = OpConstantComposite %24 %113 %24 %24 
                                    u32_4 %116 = OpConstantComposite %24 %24 %113 %24 
                                    u32_4 %117 = OpConstantComposite %24 %24 %24 %113 
                                 u32_4[4] %118 = OpConstantComposite %114 %115 %116 %117 
                                          %119 = OpTypePointer Private %10 
                                          %123 = OpTypePointer Function %112 
                                          %125 = OpTypePointer Function %111 
                                      f32 %131 = OpConstant 3.674022E-40 
                                      f32 %132 = OpConstant 3.674022E-40 
                                      f32 %133 = OpConstant 3.674022E-40 
                                      f32 %134 = OpConstant 3.674022E-40 
                                    f32_4 %135 = OpConstantComposite %131 %132 %133 %134 
                                      f32 %145 = OpConstant 3.674022E-40 
                                      f32 %146 = OpConstant 3.674022E-40 
                                      f32 %147 = OpConstant 3.674022E-40 
                                      f32 %148 = OpConstant 3.674022E-40 
                                    f32_4 %149 = OpConstantComposite %145 %146 %147 %148 
                                      u32 %158 = OpConstant 2 
                                      f32 %160 = OpConstant 3.674022E-40 
                                      f32 %161 = OpConstant 3.674022E-40 
                                      f32 %162 = OpConstant 3.674022E-40 
                                      f32 %163 = OpConstant 3.674022E-40 
                                    f32_4 %164 = OpConstantComposite %160 %161 %162 %163 
                                      u32 %173 = OpConstant 3 
                                          %188 = OpTypePointer Private %57 
                          Private bool_4* %189 = OpVariable Private 
                                      f32 %191 = OpConstant 3.674022E-40 
                                    f32_4 %192 = OpConstantComposite %191 %191 %191 %191 
                                      i32 %214 = OpConstant 1 
                                      i32 %216 = OpConstant -1 
                                          %222 = OpTypeVector %6 3 
                                          %223 = OpTypePointer Input %222 
                     Input f32_3* vs_TEXCOORD3 = OpVariable Input 
                             Private f32* %243 = OpVariable Private 
                     Input f32_3* vs_TEXCOORD4 = OpVariable Input 
                                          %250 = OpTypePointer Private %222 
                           Private f32_3* %251 = OpVariable Private 
                     Input f32_3* vs_TEXCOORD2 = OpVariable Input 
                           Private f32_3* %265 = OpVariable Private 
                           Private f32_3* %273 = OpVariable Private 
                                          %274 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                          %275 = OpTypePointer UniformConstant %274 
     UniformConstant read_only Texture2D* %276 = OpVariable UniformConstant 
                                          %278 = OpTypeSampler 
                                          %279 = OpTypePointer UniformConstant %278 
                 UniformConstant sampler* %280 = OpVariable UniformConstant 
                                          %282 = OpTypeSampledImage %274 
                                          %284 = OpTypePointer Input %27 
                     Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                           Private f32_3* %289 = OpVariable Private 
                                      f32 %291 = OpConstant 3.674022E-40 
                                    f32_3 %292 = OpConstantComposite %291 %291 %291 
                                      f32 %294 = OpConstant 3.674022E-40 
                                    f32_3 %295 = OpConstantComposite %294 %294 %294 
                           Private f32_3* %297 = OpVariable Private 
                                          %300 = OpTypeStruct %7 %7 %6 %6 
                                          %301 = OpTypePointer Uniform %300 
Uniform struct {f32_4; f32_4; f32; f32;}* %302 = OpVariable Uniform 
                                      i32 %303 = OpConstant 3 
                           Private f32_3* %315 = OpVariable Private 
                           Private f32_3* %328 = OpVariable Private 
                                      f32 %405 = OpConstant 3.674022E-40 
                                    f32_2 %406 = OpConstantComposite %405 %405 
                           Private f32_4* %411 = OpVariable Private 
     UniformConstant read_only Texture2D* %412 = OpVariable UniformConstant 
                 UniformConstant sampler* %414 = OpVariable UniformConstant 
                           Private f32_4* %438 = OpVariable Private 
     UniformConstant read_only Texture2D* %439 = OpVariable UniformConstant 
                 UniformConstant sampler* %441 = OpVariable UniformConstant 
                                          %461 = OpTypePointer Output %7 
                            Output f32_4* %462 = OpVariable Output 
                                          %469 = OpTypePointer Output %6 
                                       void %4 = OpFunction None %3 
                                            %5 = OpLabel 
                           Function f32_2* %64 = OpVariable Function 
                             Function f32* %70 = OpVariable Function 
                             Function f32* %84 = OpVariable Function 
                       Function u32_4[4]* %124 = OpVariable Function 
                       Function u32_4[4]* %139 = OpVariable Function 
                       Function u32_4[4]* %153 = OpVariable Function 
                       Function u32_4[4]* %168 = OpVariable Function 
                       Function u32_4[4]* %180 = OpVariable Function 
                              Uniform f32* %19 = OpAccessChain %15 %17 
                                       f32 %20 = OpLoad %19 
                                       f32 %21 = OpFNegate %20 
                                       f32 %23 = OpFAdd %21 %22 
                              Private f32* %26 = OpAccessChain %9 %24 
                                                   OpStore %26 %23 
                                     f32_4 %32 = OpLoad vs_TEXCOORD5 
                                     f32_2 %33 = OpVectorShuffle %32 %32 0 1 
                                     f32_4 %34 = OpLoad vs_TEXCOORD5 
                                     f32_2 %35 = OpVectorShuffle %34 %34 3 3 
                                     f32_2 %36 = OpFDiv %33 %35 
                                                   OpStore %29 %36 
                                     f32_2 %37 = OpLoad %29 
                            Uniform f32_4* %40 = OpAccessChain %15 %38 
                                     f32_4 %41 = OpLoad %40 
                                     f32_2 %42 = OpVectorShuffle %41 %41 0 1 
                                     f32_2 %43 = OpFMul %37 %42 
                                                   OpStore %29 %43 
                                     f32_2 %44 = OpLoad %29 
                                     f32_2 %47 = OpFMul %44 %46 
                                                   OpStore %29 %47 
                                     f32_2 %52 = OpLoad %29 
                                     f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                     f32_2 %54 = OpLoad %29 
                                     f32_4 %55 = OpVectorShuffle %54 %54 0 1 0 0 
                                     f32_4 %56 = OpFNegate %55 
                                    bool_4 %58 = OpFOrdGreaterThanEqual %53 %56 
                                    bool_2 %59 = OpVectorShuffle %58 %58 0 1 
                                                   OpStore %51 %59 
                                     f32_2 %60 = OpLoad %29 
                                     f32_2 %61 = OpExtInst %1 4 %60 
                                     f32_2 %62 = OpExtInst %1 10 %61 
                                                   OpStore %29 %62 
                                     f32_2 %65 = OpLoad %29 
                                                   OpStore %64 %65 
                             Private bool* %67 = OpAccessChain %51 %24 
                                      bool %68 = OpLoad %67 
                                                   OpSelectionMerge %72 None 
                                                   OpBranchConditional %68 %71 %75 
                                           %71 = OpLabel 
                              Private f32* %73 = OpAccessChain %29 %24 
                                       f32 %74 = OpLoad %73 
                                                   OpStore %70 %74 
                                                   OpBranch %72 
                                           %75 = OpLabel 
                              Private f32* %76 = OpAccessChain %29 %24 
                                       f32 %77 = OpLoad %76 
                                       f32 %78 = OpFNegate %77 
                                                   OpStore %70 %78 
                                                   OpBranch %72 
                                           %72 = OpLabel 
                                       f32 %79 = OpLoad %70 
                             Function f32* %80 = OpAccessChain %64 %24 
                                                   OpStore %80 %79 
                             Private bool* %82 = OpAccessChain %51 %81 
                                      bool %83 = OpLoad %82 
                                                   OpSelectionMerge %86 None 
                                                   OpBranchConditional %83 %85 %89 
                                           %85 = OpLabel 
                              Private f32* %87 = OpAccessChain %29 %81 
                                       f32 %88 = OpLoad %87 
                                                   OpStore %84 %88 
                                                   OpBranch %86 
                                           %89 = OpLabel 
                              Private f32* %90 = OpAccessChain %29 %81 
                                       f32 %91 = OpLoad %90 
                                       f32 %92 = OpFNegate %91 
                                                   OpStore %84 %92 
                                                   OpBranch %86 
                                           %86 = OpLabel 
                                       f32 %93 = OpLoad %84 
                             Function f32* %94 = OpAccessChain %64 %81 
                                                   OpStore %94 %93 
                                     f32_2 %95 = OpLoad %64 
                                                   OpStore %29 %95 
                                     f32_2 %96 = OpLoad %29 
                                     f32_2 %99 = OpFMul %96 %98 
                                                   OpStore %29 %99 
                                    f32_2 %103 = OpLoad %29 
                                    u32_2 %104 = OpConvertFToU %103 
                                                   OpStore %102 %104 
                             Private u32* %120 = OpAccessChain %102 %24 
                                      u32 %121 = OpLoad %120 
                                      i32 %122 = OpBitcast %121 
                                                   OpStore %124 %118 
                          Function u32_4* %126 = OpAccessChain %124 %122 
                                    u32_4 %127 = OpLoad %126 
                                    f32_4 %128 = OpBitcast %127 
                                      f32 %129 = OpDot %110 %128 
                             Private f32* %130 = OpAccessChain %105 %24 
                                                   OpStore %130 %129 
                             Private u32* %136 = OpAccessChain %102 %24 
                                      u32 %137 = OpLoad %136 
                                      i32 %138 = OpBitcast %137 
                                                   OpStore %139 %118 
                          Function u32_4* %140 = OpAccessChain %139 %138 
                                    u32_4 %141 = OpLoad %140 
                                    f32_4 %142 = OpBitcast %141 
                                      f32 %143 = OpDot %135 %142 
                             Private f32* %144 = OpAccessChain %105 %81 
                                                   OpStore %144 %143 
                             Private u32* %150 = OpAccessChain %102 %24 
                                      u32 %151 = OpLoad %150 
                                      i32 %152 = OpBitcast %151 
                                                   OpStore %153 %118 
                          Function u32_4* %154 = OpAccessChain %153 %152 
                                    u32_4 %155 = OpLoad %154 
                                    f32_4 %156 = OpBitcast %155 
                                      f32 %157 = OpDot %149 %156 
                             Private f32* %159 = OpAccessChain %105 %158 
                                                   OpStore %159 %157 
                             Private u32* %165 = OpAccessChain %102 %24 
                                      u32 %166 = OpLoad %165 
                                      i32 %167 = OpBitcast %166 
                                                   OpStore %168 %118 
                          Function u32_4* %169 = OpAccessChain %168 %167 
                                    u32_4 %170 = OpLoad %169 
                                    f32_4 %171 = OpBitcast %170 
                                      f32 %172 = OpDot %164 %171 
                             Private f32* %174 = OpAccessChain %105 %173 
                                                   OpStore %174 %172 
                                    f32_4 %175 = OpLoad %105 
                                    f32_4 %176 = OpFNegate %175 
                             Private u32* %177 = OpAccessChain %102 %81 
                                      u32 %178 = OpLoad %177 
                                      i32 %179 = OpBitcast %178 
                                                   OpStore %180 %118 
                          Function u32_4* %181 = OpAccessChain %180 %179 
                                    u32_4 %182 = OpLoad %181 
                                    f32_4 %183 = OpBitcast %182 
                                    f32_4 %184 = OpFMul %176 %183 
                                    f32_4 %185 = OpLoad %9 
                                    f32_4 %186 = OpVectorShuffle %185 %185 0 0 0 0 
                                    f32_4 %187 = OpFAdd %184 %186 
                                                   OpStore %9 %187 
                                    f32_4 %190 = OpLoad %9 
                                   bool_4 %193 = OpFOrdLessThan %190 %192 
                                                   OpStore %189 %193 
                            Private bool* %194 = OpAccessChain %189 %158 
                                     bool %195 = OpLoad %194 
                            Private bool* %196 = OpAccessChain %189 %24 
                                     bool %197 = OpLoad %196 
                                     bool %198 = OpLogicalOr %195 %197 
                            Private bool* %199 = OpAccessChain %189 %24 
                                                   OpStore %199 %198 
                            Private bool* %200 = OpAccessChain %189 %173 
                                     bool %201 = OpLoad %200 
                            Private bool* %202 = OpAccessChain %189 %81 
                                     bool %203 = OpLoad %202 
                                     bool %204 = OpLogicalOr %201 %203 
                            Private bool* %205 = OpAccessChain %189 %81 
                                                   OpStore %205 %204 
                            Private bool* %206 = OpAccessChain %189 %81 
                                     bool %207 = OpLoad %206 
                            Private bool* %208 = OpAccessChain %189 %24 
                                     bool %209 = OpLoad %208 
                                     bool %210 = OpLogicalOr %207 %209 
                            Private bool* %211 = OpAccessChain %189 %24 
                                                   OpStore %211 %210 
                            Private bool* %212 = OpAccessChain %189 %24 
                                     bool %213 = OpLoad %212 
                                      i32 %215 = OpSelect %213 %214 %38 
                                      i32 %217 = OpIMul %215 %216 
                                     bool %218 = OpINotEqual %217 %38 
                                                   OpSelectionMerge %220 None 
                                                   OpBranchConditional %218 %219 %220 
                                          %219 = OpLabel 
                                                   OpKill
                                          %220 = OpLabel 
                                    f32_3 %225 = OpLoad vs_TEXCOORD3 
                                    f32_3 %226 = OpLoad vs_TEXCOORD3 
                                      f32 %227 = OpDot %225 %226 
                             Private f32* %228 = OpAccessChain %9 %24 
                                                   OpStore %228 %227 
                             Private f32* %229 = OpAccessChain %9 %24 
                                      f32 %230 = OpLoad %229 
                                      f32 %231 = OpExtInst %1 32 %230 
                             Private f32* %232 = OpAccessChain %9 %24 
                                                   OpStore %232 %231 
                                    f32_4 %233 = OpLoad %9 
                                    f32_3 %234 = OpVectorShuffle %233 %233 0 0 0 
                                    f32_3 %235 = OpLoad vs_TEXCOORD3 
                                    f32_3 %236 = OpVectorShuffle %235 %235 1 0 2 
                                    f32_3 %237 = OpFMul %234 %236 
                                    f32_4 %238 = OpLoad %9 
                                    f32_4 %239 = OpVectorShuffle %238 %237 4 5 6 3 
                                                   OpStore %9 %239 
                             Private f32* %240 = OpAccessChain %9 %158 
                                      f32 %241 = OpLoad %240 
                             Private f32* %242 = OpAccessChain %105 %24 
                                                   OpStore %242 %241 
                                    f32_3 %245 = OpLoad vs_TEXCOORD4 
                                    f32_3 %246 = OpLoad vs_TEXCOORD4 
                                      f32 %247 = OpDot %245 %246 
                                                   OpStore %243 %247 
                                      f32 %248 = OpLoad %243 
                                      f32 %249 = OpExtInst %1 32 %248 
                                                   OpStore %243 %249 
                                      f32 %252 = OpLoad %243 
                                    f32_3 %253 = OpCompositeConstruct %252 %252 %252 
                                    f32_3 %254 = OpLoad vs_TEXCOORD4 
                                    f32_3 %255 = OpFMul %253 %254 
                                                   OpStore %251 %255 
                             Private f32* %256 = OpAccessChain %251 %158 
                                      f32 %257 = OpLoad %256 
                             Private f32* %258 = OpAccessChain %105 %81 
                                                   OpStore %258 %257 
                                    f32_3 %260 = OpLoad vs_TEXCOORD2 
                                    f32_3 %261 = OpLoad vs_TEXCOORD2 
                                      f32 %262 = OpDot %260 %261 
                                                   OpStore %243 %262 
                                      f32 %263 = OpLoad %243 
                                      f32 %264 = OpExtInst %1 32 %263 
                                                   OpStore %243 %264 
                                      f32 %266 = OpLoad %243 
                                    f32_3 %267 = OpCompositeConstruct %266 %266 %266 
                                    f32_3 %268 = OpLoad vs_TEXCOORD2 
                                    f32_3 %269 = OpFMul %267 %268 
                                                   OpStore %265 %269 
                             Private f32* %270 = OpAccessChain %265 %158 
                                      f32 %271 = OpLoad %270 
                             Private f32* %272 = OpAccessChain %105 %158 
                                                   OpStore %272 %271 
                      read_only Texture2D %277 = OpLoad %276 
                                  sampler %281 = OpLoad %280 
               read_only Texture2DSampled %283 = OpSampledImage %277 %281 
                                    f32_2 %286 = OpLoad vs_TEXCOORD0 
                                    f32_4 %287 = OpImageSampleImplicitLod %283 %286 
                                    f32_3 %288 = OpVectorShuffle %287 %287 0 1 2 
                                                   OpStore %273 %288 
                                    f32_3 %290 = OpLoad %273 
                                    f32_3 %293 = OpFMul %290 %292 
                                    f32_3 %296 = OpFAdd %293 %295 
                                                   OpStore %289 %296 
                                    f32_3 %298 = OpLoad %289 
                                    f32_2 %299 = OpVectorShuffle %298 %298 0 1 
                             Uniform f32* %304 = OpAccessChain %302 %303 
                                      f32 %305 = OpLoad %304 
                             Uniform f32* %306 = OpAccessChain %302 %303 
                                      f32 %307 = OpLoad %306 
                                    f32_2 %308 = OpCompositeConstruct %305 %307 
                                      f32 %309 = OpCompositeExtract %308 0 
                                      f32 %310 = OpCompositeExtract %308 1 
                                    f32_2 %311 = OpCompositeConstruct %309 %310 
                                    f32_2 %312 = OpFMul %299 %311 
                                    f32_3 %313 = OpLoad %297 
                                    f32_3 %314 = OpVectorShuffle %313 %312 3 4 2 
                                                   OpStore %297 %314 
                                    f32_3 %316 = OpLoad %297 
                                    f32_2 %317 = OpVectorShuffle %316 %316 0 1 
                                    f32_3 %318 = OpLoad %315 
                                    f32_3 %319 = OpVectorShuffle %318 %317 3 4 2 
                                                   OpStore %315 %319 
                             Private f32* %320 = OpAccessChain %289 %158 
                                      f32 %321 = OpLoad %320 
                             Private f32* %322 = OpAccessChain %315 %158 
                                                   OpStore %322 %321 
                                    f32_3 %323 = OpLoad %315 
                                    f32_4 %324 = OpLoad %105 
                                    f32_3 %325 = OpVectorShuffle %324 %324 0 1 2 
                                      f32 %326 = OpDot %323 %325 
                             Private f32* %327 = OpAccessChain %105 %158 
                                                   OpStore %327 %326 
                             Private f32* %329 = OpAccessChain %9 %81 
                                      f32 %330 = OpLoad %329 
                             Private f32* %331 = OpAccessChain %328 %24 
                                                   OpStore %331 %330 
                             Private f32* %332 = OpAccessChain %251 %24 
                                      f32 %333 = OpLoad %332 
                             Private f32* %334 = OpAccessChain %328 %81 
                                                   OpStore %334 %333 
                             Private f32* %335 = OpAccessChain %251 %81 
                                      f32 %336 = OpLoad %335 
                             Private f32* %337 = OpAccessChain %9 %81 
                                                   OpStore %337 %336 
                             Private f32* %338 = OpAccessChain %265 %24 
                                      f32 %339 = OpLoad %338 
                             Private f32* %340 = OpAccessChain %328 %158 
                                                   OpStore %340 %339 
                             Private f32* %341 = OpAccessChain %265 %81 
                                      f32 %342 = OpLoad %341 
                             Private f32* %343 = OpAccessChain %9 %158 
                                                   OpStore %343 %342 
                             Private f32* %344 = OpAccessChain %315 %158 
                                      f32 %345 = OpLoad %344 
                             Private f32* %346 = OpAccessChain %297 %158 
                                                   OpStore %346 %345 
                                    f32_3 %347 = OpLoad %315 
                                    f32_4 %348 = OpLoad %9 
                                    f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
                                      f32 %350 = OpDot %347 %349 
                             Private f32* %351 = OpAccessChain %105 %81 
                                                   OpStore %351 %350 
                                    f32_3 %352 = OpLoad %297 
                                    f32_3 %353 = OpLoad %328 
                                      f32 %354 = OpDot %352 %353 
                             Private f32* %355 = OpAccessChain %105 %24 
                                                   OpStore %355 %354 
                                    f32_4 %356 = OpLoad %105 
                                    f32_3 %357 = OpVectorShuffle %356 %356 0 1 2 
                                    f32_4 %358 = OpLoad %105 
                                    f32_3 %359 = OpVectorShuffle %358 %358 0 1 2 
                                      f32 %360 = OpDot %357 %359 
                             Private f32* %361 = OpAccessChain %9 %24 
                                                   OpStore %361 %360 
                             Private f32* %362 = OpAccessChain %9 %24 
                                      f32 %363 = OpLoad %362 
                                      f32 %364 = OpExtInst %1 32 %363 
                             Private f32* %365 = OpAccessChain %9 %24 
                                                   OpStore %365 %364 
                                    f32_4 %366 = OpLoad %9 
                                    f32_3 %367 = OpVectorShuffle %366 %366 0 0 0 
                                    f32_4 %368 = OpLoad %105 
                                    f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                    f32_3 %370 = OpFMul %367 %369 
                                    f32_4 %371 = OpLoad %9 
                                    f32_4 %372 = OpVectorShuffle %371 %370 4 5 6 3 
                                                   OpStore %9 %372 
                             Uniform f32* %373 = OpAccessChain %15 %214 %38 %24 
                                      f32 %374 = OpLoad %373 
                             Private f32* %375 = OpAccessChain %105 %24 
                                                   OpStore %375 %374 
                             Uniform f32* %376 = OpAccessChain %15 %214 %214 %24 
                                      f32 %377 = OpLoad %376 
                             Private f32* %378 = OpAccessChain %105 %81 
                                                   OpStore %378 %377 
                             Uniform f32* %379 = OpAccessChain %15 %214 %17 %24 
                                      f32 %380 = OpLoad %379 
                             Private f32* %381 = OpAccessChain %105 %158 
                                                   OpStore %381 %380 
                                    f32_4 %382 = OpLoad %105 
                                    f32_3 %383 = OpVectorShuffle %382 %382 0 1 2 
                                    f32_4 %384 = OpLoad %9 
                                    f32_3 %385 = OpVectorShuffle %384 %384 0 1 2 
                                      f32 %386 = OpDot %383 %385 
                             Private f32* %387 = OpAccessChain %289 %24 
                                                   OpStore %387 %386 
                             Uniform f32* %388 = OpAccessChain %15 %214 %38 %81 
                                      f32 %389 = OpLoad %388 
                             Private f32* %390 = OpAccessChain %105 %24 
                                                   OpStore %390 %389 
                             Uniform f32* %391 = OpAccessChain %15 %214 %214 %81 
                                      f32 %392 = OpLoad %391 
                             Private f32* %393 = OpAccessChain %105 %81 
                                                   OpStore %393 %392 
                             Uniform f32* %394 = OpAccessChain %15 %214 %17 %81 
                                      f32 %395 = OpLoad %394 
                             Private f32* %396 = OpAccessChain %105 %158 
                                                   OpStore %396 %395 
                                    f32_4 %397 = OpLoad %105 
                                    f32_3 %398 = OpVectorShuffle %397 %397 0 1 2 
                                    f32_4 %399 = OpLoad %9 
                                    f32_3 %400 = OpVectorShuffle %399 %399 0 1 2 
                                      f32 %401 = OpDot %398 %400 
                             Private f32* %402 = OpAccessChain %289 %81 
                                                   OpStore %402 %401 
                                    f32_3 %403 = OpLoad %289 
                                    f32_2 %404 = OpVectorShuffle %403 %403 0 1 
                                    f32_2 %407 = OpFMul %404 %406 
                                    f32_2 %408 = OpFAdd %407 %406 
                                    f32_3 %409 = OpLoad %289 
                                    f32_3 %410 = OpVectorShuffle %409 %408 3 4 2 
                                                   OpStore %289 %410 
                      read_only Texture2D %413 = OpLoad %412 
                                  sampler %415 = OpLoad %414 
               read_only Texture2DSampled %416 = OpSampledImage %413 %415 
                                    f32_3 %417 = OpLoad %289 
                                    f32_2 %418 = OpVectorShuffle %417 %417 0 1 
                                    f32_4 %419 = OpImageSampleImplicitLod %416 %418 
                                                   OpStore %411 %419 
                                    f32_4 %420 = OpLoad %411 
                                    f32_3 %421 = OpVectorShuffle %420 %420 0 1 2 
                           Uniform f32_4* %422 = OpAccessChain %302 %214 
                                    f32_4 %423 = OpLoad %422 
                                    f32_3 %424 = OpVectorShuffle %423 %423 0 1 2 
                                    f32_3 %425 = OpFMul %421 %424 
                                    f32_4 %426 = OpLoad %9 
                                    f32_4 %427 = OpVectorShuffle %426 %425 4 5 6 3 
                                                   OpStore %9 %427 
                                    f32_4 %428 = OpLoad %411 
                                    f32_3 %429 = OpVectorShuffle %428 %428 3 3 3 
                             Uniform f32* %430 = OpAccessChain %302 %17 
                                      f32 %431 = OpLoad %430 
                                    f32_3 %432 = OpCompositeConstruct %431 %431 %431 
                                    f32_3 %433 = OpFMul %429 %432 
                                    f32_4 %434 = OpLoad %9 
                                    f32_3 %435 = OpVectorShuffle %434 %434 0 1 2 
                                    f32_3 %436 = OpFNegate %435 
                                    f32_3 %437 = OpFAdd %433 %436 
                                                   OpStore %289 %437 
                      read_only Texture2D %440 = OpLoad %439 
                                  sampler %442 = OpLoad %441 
               read_only Texture2DSampled %443 = OpSampledImage %440 %442 
                                    f32_2 %444 = OpLoad vs_TEXCOORD0 
                                    f32_4 %445 = OpImageSampleImplicitLod %443 %444 
                                                   OpStore %438 %445 
                                    f32_4 %446 = OpLoad %438 
                                    f32_3 %447 = OpVectorShuffle %446 %446 3 3 3 
                                    f32_3 %448 = OpLoad %289 
                                    f32_3 %449 = OpFMul %447 %448 
                                    f32_4 %450 = OpLoad %9 
                                    f32_3 %451 = OpVectorShuffle %450 %450 0 1 2 
                                    f32_3 %452 = OpFAdd %449 %451 
                                                   OpStore %289 %452 
                                    f32_4 %453 = OpLoad %438 
                                    f32_3 %454 = OpVectorShuffle %453 %453 0 1 2 
                           Uniform f32_4* %455 = OpAccessChain %302 %38 
                                    f32_4 %456 = OpLoad %455 
                                    f32_3 %457 = OpVectorShuffle %456 %456 0 1 2 
                                    f32_3 %458 = OpFMul %454 %457 
                                    f32_4 %459 = OpLoad %9 
                                    f32_4 %460 = OpVectorShuffle %459 %458 4 5 6 3 
                                                   OpStore %9 %460 
                                    f32_3 %463 = OpLoad %289 
                                    f32_4 %464 = OpLoad %9 
                                    f32_3 %465 = OpVectorShuffle %464 %464 0 1 2 
                                    f32_3 %466 = OpFMul %463 %465 
                                    f32_4 %467 = OpLoad %462 
                                    f32_4 %468 = OpVectorShuffle %467 %466 4 5 6 3 
                                                   OpStore %462 %468 
                              Output f32* %470 = OpAccessChain %462 %173 
                                                   OpStore %470 %22 
                                                   OpReturn
                                                   OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _CharacterAlpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _MainColor;
	UNITY_UNIFORM vec4 _MatColor;
	UNITY_UNIFORM float _MatnormalIntenstiy;
	UNITY_UNIFORM float _NormalIntensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MatCap;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _Normal;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec2 u_xlat8;
uvec2 u_xlatu8;
float u_xlat24;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.xy = u_xlat8.xy * _ScreenParams.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat8.xyxx, (-u_xlat8.xyxx)).xy;
    u_xlat8.xy = fract(abs(u_xlat8.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat8;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat8.x : (-u_xlat8.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat8.y : (-u_xlat8.y);
        u_xlat8 = hlslcc_movcTemp;
    }
    u_xlat8.xy = u_xlat8.xy * vec2(4.0, 4.0);
    u_xlatu8.xy = uvec2(u_xlat8.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu8.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu8.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.yxz;
    u_xlat1.x = u_xlat0.z;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat1.y = u_xlat2.z;
    u_xlat24 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * vs_TEXCOORD2.xyz;
    u_xlat1.z = u_xlat3.z;
    u_xlat16_4.xyz = texture(_Normal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xy = u_xlat16_5.xy * vec2(vec2(_NormalIntensity, _NormalIntensity));
    u_xlat6.xy = u_xlat4.xy;
    u_xlat6.z = u_xlat16_5.z;
    u_xlat1.z = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat7.x = u_xlat0.y;
    u_xlat7.y = u_xlat2.x;
    u_xlat0.y = u_xlat2.y;
    u_xlat7.z = u_xlat3.x;
    u_xlat0.z = u_xlat3.y;
    u_xlat4.z = u_xlat6.z;
    u_xlat1.y = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat7.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MatCap, u_xlat16_5.xy);
    u_xlat0.xyz = u_xlat16_0.xyz * _MatColor.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * vec3(_MatnormalIntenstiy) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_1.www * u_xlat16_5.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "vulkan " {
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
}
}
 Pass {
  Tags { "LIGHTMODE" = "LightweightForward" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  ColorMask 0 0
  ZTest Always
  Stencil {
   Comp Equal
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 102386
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 223
; Schema: 0
                                      OpCapability Shader 
                               %1 = OpExtInstImport "GLSL.std.450" 
                                      OpMemoryModel Logical GLSL450 
                                      OpEntryPoint Fragment %4 "main" %29 %221 
                                      OpExecutionMode %4 OriginUpperLeft 
                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                      OpMemberDecorate %10 0 Offset 10 
                                      OpMemberDecorate %10 1 Offset 10 
                                      OpDecorate %10 Block 
                                      OpDecorate %12 DescriptorSet 12 
                                      OpDecorate %12 Binding 12 
                                      OpDecorate vs_TEXCOORD5 Location 29 
                                      OpDecorate %221 RelaxedPrecision 
                                      OpDecorate %221 Location 221 
                               %2 = OpTypeVoid 
                               %3 = OpTypeFunction %2 
                               %6 = OpTypeFloat 32 
                               %7 = OpTypeVector %6 4 
                               %8 = OpTypePointer Private %7 
                Private f32_4* %9 = OpVariable Private 
                              %10 = OpTypeStruct %7 %6 
                              %11 = OpTypePointer Uniform %10 
Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                              %13 = OpTypeInt 32 1 
                          i32 %14 = OpConstant 1 
                              %15 = OpTypePointer Uniform %6 
                          f32 %19 = OpConstant 3.674022E-40 
                              %21 = OpTypeInt 32 0 
                          u32 %22 = OpConstant 0 
                              %23 = OpTypePointer Private %6 
                              %25 = OpTypeVector %6 2 
                              %26 = OpTypePointer Private %25 
               Private f32_2* %27 = OpVariable Private 
                              %28 = OpTypePointer Input %7 
        Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                          i32 %36 = OpConstant 0 
                              %37 = OpTypePointer Uniform %7 
                          f32 %43 = OpConstant 3.674022E-40 
                        f32_2 %44 = OpConstantComposite %43 %43 
                              %46 = OpTypeBool 
                              %47 = OpTypeVector %46 2 
                              %48 = OpTypePointer Private %47 
              Private bool_2* %49 = OpVariable Private 
                              %55 = OpTypeVector %46 4 
                              %61 = OpTypePointer Function %25 
                              %64 = OpTypePointer Private %46 
                              %67 = OpTypePointer Function %6 
                          u32 %79 = OpConstant 1 
                          f32 %95 = OpConstant 3.674022E-40 
                        f32_2 %96 = OpConstantComposite %95 %95 
                              %98 = OpTypeVector %21 2 
                              %99 = OpTypePointer Private %98 
              Private u32_2* %100 = OpVariable Private 
              Private f32_4* %103 = OpVariable Private 
                         f32 %104 = OpConstant 3.674022E-40 
                         f32 %105 = OpConstant 3.674022E-40 
                         f32 %106 = OpConstant 3.674022E-40 
                         f32 %107 = OpConstant 3.674022E-40 
                       f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                             %109 = OpTypeVector %21 4 
                         u32 %110 = OpConstant 4 
                             %111 = OpTypeArray %109 %110 
                         u32 %112 = OpConstant 1065353216 
                       u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                       u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                       u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                       u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                    u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                             %118 = OpTypePointer Private %21 
                             %122 = OpTypePointer Function %111 
                             %124 = OpTypePointer Function %109 
                         f32 %130 = OpConstant 3.674022E-40 
                         f32 %131 = OpConstant 3.674022E-40 
                         f32 %132 = OpConstant 3.674022E-40 
                         f32 %133 = OpConstant 3.674022E-40 
                       f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                         f32 %144 = OpConstant 3.674022E-40 
                         f32 %145 = OpConstant 3.674022E-40 
                         f32 %146 = OpConstant 3.674022E-40 
                         f32 %147 = OpConstant 3.674022E-40 
                       f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                         u32 %157 = OpConstant 2 
                         f32 %159 = OpConstant 3.674022E-40 
                         f32 %160 = OpConstant 3.674022E-40 
                         f32 %161 = OpConstant 3.674022E-40 
                         f32 %162 = OpConstant 3.674022E-40 
                       f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                         u32 %172 = OpConstant 3 
                             %187 = OpTypePointer Private %55 
             Private bool_4* %188 = OpVariable Private 
                         f32 %190 = OpConstant 3.674022E-40 
                       f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                         i32 %214 = OpConstant -1 
                             %220 = OpTypePointer Output %7 
               Output f32_4* %221 = OpVariable Output 
                          void %4 = OpFunction None %3 
                               %5 = OpLabel 
              Function f32_2* %62 = OpVariable Function 
                Function f32* %68 = OpVariable Function 
                Function f32* %82 = OpVariable Function 
          Function u32_4[4]* %123 = OpVariable Function 
          Function u32_4[4]* %138 = OpVariable Function 
          Function u32_4[4]* %152 = OpVariable Function 
          Function u32_4[4]* %167 = OpVariable Function 
          Function u32_4[4]* %179 = OpVariable Function 
                 Uniform f32* %16 = OpAccessChain %12 %14 
                          f32 %17 = OpLoad %16 
                          f32 %18 = OpFNegate %17 
                          f32 %20 = OpFAdd %18 %19 
                 Private f32* %24 = OpAccessChain %9 %22 
                                      OpStore %24 %20 
                        f32_4 %30 = OpLoad vs_TEXCOORD5 
                        f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                        f32_4 %32 = OpLoad vs_TEXCOORD5 
                        f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                        f32_2 %34 = OpFDiv %31 %33 
                                      OpStore %27 %34 
                        f32_2 %35 = OpLoad %27 
               Uniform f32_4* %38 = OpAccessChain %12 %36 
                        f32_4 %39 = OpLoad %38 
                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                        f32_2 %41 = OpFMul %35 %40 
                                      OpStore %27 %41 
                        f32_2 %42 = OpLoad %27 
                        f32_2 %45 = OpFMul %42 %44 
                                      OpStore %27 %45 
                        f32_2 %50 = OpLoad %27 
                        f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                        f32_2 %52 = OpLoad %27 
                        f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                        f32_4 %54 = OpFNegate %53 
                       bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                       bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                      OpStore %49 %57 
                        f32_2 %58 = OpLoad %27 
                        f32_2 %59 = OpExtInst %1 4 %58 
                        f32_2 %60 = OpExtInst %1 10 %59 
                                      OpStore %27 %60 
                        f32_2 %63 = OpLoad %27 
                                      OpStore %62 %63 
                Private bool* %65 = OpAccessChain %49 %22 
                         bool %66 = OpLoad %65 
                                      OpSelectionMerge %70 None 
                                      OpBranchConditional %66 %69 %73 
                              %69 = OpLabel 
                 Private f32* %71 = OpAccessChain %27 %22 
                          f32 %72 = OpLoad %71 
                                      OpStore %68 %72 
                                      OpBranch %70 
                              %73 = OpLabel 
                 Private f32* %74 = OpAccessChain %27 %22 
                          f32 %75 = OpLoad %74 
                          f32 %76 = OpFNegate %75 
                                      OpStore %68 %76 
                                      OpBranch %70 
                              %70 = OpLabel 
                          f32 %77 = OpLoad %68 
                Function f32* %78 = OpAccessChain %62 %22 
                                      OpStore %78 %77 
                Private bool* %80 = OpAccessChain %49 %79 
                         bool %81 = OpLoad %80 
                                      OpSelectionMerge %84 None 
                                      OpBranchConditional %81 %83 %87 
                              %83 = OpLabel 
                 Private f32* %85 = OpAccessChain %27 %79 
                          f32 %86 = OpLoad %85 
                                      OpStore %82 %86 
                                      OpBranch %84 
                              %87 = OpLabel 
                 Private f32* %88 = OpAccessChain %27 %79 
                          f32 %89 = OpLoad %88 
                          f32 %90 = OpFNegate %89 
                                      OpStore %82 %90 
                                      OpBranch %84 
                              %84 = OpLabel 
                          f32 %91 = OpLoad %82 
                Function f32* %92 = OpAccessChain %62 %79 
                                      OpStore %92 %91 
                        f32_2 %93 = OpLoad %62 
                                      OpStore %27 %93 
                        f32_2 %94 = OpLoad %27 
                        f32_2 %97 = OpFMul %94 %96 
                                      OpStore %27 %97 
                       f32_2 %101 = OpLoad %27 
                       u32_2 %102 = OpConvertFToU %101 
                                      OpStore %100 %102 
                Private u32* %119 = OpAccessChain %100 %22 
                         u32 %120 = OpLoad %119 
                         i32 %121 = OpBitcast %120 
                                      OpStore %123 %117 
             Function u32_4* %125 = OpAccessChain %123 %121 
                       u32_4 %126 = OpLoad %125 
                       f32_4 %127 = OpBitcast %126 
                         f32 %128 = OpDot %108 %127 
                Private f32* %129 = OpAccessChain %103 %22 
                                      OpStore %129 %128 
                Private u32* %135 = OpAccessChain %100 %22 
                         u32 %136 = OpLoad %135 
                         i32 %137 = OpBitcast %136 
                                      OpStore %138 %117 
             Function u32_4* %139 = OpAccessChain %138 %137 
                       u32_4 %140 = OpLoad %139 
                       f32_4 %141 = OpBitcast %140 
                         f32 %142 = OpDot %134 %141 
                Private f32* %143 = OpAccessChain %103 %79 
                                      OpStore %143 %142 
                Private u32* %149 = OpAccessChain %100 %22 
                         u32 %150 = OpLoad %149 
                         i32 %151 = OpBitcast %150 
                                      OpStore %152 %117 
             Function u32_4* %153 = OpAccessChain %152 %151 
                       u32_4 %154 = OpLoad %153 
                       f32_4 %155 = OpBitcast %154 
                         f32 %156 = OpDot %148 %155 
                Private f32* %158 = OpAccessChain %103 %157 
                                      OpStore %158 %156 
                Private u32* %164 = OpAccessChain %100 %22 
                         u32 %165 = OpLoad %164 
                         i32 %166 = OpBitcast %165 
                                      OpStore %167 %117 
             Function u32_4* %168 = OpAccessChain %167 %166 
                       u32_4 %169 = OpLoad %168 
                       f32_4 %170 = OpBitcast %169 
                         f32 %171 = OpDot %163 %170 
                Private f32* %173 = OpAccessChain %103 %172 
                                      OpStore %173 %171 
                       f32_4 %174 = OpLoad %103 
                       f32_4 %175 = OpFNegate %174 
                Private u32* %176 = OpAccessChain %100 %79 
                         u32 %177 = OpLoad %176 
                         i32 %178 = OpBitcast %177 
                                      OpStore %179 %117 
             Function u32_4* %180 = OpAccessChain %179 %178 
                       u32_4 %181 = OpLoad %180 
                       f32_4 %182 = OpBitcast %181 
                       f32_4 %183 = OpFMul %175 %182 
                       f32_4 %184 = OpLoad %9 
                       f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                       f32_4 %186 = OpFAdd %183 %185 
                                      OpStore %9 %186 
                       f32_4 %189 = OpLoad %9 
                      bool_4 %192 = OpFOrdLessThan %189 %191 
                                      OpStore %188 %192 
               Private bool* %193 = OpAccessChain %188 %157 
                        bool %194 = OpLoad %193 
               Private bool* %195 = OpAccessChain %188 %22 
                        bool %196 = OpLoad %195 
                        bool %197 = OpLogicalOr %194 %196 
               Private bool* %198 = OpAccessChain %188 %22 
                                      OpStore %198 %197 
               Private bool* %199 = OpAccessChain %188 %172 
                        bool %200 = OpLoad %199 
               Private bool* %201 = OpAccessChain %188 %79 
                        bool %202 = OpLoad %201 
                        bool %203 = OpLogicalOr %200 %202 
               Private bool* %204 = OpAccessChain %188 %79 
                                      OpStore %204 %203 
               Private bool* %205 = OpAccessChain %188 %79 
                        bool %206 = OpLoad %205 
               Private bool* %207 = OpAccessChain %188 %22 
                        bool %208 = OpLoad %207 
                        bool %209 = OpLogicalOr %206 %208 
               Private bool* %210 = OpAccessChain %188 %22 
                                      OpStore %210 %209 
               Private bool* %211 = OpAccessChain %188 %22 
                        bool %212 = OpLoad %211 
                         i32 %213 = OpSelect %212 %14 %36 
                         i32 %215 = OpIMul %213 %214 
                        bool %216 = OpINotEqual %215 %36 
                                      OpSelectionMerge %218 None 
                                      OpBranchConditional %216 %217 %218 
                             %217 = OpLabel 
                                      OpKill
                             %218 = OpLabel 
                                      OpStore %221 %191 
                                      OpReturn
                                      OpFunctionEnd
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 223
; Schema: 0
                                      OpCapability Shader 
                               %1 = OpExtInstImport "GLSL.std.450" 
                                      OpMemoryModel Logical GLSL450 
                                      OpEntryPoint Fragment %4 "main" %29 %221 
                                      OpExecutionMode %4 OriginUpperLeft 
                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                      OpMemberDecorate %10 0 Offset 10 
                                      OpMemberDecorate %10 1 Offset 10 
                                      OpDecorate %10 Block 
                                      OpDecorate %12 DescriptorSet 12 
                                      OpDecorate %12 Binding 12 
                                      OpDecorate vs_TEXCOORD5 Location 29 
                                      OpDecorate %221 RelaxedPrecision 
                                      OpDecorate %221 Location 221 
                               %2 = OpTypeVoid 
                               %3 = OpTypeFunction %2 
                               %6 = OpTypeFloat 32 
                               %7 = OpTypeVector %6 4 
                               %8 = OpTypePointer Private %7 
                Private f32_4* %9 = OpVariable Private 
                              %10 = OpTypeStruct %7 %6 
                              %11 = OpTypePointer Uniform %10 
Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                              %13 = OpTypeInt 32 1 
                          i32 %14 = OpConstant 1 
                              %15 = OpTypePointer Uniform %6 
                          f32 %19 = OpConstant 3.674022E-40 
                              %21 = OpTypeInt 32 0 
                          u32 %22 = OpConstant 0 
                              %23 = OpTypePointer Private %6 
                              %25 = OpTypeVector %6 2 
                              %26 = OpTypePointer Private %25 
               Private f32_2* %27 = OpVariable Private 
                              %28 = OpTypePointer Input %7 
        Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                          i32 %36 = OpConstant 0 
                              %37 = OpTypePointer Uniform %7 
                          f32 %43 = OpConstant 3.674022E-40 
                        f32_2 %44 = OpConstantComposite %43 %43 
                              %46 = OpTypeBool 
                              %47 = OpTypeVector %46 2 
                              %48 = OpTypePointer Private %47 
              Private bool_2* %49 = OpVariable Private 
                              %55 = OpTypeVector %46 4 
                              %61 = OpTypePointer Function %25 
                              %64 = OpTypePointer Private %46 
                              %67 = OpTypePointer Function %6 
                          u32 %79 = OpConstant 1 
                          f32 %95 = OpConstant 3.674022E-40 
                        f32_2 %96 = OpConstantComposite %95 %95 
                              %98 = OpTypeVector %21 2 
                              %99 = OpTypePointer Private %98 
              Private u32_2* %100 = OpVariable Private 
              Private f32_4* %103 = OpVariable Private 
                         f32 %104 = OpConstant 3.674022E-40 
                         f32 %105 = OpConstant 3.674022E-40 
                         f32 %106 = OpConstant 3.674022E-40 
                         f32 %107 = OpConstant 3.674022E-40 
                       f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                             %109 = OpTypeVector %21 4 
                         u32 %110 = OpConstant 4 
                             %111 = OpTypeArray %109 %110 
                         u32 %112 = OpConstant 1065353216 
                       u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                       u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                       u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                       u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                    u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                             %118 = OpTypePointer Private %21 
                             %122 = OpTypePointer Function %111 
                             %124 = OpTypePointer Function %109 
                         f32 %130 = OpConstant 3.674022E-40 
                         f32 %131 = OpConstant 3.674022E-40 
                         f32 %132 = OpConstant 3.674022E-40 
                         f32 %133 = OpConstant 3.674022E-40 
                       f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                         f32 %144 = OpConstant 3.674022E-40 
                         f32 %145 = OpConstant 3.674022E-40 
                         f32 %146 = OpConstant 3.674022E-40 
                         f32 %147 = OpConstant 3.674022E-40 
                       f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                         u32 %157 = OpConstant 2 
                         f32 %159 = OpConstant 3.674022E-40 
                         f32 %160 = OpConstant 3.674022E-40 
                         f32 %161 = OpConstant 3.674022E-40 
                         f32 %162 = OpConstant 3.674022E-40 
                       f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                         u32 %172 = OpConstant 3 
                             %187 = OpTypePointer Private %55 
             Private bool_4* %188 = OpVariable Private 
                         f32 %190 = OpConstant 3.674022E-40 
                       f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                         i32 %214 = OpConstant -1 
                             %220 = OpTypePointer Output %7 
               Output f32_4* %221 = OpVariable Output 
                          void %4 = OpFunction None %3 
                               %5 = OpLabel 
              Function f32_2* %62 = OpVariable Function 
                Function f32* %68 = OpVariable Function 
                Function f32* %82 = OpVariable Function 
          Function u32_4[4]* %123 = OpVariable Function 
          Function u32_4[4]* %138 = OpVariable Function 
          Function u32_4[4]* %152 = OpVariable Function 
          Function u32_4[4]* %167 = OpVariable Function 
          Function u32_4[4]* %179 = OpVariable Function 
                 Uniform f32* %16 = OpAccessChain %12 %14 
                          f32 %17 = OpLoad %16 
                          f32 %18 = OpFNegate %17 
                          f32 %20 = OpFAdd %18 %19 
                 Private f32* %24 = OpAccessChain %9 %22 
                                      OpStore %24 %20 
                        f32_4 %30 = OpLoad vs_TEXCOORD5 
                        f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                        f32_4 %32 = OpLoad vs_TEXCOORD5 
                        f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                        f32_2 %34 = OpFDiv %31 %33 
                                      OpStore %27 %34 
                        f32_2 %35 = OpLoad %27 
               Uniform f32_4* %38 = OpAccessChain %12 %36 
                        f32_4 %39 = OpLoad %38 
                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                        f32_2 %41 = OpFMul %35 %40 
                                      OpStore %27 %41 
                        f32_2 %42 = OpLoad %27 
                        f32_2 %45 = OpFMul %42 %44 
                                      OpStore %27 %45 
                        f32_2 %50 = OpLoad %27 
                        f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                        f32_2 %52 = OpLoad %27 
                        f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                        f32_4 %54 = OpFNegate %53 
                       bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                       bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                      OpStore %49 %57 
                        f32_2 %58 = OpLoad %27 
                        f32_2 %59 = OpExtInst %1 4 %58 
                        f32_2 %60 = OpExtInst %1 10 %59 
                                      OpStore %27 %60 
                        f32_2 %63 = OpLoad %27 
                                      OpStore %62 %63 
                Private bool* %65 = OpAccessChain %49 %22 
                         bool %66 = OpLoad %65 
                                      OpSelectionMerge %70 None 
                                      OpBranchConditional %66 %69 %73 
                              %69 = OpLabel 
                 Private f32* %71 = OpAccessChain %27 %22 
                          f32 %72 = OpLoad %71 
                                      OpStore %68 %72 
                                      OpBranch %70 
                              %73 = OpLabel 
                 Private f32* %74 = OpAccessChain %27 %22 
                          f32 %75 = OpLoad %74 
                          f32 %76 = OpFNegate %75 
                                      OpStore %68 %76 
                                      OpBranch %70 
                              %70 = OpLabel 
                          f32 %77 = OpLoad %68 
                Function f32* %78 = OpAccessChain %62 %22 
                                      OpStore %78 %77 
                Private bool* %80 = OpAccessChain %49 %79 
                         bool %81 = OpLoad %80 
                                      OpSelectionMerge %84 None 
                                      OpBranchConditional %81 %83 %87 
                              %83 = OpLabel 
                 Private f32* %85 = OpAccessChain %27 %79 
                          f32 %86 = OpLoad %85 
                                      OpStore %82 %86 
                                      OpBranch %84 
                              %87 = OpLabel 
                 Private f32* %88 = OpAccessChain %27 %79 
                          f32 %89 = OpLoad %88 
                          f32 %90 = OpFNegate %89 
                                      OpStore %82 %90 
                                      OpBranch %84 
                              %84 = OpLabel 
                          f32 %91 = OpLoad %82 
                Function f32* %92 = OpAccessChain %62 %79 
                                      OpStore %92 %91 
                        f32_2 %93 = OpLoad %62 
                                      OpStore %27 %93 
                        f32_2 %94 = OpLoad %27 
                        f32_2 %97 = OpFMul %94 %96 
                                      OpStore %27 %97 
                       f32_2 %101 = OpLoad %27 
                       u32_2 %102 = OpConvertFToU %101 
                                      OpStore %100 %102 
                Private u32* %119 = OpAccessChain %100 %22 
                         u32 %120 = OpLoad %119 
                         i32 %121 = OpBitcast %120 
                                      OpStore %123 %117 
             Function u32_4* %125 = OpAccessChain %123 %121 
                       u32_4 %126 = OpLoad %125 
                       f32_4 %127 = OpBitcast %126 
                         f32 %128 = OpDot %108 %127 
                Private f32* %129 = OpAccessChain %103 %22 
                                      OpStore %129 %128 
                Private u32* %135 = OpAccessChain %100 %22 
                         u32 %136 = OpLoad %135 
                         i32 %137 = OpBitcast %136 
                                      OpStore %138 %117 
             Function u32_4* %139 = OpAccessChain %138 %137 
                       u32_4 %140 = OpLoad %139 
                       f32_4 %141 = OpBitcast %140 
                         f32 %142 = OpDot %134 %141 
                Private f32* %143 = OpAccessChain %103 %79 
                                      OpStore %143 %142 
                Private u32* %149 = OpAccessChain %100 %22 
                         u32 %150 = OpLoad %149 
                         i32 %151 = OpBitcast %150 
                                      OpStore %152 %117 
             Function u32_4* %153 = OpAccessChain %152 %151 
                       u32_4 %154 = OpLoad %153 
                       f32_4 %155 = OpBitcast %154 
                         f32 %156 = OpDot %148 %155 
                Private f32* %158 = OpAccessChain %103 %157 
                                      OpStore %158 %156 
                Private u32* %164 = OpAccessChain %100 %22 
                         u32 %165 = OpLoad %164 
                         i32 %166 = OpBitcast %165 
                                      OpStore %167 %117 
             Function u32_4* %168 = OpAccessChain %167 %166 
                       u32_4 %169 = OpLoad %168 
                       f32_4 %170 = OpBitcast %169 
                         f32 %171 = OpDot %163 %170 
                Private f32* %173 = OpAccessChain %103 %172 
                                      OpStore %173 %171 
                       f32_4 %174 = OpLoad %103 
                       f32_4 %175 = OpFNegate %174 
                Private u32* %176 = OpAccessChain %100 %79 
                         u32 %177 = OpLoad %176 
                         i32 %178 = OpBitcast %177 
                                      OpStore %179 %117 
             Function u32_4* %180 = OpAccessChain %179 %178 
                       u32_4 %181 = OpLoad %180 
                       f32_4 %182 = OpBitcast %181 
                       f32_4 %183 = OpFMul %175 %182 
                       f32_4 %184 = OpLoad %9 
                       f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                       f32_4 %186 = OpFAdd %183 %185 
                                      OpStore %9 %186 
                       f32_4 %189 = OpLoad %9 
                      bool_4 %192 = OpFOrdLessThan %189 %191 
                                      OpStore %188 %192 
               Private bool* %193 = OpAccessChain %188 %157 
                        bool %194 = OpLoad %193 
               Private bool* %195 = OpAccessChain %188 %22 
                        bool %196 = OpLoad %195 
                        bool %197 = OpLogicalOr %194 %196 
               Private bool* %198 = OpAccessChain %188 %22 
                                      OpStore %198 %197 
               Private bool* %199 = OpAccessChain %188 %172 
                        bool %200 = OpLoad %199 
               Private bool* %201 = OpAccessChain %188 %79 
                        bool %202 = OpLoad %201 
                        bool %203 = OpLogicalOr %200 %202 
               Private bool* %204 = OpAccessChain %188 %79 
                                      OpStore %204 %203 
               Private bool* %205 = OpAccessChain %188 %79 
                        bool %206 = OpLoad %205 
               Private bool* %207 = OpAccessChain %188 %22 
                        bool %208 = OpLoad %207 
                        bool %209 = OpLogicalOr %206 %208 
               Private bool* %210 = OpAccessChain %188 %22 
                                      OpStore %210 %209 
               Private bool* %211 = OpAccessChain %188 %22 
                        bool %212 = OpLoad %211 
                         i32 %213 = OpSelect %212 %14 %36 
                         i32 %215 = OpIMul %213 %214 
                        bool %216 = OpINotEqual %215 %36 
                                      OpSelectionMerge %218 None 
                                      OpBranchConditional %216 %217 %218 
                             %217 = OpLabel 
                                      OpKill
                             %218 = OpLabel 
                                      OpStore %221 %191 
                                      OpReturn
                                      OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 223
; Schema: 0
                                      OpCapability Shader 
                               %1 = OpExtInstImport "GLSL.std.450" 
                                      OpMemoryModel Logical GLSL450 
                                      OpEntryPoint Fragment %4 "main" %29 %221 
                                      OpExecutionMode %4 OriginUpperLeft 
                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                      OpMemberDecorate %10 0 Offset 10 
                                      OpMemberDecorate %10 1 Offset 10 
                                      OpDecorate %10 Block 
                                      OpDecorate %12 DescriptorSet 12 
                                      OpDecorate %12 Binding 12 
                                      OpDecorate vs_TEXCOORD5 Location 29 
                                      OpDecorate %221 RelaxedPrecision 
                                      OpDecorate %221 Location 221 
                               %2 = OpTypeVoid 
                               %3 = OpTypeFunction %2 
                               %6 = OpTypeFloat 32 
                               %7 = OpTypeVector %6 4 
                               %8 = OpTypePointer Private %7 
                Private f32_4* %9 = OpVariable Private 
                              %10 = OpTypeStruct %7 %6 
                              %11 = OpTypePointer Uniform %10 
Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                              %13 = OpTypeInt 32 1 
                          i32 %14 = OpConstant 1 
                              %15 = OpTypePointer Uniform %6 
                          f32 %19 = OpConstant 3.674022E-40 
                              %21 = OpTypeInt 32 0 
                          u32 %22 = OpConstant 0 
                              %23 = OpTypePointer Private %6 
                              %25 = OpTypeVector %6 2 
                              %26 = OpTypePointer Private %25 
               Private f32_2* %27 = OpVariable Private 
                              %28 = OpTypePointer Input %7 
        Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                          i32 %36 = OpConstant 0 
                              %37 = OpTypePointer Uniform %7 
                          f32 %43 = OpConstant 3.674022E-40 
                        f32_2 %44 = OpConstantComposite %43 %43 
                              %46 = OpTypeBool 
                              %47 = OpTypeVector %46 2 
                              %48 = OpTypePointer Private %47 
              Private bool_2* %49 = OpVariable Private 
                              %55 = OpTypeVector %46 4 
                              %61 = OpTypePointer Function %25 
                              %64 = OpTypePointer Private %46 
                              %67 = OpTypePointer Function %6 
                          u32 %79 = OpConstant 1 
                          f32 %95 = OpConstant 3.674022E-40 
                        f32_2 %96 = OpConstantComposite %95 %95 
                              %98 = OpTypeVector %21 2 
                              %99 = OpTypePointer Private %98 
              Private u32_2* %100 = OpVariable Private 
              Private f32_4* %103 = OpVariable Private 
                         f32 %104 = OpConstant 3.674022E-40 
                         f32 %105 = OpConstant 3.674022E-40 
                         f32 %106 = OpConstant 3.674022E-40 
                         f32 %107 = OpConstant 3.674022E-40 
                       f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                             %109 = OpTypeVector %21 4 
                         u32 %110 = OpConstant 4 
                             %111 = OpTypeArray %109 %110 
                         u32 %112 = OpConstant 1065353216 
                       u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                       u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                       u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                       u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                    u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                             %118 = OpTypePointer Private %21 
                             %122 = OpTypePointer Function %111 
                             %124 = OpTypePointer Function %109 
                         f32 %130 = OpConstant 3.674022E-40 
                         f32 %131 = OpConstant 3.674022E-40 
                         f32 %132 = OpConstant 3.674022E-40 
                         f32 %133 = OpConstant 3.674022E-40 
                       f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                         f32 %144 = OpConstant 3.674022E-40 
                         f32 %145 = OpConstant 3.674022E-40 
                         f32 %146 = OpConstant 3.674022E-40 
                         f32 %147 = OpConstant 3.674022E-40 
                       f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                         u32 %157 = OpConstant 2 
                         f32 %159 = OpConstant 3.674022E-40 
                         f32 %160 = OpConstant 3.674022E-40 
                         f32 %161 = OpConstant 3.674022E-40 
                         f32 %162 = OpConstant 3.674022E-40 
                       f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                         u32 %172 = OpConstant 3 
                             %187 = OpTypePointer Private %55 
             Private bool_4* %188 = OpVariable Private 
                         f32 %190 = OpConstant 3.674022E-40 
                       f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                         i32 %214 = OpConstant -1 
                             %220 = OpTypePointer Output %7 
               Output f32_4* %221 = OpVariable Output 
                          void %4 = OpFunction None %3 
                               %5 = OpLabel 
              Function f32_2* %62 = OpVariable Function 
                Function f32* %68 = OpVariable Function 
                Function f32* %82 = OpVariable Function 
          Function u32_4[4]* %123 = OpVariable Function 
          Function u32_4[4]* %138 = OpVariable Function 
          Function u32_4[4]* %152 = OpVariable Function 
          Function u32_4[4]* %167 = OpVariable Function 
          Function u32_4[4]* %179 = OpVariable Function 
                 Uniform f32* %16 = OpAccessChain %12 %14 
                          f32 %17 = OpLoad %16 
                          f32 %18 = OpFNegate %17 
                          f32 %20 = OpFAdd %18 %19 
                 Private f32* %24 = OpAccessChain %9 %22 
                                      OpStore %24 %20 
                        f32_4 %30 = OpLoad vs_TEXCOORD5 
                        f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                        f32_4 %32 = OpLoad vs_TEXCOORD5 
                        f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                        f32_2 %34 = OpFDiv %31 %33 
                                      OpStore %27 %34 
                        f32_2 %35 = OpLoad %27 
               Uniform f32_4* %38 = OpAccessChain %12 %36 
                        f32_4 %39 = OpLoad %38 
                        f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                        f32_2 %41 = OpFMul %35 %40 
                                      OpStore %27 %41 
                        f32_2 %42 = OpLoad %27 
                        f32_2 %45 = OpFMul %42 %44 
                                      OpStore %27 %45 
                        f32_2 %50 = OpLoad %27 
                        f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                        f32_2 %52 = OpLoad %27 
                        f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                        f32_4 %54 = OpFNegate %53 
                       bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                       bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                      OpStore %49 %57 
                        f32_2 %58 = OpLoad %27 
                        f32_2 %59 = OpExtInst %1 4 %58 
                        f32_2 %60 = OpExtInst %1 10 %59 
                                      OpStore %27 %60 
                        f32_2 %63 = OpLoad %27 
                                      OpStore %62 %63 
                Private bool* %65 = OpAccessChain %49 %22 
                         bool %66 = OpLoad %65 
                                      OpSelectionMerge %70 None 
                                      OpBranchConditional %66 %69 %73 
                              %69 = OpLabel 
                 Private f32* %71 = OpAccessChain %27 %22 
                          f32 %72 = OpLoad %71 
                                      OpStore %68 %72 
                                      OpBranch %70 
                              %73 = OpLabel 
                 Private f32* %74 = OpAccessChain %27 %22 
                          f32 %75 = OpLoad %74 
                          f32 %76 = OpFNegate %75 
                                      OpStore %68 %76 
                                      OpBranch %70 
                              %70 = OpLabel 
                          f32 %77 = OpLoad %68 
                Function f32* %78 = OpAccessChain %62 %22 
                                      OpStore %78 %77 
                Private bool* %80 = OpAccessChain %49 %79 
                         bool %81 = OpLoad %80 
                                      OpSelectionMerge %84 None 
                                      OpBranchConditional %81 %83 %87 
                              %83 = OpLabel 
                 Private f32* %85 = OpAccessChain %27 %79 
                          f32 %86 = OpLoad %85 
                                      OpStore %82 %86 
                                      OpBranch %84 
                              %87 = OpLabel 
                 Private f32* %88 = OpAccessChain %27 %79 
                          f32 %89 = OpLoad %88 
                          f32 %90 = OpFNegate %89 
                                      OpStore %82 %90 
                                      OpBranch %84 
                              %84 = OpLabel 
                          f32 %91 = OpLoad %82 
                Function f32* %92 = OpAccessChain %62 %79 
                                      OpStore %92 %91 
                        f32_2 %93 = OpLoad %62 
                                      OpStore %27 %93 
                        f32_2 %94 = OpLoad %27 
                        f32_2 %97 = OpFMul %94 %96 
                                      OpStore %27 %97 
                       f32_2 %101 = OpLoad %27 
                       u32_2 %102 = OpConvertFToU %101 
                                      OpStore %100 %102 
                Private u32* %119 = OpAccessChain %100 %22 
                         u32 %120 = OpLoad %119 
                         i32 %121 = OpBitcast %120 
                                      OpStore %123 %117 
             Function u32_4* %125 = OpAccessChain %123 %121 
                       u32_4 %126 = OpLoad %125 
                       f32_4 %127 = OpBitcast %126 
                         f32 %128 = OpDot %108 %127 
                Private f32* %129 = OpAccessChain %103 %22 
                                      OpStore %129 %128 
                Private u32* %135 = OpAccessChain %100 %22 
                         u32 %136 = OpLoad %135 
                         i32 %137 = OpBitcast %136 
                                      OpStore %138 %117 
             Function u32_4* %139 = OpAccessChain %138 %137 
                       u32_4 %140 = OpLoad %139 
                       f32_4 %141 = OpBitcast %140 
                         f32 %142 = OpDot %134 %141 
                Private f32* %143 = OpAccessChain %103 %79 
                                      OpStore %143 %142 
                Private u32* %149 = OpAccessChain %100 %22 
                         u32 %150 = OpLoad %149 
                         i32 %151 = OpBitcast %150 
                                      OpStore %152 %117 
             Function u32_4* %153 = OpAccessChain %152 %151 
                       u32_4 %154 = OpLoad %153 
                       f32_4 %155 = OpBitcast %154 
                         f32 %156 = OpDot %148 %155 
                Private f32* %158 = OpAccessChain %103 %157 
                                      OpStore %158 %156 
                Private u32* %164 = OpAccessChain %100 %22 
                         u32 %165 = OpLoad %164 
                         i32 %166 = OpBitcast %165 
                                      OpStore %167 %117 
             Function u32_4* %168 = OpAccessChain %167 %166 
                       u32_4 %169 = OpLoad %168 
                       f32_4 %170 = OpBitcast %169 
                         f32 %171 = OpDot %163 %170 
                Private f32* %173 = OpAccessChain %103 %172 
                                      OpStore %173 %171 
                       f32_4 %174 = OpLoad %103 
                       f32_4 %175 = OpFNegate %174 
                Private u32* %176 = OpAccessChain %100 %79 
                         u32 %177 = OpLoad %176 
                         i32 %178 = OpBitcast %177 
                                      OpStore %179 %117 
             Function u32_4* %180 = OpAccessChain %179 %178 
                       u32_4 %181 = OpLoad %180 
                       f32_4 %182 = OpBitcast %181 
                       f32_4 %183 = OpFMul %175 %182 
                       f32_4 %184 = OpLoad %9 
                       f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                       f32_4 %186 = OpFAdd %183 %185 
                                      OpStore %9 %186 
                       f32_4 %189 = OpLoad %9 
                      bool_4 %192 = OpFOrdLessThan %189 %191 
                                      OpStore %188 %192 
               Private bool* %193 = OpAccessChain %188 %157 
                        bool %194 = OpLoad %193 
               Private bool* %195 = OpAccessChain %188 %22 
                        bool %196 = OpLoad %195 
                        bool %197 = OpLogicalOr %194 %196 
               Private bool* %198 = OpAccessChain %188 %22 
                                      OpStore %198 %197 
               Private bool* %199 = OpAccessChain %188 %172 
                        bool %200 = OpLoad %199 
               Private bool* %201 = OpAccessChain %188 %79 
                        bool %202 = OpLoad %201 
                        bool %203 = OpLogicalOr %200 %202 
               Private bool* %204 = OpAccessChain %188 %79 
                                      OpStore %204 %203 
               Private bool* %205 = OpAccessChain %188 %79 
                        bool %206 = OpLoad %205 
               Private bool* %207 = OpAccessChain %188 %22 
                        bool %208 = OpLoad %207 
                        bool %209 = OpLogicalOr %206 %208 
               Private bool* %210 = OpAccessChain %188 %22 
                                      OpStore %210 %209 
               Private bool* %211 = OpAccessChain %188 %22 
                        bool %212 = OpLoad %211 
                         i32 %213 = OpSelect %212 %14 %36 
                         i32 %215 = OpIMul %213 %214 
                        bool %216 = OpINotEqual %215 %36 
                                      OpSelectionMerge %218 None 
                                      OpBranchConditional %216 %217 %218 
                             %217 = OpLabel 
                                      OpKill
                             %218 = OpLabel 
                                      OpStore %221 %191 
                                      OpReturn
                                      OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "vulkan " {
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
}
}
 Pass {
  Tags { "LIGHTMODE" = "SRPDEFAULTUNLIT" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Stencil {
   Comp Equal
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 134132
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 0.349999994;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 247
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Fragment %4 "main" %29 %234 %239 
                                              OpExecutionMode %4 OriginUpperLeft 
                                              OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpMemberDecorate %10 0 Offset 10 
                                              OpMemberDecorate %10 1 Offset 10 
                                              OpDecorate %10 Block 
                                              OpDecorate %12 DescriptorSet 12 
                                              OpDecorate %12 Binding 12 
                                              OpDecorate vs_TEXCOORD5 Location 29 
                                              OpDecorate %222 RelaxedPrecision 
                                              OpDecorate %225 RelaxedPrecision 
                                              OpDecorate %225 DescriptorSet 225 
                                              OpDecorate %225 Binding 225 
                                              OpDecorate %226 RelaxedPrecision 
                                              OpDecorate %229 RelaxedPrecision 
                                              OpDecorate %229 DescriptorSet 229 
                                              OpDecorate %229 Binding 229 
                                              OpDecorate %230 RelaxedPrecision 
                                              OpDecorate vs_TEXCOORD0 Location 234 
                                              OpDecorate %237 RelaxedPrecision 
                                              OpDecorate %239 RelaxedPrecision 
                                              OpDecorate %239 Location 239 
                                              OpDecorate %240 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypeStruct %7 %6 
                                      %11 = OpTypePointer Uniform %10 
        Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                                      %13 = OpTypeInt 32 1 
                                  i32 %14 = OpConstant 1 
                                      %15 = OpTypePointer Uniform %6 
                                  f32 %19 = OpConstant 3.674022E-40 
                                      %21 = OpTypeInt 32 0 
                                  u32 %22 = OpConstant 0 
                                      %23 = OpTypePointer Private %6 
                                      %25 = OpTypeVector %6 2 
                                      %26 = OpTypePointer Private %25 
                       Private f32_2* %27 = OpVariable Private 
                                      %28 = OpTypePointer Input %7 
                Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                  i32 %36 = OpConstant 0 
                                      %37 = OpTypePointer Uniform %7 
                                  f32 %43 = OpConstant 3.674022E-40 
                                f32_2 %44 = OpConstantComposite %43 %43 
                                      %46 = OpTypeBool 
                                      %47 = OpTypeVector %46 2 
                                      %48 = OpTypePointer Private %47 
                      Private bool_2* %49 = OpVariable Private 
                                      %55 = OpTypeVector %46 4 
                                      %61 = OpTypePointer Function %25 
                                      %64 = OpTypePointer Private %46 
                                      %67 = OpTypePointer Function %6 
                                  u32 %79 = OpConstant 1 
                                  f32 %95 = OpConstant 3.674022E-40 
                                f32_2 %96 = OpConstantComposite %95 %95 
                                      %98 = OpTypeVector %21 2 
                                      %99 = OpTypePointer Private %98 
                      Private u32_2* %100 = OpVariable Private 
                      Private f32_4* %103 = OpVariable Private 
                                 f32 %104 = OpConstant 3.674022E-40 
                                 f32 %105 = OpConstant 3.674022E-40 
                                 f32 %106 = OpConstant 3.674022E-40 
                                 f32 %107 = OpConstant 3.674022E-40 
                               f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                                     %109 = OpTypeVector %21 4 
                                 u32 %110 = OpConstant 4 
                                     %111 = OpTypeArray %109 %110 
                                 u32 %112 = OpConstant 1065353216 
                               u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                               u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                               u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                               u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                            u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                                     %118 = OpTypePointer Private %21 
                                     %122 = OpTypePointer Function %111 
                                     %124 = OpTypePointer Function %109 
                                 f32 %130 = OpConstant 3.674022E-40 
                                 f32 %131 = OpConstant 3.674022E-40 
                                 f32 %132 = OpConstant 3.674022E-40 
                                 f32 %133 = OpConstant 3.674022E-40 
                               f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                                 f32 %144 = OpConstant 3.674022E-40 
                                 f32 %145 = OpConstant 3.674022E-40 
                                 f32 %146 = OpConstant 3.674022E-40 
                                 f32 %147 = OpConstant 3.674022E-40 
                               f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                                 u32 %157 = OpConstant 2 
                                 f32 %159 = OpConstant 3.674022E-40 
                                 f32 %160 = OpConstant 3.674022E-40 
                                 f32 %161 = OpConstant 3.674022E-40 
                                 f32 %162 = OpConstant 3.674022E-40 
                               f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                                 u32 %172 = OpConstant 3 
                                     %187 = OpTypePointer Private %55 
                     Private bool_4* %188 = OpVariable Private 
                                 f32 %190 = OpConstant 3.674022E-40 
                               f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                                 i32 %214 = OpConstant -1 
                                     %220 = OpTypeVector %6 3 
                                     %221 = OpTypePointer Private %220 
                      Private f32_3* %222 = OpVariable Private 
                                     %223 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %224 = OpTypePointer UniformConstant %223 
UniformConstant read_only Texture2D* %225 = OpVariable UniformConstant 
                                     %227 = OpTypeSampler 
                                     %228 = OpTypePointer UniformConstant %227 
            UniformConstant sampler* %229 = OpVariable UniformConstant 
                                     %231 = OpTypeSampledImage %223 
                                     %233 = OpTypePointer Input %25 
                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                     %238 = OpTypePointer Output %7 
                       Output f32_4* %239 = OpVariable Output 
                                 f32 %243 = OpConstant 3.674022E-40 
                                     %244 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                      Function f32_2* %62 = OpVariable Function 
                        Function f32* %68 = OpVariable Function 
                        Function f32* %82 = OpVariable Function 
                  Function u32_4[4]* %123 = OpVariable Function 
                  Function u32_4[4]* %138 = OpVariable Function 
                  Function u32_4[4]* %152 = OpVariable Function 
                  Function u32_4[4]* %167 = OpVariable Function 
                  Function u32_4[4]* %179 = OpVariable Function 
                         Uniform f32* %16 = OpAccessChain %12 %14 
                                  f32 %17 = OpLoad %16 
                                  f32 %18 = OpFNegate %17 
                                  f32 %20 = OpFAdd %18 %19 
                         Private f32* %24 = OpAccessChain %9 %22 
                                              OpStore %24 %20 
                                f32_4 %30 = OpLoad vs_TEXCOORD5 
                                f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                                f32_4 %32 = OpLoad vs_TEXCOORD5 
                                f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                                f32_2 %34 = OpFDiv %31 %33 
                                              OpStore %27 %34 
                                f32_2 %35 = OpLoad %27 
                       Uniform f32_4* %38 = OpAccessChain %12 %36 
                                f32_4 %39 = OpLoad %38 
                                f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                                f32_2 %41 = OpFMul %35 %40 
                                              OpStore %27 %41 
                                f32_2 %42 = OpLoad %27 
                                f32_2 %45 = OpFMul %42 %44 
                                              OpStore %27 %45 
                                f32_2 %50 = OpLoad %27 
                                f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                                f32_2 %52 = OpLoad %27 
                                f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                f32_4 %54 = OpFNegate %53 
                               bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                               bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                              OpStore %49 %57 
                                f32_2 %58 = OpLoad %27 
                                f32_2 %59 = OpExtInst %1 4 %58 
                                f32_2 %60 = OpExtInst %1 10 %59 
                                              OpStore %27 %60 
                                f32_2 %63 = OpLoad %27 
                                              OpStore %62 %63 
                        Private bool* %65 = OpAccessChain %49 %22 
                                 bool %66 = OpLoad %65 
                                              OpSelectionMerge %70 None 
                                              OpBranchConditional %66 %69 %73 
                                      %69 = OpLabel 
                         Private f32* %71 = OpAccessChain %27 %22 
                                  f32 %72 = OpLoad %71 
                                              OpStore %68 %72 
                                              OpBranch %70 
                                      %73 = OpLabel 
                         Private f32* %74 = OpAccessChain %27 %22 
                                  f32 %75 = OpLoad %74 
                                  f32 %76 = OpFNegate %75 
                                              OpStore %68 %76 
                                              OpBranch %70 
                                      %70 = OpLabel 
                                  f32 %77 = OpLoad %68 
                        Function f32* %78 = OpAccessChain %62 %22 
                                              OpStore %78 %77 
                        Private bool* %80 = OpAccessChain %49 %79 
                                 bool %81 = OpLoad %80 
                                              OpSelectionMerge %84 None 
                                              OpBranchConditional %81 %83 %87 
                                      %83 = OpLabel 
                         Private f32* %85 = OpAccessChain %27 %79 
                                  f32 %86 = OpLoad %85 
                                              OpStore %82 %86 
                                              OpBranch %84 
                                      %87 = OpLabel 
                         Private f32* %88 = OpAccessChain %27 %79 
                                  f32 %89 = OpLoad %88 
                                  f32 %90 = OpFNegate %89 
                                              OpStore %82 %90 
                                              OpBranch %84 
                                      %84 = OpLabel 
                                  f32 %91 = OpLoad %82 
                        Function f32* %92 = OpAccessChain %62 %79 
                                              OpStore %92 %91 
                                f32_2 %93 = OpLoad %62 
                                              OpStore %27 %93 
                                f32_2 %94 = OpLoad %27 
                                f32_2 %97 = OpFMul %94 %96 
                                              OpStore %27 %97 
                               f32_2 %101 = OpLoad %27 
                               u32_2 %102 = OpConvertFToU %101 
                                              OpStore %100 %102 
                        Private u32* %119 = OpAccessChain %100 %22 
                                 u32 %120 = OpLoad %119 
                                 i32 %121 = OpBitcast %120 
                                              OpStore %123 %117 
                     Function u32_4* %125 = OpAccessChain %123 %121 
                               u32_4 %126 = OpLoad %125 
                               f32_4 %127 = OpBitcast %126 
                                 f32 %128 = OpDot %108 %127 
                        Private f32* %129 = OpAccessChain %103 %22 
                                              OpStore %129 %128 
                        Private u32* %135 = OpAccessChain %100 %22 
                                 u32 %136 = OpLoad %135 
                                 i32 %137 = OpBitcast %136 
                                              OpStore %138 %117 
                     Function u32_4* %139 = OpAccessChain %138 %137 
                               u32_4 %140 = OpLoad %139 
                               f32_4 %141 = OpBitcast %140 
                                 f32 %142 = OpDot %134 %141 
                        Private f32* %143 = OpAccessChain %103 %79 
                                              OpStore %143 %142 
                        Private u32* %149 = OpAccessChain %100 %22 
                                 u32 %150 = OpLoad %149 
                                 i32 %151 = OpBitcast %150 
                                              OpStore %152 %117 
                     Function u32_4* %153 = OpAccessChain %152 %151 
                               u32_4 %154 = OpLoad %153 
                               f32_4 %155 = OpBitcast %154 
                                 f32 %156 = OpDot %148 %155 
                        Private f32* %158 = OpAccessChain %103 %157 
                                              OpStore %158 %156 
                        Private u32* %164 = OpAccessChain %100 %22 
                                 u32 %165 = OpLoad %164 
                                 i32 %166 = OpBitcast %165 
                                              OpStore %167 %117 
                     Function u32_4* %168 = OpAccessChain %167 %166 
                               u32_4 %169 = OpLoad %168 
                               f32_4 %170 = OpBitcast %169 
                                 f32 %171 = OpDot %163 %170 
                        Private f32* %173 = OpAccessChain %103 %172 
                                              OpStore %173 %171 
                               f32_4 %174 = OpLoad %103 
                               f32_4 %175 = OpFNegate %174 
                        Private u32* %176 = OpAccessChain %100 %79 
                                 u32 %177 = OpLoad %176 
                                 i32 %178 = OpBitcast %177 
                                              OpStore %179 %117 
                     Function u32_4* %180 = OpAccessChain %179 %178 
                               u32_4 %181 = OpLoad %180 
                               f32_4 %182 = OpBitcast %181 
                               f32_4 %183 = OpFMul %175 %182 
                               f32_4 %184 = OpLoad %9 
                               f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                               f32_4 %186 = OpFAdd %183 %185 
                                              OpStore %9 %186 
                               f32_4 %189 = OpLoad %9 
                              bool_4 %192 = OpFOrdLessThan %189 %191 
                                              OpStore %188 %192 
                       Private bool* %193 = OpAccessChain %188 %157 
                                bool %194 = OpLoad %193 
                       Private bool* %195 = OpAccessChain %188 %22 
                                bool %196 = OpLoad %195 
                                bool %197 = OpLogicalOr %194 %196 
                       Private bool* %198 = OpAccessChain %188 %22 
                                              OpStore %198 %197 
                       Private bool* %199 = OpAccessChain %188 %172 
                                bool %200 = OpLoad %199 
                       Private bool* %201 = OpAccessChain %188 %79 
                                bool %202 = OpLoad %201 
                                bool %203 = OpLogicalOr %200 %202 
                       Private bool* %204 = OpAccessChain %188 %79 
                                              OpStore %204 %203 
                       Private bool* %205 = OpAccessChain %188 %79 
                                bool %206 = OpLoad %205 
                       Private bool* %207 = OpAccessChain %188 %22 
                                bool %208 = OpLoad %207 
                                bool %209 = OpLogicalOr %206 %208 
                       Private bool* %210 = OpAccessChain %188 %22 
                                              OpStore %210 %209 
                       Private bool* %211 = OpAccessChain %188 %22 
                                bool %212 = OpLoad %211 
                                 i32 %213 = OpSelect %212 %14 %36 
                                 i32 %215 = OpIMul %213 %214 
                                bool %216 = OpINotEqual %215 %36 
                                              OpSelectionMerge %218 None 
                                              OpBranchConditional %216 %217 %218 
                                     %217 = OpLabel 
                                              OpKill
                                     %218 = OpLabel 
                 read_only Texture2D %226 = OpLoad %225 
                             sampler %230 = OpLoad %229 
          read_only Texture2DSampled %232 = OpSampledImage %226 %230 
                               f32_2 %235 = OpLoad vs_TEXCOORD0 
                               f32_4 %236 = OpImageSampleImplicitLod %232 %235 
                               f32_3 %237 = OpVectorShuffle %236 %236 0 1 2 
                                              OpStore %222 %237 
                               f32_3 %240 = OpLoad %222 
                               f32_4 %241 = OpLoad %239 
                               f32_4 %242 = OpVectorShuffle %241 %240 4 5 6 3 
                                              OpStore %239 %242 
                         Output f32* %245 = OpAccessChain %239 %172 
                                              OpStore %245 %243 
                                              OpReturn
                                              OpFunctionEnd
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 247
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Fragment %4 "main" %29 %234 %239 
                                              OpExecutionMode %4 OriginUpperLeft 
                                              OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpMemberDecorate %10 0 Offset 10 
                                              OpMemberDecorate %10 1 Offset 10 
                                              OpDecorate %10 Block 
                                              OpDecorate %12 DescriptorSet 12 
                                              OpDecorate %12 Binding 12 
                                              OpDecorate vs_TEXCOORD5 Location 29 
                                              OpDecorate %222 RelaxedPrecision 
                                              OpDecorate %225 RelaxedPrecision 
                                              OpDecorate %225 DescriptorSet 225 
                                              OpDecorate %225 Binding 225 
                                              OpDecorate %226 RelaxedPrecision 
                                              OpDecorate %229 RelaxedPrecision 
                                              OpDecorate %229 DescriptorSet 229 
                                              OpDecorate %229 Binding 229 
                                              OpDecorate %230 RelaxedPrecision 
                                              OpDecorate vs_TEXCOORD0 Location 234 
                                              OpDecorate %237 RelaxedPrecision 
                                              OpDecorate %239 RelaxedPrecision 
                                              OpDecorate %239 Location 239 
                                              OpDecorate %240 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypeStruct %7 %6 
                                      %11 = OpTypePointer Uniform %10 
        Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                                      %13 = OpTypeInt 32 1 
                                  i32 %14 = OpConstant 1 
                                      %15 = OpTypePointer Uniform %6 
                                  f32 %19 = OpConstant 3.674022E-40 
                                      %21 = OpTypeInt 32 0 
                                  u32 %22 = OpConstant 0 
                                      %23 = OpTypePointer Private %6 
                                      %25 = OpTypeVector %6 2 
                                      %26 = OpTypePointer Private %25 
                       Private f32_2* %27 = OpVariable Private 
                                      %28 = OpTypePointer Input %7 
                Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                  i32 %36 = OpConstant 0 
                                      %37 = OpTypePointer Uniform %7 
                                  f32 %43 = OpConstant 3.674022E-40 
                                f32_2 %44 = OpConstantComposite %43 %43 
                                      %46 = OpTypeBool 
                                      %47 = OpTypeVector %46 2 
                                      %48 = OpTypePointer Private %47 
                      Private bool_2* %49 = OpVariable Private 
                                      %55 = OpTypeVector %46 4 
                                      %61 = OpTypePointer Function %25 
                                      %64 = OpTypePointer Private %46 
                                      %67 = OpTypePointer Function %6 
                                  u32 %79 = OpConstant 1 
                                  f32 %95 = OpConstant 3.674022E-40 
                                f32_2 %96 = OpConstantComposite %95 %95 
                                      %98 = OpTypeVector %21 2 
                                      %99 = OpTypePointer Private %98 
                      Private u32_2* %100 = OpVariable Private 
                      Private f32_4* %103 = OpVariable Private 
                                 f32 %104 = OpConstant 3.674022E-40 
                                 f32 %105 = OpConstant 3.674022E-40 
                                 f32 %106 = OpConstant 3.674022E-40 
                                 f32 %107 = OpConstant 3.674022E-40 
                               f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                                     %109 = OpTypeVector %21 4 
                                 u32 %110 = OpConstant 4 
                                     %111 = OpTypeArray %109 %110 
                                 u32 %112 = OpConstant 1065353216 
                               u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                               u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                               u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                               u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                            u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                                     %118 = OpTypePointer Private %21 
                                     %122 = OpTypePointer Function %111 
                                     %124 = OpTypePointer Function %109 
                                 f32 %130 = OpConstant 3.674022E-40 
                                 f32 %131 = OpConstant 3.674022E-40 
                                 f32 %132 = OpConstant 3.674022E-40 
                                 f32 %133 = OpConstant 3.674022E-40 
                               f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                                 f32 %144 = OpConstant 3.674022E-40 
                                 f32 %145 = OpConstant 3.674022E-40 
                                 f32 %146 = OpConstant 3.674022E-40 
                                 f32 %147 = OpConstant 3.674022E-40 
                               f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                                 u32 %157 = OpConstant 2 
                                 f32 %159 = OpConstant 3.674022E-40 
                                 f32 %160 = OpConstant 3.674022E-40 
                                 f32 %161 = OpConstant 3.674022E-40 
                                 f32 %162 = OpConstant 3.674022E-40 
                               f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                                 u32 %172 = OpConstant 3 
                                     %187 = OpTypePointer Private %55 
                     Private bool_4* %188 = OpVariable Private 
                                 f32 %190 = OpConstant 3.674022E-40 
                               f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                                 i32 %214 = OpConstant -1 
                                     %220 = OpTypeVector %6 3 
                                     %221 = OpTypePointer Private %220 
                      Private f32_3* %222 = OpVariable Private 
                                     %223 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %224 = OpTypePointer UniformConstant %223 
UniformConstant read_only Texture2D* %225 = OpVariable UniformConstant 
                                     %227 = OpTypeSampler 
                                     %228 = OpTypePointer UniformConstant %227 
            UniformConstant sampler* %229 = OpVariable UniformConstant 
                                     %231 = OpTypeSampledImage %223 
                                     %233 = OpTypePointer Input %25 
                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                     %238 = OpTypePointer Output %7 
                       Output f32_4* %239 = OpVariable Output 
                                 f32 %243 = OpConstant 3.674022E-40 
                                     %244 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                      Function f32_2* %62 = OpVariable Function 
                        Function f32* %68 = OpVariable Function 
                        Function f32* %82 = OpVariable Function 
                  Function u32_4[4]* %123 = OpVariable Function 
                  Function u32_4[4]* %138 = OpVariable Function 
                  Function u32_4[4]* %152 = OpVariable Function 
                  Function u32_4[4]* %167 = OpVariable Function 
                  Function u32_4[4]* %179 = OpVariable Function 
                         Uniform f32* %16 = OpAccessChain %12 %14 
                                  f32 %17 = OpLoad %16 
                                  f32 %18 = OpFNegate %17 
                                  f32 %20 = OpFAdd %18 %19 
                         Private f32* %24 = OpAccessChain %9 %22 
                                              OpStore %24 %20 
                                f32_4 %30 = OpLoad vs_TEXCOORD5 
                                f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                                f32_4 %32 = OpLoad vs_TEXCOORD5 
                                f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                                f32_2 %34 = OpFDiv %31 %33 
                                              OpStore %27 %34 
                                f32_2 %35 = OpLoad %27 
                       Uniform f32_4* %38 = OpAccessChain %12 %36 
                                f32_4 %39 = OpLoad %38 
                                f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                                f32_2 %41 = OpFMul %35 %40 
                                              OpStore %27 %41 
                                f32_2 %42 = OpLoad %27 
                                f32_2 %45 = OpFMul %42 %44 
                                              OpStore %27 %45 
                                f32_2 %50 = OpLoad %27 
                                f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                                f32_2 %52 = OpLoad %27 
                                f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                f32_4 %54 = OpFNegate %53 
                               bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                               bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                              OpStore %49 %57 
                                f32_2 %58 = OpLoad %27 
                                f32_2 %59 = OpExtInst %1 4 %58 
                                f32_2 %60 = OpExtInst %1 10 %59 
                                              OpStore %27 %60 
                                f32_2 %63 = OpLoad %27 
                                              OpStore %62 %63 
                        Private bool* %65 = OpAccessChain %49 %22 
                                 bool %66 = OpLoad %65 
                                              OpSelectionMerge %70 None 
                                              OpBranchConditional %66 %69 %73 
                                      %69 = OpLabel 
                         Private f32* %71 = OpAccessChain %27 %22 
                                  f32 %72 = OpLoad %71 
                                              OpStore %68 %72 
                                              OpBranch %70 
                                      %73 = OpLabel 
                         Private f32* %74 = OpAccessChain %27 %22 
                                  f32 %75 = OpLoad %74 
                                  f32 %76 = OpFNegate %75 
                                              OpStore %68 %76 
                                              OpBranch %70 
                                      %70 = OpLabel 
                                  f32 %77 = OpLoad %68 
                        Function f32* %78 = OpAccessChain %62 %22 
                                              OpStore %78 %77 
                        Private bool* %80 = OpAccessChain %49 %79 
                                 bool %81 = OpLoad %80 
                                              OpSelectionMerge %84 None 
                                              OpBranchConditional %81 %83 %87 
                                      %83 = OpLabel 
                         Private f32* %85 = OpAccessChain %27 %79 
                                  f32 %86 = OpLoad %85 
                                              OpStore %82 %86 
                                              OpBranch %84 
                                      %87 = OpLabel 
                         Private f32* %88 = OpAccessChain %27 %79 
                                  f32 %89 = OpLoad %88 
                                  f32 %90 = OpFNegate %89 
                                              OpStore %82 %90 
                                              OpBranch %84 
                                      %84 = OpLabel 
                                  f32 %91 = OpLoad %82 
                        Function f32* %92 = OpAccessChain %62 %79 
                                              OpStore %92 %91 
                                f32_2 %93 = OpLoad %62 
                                              OpStore %27 %93 
                                f32_2 %94 = OpLoad %27 
                                f32_2 %97 = OpFMul %94 %96 
                                              OpStore %27 %97 
                               f32_2 %101 = OpLoad %27 
                               u32_2 %102 = OpConvertFToU %101 
                                              OpStore %100 %102 
                        Private u32* %119 = OpAccessChain %100 %22 
                                 u32 %120 = OpLoad %119 
                                 i32 %121 = OpBitcast %120 
                                              OpStore %123 %117 
                     Function u32_4* %125 = OpAccessChain %123 %121 
                               u32_4 %126 = OpLoad %125 
                               f32_4 %127 = OpBitcast %126 
                                 f32 %128 = OpDot %108 %127 
                        Private f32* %129 = OpAccessChain %103 %22 
                                              OpStore %129 %128 
                        Private u32* %135 = OpAccessChain %100 %22 
                                 u32 %136 = OpLoad %135 
                                 i32 %137 = OpBitcast %136 
                                              OpStore %138 %117 
                     Function u32_4* %139 = OpAccessChain %138 %137 
                               u32_4 %140 = OpLoad %139 
                               f32_4 %141 = OpBitcast %140 
                                 f32 %142 = OpDot %134 %141 
                        Private f32* %143 = OpAccessChain %103 %79 
                                              OpStore %143 %142 
                        Private u32* %149 = OpAccessChain %100 %22 
                                 u32 %150 = OpLoad %149 
                                 i32 %151 = OpBitcast %150 
                                              OpStore %152 %117 
                     Function u32_4* %153 = OpAccessChain %152 %151 
                               u32_4 %154 = OpLoad %153 
                               f32_4 %155 = OpBitcast %154 
                                 f32 %156 = OpDot %148 %155 
                        Private f32* %158 = OpAccessChain %103 %157 
                                              OpStore %158 %156 
                        Private u32* %164 = OpAccessChain %100 %22 
                                 u32 %165 = OpLoad %164 
                                 i32 %166 = OpBitcast %165 
                                              OpStore %167 %117 
                     Function u32_4* %168 = OpAccessChain %167 %166 
                               u32_4 %169 = OpLoad %168 
                               f32_4 %170 = OpBitcast %169 
                                 f32 %171 = OpDot %163 %170 
                        Private f32* %173 = OpAccessChain %103 %172 
                                              OpStore %173 %171 
                               f32_4 %174 = OpLoad %103 
                               f32_4 %175 = OpFNegate %174 
                        Private u32* %176 = OpAccessChain %100 %79 
                                 u32 %177 = OpLoad %176 
                                 i32 %178 = OpBitcast %177 
                                              OpStore %179 %117 
                     Function u32_4* %180 = OpAccessChain %179 %178 
                               u32_4 %181 = OpLoad %180 
                               f32_4 %182 = OpBitcast %181 
                               f32_4 %183 = OpFMul %175 %182 
                               f32_4 %184 = OpLoad %9 
                               f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                               f32_4 %186 = OpFAdd %183 %185 
                                              OpStore %9 %186 
                               f32_4 %189 = OpLoad %9 
                              bool_4 %192 = OpFOrdLessThan %189 %191 
                                              OpStore %188 %192 
                       Private bool* %193 = OpAccessChain %188 %157 
                                bool %194 = OpLoad %193 
                       Private bool* %195 = OpAccessChain %188 %22 
                                bool %196 = OpLoad %195 
                                bool %197 = OpLogicalOr %194 %196 
                       Private bool* %198 = OpAccessChain %188 %22 
                                              OpStore %198 %197 
                       Private bool* %199 = OpAccessChain %188 %172 
                                bool %200 = OpLoad %199 
                       Private bool* %201 = OpAccessChain %188 %79 
                                bool %202 = OpLoad %201 
                                bool %203 = OpLogicalOr %200 %202 
                       Private bool* %204 = OpAccessChain %188 %79 
                                              OpStore %204 %203 
                       Private bool* %205 = OpAccessChain %188 %79 
                                bool %206 = OpLoad %205 
                       Private bool* %207 = OpAccessChain %188 %22 
                                bool %208 = OpLoad %207 
                                bool %209 = OpLogicalOr %206 %208 
                       Private bool* %210 = OpAccessChain %188 %22 
                                              OpStore %210 %209 
                       Private bool* %211 = OpAccessChain %188 %22 
                                bool %212 = OpLoad %211 
                                 i32 %213 = OpSelect %212 %14 %36 
                                 i32 %215 = OpIMul %213 %214 
                                bool %216 = OpINotEqual %215 %36 
                                              OpSelectionMerge %218 None 
                                              OpBranchConditional %216 %217 %218 
                                     %217 = OpLabel 
                                              OpKill
                                     %218 = OpLabel 
                 read_only Texture2D %226 = OpLoad %225 
                             sampler %230 = OpLoad %229 
          read_only Texture2DSampled %232 = OpSampledImage %226 %230 
                               f32_2 %235 = OpLoad vs_TEXCOORD0 
                               f32_4 %236 = OpImageSampleImplicitLod %232 %235 
                               f32_3 %237 = OpVectorShuffle %236 %236 0 1 2 
                                              OpStore %222 %237 
                               f32_3 %240 = OpLoad %222 
                               f32_4 %241 = OpLoad %239 
                               f32_4 %242 = OpVectorShuffle %241 %240 4 5 6 3 
                                              OpStore %239 %242 
                         Output f32* %245 = OpAccessChain %239 %172 
                                              OpStore %245 %243 
                                              OpReturn
                                              OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 0.349999994;
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 251
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %98 %104 %106 %109 %149 %154 %188 %214 %233 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %96 0 BuiltIn 96 
                                                      OpMemberDecorate %96 1 BuiltIn 96 
                                                      OpMemberDecorate %96 2 BuiltIn 96 
                                                      OpDecorate %96 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 104 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate %109 Location 109 
                                                      OpDecorate vs_TEXCOORD2 Location 149 
                                                      OpDecorate %154 Location 154 
                                                      OpDecorate vs_TEXCOORD3 Location 188 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD4 Location 214 
                                                      OpDecorate vs_TEXCOORD5 Location 233 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %16 
                                              %70 = OpTypeStruct %7 %69 
                                              %71 = OpTypePointer Uniform %70 
           Uniform struct {f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                          u32 %94 = OpConstant 1 
                                              %95 = OpTypeArray %6 %94 
                                              %96 = OpTypeStruct %7 %6 %95 
                                              %97 = OpTypePointer Output %96 
         Output struct {f32_4; f32; f32[1];}* %98 = OpVariable Output 
                                             %100 = OpTypePointer Output %7 
                                             %102 = OpTypeVector %6 2 
                                             %103 = OpTypePointer Output %102 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %105 = OpTypePointer Input %102 
                                Input f32_2* %106 = OpVariable Input 
                                             %108 = OpTypePointer Input %12 
                                Input f32_3* %109 = OpVariable Input 
                                         u32 %115 = OpConstant 0 
                                             %116 = OpTypePointer Private %6 
                                Private f32* %130 = OpVariable Private 
                                         f32 %137 = OpConstant 3.674022E-40 
                                             %148 = OpTypePointer Output %12 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %152 = OpTypePointer Private %12 
                              Private f32_3* %153 = OpVariable Private 
                                Input f32_4* %154 = OpVariable Input 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                              Private f32_3* %190 = OpVariable Private 
                                         u32 %206 = OpConstant 3 
                                             %207 = OpTypePointer Input %6 
                                             %210 = OpTypePointer Uniform %6 
                       Output f32_3* vs_TEXCOORD4 = OpVariable Output 
                                         f32 %228 = OpConstant 3.674022E-40 
                                       f32_3 %229 = OpConstantComposite %228 %228 %228 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %245 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                        f32_4 %67 = OpLoad %9 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %26 %26 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %26 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %26 %45 
                                        f32_4 %84 = OpLoad %83 
                                        f32_4 %85 = OpLoad %9 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %9 %89 
                                        f32_4 %90 = OpLoad %9 
                               Uniform f32_4* %91 = OpAccessChain %72 %26 %59 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %9 %93 
                                        f32_4 %99 = OpLoad %9 
                               Output f32_4* %101 = OpAccessChain %98 %25 
                                                      OpStore %101 %99 
                                       f32_2 %107 = OpLoad %106 
                                                      OpStore vs_TEXCOORD0 %107 
                                       f32_3 %110 = OpLoad %109 
                              Uniform f32_4* %111 = OpAccessChain %23 %26 %25 
                                       f32_4 %112 = OpLoad %111 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %110 %113 
                                Private f32* %117 = OpAccessChain %66 %115 
                                                      OpStore %117 %114 
                                       f32_3 %118 = OpLoad %109 
                              Uniform f32_4* %119 = OpAccessChain %23 %26 %26 
                                       f32_4 %120 = OpLoad %119 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                         f32 %122 = OpDot %118 %121 
                                Private f32* %123 = OpAccessChain %66 %94 
                                                      OpStore %123 %122 
                                       f32_3 %124 = OpLoad %109 
                              Uniform f32_4* %125 = OpAccessChain %23 %26 %45 
                                       f32_4 %126 = OpLoad %125 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                         f32 %128 = OpDot %124 %127 
                                Private f32* %129 = OpAccessChain %66 %19 
                                                      OpStore %129 %128 
                                       f32_4 %131 = OpLoad %66 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_4 %133 = OpLoad %66 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %132 %134 
                                                      OpStore %130 %135 
                                         f32 %136 = OpLoad %130 
                                         f32 %138 = OpExtInst %1 40 %136 %137 
                                                      OpStore %130 %138 
                                         f32 %139 = OpLoad %130 
                                         f32 %140 = OpExtInst %1 32 %139 
                                                      OpStore %130 %140 
                                         f32 %141 = OpLoad %130 
                                       f32_3 %142 = OpCompositeConstruct %141 %141 %141 
                                       f32_4 %143 = OpLoad %66 
                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
                                       f32_3 %145 = OpFMul %142 %144 
                                       f32_4 %146 = OpLoad %66 
                                       f32_4 %147 = OpVectorShuffle %146 %145 4 5 6 3 
                                                      OpStore %66 %147 
                                       f32_4 %150 = OpLoad %66 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                                      OpStore vs_TEXCOORD2 %151 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 1 1 1 
                              Uniform f32_4* %157 = OpAccessChain %23 %25 %26 
                                       f32_4 %158 = OpLoad %157 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFMul %156 %159 
                                                      OpStore %153 %160 
                              Uniform f32_4* %161 = OpAccessChain %23 %25 %25 
                                       f32_4 %162 = OpLoad %161 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                       f32_4 %164 = OpLoad %154 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 0 0 
                                       f32_3 %166 = OpFMul %163 %165 
                                       f32_3 %167 = OpLoad %153 
                                       f32_3 %168 = OpFAdd %166 %167 
                                                      OpStore %153 %168 
                              Uniform f32_4* %169 = OpAccessChain %23 %25 %45 
                                       f32_4 %170 = OpLoad %169 
                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
                                       f32_4 %172 = OpLoad %154 
                                       f32_3 %173 = OpVectorShuffle %172 %172 2 2 2 
                                       f32_3 %174 = OpFMul %171 %173 
                                       f32_3 %175 = OpLoad %153 
                                       f32_3 %176 = OpFAdd %174 %175 
                                                      OpStore %153 %176 
                                       f32_3 %177 = OpLoad %153 
                                       f32_3 %178 = OpLoad %153 
                                         f32 %179 = OpDot %177 %178 
                                                      OpStore %130 %179 
                                         f32 %180 = OpLoad %130 
                                         f32 %181 = OpExtInst %1 40 %180 %137 
                                                      OpStore %130 %181 
                                         f32 %182 = OpLoad %130 
                                         f32 %183 = OpExtInst %1 32 %182 
                                                      OpStore %130 %183 
                                         f32 %184 = OpLoad %130 
                                       f32_3 %185 = OpCompositeConstruct %184 %184 %184 
                                       f32_3 %186 = OpLoad %153 
                                       f32_3 %187 = OpFMul %185 %186 
                                                      OpStore %153 %187 
                                       f32_3 %189 = OpLoad %153 
                                                      OpStore vs_TEXCOORD3 %189 
                                       f32_4 %191 = OpLoad %66 
                                       f32_3 %192 = OpVectorShuffle %191 %191 2 0 1 
                                       f32_3 %193 = OpLoad %153 
                                       f32_3 %194 = OpVectorShuffle %193 %193 1 2 0 
                                       f32_3 %195 = OpFMul %192 %194 
                                                      OpStore %190 %195 
                                       f32_4 %196 = OpLoad %66 
                                       f32_3 %197 = OpVectorShuffle %196 %196 1 2 0 
                                       f32_3 %198 = OpLoad %153 
                                       f32_3 %199 = OpVectorShuffle %198 %198 2 0 1 
                                       f32_3 %200 = OpFMul %197 %199 
                                       f32_3 %201 = OpLoad %190 
                                       f32_3 %202 = OpFNegate %201 
                                       f32_3 %203 = OpFAdd %200 %202 
                                       f32_4 %204 = OpLoad %66 
                                       f32_4 %205 = OpVectorShuffle %204 %203 4 5 6 3 
                                                      OpStore %66 %205 
                                  Input f32* %208 = OpAccessChain %154 %206 
                                         f32 %209 = OpLoad %208 
                                Uniform f32* %211 = OpAccessChain %23 %59 %206 
                                         f32 %212 = OpLoad %211 
                                         f32 %213 = OpFMul %209 %212 
                                                      OpStore %130 %213 
                                         f32 %215 = OpLoad %130 
                                       f32_3 %216 = OpCompositeConstruct %215 %215 %215 
                                       f32_4 %217 = OpLoad %66 
                                       f32_3 %218 = OpVectorShuffle %217 %217 0 1 2 
                                       f32_3 %219 = OpFMul %216 %218 
                                                      OpStore vs_TEXCOORD4 %219 
                                Private f32* %220 = OpAccessChain %9 %94 
                                         f32 %221 = OpLoad %220 
                                Uniform f32* %222 = OpAccessChain %72 %25 %115 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFMul %221 %223 
                                Private f32* %225 = OpAccessChain %9 %94 
                                                      OpStore %225 %224 
                                       f32_4 %226 = OpLoad %9 
                                       f32_3 %227 = OpVectorShuffle %226 %226 0 3 1 
                                       f32_3 %230 = OpFMul %227 %229 
                                       f32_4 %231 = OpLoad %66 
                                       f32_4 %232 = OpVectorShuffle %231 %230 4 1 5 6 
                                                      OpStore %66 %232 
                                       f32_4 %234 = OpLoad %9 
                                       f32_2 %235 = OpVectorShuffle %234 %234 2 3 
                                       f32_4 %236 = OpLoad vs_TEXCOORD5 
                                       f32_4 %237 = OpVectorShuffle %236 %235 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %237 
                                       f32_4 %238 = OpLoad %66 
                                       f32_2 %239 = OpVectorShuffle %238 %238 2 2 
                                       f32_4 %240 = OpLoad %66 
                                       f32_2 %241 = OpVectorShuffle %240 %240 0 3 
                                       f32_2 %242 = OpFAdd %239 %241 
                                       f32_4 %243 = OpLoad vs_TEXCOORD5 
                                       f32_4 %244 = OpVectorShuffle %243 %242 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %244 
                                 Output f32* %246 = OpAccessChain %98 %25 %94 
                                         f32 %247 = OpLoad %246 
                                         f32 %248 = OpFNegate %247 
                                 Output f32* %249 = OpAccessChain %98 %25 %94 
                                                      OpStore %249 %248 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 247
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Fragment %4 "main" %29 %234 %239 
                                              OpExecutionMode %4 OriginUpperLeft 
                                              OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpMemberDecorate %10 0 Offset 10 
                                              OpMemberDecorate %10 1 Offset 10 
                                              OpDecorate %10 Block 
                                              OpDecorate %12 DescriptorSet 12 
                                              OpDecorate %12 Binding 12 
                                              OpDecorate vs_TEXCOORD5 Location 29 
                                              OpDecorate %222 RelaxedPrecision 
                                              OpDecorate %225 RelaxedPrecision 
                                              OpDecorate %225 DescriptorSet 225 
                                              OpDecorate %225 Binding 225 
                                              OpDecorate %226 RelaxedPrecision 
                                              OpDecorate %229 RelaxedPrecision 
                                              OpDecorate %229 DescriptorSet 229 
                                              OpDecorate %229 Binding 229 
                                              OpDecorate %230 RelaxedPrecision 
                                              OpDecorate vs_TEXCOORD0 Location 234 
                                              OpDecorate %237 RelaxedPrecision 
                                              OpDecorate %239 RelaxedPrecision 
                                              OpDecorate %239 Location 239 
                                              OpDecorate %240 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypeStruct %7 %6 
                                      %11 = OpTypePointer Uniform %10 
        Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                                      %13 = OpTypeInt 32 1 
                                  i32 %14 = OpConstant 1 
                                      %15 = OpTypePointer Uniform %6 
                                  f32 %19 = OpConstant 3.674022E-40 
                                      %21 = OpTypeInt 32 0 
                                  u32 %22 = OpConstant 0 
                                      %23 = OpTypePointer Private %6 
                                      %25 = OpTypeVector %6 2 
                                      %26 = OpTypePointer Private %25 
                       Private f32_2* %27 = OpVariable Private 
                                      %28 = OpTypePointer Input %7 
                Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                  i32 %36 = OpConstant 0 
                                      %37 = OpTypePointer Uniform %7 
                                  f32 %43 = OpConstant 3.674022E-40 
                                f32_2 %44 = OpConstantComposite %43 %43 
                                      %46 = OpTypeBool 
                                      %47 = OpTypeVector %46 2 
                                      %48 = OpTypePointer Private %47 
                      Private bool_2* %49 = OpVariable Private 
                                      %55 = OpTypeVector %46 4 
                                      %61 = OpTypePointer Function %25 
                                      %64 = OpTypePointer Private %46 
                                      %67 = OpTypePointer Function %6 
                                  u32 %79 = OpConstant 1 
                                  f32 %95 = OpConstant 3.674022E-40 
                                f32_2 %96 = OpConstantComposite %95 %95 
                                      %98 = OpTypeVector %21 2 
                                      %99 = OpTypePointer Private %98 
                      Private u32_2* %100 = OpVariable Private 
                      Private f32_4* %103 = OpVariable Private 
                                 f32 %104 = OpConstant 3.674022E-40 
                                 f32 %105 = OpConstant 3.674022E-40 
                                 f32 %106 = OpConstant 3.674022E-40 
                                 f32 %107 = OpConstant 3.674022E-40 
                               f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                                     %109 = OpTypeVector %21 4 
                                 u32 %110 = OpConstant 4 
                                     %111 = OpTypeArray %109 %110 
                                 u32 %112 = OpConstant 1065353216 
                               u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                               u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                               u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                               u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                            u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                                     %118 = OpTypePointer Private %21 
                                     %122 = OpTypePointer Function %111 
                                     %124 = OpTypePointer Function %109 
                                 f32 %130 = OpConstant 3.674022E-40 
                                 f32 %131 = OpConstant 3.674022E-40 
                                 f32 %132 = OpConstant 3.674022E-40 
                                 f32 %133 = OpConstant 3.674022E-40 
                               f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                                 f32 %144 = OpConstant 3.674022E-40 
                                 f32 %145 = OpConstant 3.674022E-40 
                                 f32 %146 = OpConstant 3.674022E-40 
                                 f32 %147 = OpConstant 3.674022E-40 
                               f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                                 u32 %157 = OpConstant 2 
                                 f32 %159 = OpConstant 3.674022E-40 
                                 f32 %160 = OpConstant 3.674022E-40 
                                 f32 %161 = OpConstant 3.674022E-40 
                                 f32 %162 = OpConstant 3.674022E-40 
                               f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                                 u32 %172 = OpConstant 3 
                                     %187 = OpTypePointer Private %55 
                     Private bool_4* %188 = OpVariable Private 
                                 f32 %190 = OpConstant 3.674022E-40 
                               f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                                 i32 %214 = OpConstant -1 
                                     %220 = OpTypeVector %6 3 
                                     %221 = OpTypePointer Private %220 
                      Private f32_3* %222 = OpVariable Private 
                                     %223 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %224 = OpTypePointer UniformConstant %223 
UniformConstant read_only Texture2D* %225 = OpVariable UniformConstant 
                                     %227 = OpTypeSampler 
                                     %228 = OpTypePointer UniformConstant %227 
            UniformConstant sampler* %229 = OpVariable UniformConstant 
                                     %231 = OpTypeSampledImage %223 
                                     %233 = OpTypePointer Input %25 
                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                     %238 = OpTypePointer Output %7 
                       Output f32_4* %239 = OpVariable Output 
                                 f32 %243 = OpConstant 3.674022E-40 
                                     %244 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                      Function f32_2* %62 = OpVariable Function 
                        Function f32* %68 = OpVariable Function 
                        Function f32* %82 = OpVariable Function 
                  Function u32_4[4]* %123 = OpVariable Function 
                  Function u32_4[4]* %138 = OpVariable Function 
                  Function u32_4[4]* %152 = OpVariable Function 
                  Function u32_4[4]* %167 = OpVariable Function 
                  Function u32_4[4]* %179 = OpVariable Function 
                         Uniform f32* %16 = OpAccessChain %12 %14 
                                  f32 %17 = OpLoad %16 
                                  f32 %18 = OpFNegate %17 
                                  f32 %20 = OpFAdd %18 %19 
                         Private f32* %24 = OpAccessChain %9 %22 
                                              OpStore %24 %20 
                                f32_4 %30 = OpLoad vs_TEXCOORD5 
                                f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                                f32_4 %32 = OpLoad vs_TEXCOORD5 
                                f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                                f32_2 %34 = OpFDiv %31 %33 
                                              OpStore %27 %34 
                                f32_2 %35 = OpLoad %27 
                       Uniform f32_4* %38 = OpAccessChain %12 %36 
                                f32_4 %39 = OpLoad %38 
                                f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                                f32_2 %41 = OpFMul %35 %40 
                                              OpStore %27 %41 
                                f32_2 %42 = OpLoad %27 
                                f32_2 %45 = OpFMul %42 %44 
                                              OpStore %27 %45 
                                f32_2 %50 = OpLoad %27 
                                f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                                f32_2 %52 = OpLoad %27 
                                f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                f32_4 %54 = OpFNegate %53 
                               bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                               bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                              OpStore %49 %57 
                                f32_2 %58 = OpLoad %27 
                                f32_2 %59 = OpExtInst %1 4 %58 
                                f32_2 %60 = OpExtInst %1 10 %59 
                                              OpStore %27 %60 
                                f32_2 %63 = OpLoad %27 
                                              OpStore %62 %63 
                        Private bool* %65 = OpAccessChain %49 %22 
                                 bool %66 = OpLoad %65 
                                              OpSelectionMerge %70 None 
                                              OpBranchConditional %66 %69 %73 
                                      %69 = OpLabel 
                         Private f32* %71 = OpAccessChain %27 %22 
                                  f32 %72 = OpLoad %71 
                                              OpStore %68 %72 
                                              OpBranch %70 
                                      %73 = OpLabel 
                         Private f32* %74 = OpAccessChain %27 %22 
                                  f32 %75 = OpLoad %74 
                                  f32 %76 = OpFNegate %75 
                                              OpStore %68 %76 
                                              OpBranch %70 
                                      %70 = OpLabel 
                                  f32 %77 = OpLoad %68 
                        Function f32* %78 = OpAccessChain %62 %22 
                                              OpStore %78 %77 
                        Private bool* %80 = OpAccessChain %49 %79 
                                 bool %81 = OpLoad %80 
                                              OpSelectionMerge %84 None 
                                              OpBranchConditional %81 %83 %87 
                                      %83 = OpLabel 
                         Private f32* %85 = OpAccessChain %27 %79 
                                  f32 %86 = OpLoad %85 
                                              OpStore %82 %86 
                                              OpBranch %84 
                                      %87 = OpLabel 
                         Private f32* %88 = OpAccessChain %27 %79 
                                  f32 %89 = OpLoad %88 
                                  f32 %90 = OpFNegate %89 
                                              OpStore %82 %90 
                                              OpBranch %84 
                                      %84 = OpLabel 
                                  f32 %91 = OpLoad %82 
                        Function f32* %92 = OpAccessChain %62 %79 
                                              OpStore %92 %91 
                                f32_2 %93 = OpLoad %62 
                                              OpStore %27 %93 
                                f32_2 %94 = OpLoad %27 
                                f32_2 %97 = OpFMul %94 %96 
                                              OpStore %27 %97 
                               f32_2 %101 = OpLoad %27 
                               u32_2 %102 = OpConvertFToU %101 
                                              OpStore %100 %102 
                        Private u32* %119 = OpAccessChain %100 %22 
                                 u32 %120 = OpLoad %119 
                                 i32 %121 = OpBitcast %120 
                                              OpStore %123 %117 
                     Function u32_4* %125 = OpAccessChain %123 %121 
                               u32_4 %126 = OpLoad %125 
                               f32_4 %127 = OpBitcast %126 
                                 f32 %128 = OpDot %108 %127 
                        Private f32* %129 = OpAccessChain %103 %22 
                                              OpStore %129 %128 
                        Private u32* %135 = OpAccessChain %100 %22 
                                 u32 %136 = OpLoad %135 
                                 i32 %137 = OpBitcast %136 
                                              OpStore %138 %117 
                     Function u32_4* %139 = OpAccessChain %138 %137 
                               u32_4 %140 = OpLoad %139 
                               f32_4 %141 = OpBitcast %140 
                                 f32 %142 = OpDot %134 %141 
                        Private f32* %143 = OpAccessChain %103 %79 
                                              OpStore %143 %142 
                        Private u32* %149 = OpAccessChain %100 %22 
                                 u32 %150 = OpLoad %149 
                                 i32 %151 = OpBitcast %150 
                                              OpStore %152 %117 
                     Function u32_4* %153 = OpAccessChain %152 %151 
                               u32_4 %154 = OpLoad %153 
                               f32_4 %155 = OpBitcast %154 
                                 f32 %156 = OpDot %148 %155 
                        Private f32* %158 = OpAccessChain %103 %157 
                                              OpStore %158 %156 
                        Private u32* %164 = OpAccessChain %100 %22 
                                 u32 %165 = OpLoad %164 
                                 i32 %166 = OpBitcast %165 
                                              OpStore %167 %117 
                     Function u32_4* %168 = OpAccessChain %167 %166 
                               u32_4 %169 = OpLoad %168 
                               f32_4 %170 = OpBitcast %169 
                                 f32 %171 = OpDot %163 %170 
                        Private f32* %173 = OpAccessChain %103 %172 
                                              OpStore %173 %171 
                               f32_4 %174 = OpLoad %103 
                               f32_4 %175 = OpFNegate %174 
                        Private u32* %176 = OpAccessChain %100 %79 
                                 u32 %177 = OpLoad %176 
                                 i32 %178 = OpBitcast %177 
                                              OpStore %179 %117 
                     Function u32_4* %180 = OpAccessChain %179 %178 
                               u32_4 %181 = OpLoad %180 
                               f32_4 %182 = OpBitcast %181 
                               f32_4 %183 = OpFMul %175 %182 
                               f32_4 %184 = OpLoad %9 
                               f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                               f32_4 %186 = OpFAdd %183 %185 
                                              OpStore %9 %186 
                               f32_4 %189 = OpLoad %9 
                              bool_4 %192 = OpFOrdLessThan %189 %191 
                                              OpStore %188 %192 
                       Private bool* %193 = OpAccessChain %188 %157 
                                bool %194 = OpLoad %193 
                       Private bool* %195 = OpAccessChain %188 %22 
                                bool %196 = OpLoad %195 
                                bool %197 = OpLogicalOr %194 %196 
                       Private bool* %198 = OpAccessChain %188 %22 
                                              OpStore %198 %197 
                       Private bool* %199 = OpAccessChain %188 %172 
                                bool %200 = OpLoad %199 
                       Private bool* %201 = OpAccessChain %188 %79 
                                bool %202 = OpLoad %201 
                                bool %203 = OpLogicalOr %200 %202 
                       Private bool* %204 = OpAccessChain %188 %79 
                                              OpStore %204 %203 
                       Private bool* %205 = OpAccessChain %188 %79 
                                bool %206 = OpLoad %205 
                       Private bool* %207 = OpAccessChain %188 %22 
                                bool %208 = OpLoad %207 
                                bool %209 = OpLogicalOr %206 %208 
                       Private bool* %210 = OpAccessChain %188 %22 
                                              OpStore %210 %209 
                       Private bool* %211 = OpAccessChain %188 %22 
                                bool %212 = OpLoad %211 
                                 i32 %213 = OpSelect %212 %14 %36 
                                 i32 %215 = OpIMul %213 %214 
                                bool %216 = OpINotEqual %215 %36 
                                              OpSelectionMerge %218 None 
                                              OpBranchConditional %216 %217 %218 
                                     %217 = OpLabel 
                                              OpKill
                                     %218 = OpLabel 
                 read_only Texture2D %226 = OpLoad %225 
                             sampler %230 = OpLoad %229 
          read_only Texture2DSampled %232 = OpSampledImage %226 %230 
                               f32_2 %235 = OpLoad vs_TEXCOORD0 
                               f32_4 %236 = OpImageSampleImplicitLod %232 %235 
                               f32_3 %237 = OpVectorShuffle %236 %236 0 1 2 
                                              OpStore %222 %237 
                               f32_3 %240 = OpLoad %222 
                               f32_4 %241 = OpLoad %239 
                               f32_4 %242 = OpVectorShuffle %241 %240 4 5 6 3 
                                              OpStore %239 %242 
                         Output f32* %245 = OpAccessChain %239 %172 
                                              OpStore %245 %243 
                                              OpReturn
                                              OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
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
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 1.17549435e-38);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD4.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 0.349999994;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "vulkan " {
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
}
}
 Pass {
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  GpuProgramID 222977
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ShadowBias;
uniform 	float _LightDirection;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = vec3(_LightDirection) * _ShadowBias.xxx + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(vec3(_LightDirection), u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat6) + 1.0;
    u_xlat6 = u_xlat6 * _ShadowBias.y;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.z = max((-u_xlat0.w), u_xlat0.z);
    gl_Position = u_xlat0;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    SV_TARGET0 = vec4(u_xlat16_0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 229
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %85 %185 %189 %196 %198 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %66 ArrayStride 66 
                                                      OpMemberDecorate %67 0 Offset 67 
                                                      OpMemberDecorate %67 1 Offset 67 
                                                      OpMemberDecorate %67 2 Offset 67 
                                                      OpMemberDecorate %67 3 Offset 67 
                                                      OpDecorate %67 Block 
                                                      OpDecorate %69 DescriptorSet 69 
                                                      OpDecorate %69 Binding 69 
                                                      OpDecorate %85 Location 85 
                                                      OpMemberDecorate %183 0 BuiltIn 183 
                                                      OpMemberDecorate %183 1 BuiltIn 183 
                                                      OpMemberDecorate %183 2 BuiltIn 183 
                                                      OpDecorate %183 Block 
                                                      OpDecorate vs_TEXCOORD5 Location 189 
                                                      OpDecorate vs_TEXCOORD0 Location 196 
                                                      OpDecorate %198 Location 198 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                                              %66 = OpTypeArray %7 %16 
                                              %67 = OpTypeStruct %7 %66 %7 %6 
                                              %68 = OpTypePointer Uniform %67 
Uniform struct {f32_4; f32_4[4]; f32_4; f32;}* %69 = OpVariable Uniform 
                                              %70 = OpTypePointer Uniform %6 
                               Private f32_4* %83 = OpVariable Private 
                                              %84 = OpTypePointer Input %12 
                                 Input f32_3* %85 = OpVariable Input 
                                          u32 %91 = OpConstant 0 
                                              %92 = OpTypePointer Private %6 
                                          u32 %99 = OpConstant 1 
                                Private f32* %107 = OpVariable Private 
                                         f32 %114 = OpConstant 3.674022E-40 
                                         f32 %132 = OpConstant 3.674022E-40 
                                         f32 %133 = OpConstant 3.674022E-40 
                                         u32 %175 = OpConstant 3 
                                             %182 = OpTypeArray %6 %99 
                                             %183 = OpTypeStruct %7 %6 %182 
                                             %184 = OpTypePointer Output %183 
        Output struct {f32_4; f32; f32[1];}* %185 = OpVariable Output 
                                             %187 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %190 = OpTypeVector %6 2 
                                             %195 = OpTypePointer Output %190 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %197 = OpTypePointer Input %190 
                                Input f32_2* %198 = OpVariable Input 
                                Private f32* %200 = OpVariable Private 
                                         f32 %208 = OpConstant 3.674022E-40 
                                       f32_2 %209 = OpConstantComposite %208 %208 
                                             %223 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                 Uniform f32* %71 = OpAccessChain %69 %59 
                                          f32 %72 = OpLoad %71 
                                        f32_3 %73 = OpCompositeConstruct %72 %72 %72 
                               Uniform f32_4* %74 = OpAccessChain %69 %45 
                                        f32_4 %75 = OpLoad %74 
                                        f32_3 %76 = OpVectorShuffle %75 %75 0 0 0 
                                        f32_3 %77 = OpFMul %73 %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
                                        f32_3 %80 = OpFAdd %77 %79 
                                        f32_4 %81 = OpLoad %9 
                                        f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
                                                      OpStore %9 %82 
                                        f32_3 %86 = OpLoad %85 
                               Uniform f32_4* %87 = OpAccessChain %23 %26 %25 
                                        f32_4 %88 = OpLoad %87 
                                        f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
                                          f32 %90 = OpDot %86 %89 
                                 Private f32* %93 = OpAccessChain %83 %91 
                                                      OpStore %93 %90 
                                        f32_3 %94 = OpLoad %85 
                               Uniform f32_4* %95 = OpAccessChain %23 %26 %26 
                                        f32_4 %96 = OpLoad %95 
                                        f32_3 %97 = OpVectorShuffle %96 %96 0 1 2 
                                          f32 %98 = OpDot %94 %97 
                                Private f32* %100 = OpAccessChain %83 %99 
                                                      OpStore %100 %98 
                                       f32_3 %101 = OpLoad %85 
                              Uniform f32_4* %102 = OpAccessChain %23 %26 %45 
                                       f32_4 %103 = OpLoad %102 
                                       f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
                                         f32 %105 = OpDot %101 %104 
                                Private f32* %106 = OpAccessChain %83 %19 
                                                      OpStore %106 %105 
                                       f32_4 %108 = OpLoad %83 
                                       f32_3 %109 = OpVectorShuffle %108 %108 0 1 2 
                                       f32_4 %110 = OpLoad %83 
                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
                                         f32 %112 = OpDot %109 %111 
                                                      OpStore %107 %112 
                                         f32 %113 = OpLoad %107 
                                         f32 %115 = OpExtInst %1 40 %113 %114 
                                                      OpStore %107 %115 
                                         f32 %116 = OpLoad %107 
                                         f32 %117 = OpExtInst %1 32 %116 
                                                      OpStore %107 %117 
                                         f32 %118 = OpLoad %107 
                                       f32_3 %119 = OpCompositeConstruct %118 %118 %118 
                                       f32_4 %120 = OpLoad %83 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                       f32_3 %122 = OpFMul %119 %121 
                                       f32_4 %123 = OpLoad %83 
                                       f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
                                                      OpStore %83 %124 
                                Uniform f32* %125 = OpAccessChain %69 %59 
                                         f32 %126 = OpLoad %125 
                                       f32_3 %127 = OpCompositeConstruct %126 %126 %126 
                                       f32_4 %128 = OpLoad %83 
                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
                                         f32 %130 = OpDot %127 %129 
                                                      OpStore %107 %130 
                                         f32 %131 = OpLoad %107 
                                         f32 %134 = OpExtInst %1 43 %131 %132 %133 
                                                      OpStore %107 %134 
                                         f32 %135 = OpLoad %107 
                                         f32 %136 = OpFNegate %135 
                                         f32 %137 = OpFAdd %136 %133 
                                                      OpStore %107 %137 
                                         f32 %138 = OpLoad %107 
                                Uniform f32* %139 = OpAccessChain %69 %45 %99 
                                         f32 %140 = OpLoad %139 
                                         f32 %141 = OpFMul %138 %140 
                                                      OpStore %107 %141 
                                       f32_4 %142 = OpLoad %83 
                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
                                         f32 %144 = OpLoad %107 
                                       f32_3 %145 = OpCompositeConstruct %144 %144 %144 
                                       f32_3 %146 = OpFMul %143 %145 
                                       f32_4 %147 = OpLoad %9 
                                       f32_3 %148 = OpVectorShuffle %147 %147 0 1 2 
                                       f32_3 %149 = OpFAdd %146 %148 
                                       f32_4 %150 = OpLoad %9 
                                       f32_4 %151 = OpVectorShuffle %150 %149 4 5 6 3 
                                                      OpStore %9 %151 
                                       f32_4 %152 = OpLoad %9 
                                       f32_4 %153 = OpVectorShuffle %152 %152 1 1 1 1 
                              Uniform f32_4* %154 = OpAccessChain %69 %26 %26 
                                       f32_4 %155 = OpLoad %154 
                                       f32_4 %156 = OpFMul %153 %155 
                                                      OpStore %83 %156 
                              Uniform f32_4* %157 = OpAccessChain %69 %26 %25 
                                       f32_4 %158 = OpLoad %157 
                                       f32_4 %159 = OpLoad %9 
                                       f32_4 %160 = OpVectorShuffle %159 %159 0 0 0 0 
                                       f32_4 %161 = OpFMul %158 %160 
                                       f32_4 %162 = OpLoad %83 
                                       f32_4 %163 = OpFAdd %161 %162 
                                                      OpStore %83 %163 
                              Uniform f32_4* %164 = OpAccessChain %69 %26 %45 
                                       f32_4 %165 = OpLoad %164 
                                       f32_4 %166 = OpLoad %9 
                                       f32_4 %167 = OpVectorShuffle %166 %166 2 2 2 2 
                                       f32_4 %168 = OpFMul %165 %167 
                                       f32_4 %169 = OpLoad %83 
                                       f32_4 %170 = OpFAdd %168 %169 
                                                      OpStore %9 %170 
                                       f32_4 %171 = OpLoad %9 
                              Uniform f32_4* %172 = OpAccessChain %69 %26 %59 
                                       f32_4 %173 = OpLoad %172 
                                       f32_4 %174 = OpFAdd %171 %173 
                                                      OpStore %9 %174 
                                Private f32* %176 = OpAccessChain %9 %175 
                                         f32 %177 = OpLoad %176 
                                Private f32* %178 = OpAccessChain %9 %19 
                                         f32 %179 = OpLoad %178 
                                         f32 %180 = OpExtInst %1 37 %177 %179 
                                Private f32* %181 = OpAccessChain %9 %19 
                                                      OpStore %181 %180 
                                       f32_4 %186 = OpLoad %9 
                               Output f32_4* %188 = OpAccessChain %185 %25 
                                                      OpStore %188 %186 
                                       f32_4 %191 = OpLoad %9 
                                       f32_2 %192 = OpVectorShuffle %191 %191 2 3 
                                       f32_4 %193 = OpLoad vs_TEXCOORD5 
                                       f32_4 %194 = OpVectorShuffle %193 %192 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %194 
                                       f32_2 %199 = OpLoad %198 
                                                      OpStore vs_TEXCOORD0 %199 
                                Private f32* %201 = OpAccessChain %9 %99 
                                         f32 %202 = OpLoad %201 
                                Uniform f32* %203 = OpAccessChain %69 %25 %91 
                                         f32 %204 = OpLoad %203 
                                         f32 %205 = OpFMul %202 %204 
                                                      OpStore %200 %205 
                                       f32_4 %206 = OpLoad %9 
                                       f32_2 %207 = OpVectorShuffle %206 %206 0 3 
                                       f32_2 %210 = OpFMul %207 %209 
                                       f32_4 %211 = OpLoad %9 
                                       f32_4 %212 = OpVectorShuffle %211 %210 4 1 5 3 
                                                      OpStore %9 %212 
                                         f32 %213 = OpLoad %200 
                                         f32 %214 = OpFMul %213 %208 
                                Private f32* %215 = OpAccessChain %9 %175 
                                                      OpStore %215 %214 
                                       f32_4 %216 = OpLoad %9 
                                       f32_2 %217 = OpVectorShuffle %216 %216 2 2 
                                       f32_4 %218 = OpLoad %9 
                                       f32_2 %219 = OpVectorShuffle %218 %218 0 3 
                                       f32_2 %220 = OpFAdd %217 %219 
                                       f32_4 %221 = OpLoad vs_TEXCOORD5 
                                       f32_4 %222 = OpVectorShuffle %221 %220 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %222 
                                 Output f32* %224 = OpAccessChain %185 %25 %99 
                                         f32 %225 = OpLoad %224 
                                         f32 %226 = OpFNegate %225 
                                 Output f32* %227 = OpAccessChain %185 %25 %99 
                                                      OpStore %227 %226 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 241
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Fragment %4 "main" %29 %232 %237 
                                              OpExecutionMode %4 OriginUpperLeft 
                                              OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpMemberDecorate %10 0 Offset 10 
                                              OpMemberDecorate %10 1 Offset 10 
                                              OpDecorate %10 Block 
                                              OpDecorate %12 DescriptorSet 12 
                                              OpDecorate %12 Binding 12 
                                              OpDecorate vs_TEXCOORD5 Location 29 
                                              OpDecorate %220 RelaxedPrecision 
                                              OpDecorate %223 RelaxedPrecision 
                                              OpDecorate %223 DescriptorSet 223 
                                              OpDecorate %223 Binding 223 
                                              OpDecorate %224 RelaxedPrecision 
                                              OpDecorate %227 RelaxedPrecision 
                                              OpDecorate %227 DescriptorSet 227 
                                              OpDecorate %227 Binding 227 
                                              OpDecorate %228 RelaxedPrecision 
                                              OpDecorate vs_TEXCOORD0 Location 232 
                                              OpDecorate %235 RelaxedPrecision 
                                              OpDecorate %237 RelaxedPrecision 
                                              OpDecorate %237 Location 237 
                                              OpDecorate %238 RelaxedPrecision 
                                              OpDecorate %239 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypeStruct %7 %6 
                                      %11 = OpTypePointer Uniform %10 
        Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                                      %13 = OpTypeInt 32 1 
                                  i32 %14 = OpConstant 1 
                                      %15 = OpTypePointer Uniform %6 
                                  f32 %19 = OpConstant 3.674022E-40 
                                      %21 = OpTypeInt 32 0 
                                  u32 %22 = OpConstant 0 
                                      %23 = OpTypePointer Private %6 
                                      %25 = OpTypeVector %6 2 
                                      %26 = OpTypePointer Private %25 
                       Private f32_2* %27 = OpVariable Private 
                                      %28 = OpTypePointer Input %7 
                Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                  i32 %36 = OpConstant 0 
                                      %37 = OpTypePointer Uniform %7 
                                  f32 %43 = OpConstant 3.674022E-40 
                                f32_2 %44 = OpConstantComposite %43 %43 
                                      %46 = OpTypeBool 
                                      %47 = OpTypeVector %46 2 
                                      %48 = OpTypePointer Private %47 
                      Private bool_2* %49 = OpVariable Private 
                                      %55 = OpTypeVector %46 4 
                                      %61 = OpTypePointer Function %25 
                                      %64 = OpTypePointer Private %46 
                                      %67 = OpTypePointer Function %6 
                                  u32 %79 = OpConstant 1 
                                  f32 %95 = OpConstant 3.674022E-40 
                                f32_2 %96 = OpConstantComposite %95 %95 
                                      %98 = OpTypeVector %21 2 
                                      %99 = OpTypePointer Private %98 
                      Private u32_2* %100 = OpVariable Private 
                      Private f32_4* %103 = OpVariable Private 
                                 f32 %104 = OpConstant 3.674022E-40 
                                 f32 %105 = OpConstant 3.674022E-40 
                                 f32 %106 = OpConstant 3.674022E-40 
                                 f32 %107 = OpConstant 3.674022E-40 
                               f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                                     %109 = OpTypeVector %21 4 
                                 u32 %110 = OpConstant 4 
                                     %111 = OpTypeArray %109 %110 
                                 u32 %112 = OpConstant 1065353216 
                               u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                               u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                               u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                               u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                            u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                                     %118 = OpTypePointer Private %21 
                                     %122 = OpTypePointer Function %111 
                                     %124 = OpTypePointer Function %109 
                                 f32 %130 = OpConstant 3.674022E-40 
                                 f32 %131 = OpConstant 3.674022E-40 
                                 f32 %132 = OpConstant 3.674022E-40 
                                 f32 %133 = OpConstant 3.674022E-40 
                               f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                                 f32 %144 = OpConstant 3.674022E-40 
                                 f32 %145 = OpConstant 3.674022E-40 
                                 f32 %146 = OpConstant 3.674022E-40 
                                 f32 %147 = OpConstant 3.674022E-40 
                               f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                                 u32 %157 = OpConstant 2 
                                 f32 %159 = OpConstant 3.674022E-40 
                                 f32 %160 = OpConstant 3.674022E-40 
                                 f32 %161 = OpConstant 3.674022E-40 
                                 f32 %162 = OpConstant 3.674022E-40 
                               f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                                 u32 %172 = OpConstant 3 
                                     %187 = OpTypePointer Private %55 
                     Private bool_4* %188 = OpVariable Private 
                                 f32 %190 = OpConstant 3.674022E-40 
                               f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                                 i32 %214 = OpConstant -1 
                        Private f32* %220 = OpVariable Private 
                                     %221 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %222 = OpTypePointer UniformConstant %221 
UniformConstant read_only Texture2D* %223 = OpVariable UniformConstant 
                                     %225 = OpTypeSampler 
                                     %226 = OpTypePointer UniformConstant %225 
            UniformConstant sampler* %227 = OpVariable UniformConstant 
                                     %229 = OpTypeSampledImage %221 
                                     %231 = OpTypePointer Input %25 
                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                     %236 = OpTypePointer Output %7 
                       Output f32_4* %237 = OpVariable Output 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                      Function f32_2* %62 = OpVariable Function 
                        Function f32* %68 = OpVariable Function 
                        Function f32* %82 = OpVariable Function 
                  Function u32_4[4]* %123 = OpVariable Function 
                  Function u32_4[4]* %138 = OpVariable Function 
                  Function u32_4[4]* %152 = OpVariable Function 
                  Function u32_4[4]* %167 = OpVariable Function 
                  Function u32_4[4]* %179 = OpVariable Function 
                         Uniform f32* %16 = OpAccessChain %12 %14 
                                  f32 %17 = OpLoad %16 
                                  f32 %18 = OpFNegate %17 
                                  f32 %20 = OpFAdd %18 %19 
                         Private f32* %24 = OpAccessChain %9 %22 
                                              OpStore %24 %20 
                                f32_4 %30 = OpLoad vs_TEXCOORD5 
                                f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                                f32_4 %32 = OpLoad vs_TEXCOORD5 
                                f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                                f32_2 %34 = OpFDiv %31 %33 
                                              OpStore %27 %34 
                                f32_2 %35 = OpLoad %27 
                       Uniform f32_4* %38 = OpAccessChain %12 %36 
                                f32_4 %39 = OpLoad %38 
                                f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                                f32_2 %41 = OpFMul %35 %40 
                                              OpStore %27 %41 
                                f32_2 %42 = OpLoad %27 
                                f32_2 %45 = OpFMul %42 %44 
                                              OpStore %27 %45 
                                f32_2 %50 = OpLoad %27 
                                f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                                f32_2 %52 = OpLoad %27 
                                f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                f32_4 %54 = OpFNegate %53 
                               bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                               bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                              OpStore %49 %57 
                                f32_2 %58 = OpLoad %27 
                                f32_2 %59 = OpExtInst %1 4 %58 
                                f32_2 %60 = OpExtInst %1 10 %59 
                                              OpStore %27 %60 
                                f32_2 %63 = OpLoad %27 
                                              OpStore %62 %63 
                        Private bool* %65 = OpAccessChain %49 %22 
                                 bool %66 = OpLoad %65 
                                              OpSelectionMerge %70 None 
                                              OpBranchConditional %66 %69 %73 
                                      %69 = OpLabel 
                         Private f32* %71 = OpAccessChain %27 %22 
                                  f32 %72 = OpLoad %71 
                                              OpStore %68 %72 
                                              OpBranch %70 
                                      %73 = OpLabel 
                         Private f32* %74 = OpAccessChain %27 %22 
                                  f32 %75 = OpLoad %74 
                                  f32 %76 = OpFNegate %75 
                                              OpStore %68 %76 
                                              OpBranch %70 
                                      %70 = OpLabel 
                                  f32 %77 = OpLoad %68 
                        Function f32* %78 = OpAccessChain %62 %22 
                                              OpStore %78 %77 
                        Private bool* %80 = OpAccessChain %49 %79 
                                 bool %81 = OpLoad %80 
                                              OpSelectionMerge %84 None 
                                              OpBranchConditional %81 %83 %87 
                                      %83 = OpLabel 
                         Private f32* %85 = OpAccessChain %27 %79 
                                  f32 %86 = OpLoad %85 
                                              OpStore %82 %86 
                                              OpBranch %84 
                                      %87 = OpLabel 
                         Private f32* %88 = OpAccessChain %27 %79 
                                  f32 %89 = OpLoad %88 
                                  f32 %90 = OpFNegate %89 
                                              OpStore %82 %90 
                                              OpBranch %84 
                                      %84 = OpLabel 
                                  f32 %91 = OpLoad %82 
                        Function f32* %92 = OpAccessChain %62 %79 
                                              OpStore %92 %91 
                                f32_2 %93 = OpLoad %62 
                                              OpStore %27 %93 
                                f32_2 %94 = OpLoad %27 
                                f32_2 %97 = OpFMul %94 %96 
                                              OpStore %27 %97 
                               f32_2 %101 = OpLoad %27 
                               u32_2 %102 = OpConvertFToU %101 
                                              OpStore %100 %102 
                        Private u32* %119 = OpAccessChain %100 %22 
                                 u32 %120 = OpLoad %119 
                                 i32 %121 = OpBitcast %120 
                                              OpStore %123 %117 
                     Function u32_4* %125 = OpAccessChain %123 %121 
                               u32_4 %126 = OpLoad %125 
                               f32_4 %127 = OpBitcast %126 
                                 f32 %128 = OpDot %108 %127 
                        Private f32* %129 = OpAccessChain %103 %22 
                                              OpStore %129 %128 
                        Private u32* %135 = OpAccessChain %100 %22 
                                 u32 %136 = OpLoad %135 
                                 i32 %137 = OpBitcast %136 
                                              OpStore %138 %117 
                     Function u32_4* %139 = OpAccessChain %138 %137 
                               u32_4 %140 = OpLoad %139 
                               f32_4 %141 = OpBitcast %140 
                                 f32 %142 = OpDot %134 %141 
                        Private f32* %143 = OpAccessChain %103 %79 
                                              OpStore %143 %142 
                        Private u32* %149 = OpAccessChain %100 %22 
                                 u32 %150 = OpLoad %149 
                                 i32 %151 = OpBitcast %150 
                                              OpStore %152 %117 
                     Function u32_4* %153 = OpAccessChain %152 %151 
                               u32_4 %154 = OpLoad %153 
                               f32_4 %155 = OpBitcast %154 
                                 f32 %156 = OpDot %148 %155 
                        Private f32* %158 = OpAccessChain %103 %157 
                                              OpStore %158 %156 
                        Private u32* %164 = OpAccessChain %100 %22 
                                 u32 %165 = OpLoad %164 
                                 i32 %166 = OpBitcast %165 
                                              OpStore %167 %117 
                     Function u32_4* %168 = OpAccessChain %167 %166 
                               u32_4 %169 = OpLoad %168 
                               f32_4 %170 = OpBitcast %169 
                                 f32 %171 = OpDot %163 %170 
                        Private f32* %173 = OpAccessChain %103 %172 
                                              OpStore %173 %171 
                               f32_4 %174 = OpLoad %103 
                               f32_4 %175 = OpFNegate %174 
                        Private u32* %176 = OpAccessChain %100 %79 
                                 u32 %177 = OpLoad %176 
                                 i32 %178 = OpBitcast %177 
                                              OpStore %179 %117 
                     Function u32_4* %180 = OpAccessChain %179 %178 
                               u32_4 %181 = OpLoad %180 
                               f32_4 %182 = OpBitcast %181 
                               f32_4 %183 = OpFMul %175 %182 
                               f32_4 %184 = OpLoad %9 
                               f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                               f32_4 %186 = OpFAdd %183 %185 
                                              OpStore %9 %186 
                               f32_4 %189 = OpLoad %9 
                              bool_4 %192 = OpFOrdLessThan %189 %191 
                                              OpStore %188 %192 
                       Private bool* %193 = OpAccessChain %188 %157 
                                bool %194 = OpLoad %193 
                       Private bool* %195 = OpAccessChain %188 %22 
                                bool %196 = OpLoad %195 
                                bool %197 = OpLogicalOr %194 %196 
                       Private bool* %198 = OpAccessChain %188 %22 
                                              OpStore %198 %197 
                       Private bool* %199 = OpAccessChain %188 %172 
                                bool %200 = OpLoad %199 
                       Private bool* %201 = OpAccessChain %188 %79 
                                bool %202 = OpLoad %201 
                                bool %203 = OpLogicalOr %200 %202 
                       Private bool* %204 = OpAccessChain %188 %79 
                                              OpStore %204 %203 
                       Private bool* %205 = OpAccessChain %188 %79 
                                bool %206 = OpLoad %205 
                       Private bool* %207 = OpAccessChain %188 %22 
                                bool %208 = OpLoad %207 
                                bool %209 = OpLogicalOr %206 %208 
                       Private bool* %210 = OpAccessChain %188 %22 
                                              OpStore %210 %209 
                       Private bool* %211 = OpAccessChain %188 %22 
                                bool %212 = OpLoad %211 
                                 i32 %213 = OpSelect %212 %14 %36 
                                 i32 %215 = OpIMul %213 %214 
                                bool %216 = OpINotEqual %215 %36 
                                              OpSelectionMerge %218 None 
                                              OpBranchConditional %216 %217 %218 
                                     %217 = OpLabel 
                                              OpKill
                                     %218 = OpLabel 
                 read_only Texture2D %224 = OpLoad %223 
                             sampler %228 = OpLoad %227 
          read_only Texture2DSampled %230 = OpSampledImage %224 %228 
                               f32_2 %233 = OpLoad vs_TEXCOORD0 
                               f32_4 %234 = OpImageSampleImplicitLod %230 %233 
                                 f32 %235 = OpCompositeExtract %234 3 
                                              OpStore %220 %235 
                                 f32 %238 = OpLoad %220 
                               f32_4 %239 = OpCompositeConstruct %238 %238 %238 %238 
                                              OpStore %237 %239 
                                              OpReturn
                                              OpFunctionEnd
"
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 229
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %85 %185 %189 %196 %198 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %66 ArrayStride 66 
                                                      OpMemberDecorate %67 0 Offset 67 
                                                      OpMemberDecorate %67 1 Offset 67 
                                                      OpMemberDecorate %67 2 Offset 67 
                                                      OpMemberDecorate %67 3 Offset 67 
                                                      OpDecorate %67 Block 
                                                      OpDecorate %69 DescriptorSet 69 
                                                      OpDecorate %69 Binding 69 
                                                      OpDecorate %85 Location 85 
                                                      OpMemberDecorate %183 0 BuiltIn 183 
                                                      OpMemberDecorate %183 1 BuiltIn 183 
                                                      OpMemberDecorate %183 2 BuiltIn 183 
                                                      OpDecorate %183 Block 
                                                      OpDecorate vs_TEXCOORD5 Location 189 
                                                      OpDecorate vs_TEXCOORD0 Location 196 
                                                      OpDecorate %198 Location 198 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                                              %66 = OpTypeArray %7 %16 
                                              %67 = OpTypeStruct %7 %66 %7 %6 
                                              %68 = OpTypePointer Uniform %67 
Uniform struct {f32_4; f32_4[4]; f32_4; f32;}* %69 = OpVariable Uniform 
                                              %70 = OpTypePointer Uniform %6 
                               Private f32_4* %83 = OpVariable Private 
                                              %84 = OpTypePointer Input %12 
                                 Input f32_3* %85 = OpVariable Input 
                                          u32 %91 = OpConstant 0 
                                              %92 = OpTypePointer Private %6 
                                          u32 %99 = OpConstant 1 
                                Private f32* %107 = OpVariable Private 
                                         f32 %114 = OpConstant 3.674022E-40 
                                         f32 %132 = OpConstant 3.674022E-40 
                                         f32 %133 = OpConstant 3.674022E-40 
                                         u32 %175 = OpConstant 3 
                                             %182 = OpTypeArray %6 %99 
                                             %183 = OpTypeStruct %7 %6 %182 
                                             %184 = OpTypePointer Output %183 
        Output struct {f32_4; f32; f32[1];}* %185 = OpVariable Output 
                                             %187 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %190 = OpTypeVector %6 2 
                                             %195 = OpTypePointer Output %190 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %197 = OpTypePointer Input %190 
                                Input f32_2* %198 = OpVariable Input 
                                Private f32* %200 = OpVariable Private 
                                         f32 %208 = OpConstant 3.674022E-40 
                                       f32_2 %209 = OpConstantComposite %208 %208 
                                             %223 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                 Uniform f32* %71 = OpAccessChain %69 %59 
                                          f32 %72 = OpLoad %71 
                                        f32_3 %73 = OpCompositeConstruct %72 %72 %72 
                               Uniform f32_4* %74 = OpAccessChain %69 %45 
                                        f32_4 %75 = OpLoad %74 
                                        f32_3 %76 = OpVectorShuffle %75 %75 0 0 0 
                                        f32_3 %77 = OpFMul %73 %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
                                        f32_3 %80 = OpFAdd %77 %79 
                                        f32_4 %81 = OpLoad %9 
                                        f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
                                                      OpStore %9 %82 
                                        f32_3 %86 = OpLoad %85 
                               Uniform f32_4* %87 = OpAccessChain %23 %26 %25 
                                        f32_4 %88 = OpLoad %87 
                                        f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
                                          f32 %90 = OpDot %86 %89 
                                 Private f32* %93 = OpAccessChain %83 %91 
                                                      OpStore %93 %90 
                                        f32_3 %94 = OpLoad %85 
                               Uniform f32_4* %95 = OpAccessChain %23 %26 %26 
                                        f32_4 %96 = OpLoad %95 
                                        f32_3 %97 = OpVectorShuffle %96 %96 0 1 2 
                                          f32 %98 = OpDot %94 %97 
                                Private f32* %100 = OpAccessChain %83 %99 
                                                      OpStore %100 %98 
                                       f32_3 %101 = OpLoad %85 
                              Uniform f32_4* %102 = OpAccessChain %23 %26 %45 
                                       f32_4 %103 = OpLoad %102 
                                       f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
                                         f32 %105 = OpDot %101 %104 
                                Private f32* %106 = OpAccessChain %83 %19 
                                                      OpStore %106 %105 
                                       f32_4 %108 = OpLoad %83 
                                       f32_3 %109 = OpVectorShuffle %108 %108 0 1 2 
                                       f32_4 %110 = OpLoad %83 
                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
                                         f32 %112 = OpDot %109 %111 
                                                      OpStore %107 %112 
                                         f32 %113 = OpLoad %107 
                                         f32 %115 = OpExtInst %1 40 %113 %114 
                                                      OpStore %107 %115 
                                         f32 %116 = OpLoad %107 
                                         f32 %117 = OpExtInst %1 32 %116 
                                                      OpStore %107 %117 
                                         f32 %118 = OpLoad %107 
                                       f32_3 %119 = OpCompositeConstruct %118 %118 %118 
                                       f32_4 %120 = OpLoad %83 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                       f32_3 %122 = OpFMul %119 %121 
                                       f32_4 %123 = OpLoad %83 
                                       f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
                                                      OpStore %83 %124 
                                Uniform f32* %125 = OpAccessChain %69 %59 
                                         f32 %126 = OpLoad %125 
                                       f32_3 %127 = OpCompositeConstruct %126 %126 %126 
                                       f32_4 %128 = OpLoad %83 
                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
                                         f32 %130 = OpDot %127 %129 
                                                      OpStore %107 %130 
                                         f32 %131 = OpLoad %107 
                                         f32 %134 = OpExtInst %1 43 %131 %132 %133 
                                                      OpStore %107 %134 
                                         f32 %135 = OpLoad %107 
                                         f32 %136 = OpFNegate %135 
                                         f32 %137 = OpFAdd %136 %133 
                                                      OpStore %107 %137 
                                         f32 %138 = OpLoad %107 
                                Uniform f32* %139 = OpAccessChain %69 %45 %99 
                                         f32 %140 = OpLoad %139 
                                         f32 %141 = OpFMul %138 %140 
                                                      OpStore %107 %141 
                                       f32_4 %142 = OpLoad %83 
                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
                                         f32 %144 = OpLoad %107 
                                       f32_3 %145 = OpCompositeConstruct %144 %144 %144 
                                       f32_3 %146 = OpFMul %143 %145 
                                       f32_4 %147 = OpLoad %9 
                                       f32_3 %148 = OpVectorShuffle %147 %147 0 1 2 
                                       f32_3 %149 = OpFAdd %146 %148 
                                       f32_4 %150 = OpLoad %9 
                                       f32_4 %151 = OpVectorShuffle %150 %149 4 5 6 3 
                                                      OpStore %9 %151 
                                       f32_4 %152 = OpLoad %9 
                                       f32_4 %153 = OpVectorShuffle %152 %152 1 1 1 1 
                              Uniform f32_4* %154 = OpAccessChain %69 %26 %26 
                                       f32_4 %155 = OpLoad %154 
                                       f32_4 %156 = OpFMul %153 %155 
                                                      OpStore %83 %156 
                              Uniform f32_4* %157 = OpAccessChain %69 %26 %25 
                                       f32_4 %158 = OpLoad %157 
                                       f32_4 %159 = OpLoad %9 
                                       f32_4 %160 = OpVectorShuffle %159 %159 0 0 0 0 
                                       f32_4 %161 = OpFMul %158 %160 
                                       f32_4 %162 = OpLoad %83 
                                       f32_4 %163 = OpFAdd %161 %162 
                                                      OpStore %83 %163 
                              Uniform f32_4* %164 = OpAccessChain %69 %26 %45 
                                       f32_4 %165 = OpLoad %164 
                                       f32_4 %166 = OpLoad %9 
                                       f32_4 %167 = OpVectorShuffle %166 %166 2 2 2 2 
                                       f32_4 %168 = OpFMul %165 %167 
                                       f32_4 %169 = OpLoad %83 
                                       f32_4 %170 = OpFAdd %168 %169 
                                                      OpStore %9 %170 
                                       f32_4 %171 = OpLoad %9 
                              Uniform f32_4* %172 = OpAccessChain %69 %26 %59 
                                       f32_4 %173 = OpLoad %172 
                                       f32_4 %174 = OpFAdd %171 %173 
                                                      OpStore %9 %174 
                                Private f32* %176 = OpAccessChain %9 %175 
                                         f32 %177 = OpLoad %176 
                                Private f32* %178 = OpAccessChain %9 %19 
                                         f32 %179 = OpLoad %178 
                                         f32 %180 = OpExtInst %1 37 %177 %179 
                                Private f32* %181 = OpAccessChain %9 %19 
                                                      OpStore %181 %180 
                                       f32_4 %186 = OpLoad %9 
                               Output f32_4* %188 = OpAccessChain %185 %25 
                                                      OpStore %188 %186 
                                       f32_4 %191 = OpLoad %9 
                                       f32_2 %192 = OpVectorShuffle %191 %191 2 3 
                                       f32_4 %193 = OpLoad vs_TEXCOORD5 
                                       f32_4 %194 = OpVectorShuffle %193 %192 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %194 
                                       f32_2 %199 = OpLoad %198 
                                                      OpStore vs_TEXCOORD0 %199 
                                Private f32* %201 = OpAccessChain %9 %99 
                                         f32 %202 = OpLoad %201 
                                Uniform f32* %203 = OpAccessChain %69 %25 %91 
                                         f32 %204 = OpLoad %203 
                                         f32 %205 = OpFMul %202 %204 
                                                      OpStore %200 %205 
                                       f32_4 %206 = OpLoad %9 
                                       f32_2 %207 = OpVectorShuffle %206 %206 0 3 
                                       f32_2 %210 = OpFMul %207 %209 
                                       f32_4 %211 = OpLoad %9 
                                       f32_4 %212 = OpVectorShuffle %211 %210 4 1 5 3 
                                                      OpStore %9 %212 
                                         f32 %213 = OpLoad %200 
                                         f32 %214 = OpFMul %213 %208 
                                Private f32* %215 = OpAccessChain %9 %175 
                                                      OpStore %215 %214 
                                       f32_4 %216 = OpLoad %9 
                                       f32_2 %217 = OpVectorShuffle %216 %216 2 2 
                                       f32_4 %218 = OpLoad %9 
                                       f32_2 %219 = OpVectorShuffle %218 %218 0 3 
                                       f32_2 %220 = OpFAdd %217 %219 
                                       f32_4 %221 = OpLoad vs_TEXCOORD5 
                                       f32_4 %222 = OpVectorShuffle %221 %220 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %222 
                                 Output f32* %224 = OpAccessChain %185 %25 %99 
                                         f32 %225 = OpLoad %224 
                                         f32 %226 = OpFNegate %225 
                                 Output f32* %227 = OpAccessChain %185 %25 %99 
                                                      OpStore %227 %226 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 241
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Fragment %4 "main" %29 %232 %237 
                                              OpExecutionMode %4 OriginUpperLeft 
                                              OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpMemberDecorate %10 0 Offset 10 
                                              OpMemberDecorate %10 1 Offset 10 
                                              OpDecorate %10 Block 
                                              OpDecorate %12 DescriptorSet 12 
                                              OpDecorate %12 Binding 12 
                                              OpDecorate vs_TEXCOORD5 Location 29 
                                              OpDecorate %220 RelaxedPrecision 
                                              OpDecorate %223 RelaxedPrecision 
                                              OpDecorate %223 DescriptorSet 223 
                                              OpDecorate %223 Binding 223 
                                              OpDecorate %224 RelaxedPrecision 
                                              OpDecorate %227 RelaxedPrecision 
                                              OpDecorate %227 DescriptorSet 227 
                                              OpDecorate %227 Binding 227 
                                              OpDecorate %228 RelaxedPrecision 
                                              OpDecorate vs_TEXCOORD0 Location 232 
                                              OpDecorate %235 RelaxedPrecision 
                                              OpDecorate %237 RelaxedPrecision 
                                              OpDecorate %237 Location 237 
                                              OpDecorate %238 RelaxedPrecision 
                                              OpDecorate %239 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypeStruct %7 %6 
                                      %11 = OpTypePointer Uniform %10 
        Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                                      %13 = OpTypeInt 32 1 
                                  i32 %14 = OpConstant 1 
                                      %15 = OpTypePointer Uniform %6 
                                  f32 %19 = OpConstant 3.674022E-40 
                                      %21 = OpTypeInt 32 0 
                                  u32 %22 = OpConstant 0 
                                      %23 = OpTypePointer Private %6 
                                      %25 = OpTypeVector %6 2 
                                      %26 = OpTypePointer Private %25 
                       Private f32_2* %27 = OpVariable Private 
                                      %28 = OpTypePointer Input %7 
                Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                  i32 %36 = OpConstant 0 
                                      %37 = OpTypePointer Uniform %7 
                                  f32 %43 = OpConstant 3.674022E-40 
                                f32_2 %44 = OpConstantComposite %43 %43 
                                      %46 = OpTypeBool 
                                      %47 = OpTypeVector %46 2 
                                      %48 = OpTypePointer Private %47 
                      Private bool_2* %49 = OpVariable Private 
                                      %55 = OpTypeVector %46 4 
                                      %61 = OpTypePointer Function %25 
                                      %64 = OpTypePointer Private %46 
                                      %67 = OpTypePointer Function %6 
                                  u32 %79 = OpConstant 1 
                                  f32 %95 = OpConstant 3.674022E-40 
                                f32_2 %96 = OpConstantComposite %95 %95 
                                      %98 = OpTypeVector %21 2 
                                      %99 = OpTypePointer Private %98 
                      Private u32_2* %100 = OpVariable Private 
                      Private f32_4* %103 = OpVariable Private 
                                 f32 %104 = OpConstant 3.674022E-40 
                                 f32 %105 = OpConstant 3.674022E-40 
                                 f32 %106 = OpConstant 3.674022E-40 
                                 f32 %107 = OpConstant 3.674022E-40 
                               f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                                     %109 = OpTypeVector %21 4 
                                 u32 %110 = OpConstant 4 
                                     %111 = OpTypeArray %109 %110 
                                 u32 %112 = OpConstant 1065353216 
                               u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                               u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                               u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                               u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                            u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                                     %118 = OpTypePointer Private %21 
                                     %122 = OpTypePointer Function %111 
                                     %124 = OpTypePointer Function %109 
                                 f32 %130 = OpConstant 3.674022E-40 
                                 f32 %131 = OpConstant 3.674022E-40 
                                 f32 %132 = OpConstant 3.674022E-40 
                                 f32 %133 = OpConstant 3.674022E-40 
                               f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                                 f32 %144 = OpConstant 3.674022E-40 
                                 f32 %145 = OpConstant 3.674022E-40 
                                 f32 %146 = OpConstant 3.674022E-40 
                                 f32 %147 = OpConstant 3.674022E-40 
                               f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                                 u32 %157 = OpConstant 2 
                                 f32 %159 = OpConstant 3.674022E-40 
                                 f32 %160 = OpConstant 3.674022E-40 
                                 f32 %161 = OpConstant 3.674022E-40 
                                 f32 %162 = OpConstant 3.674022E-40 
                               f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                                 u32 %172 = OpConstant 3 
                                     %187 = OpTypePointer Private %55 
                     Private bool_4* %188 = OpVariable Private 
                                 f32 %190 = OpConstant 3.674022E-40 
                               f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                                 i32 %214 = OpConstant -1 
                        Private f32* %220 = OpVariable Private 
                                     %221 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %222 = OpTypePointer UniformConstant %221 
UniformConstant read_only Texture2D* %223 = OpVariable UniformConstant 
                                     %225 = OpTypeSampler 
                                     %226 = OpTypePointer UniformConstant %225 
            UniformConstant sampler* %227 = OpVariable UniformConstant 
                                     %229 = OpTypeSampledImage %221 
                                     %231 = OpTypePointer Input %25 
                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                     %236 = OpTypePointer Output %7 
                       Output f32_4* %237 = OpVariable Output 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                      Function f32_2* %62 = OpVariable Function 
                        Function f32* %68 = OpVariable Function 
                        Function f32* %82 = OpVariable Function 
                  Function u32_4[4]* %123 = OpVariable Function 
                  Function u32_4[4]* %138 = OpVariable Function 
                  Function u32_4[4]* %152 = OpVariable Function 
                  Function u32_4[4]* %167 = OpVariable Function 
                  Function u32_4[4]* %179 = OpVariable Function 
                         Uniform f32* %16 = OpAccessChain %12 %14 
                                  f32 %17 = OpLoad %16 
                                  f32 %18 = OpFNegate %17 
                                  f32 %20 = OpFAdd %18 %19 
                         Private f32* %24 = OpAccessChain %9 %22 
                                              OpStore %24 %20 
                                f32_4 %30 = OpLoad vs_TEXCOORD5 
                                f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                                f32_4 %32 = OpLoad vs_TEXCOORD5 
                                f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                                f32_2 %34 = OpFDiv %31 %33 
                                              OpStore %27 %34 
                                f32_2 %35 = OpLoad %27 
                       Uniform f32_4* %38 = OpAccessChain %12 %36 
                                f32_4 %39 = OpLoad %38 
                                f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                                f32_2 %41 = OpFMul %35 %40 
                                              OpStore %27 %41 
                                f32_2 %42 = OpLoad %27 
                                f32_2 %45 = OpFMul %42 %44 
                                              OpStore %27 %45 
                                f32_2 %50 = OpLoad %27 
                                f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                                f32_2 %52 = OpLoad %27 
                                f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                f32_4 %54 = OpFNegate %53 
                               bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                               bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                              OpStore %49 %57 
                                f32_2 %58 = OpLoad %27 
                                f32_2 %59 = OpExtInst %1 4 %58 
                                f32_2 %60 = OpExtInst %1 10 %59 
                                              OpStore %27 %60 
                                f32_2 %63 = OpLoad %27 
                                              OpStore %62 %63 
                        Private bool* %65 = OpAccessChain %49 %22 
                                 bool %66 = OpLoad %65 
                                              OpSelectionMerge %70 None 
                                              OpBranchConditional %66 %69 %73 
                                      %69 = OpLabel 
                         Private f32* %71 = OpAccessChain %27 %22 
                                  f32 %72 = OpLoad %71 
                                              OpStore %68 %72 
                                              OpBranch %70 
                                      %73 = OpLabel 
                         Private f32* %74 = OpAccessChain %27 %22 
                                  f32 %75 = OpLoad %74 
                                  f32 %76 = OpFNegate %75 
                                              OpStore %68 %76 
                                              OpBranch %70 
                                      %70 = OpLabel 
                                  f32 %77 = OpLoad %68 
                        Function f32* %78 = OpAccessChain %62 %22 
                                              OpStore %78 %77 
                        Private bool* %80 = OpAccessChain %49 %79 
                                 bool %81 = OpLoad %80 
                                              OpSelectionMerge %84 None 
                                              OpBranchConditional %81 %83 %87 
                                      %83 = OpLabel 
                         Private f32* %85 = OpAccessChain %27 %79 
                                  f32 %86 = OpLoad %85 
                                              OpStore %82 %86 
                                              OpBranch %84 
                                      %87 = OpLabel 
                         Private f32* %88 = OpAccessChain %27 %79 
                                  f32 %89 = OpLoad %88 
                                  f32 %90 = OpFNegate %89 
                                              OpStore %82 %90 
                                              OpBranch %84 
                                      %84 = OpLabel 
                                  f32 %91 = OpLoad %82 
                        Function f32* %92 = OpAccessChain %62 %79 
                                              OpStore %92 %91 
                                f32_2 %93 = OpLoad %62 
                                              OpStore %27 %93 
                                f32_2 %94 = OpLoad %27 
                                f32_2 %97 = OpFMul %94 %96 
                                              OpStore %27 %97 
                               f32_2 %101 = OpLoad %27 
                               u32_2 %102 = OpConvertFToU %101 
                                              OpStore %100 %102 
                        Private u32* %119 = OpAccessChain %100 %22 
                                 u32 %120 = OpLoad %119 
                                 i32 %121 = OpBitcast %120 
                                              OpStore %123 %117 
                     Function u32_4* %125 = OpAccessChain %123 %121 
                               u32_4 %126 = OpLoad %125 
                               f32_4 %127 = OpBitcast %126 
                                 f32 %128 = OpDot %108 %127 
                        Private f32* %129 = OpAccessChain %103 %22 
                                              OpStore %129 %128 
                        Private u32* %135 = OpAccessChain %100 %22 
                                 u32 %136 = OpLoad %135 
                                 i32 %137 = OpBitcast %136 
                                              OpStore %138 %117 
                     Function u32_4* %139 = OpAccessChain %138 %137 
                               u32_4 %140 = OpLoad %139 
                               f32_4 %141 = OpBitcast %140 
                                 f32 %142 = OpDot %134 %141 
                        Private f32* %143 = OpAccessChain %103 %79 
                                              OpStore %143 %142 
                        Private u32* %149 = OpAccessChain %100 %22 
                                 u32 %150 = OpLoad %149 
                                 i32 %151 = OpBitcast %150 
                                              OpStore %152 %117 
                     Function u32_4* %153 = OpAccessChain %152 %151 
                               u32_4 %154 = OpLoad %153 
                               f32_4 %155 = OpBitcast %154 
                                 f32 %156 = OpDot %148 %155 
                        Private f32* %158 = OpAccessChain %103 %157 
                                              OpStore %158 %156 
                        Private u32* %164 = OpAccessChain %100 %22 
                                 u32 %165 = OpLoad %164 
                                 i32 %166 = OpBitcast %165 
                                              OpStore %167 %117 
                     Function u32_4* %168 = OpAccessChain %167 %166 
                               u32_4 %169 = OpLoad %168 
                               f32_4 %170 = OpBitcast %169 
                                 f32 %171 = OpDot %163 %170 
                        Private f32* %173 = OpAccessChain %103 %172 
                                              OpStore %173 %171 
                               f32_4 %174 = OpLoad %103 
                               f32_4 %175 = OpFNegate %174 
                        Private u32* %176 = OpAccessChain %100 %79 
                                 u32 %177 = OpLoad %176 
                                 i32 %178 = OpBitcast %177 
                                              OpStore %179 %117 
                     Function u32_4* %180 = OpAccessChain %179 %178 
                               u32_4 %181 = OpLoad %180 
                               f32_4 %182 = OpBitcast %181 
                               f32_4 %183 = OpFMul %175 %182 
                               f32_4 %184 = OpLoad %9 
                               f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                               f32_4 %186 = OpFAdd %183 %185 
                                              OpStore %9 %186 
                               f32_4 %189 = OpLoad %9 
                              bool_4 %192 = OpFOrdLessThan %189 %191 
                                              OpStore %188 %192 
                       Private bool* %193 = OpAccessChain %188 %157 
                                bool %194 = OpLoad %193 
                       Private bool* %195 = OpAccessChain %188 %22 
                                bool %196 = OpLoad %195 
                                bool %197 = OpLogicalOr %194 %196 
                       Private bool* %198 = OpAccessChain %188 %22 
                                              OpStore %198 %197 
                       Private bool* %199 = OpAccessChain %188 %172 
                                bool %200 = OpLoad %199 
                       Private bool* %201 = OpAccessChain %188 %79 
                                bool %202 = OpLoad %201 
                                bool %203 = OpLogicalOr %200 %202 
                       Private bool* %204 = OpAccessChain %188 %79 
                                              OpStore %204 %203 
                       Private bool* %205 = OpAccessChain %188 %79 
                                bool %206 = OpLoad %205 
                       Private bool* %207 = OpAccessChain %188 %22 
                                bool %208 = OpLoad %207 
                                bool %209 = OpLogicalOr %206 %208 
                       Private bool* %210 = OpAccessChain %188 %22 
                                              OpStore %210 %209 
                       Private bool* %211 = OpAccessChain %188 %22 
                                bool %212 = OpLoad %211 
                                 i32 %213 = OpSelect %212 %14 %36 
                                 i32 %215 = OpIMul %213 %214 
                                bool %216 = OpINotEqual %215 %36 
                                              OpSelectionMerge %218 None 
                                              OpBranchConditional %216 %217 %218 
                                     %217 = OpLabel 
                                              OpKill
                                     %218 = OpLabel 
                 read_only Texture2D %224 = OpLoad %223 
                             sampler %228 = OpLoad %227 
          read_only Texture2DSampled %230 = OpSampledImage %224 %228 
                               f32_2 %233 = OpLoad vs_TEXCOORD0 
                               f32_4 %234 = OpImageSampleImplicitLod %230 %233 
                                 f32 %235 = OpCompositeExtract %234 3 
                                              OpStore %220 %235 
                                 f32 %238 = OpLoad %220 
                               f32_4 %239 = OpCompositeConstruct %238 %238 %238 %238 
                                              OpStore %237 %239 
                                              OpReturn
                                              OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ShadowBias;
uniform 	float _LightDirection;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = vec3(_LightDirection) * _ShadowBias.xxx + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(vec3(_LightDirection), u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat6) + 1.0;
    u_xlat6 = u_xlat6 * _ShadowBias.y;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.z = max((-u_xlat0.w), u_xlat0.z);
    gl_Position = u_xlat0;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    SV_TARGET0 = vec4(u_xlat16_0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 229
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %85 %185 %189 %196 %198 
                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %20 ArrayStride 20 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 RelaxedPrecision 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %66 ArrayStride 66 
                                                      OpMemberDecorate %67 0 Offset 67 
                                                      OpMemberDecorate %67 1 Offset 67 
                                                      OpMemberDecorate %67 2 Offset 67 
                                                      OpMemberDecorate %67 3 Offset 67 
                                                      OpDecorate %67 Block 
                                                      OpDecorate %69 DescriptorSet 69 
                                                      OpDecorate %69 Binding 69 
                                                      OpDecorate %85 Location 85 
                                                      OpMemberDecorate %183 0 BuiltIn 183 
                                                      OpMemberDecorate %183 1 BuiltIn 183 
                                                      OpMemberDecorate %183 2 BuiltIn 183 
                                                      OpDecorate %183 Block 
                                                      OpDecorate vs_TEXCOORD5 Location 189 
                                                      OpDecorate vs_TEXCOORD0 Location 196 
                                                      OpDecorate %198 Location 198 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %7 %19 
                                              %21 = OpTypeStruct %17 %18 %7 %7 %7 %20 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %7 
                                          i32 %45 = OpConstant 2 
                                          i32 %59 = OpConstant 3 
                                              %66 = OpTypeArray %7 %16 
                                              %67 = OpTypeStruct %7 %66 %7 %6 
                                              %68 = OpTypePointer Uniform %67 
Uniform struct {f32_4; f32_4[4]; f32_4; f32;}* %69 = OpVariable Uniform 
                                              %70 = OpTypePointer Uniform %6 
                               Private f32_4* %83 = OpVariable Private 
                                              %84 = OpTypePointer Input %12 
                                 Input f32_3* %85 = OpVariable Input 
                                          u32 %91 = OpConstant 0 
                                              %92 = OpTypePointer Private %6 
                                          u32 %99 = OpConstant 1 
                                Private f32* %107 = OpVariable Private 
                                         f32 %114 = OpConstant 3.674022E-40 
                                         f32 %132 = OpConstant 3.674022E-40 
                                         f32 %133 = OpConstant 3.674022E-40 
                                         u32 %175 = OpConstant 3 
                                             %182 = OpTypeArray %6 %99 
                                             %183 = OpTypeStruct %7 %6 %182 
                                             %184 = OpTypePointer Output %183 
        Output struct {f32_4; f32; f32[1];}* %185 = OpVariable Output 
                                             %187 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD5 = OpVariable Output 
                                             %190 = OpTypeVector %6 2 
                                             %195 = OpTypePointer Output %190 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                             %197 = OpTypePointer Input %190 
                                Input f32_2* %198 = OpVariable Input 
                                Private f32* %200 = OpVariable Private 
                                         f32 %208 = OpConstant 3.674022E-40 
                                       f32_2 %209 = OpConstantComposite %208 %208 
                                             %223 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                        f32_4 %32 = OpLoad %9 
                                        f32_4 %33 = OpVectorShuffle %32 %31 4 5 6 3 
                                                      OpStore %9 %33 
                               Uniform f32_4* %34 = OpAccessChain %23 %25 %25 
                                        f32_4 %35 = OpLoad %34 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 1 2 
                                        f32_4 %37 = OpLoad %11 
                                        f32_3 %38 = OpVectorShuffle %37 %37 0 0 0 
                                        f32_3 %39 = OpFMul %36 %38 
                                        f32_4 %40 = OpLoad %9 
                                        f32_3 %41 = OpVectorShuffle %40 %40 0 1 2 
                                        f32_3 %42 = OpFAdd %39 %41 
                                        f32_4 %43 = OpLoad %9 
                                        f32_4 %44 = OpVectorShuffle %43 %42 4 5 6 3 
                                                      OpStore %9 %44 
                               Uniform f32_4* %46 = OpAccessChain %23 %25 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                        f32_4 %49 = OpLoad %11 
                                        f32_3 %50 = OpVectorShuffle %49 %49 2 2 2 
                                        f32_3 %51 = OpFMul %48 %50 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %51 %53 
                                        f32_4 %55 = OpLoad %9 
                                        f32_4 %56 = OpVectorShuffle %55 %54 4 5 6 3 
                                                      OpStore %9 %56 
                                        f32_4 %57 = OpLoad %9 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                               Uniform f32_4* %60 = OpAccessChain %23 %25 %59 
                                        f32_4 %61 = OpLoad %60 
                                        f32_3 %62 = OpVectorShuffle %61 %61 0 1 2 
                                        f32_3 %63 = OpFAdd %58 %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %63 4 5 6 3 
                                                      OpStore %9 %65 
                                 Uniform f32* %71 = OpAccessChain %69 %59 
                                          f32 %72 = OpLoad %71 
                                        f32_3 %73 = OpCompositeConstruct %72 %72 %72 
                               Uniform f32_4* %74 = OpAccessChain %69 %45 
                                        f32_4 %75 = OpLoad %74 
                                        f32_3 %76 = OpVectorShuffle %75 %75 0 0 0 
                                        f32_3 %77 = OpFMul %73 %76 
                                        f32_4 %78 = OpLoad %9 
                                        f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
                                        f32_3 %80 = OpFAdd %77 %79 
                                        f32_4 %81 = OpLoad %9 
                                        f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
                                                      OpStore %9 %82 
                                        f32_3 %86 = OpLoad %85 
                               Uniform f32_4* %87 = OpAccessChain %23 %26 %25 
                                        f32_4 %88 = OpLoad %87 
                                        f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
                                          f32 %90 = OpDot %86 %89 
                                 Private f32* %93 = OpAccessChain %83 %91 
                                                      OpStore %93 %90 
                                        f32_3 %94 = OpLoad %85 
                               Uniform f32_4* %95 = OpAccessChain %23 %26 %26 
                                        f32_4 %96 = OpLoad %95 
                                        f32_3 %97 = OpVectorShuffle %96 %96 0 1 2 
                                          f32 %98 = OpDot %94 %97 
                                Private f32* %100 = OpAccessChain %83 %99 
                                                      OpStore %100 %98 
                                       f32_3 %101 = OpLoad %85 
                              Uniform f32_4* %102 = OpAccessChain %23 %26 %45 
                                       f32_4 %103 = OpLoad %102 
                                       f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
                                         f32 %105 = OpDot %101 %104 
                                Private f32* %106 = OpAccessChain %83 %19 
                                                      OpStore %106 %105 
                                       f32_4 %108 = OpLoad %83 
                                       f32_3 %109 = OpVectorShuffle %108 %108 0 1 2 
                                       f32_4 %110 = OpLoad %83 
                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
                                         f32 %112 = OpDot %109 %111 
                                                      OpStore %107 %112 
                                         f32 %113 = OpLoad %107 
                                         f32 %115 = OpExtInst %1 40 %113 %114 
                                                      OpStore %107 %115 
                                         f32 %116 = OpLoad %107 
                                         f32 %117 = OpExtInst %1 32 %116 
                                                      OpStore %107 %117 
                                         f32 %118 = OpLoad %107 
                                       f32_3 %119 = OpCompositeConstruct %118 %118 %118 
                                       f32_4 %120 = OpLoad %83 
                                       f32_3 %121 = OpVectorShuffle %120 %120 0 1 2 
                                       f32_3 %122 = OpFMul %119 %121 
                                       f32_4 %123 = OpLoad %83 
                                       f32_4 %124 = OpVectorShuffle %123 %122 4 5 6 3 
                                                      OpStore %83 %124 
                                Uniform f32* %125 = OpAccessChain %69 %59 
                                         f32 %126 = OpLoad %125 
                                       f32_3 %127 = OpCompositeConstruct %126 %126 %126 
                                       f32_4 %128 = OpLoad %83 
                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
                                         f32 %130 = OpDot %127 %129 
                                                      OpStore %107 %130 
                                         f32 %131 = OpLoad %107 
                                         f32 %134 = OpExtInst %1 43 %131 %132 %133 
                                                      OpStore %107 %134 
                                         f32 %135 = OpLoad %107 
                                         f32 %136 = OpFNegate %135 
                                         f32 %137 = OpFAdd %136 %133 
                                                      OpStore %107 %137 
                                         f32 %138 = OpLoad %107 
                                Uniform f32* %139 = OpAccessChain %69 %45 %99 
                                         f32 %140 = OpLoad %139 
                                         f32 %141 = OpFMul %138 %140 
                                                      OpStore %107 %141 
                                       f32_4 %142 = OpLoad %83 
                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
                                         f32 %144 = OpLoad %107 
                                       f32_3 %145 = OpCompositeConstruct %144 %144 %144 
                                       f32_3 %146 = OpFMul %143 %145 
                                       f32_4 %147 = OpLoad %9 
                                       f32_3 %148 = OpVectorShuffle %147 %147 0 1 2 
                                       f32_3 %149 = OpFAdd %146 %148 
                                       f32_4 %150 = OpLoad %9 
                                       f32_4 %151 = OpVectorShuffle %150 %149 4 5 6 3 
                                                      OpStore %9 %151 
                                       f32_4 %152 = OpLoad %9 
                                       f32_4 %153 = OpVectorShuffle %152 %152 1 1 1 1 
                              Uniform f32_4* %154 = OpAccessChain %69 %26 %26 
                                       f32_4 %155 = OpLoad %154 
                                       f32_4 %156 = OpFMul %153 %155 
                                                      OpStore %83 %156 
                              Uniform f32_4* %157 = OpAccessChain %69 %26 %25 
                                       f32_4 %158 = OpLoad %157 
                                       f32_4 %159 = OpLoad %9 
                                       f32_4 %160 = OpVectorShuffle %159 %159 0 0 0 0 
                                       f32_4 %161 = OpFMul %158 %160 
                                       f32_4 %162 = OpLoad %83 
                                       f32_4 %163 = OpFAdd %161 %162 
                                                      OpStore %83 %163 
                              Uniform f32_4* %164 = OpAccessChain %69 %26 %45 
                                       f32_4 %165 = OpLoad %164 
                                       f32_4 %166 = OpLoad %9 
                                       f32_4 %167 = OpVectorShuffle %166 %166 2 2 2 2 
                                       f32_4 %168 = OpFMul %165 %167 
                                       f32_4 %169 = OpLoad %83 
                                       f32_4 %170 = OpFAdd %168 %169 
                                                      OpStore %9 %170 
                                       f32_4 %171 = OpLoad %9 
                              Uniform f32_4* %172 = OpAccessChain %69 %26 %59 
                                       f32_4 %173 = OpLoad %172 
                                       f32_4 %174 = OpFAdd %171 %173 
                                                      OpStore %9 %174 
                                Private f32* %176 = OpAccessChain %9 %175 
                                         f32 %177 = OpLoad %176 
                                Private f32* %178 = OpAccessChain %9 %19 
                                         f32 %179 = OpLoad %178 
                                         f32 %180 = OpExtInst %1 37 %177 %179 
                                Private f32* %181 = OpAccessChain %9 %19 
                                                      OpStore %181 %180 
                                       f32_4 %186 = OpLoad %9 
                               Output f32_4* %188 = OpAccessChain %185 %25 
                                                      OpStore %188 %186 
                                       f32_4 %191 = OpLoad %9 
                                       f32_2 %192 = OpVectorShuffle %191 %191 2 3 
                                       f32_4 %193 = OpLoad vs_TEXCOORD5 
                                       f32_4 %194 = OpVectorShuffle %193 %192 0 1 4 5 
                                                      OpStore vs_TEXCOORD5 %194 
                                       f32_2 %199 = OpLoad %198 
                                                      OpStore vs_TEXCOORD0 %199 
                                Private f32* %201 = OpAccessChain %9 %99 
                                         f32 %202 = OpLoad %201 
                                Uniform f32* %203 = OpAccessChain %69 %25 %91 
                                         f32 %204 = OpLoad %203 
                                         f32 %205 = OpFMul %202 %204 
                                                      OpStore %200 %205 
                                       f32_4 %206 = OpLoad %9 
                                       f32_2 %207 = OpVectorShuffle %206 %206 0 3 
                                       f32_2 %210 = OpFMul %207 %209 
                                       f32_4 %211 = OpLoad %9 
                                       f32_4 %212 = OpVectorShuffle %211 %210 4 1 5 3 
                                                      OpStore %9 %212 
                                         f32 %213 = OpLoad %200 
                                         f32 %214 = OpFMul %213 %208 
                                Private f32* %215 = OpAccessChain %9 %175 
                                                      OpStore %215 %214 
                                       f32_4 %216 = OpLoad %9 
                                       f32_2 %217 = OpVectorShuffle %216 %216 2 2 
                                       f32_4 %218 = OpLoad %9 
                                       f32_2 %219 = OpVectorShuffle %218 %218 0 3 
                                       f32_2 %220 = OpFAdd %217 %219 
                                       f32_4 %221 = OpLoad vs_TEXCOORD5 
                                       f32_4 %222 = OpVectorShuffle %221 %220 4 5 2 3 
                                                      OpStore vs_TEXCOORD5 %222 
                                 Output f32* %224 = OpAccessChain %185 %25 %99 
                                         f32 %225 = OpLoad %224 
                                         f32 %226 = OpFNegate %225 
                                 Output f32* %227 = OpAccessChain %185 %25 %99 
                                                      OpStore %227 %226 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 241
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Fragment %4 "main" %29 %232 %237 
                                              OpExecutionMode %4 OriginUpperLeft 
                                              OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpMemberDecorate %10 0 Offset 10 
                                              OpMemberDecorate %10 1 Offset 10 
                                              OpDecorate %10 Block 
                                              OpDecorate %12 DescriptorSet 12 
                                              OpDecorate %12 Binding 12 
                                              OpDecorate vs_TEXCOORD5 Location 29 
                                              OpDecorate %220 RelaxedPrecision 
                                              OpDecorate %223 RelaxedPrecision 
                                              OpDecorate %223 DescriptorSet 223 
                                              OpDecorate %223 Binding 223 
                                              OpDecorate %224 RelaxedPrecision 
                                              OpDecorate %227 RelaxedPrecision 
                                              OpDecorate %227 DescriptorSet 227 
                                              OpDecorate %227 Binding 227 
                                              OpDecorate %228 RelaxedPrecision 
                                              OpDecorate vs_TEXCOORD0 Location 232 
                                              OpDecorate %235 RelaxedPrecision 
                                              OpDecorate %237 RelaxedPrecision 
                                              OpDecorate %237 Location 237 
                                              OpDecorate %238 RelaxedPrecision 
                                              OpDecorate %239 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypeStruct %7 %6 
                                      %11 = OpTypePointer Uniform %10 
        Uniform struct {f32_4; f32;}* %12 = OpVariable Uniform 
                                      %13 = OpTypeInt 32 1 
                                  i32 %14 = OpConstant 1 
                                      %15 = OpTypePointer Uniform %6 
                                  f32 %19 = OpConstant 3.674022E-40 
                                      %21 = OpTypeInt 32 0 
                                  u32 %22 = OpConstant 0 
                                      %23 = OpTypePointer Private %6 
                                      %25 = OpTypeVector %6 2 
                                      %26 = OpTypePointer Private %25 
                       Private f32_2* %27 = OpVariable Private 
                                      %28 = OpTypePointer Input %7 
                Input f32_4* vs_TEXCOORD5 = OpVariable Input 
                                  i32 %36 = OpConstant 0 
                                      %37 = OpTypePointer Uniform %7 
                                  f32 %43 = OpConstant 3.674022E-40 
                                f32_2 %44 = OpConstantComposite %43 %43 
                                      %46 = OpTypeBool 
                                      %47 = OpTypeVector %46 2 
                                      %48 = OpTypePointer Private %47 
                      Private bool_2* %49 = OpVariable Private 
                                      %55 = OpTypeVector %46 4 
                                      %61 = OpTypePointer Function %25 
                                      %64 = OpTypePointer Private %46 
                                      %67 = OpTypePointer Function %6 
                                  u32 %79 = OpConstant 1 
                                  f32 %95 = OpConstant 3.674022E-40 
                                f32_2 %96 = OpConstantComposite %95 %95 
                                      %98 = OpTypeVector %21 2 
                                      %99 = OpTypePointer Private %98 
                      Private u32_2* %100 = OpVariable Private 
                      Private f32_4* %103 = OpVariable Private 
                                 f32 %104 = OpConstant 3.674022E-40 
                                 f32 %105 = OpConstant 3.674022E-40 
                                 f32 %106 = OpConstant 3.674022E-40 
                                 f32 %107 = OpConstant 3.674022E-40 
                               f32_4 %108 = OpConstantComposite %104 %105 %106 %107 
                                     %109 = OpTypeVector %21 4 
                                 u32 %110 = OpConstant 4 
                                     %111 = OpTypeArray %109 %110 
                                 u32 %112 = OpConstant 1065353216 
                               u32_4 %113 = OpConstantComposite %112 %22 %22 %22 
                               u32_4 %114 = OpConstantComposite %22 %112 %22 %22 
                               u32_4 %115 = OpConstantComposite %22 %22 %112 %22 
                               u32_4 %116 = OpConstantComposite %22 %22 %22 %112 
                            u32_4[4] %117 = OpConstantComposite %113 %114 %115 %116 
                                     %118 = OpTypePointer Private %21 
                                     %122 = OpTypePointer Function %111 
                                     %124 = OpTypePointer Function %109 
                                 f32 %130 = OpConstant 3.674022E-40 
                                 f32 %131 = OpConstant 3.674022E-40 
                                 f32 %132 = OpConstant 3.674022E-40 
                                 f32 %133 = OpConstant 3.674022E-40 
                               f32_4 %134 = OpConstantComposite %130 %131 %132 %133 
                                 f32 %144 = OpConstant 3.674022E-40 
                                 f32 %145 = OpConstant 3.674022E-40 
                                 f32 %146 = OpConstant 3.674022E-40 
                                 f32 %147 = OpConstant 3.674022E-40 
                               f32_4 %148 = OpConstantComposite %144 %145 %146 %147 
                                 u32 %157 = OpConstant 2 
                                 f32 %159 = OpConstant 3.674022E-40 
                                 f32 %160 = OpConstant 3.674022E-40 
                                 f32 %161 = OpConstant 3.674022E-40 
                                 f32 %162 = OpConstant 3.674022E-40 
                               f32_4 %163 = OpConstantComposite %159 %160 %161 %162 
                                 u32 %172 = OpConstant 3 
                                     %187 = OpTypePointer Private %55 
                     Private bool_4* %188 = OpVariable Private 
                                 f32 %190 = OpConstant 3.674022E-40 
                               f32_4 %191 = OpConstantComposite %190 %190 %190 %190 
                                 i32 %214 = OpConstant -1 
                        Private f32* %220 = OpVariable Private 
                                     %221 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %222 = OpTypePointer UniformConstant %221 
UniformConstant read_only Texture2D* %223 = OpVariable UniformConstant 
                                     %225 = OpTypeSampler 
                                     %226 = OpTypePointer UniformConstant %225 
            UniformConstant sampler* %227 = OpVariable UniformConstant 
                                     %229 = OpTypeSampledImage %221 
                                     %231 = OpTypePointer Input %25 
                Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                                     %236 = OpTypePointer Output %7 
                       Output f32_4* %237 = OpVariable Output 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                      Function f32_2* %62 = OpVariable Function 
                        Function f32* %68 = OpVariable Function 
                        Function f32* %82 = OpVariable Function 
                  Function u32_4[4]* %123 = OpVariable Function 
                  Function u32_4[4]* %138 = OpVariable Function 
                  Function u32_4[4]* %152 = OpVariable Function 
                  Function u32_4[4]* %167 = OpVariable Function 
                  Function u32_4[4]* %179 = OpVariable Function 
                         Uniform f32* %16 = OpAccessChain %12 %14 
                                  f32 %17 = OpLoad %16 
                                  f32 %18 = OpFNegate %17 
                                  f32 %20 = OpFAdd %18 %19 
                         Private f32* %24 = OpAccessChain %9 %22 
                                              OpStore %24 %20 
                                f32_4 %30 = OpLoad vs_TEXCOORD5 
                                f32_2 %31 = OpVectorShuffle %30 %30 0 1 
                                f32_4 %32 = OpLoad vs_TEXCOORD5 
                                f32_2 %33 = OpVectorShuffle %32 %32 3 3 
                                f32_2 %34 = OpFDiv %31 %33 
                                              OpStore %27 %34 
                                f32_2 %35 = OpLoad %27 
                       Uniform f32_4* %38 = OpAccessChain %12 %36 
                                f32_4 %39 = OpLoad %38 
                                f32_2 %40 = OpVectorShuffle %39 %39 0 1 
                                f32_2 %41 = OpFMul %35 %40 
                                              OpStore %27 %41 
                                f32_2 %42 = OpLoad %27 
                                f32_2 %45 = OpFMul %42 %44 
                                              OpStore %27 %45 
                                f32_2 %50 = OpLoad %27 
                                f32_4 %51 = OpVectorShuffle %50 %50 0 1 0 0 
                                f32_2 %52 = OpLoad %27 
                                f32_4 %53 = OpVectorShuffle %52 %52 0 1 0 0 
                                f32_4 %54 = OpFNegate %53 
                               bool_4 %56 = OpFOrdGreaterThanEqual %51 %54 
                               bool_2 %57 = OpVectorShuffle %56 %56 0 1 
                                              OpStore %49 %57 
                                f32_2 %58 = OpLoad %27 
                                f32_2 %59 = OpExtInst %1 4 %58 
                                f32_2 %60 = OpExtInst %1 10 %59 
                                              OpStore %27 %60 
                                f32_2 %63 = OpLoad %27 
                                              OpStore %62 %63 
                        Private bool* %65 = OpAccessChain %49 %22 
                                 bool %66 = OpLoad %65 
                                              OpSelectionMerge %70 None 
                                              OpBranchConditional %66 %69 %73 
                                      %69 = OpLabel 
                         Private f32* %71 = OpAccessChain %27 %22 
                                  f32 %72 = OpLoad %71 
                                              OpStore %68 %72 
                                              OpBranch %70 
                                      %73 = OpLabel 
                         Private f32* %74 = OpAccessChain %27 %22 
                                  f32 %75 = OpLoad %74 
                                  f32 %76 = OpFNegate %75 
                                              OpStore %68 %76 
                                              OpBranch %70 
                                      %70 = OpLabel 
                                  f32 %77 = OpLoad %68 
                        Function f32* %78 = OpAccessChain %62 %22 
                                              OpStore %78 %77 
                        Private bool* %80 = OpAccessChain %49 %79 
                                 bool %81 = OpLoad %80 
                                              OpSelectionMerge %84 None 
                                              OpBranchConditional %81 %83 %87 
                                      %83 = OpLabel 
                         Private f32* %85 = OpAccessChain %27 %79 
                                  f32 %86 = OpLoad %85 
                                              OpStore %82 %86 
                                              OpBranch %84 
                                      %87 = OpLabel 
                         Private f32* %88 = OpAccessChain %27 %79 
                                  f32 %89 = OpLoad %88 
                                  f32 %90 = OpFNegate %89 
                                              OpStore %82 %90 
                                              OpBranch %84 
                                      %84 = OpLabel 
                                  f32 %91 = OpLoad %82 
                        Function f32* %92 = OpAccessChain %62 %79 
                                              OpStore %92 %91 
                                f32_2 %93 = OpLoad %62 
                                              OpStore %27 %93 
                                f32_2 %94 = OpLoad %27 
                                f32_2 %97 = OpFMul %94 %96 
                                              OpStore %27 %97 
                               f32_2 %101 = OpLoad %27 
                               u32_2 %102 = OpConvertFToU %101 
                                              OpStore %100 %102 
                        Private u32* %119 = OpAccessChain %100 %22 
                                 u32 %120 = OpLoad %119 
                                 i32 %121 = OpBitcast %120 
                                              OpStore %123 %117 
                     Function u32_4* %125 = OpAccessChain %123 %121 
                               u32_4 %126 = OpLoad %125 
                               f32_4 %127 = OpBitcast %126 
                                 f32 %128 = OpDot %108 %127 
                        Private f32* %129 = OpAccessChain %103 %22 
                                              OpStore %129 %128 
                        Private u32* %135 = OpAccessChain %100 %22 
                                 u32 %136 = OpLoad %135 
                                 i32 %137 = OpBitcast %136 
                                              OpStore %138 %117 
                     Function u32_4* %139 = OpAccessChain %138 %137 
                               u32_4 %140 = OpLoad %139 
                               f32_4 %141 = OpBitcast %140 
                                 f32 %142 = OpDot %134 %141 
                        Private f32* %143 = OpAccessChain %103 %79 
                                              OpStore %143 %142 
                        Private u32* %149 = OpAccessChain %100 %22 
                                 u32 %150 = OpLoad %149 
                                 i32 %151 = OpBitcast %150 
                                              OpStore %152 %117 
                     Function u32_4* %153 = OpAccessChain %152 %151 
                               u32_4 %154 = OpLoad %153 
                               f32_4 %155 = OpBitcast %154 
                                 f32 %156 = OpDot %148 %155 
                        Private f32* %158 = OpAccessChain %103 %157 
                                              OpStore %158 %156 
                        Private u32* %164 = OpAccessChain %100 %22 
                                 u32 %165 = OpLoad %164 
                                 i32 %166 = OpBitcast %165 
                                              OpStore %167 %117 
                     Function u32_4* %168 = OpAccessChain %167 %166 
                               u32_4 %169 = OpLoad %168 
                               f32_4 %170 = OpBitcast %169 
                                 f32 %171 = OpDot %163 %170 
                        Private f32* %173 = OpAccessChain %103 %172 
                                              OpStore %173 %171 
                               f32_4 %174 = OpLoad %103 
                               f32_4 %175 = OpFNegate %174 
                        Private u32* %176 = OpAccessChain %100 %79 
                                 u32 %177 = OpLoad %176 
                                 i32 %178 = OpBitcast %177 
                                              OpStore %179 %117 
                     Function u32_4* %180 = OpAccessChain %179 %178 
                               u32_4 %181 = OpLoad %180 
                               f32_4 %182 = OpBitcast %181 
                               f32_4 %183 = OpFMul %175 %182 
                               f32_4 %184 = OpLoad %9 
                               f32_4 %185 = OpVectorShuffle %184 %184 0 0 0 0 
                               f32_4 %186 = OpFAdd %183 %185 
                                              OpStore %9 %186 
                               f32_4 %189 = OpLoad %9 
                              bool_4 %192 = OpFOrdLessThan %189 %191 
                                              OpStore %188 %192 
                       Private bool* %193 = OpAccessChain %188 %157 
                                bool %194 = OpLoad %193 
                       Private bool* %195 = OpAccessChain %188 %22 
                                bool %196 = OpLoad %195 
                                bool %197 = OpLogicalOr %194 %196 
                       Private bool* %198 = OpAccessChain %188 %22 
                                              OpStore %198 %197 
                       Private bool* %199 = OpAccessChain %188 %172 
                                bool %200 = OpLoad %199 
                       Private bool* %201 = OpAccessChain %188 %79 
                                bool %202 = OpLoad %201 
                                bool %203 = OpLogicalOr %200 %202 
                       Private bool* %204 = OpAccessChain %188 %79 
                                              OpStore %204 %203 
                       Private bool* %205 = OpAccessChain %188 %79 
                                bool %206 = OpLoad %205 
                       Private bool* %207 = OpAccessChain %188 %22 
                                bool %208 = OpLoad %207 
                                bool %209 = OpLogicalOr %206 %208 
                       Private bool* %210 = OpAccessChain %188 %22 
                                              OpStore %210 %209 
                       Private bool* %211 = OpAccessChain %188 %22 
                                bool %212 = OpLoad %211 
                                 i32 %213 = OpSelect %212 %14 %36 
                                 i32 %215 = OpIMul %213 %214 
                                bool %216 = OpINotEqual %215 %36 
                                              OpSelectionMerge %218 None 
                                              OpBranchConditional %216 %217 %218 
                                     %217 = OpLabel 
                                              OpKill
                                     %218 = OpLabel 
                 read_only Texture2D %224 = OpLoad %223 
                             sampler %228 = OpLoad %227 
          read_only Texture2DSampled %230 = OpSampledImage %224 %228 
                               f32_2 %233 = OpLoad vs_TEXCOORD0 
                               f32_4 %234 = OpImageSampleImplicitLod %230 %233 
                                 f32 %235 = OpCompositeExtract %234 3 
                                              OpStore %220 %235 
                                 f32 %238 = OpLoad %220 
                               f32_4 %239 = OpCompositeConstruct %238 %238 %238 %238 
                                              OpStore %237 %239 
                                              OpReturn
                                              OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ShadowBias;
uniform 	float _LightDirection;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = vec3(_LightDirection) * _ShadowBias.xxx + u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat6 = dot(vec3(_LightDirection), u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat6) + 1.0;
    u_xlat6 = u_xlat6 * _ShadowBias.y;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.z = max((-u_xlat0.w), u_xlat0.z);
    gl_Position = u_xlat0;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
vec4 ImmCB_0[4];
uniform 	vec4 _ScreenParams;
uniform 	float _CharacterAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
uvec2 u_xlatu2;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlat0.x = (-_CharacterAlpha) + 1.0;
    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(0.25, 0.25);
    u_xlatb1.xy = greaterThanEqual(u_xlat2.xyxx, (-u_xlat2.xyxx)).xy;
    u_xlat2.xy = fract(abs(u_xlat2.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat2.y : (-u_xlat2.y);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.xy = u_xlat2.xy * vec2(4.0, 4.0);
    u_xlatu2.xy = uvec2(u_xlat2.xy);
    u_xlat1.x = dot(vec4(0.0588235296, 0.764705896, 0.235294119, 0.941176474), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.y = dot(vec4(0.529411793, 0.294117659, 0.70588237, 0.470588237), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.z = dot(vec4(0.176470593, 0.882352948, 0.117647059, 0.823529422), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat1.w = dot(vec4(0.647058845, 0.411764711, 0.588235319, 0.352941185), ImmCB_0[int(u_xlatu2.x)]);
    u_xlat0 = (-u_xlat1) * ImmCB_0[int(u_xlatu2.y)] + u_xlat0.xxxx;
    u_xlatb0 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.y = u_xlatb0.w || u_xlatb0.y;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    SV_TARGET0 = vec4(u_xlat16_0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
SubProgram "vulkan " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" }
""
}
SubProgram "vulkan " {
""
}
SubProgram "gles3 " {
Keywords { "_MAIN_LIGHT_SHADOWS" "_MAIN_LIGHT_SHADOWS_CASCADE" }
""
}
}
}
}
}