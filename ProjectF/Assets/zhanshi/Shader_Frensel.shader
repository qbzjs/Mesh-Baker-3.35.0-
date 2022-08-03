//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shader/Frensel" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_frenselcolor ("frensel color", Color) = (1,1,1,1)
_frenselpower ("frensel power", Float) = 1
_frenselIntensity ("frensel Intensity", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "UniversalForward" "QUEUE" = "Transparent" }
  ColorMask 0 0
  GpuProgramID 52114
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 150
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %81 %92 %101 %102 %106 %136 %141 %142 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %12 Location 12 
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
                                                      OpDecorate %59 ArrayStride 59 
                                                      OpMemberDecorate %60 0 Offset 60 
                                                      OpMemberDecorate %60 1 Offset 60 
                                                      OpDecorate %60 Block 
                                                      OpDecorate %62 DescriptorSet 62 
                                                      OpDecorate %62 Binding 62 
                                                      OpDecorate vs_TEXCOORD2 Location 81 
                                                      OpMemberDecorate %90 0 BuiltIn 90 
                                                      OpMemberDecorate %90 1 BuiltIn 90 
                                                      OpMemberDecorate %90 2 BuiltIn 90 
                                                      OpDecorate %90 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 101 
                                                      OpDecorate %102 Location 102 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate vs_TEXCOORD1 Location 136 
                                                      OpDecorate vs_TEXCOORD3 Location 141 
                                                      OpDecorate %142 Location 142 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 4 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_4* %12 = OpVariable Input 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %10 %16 
                                              %18 = OpTypeArray %10 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %10 %19 
                                              %21 = OpTypeStruct %17 %18 %10 %10 %10 %20 %10 %10 %10 %10 %10 %10 %10 %10 %10 %10 %10 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %10 
                                          i32 %40 = OpConstant 2 
                                          i32 %50 = OpConstant 3 
                                              %55 = OpTypePointer Private %10 
                               Private f32_4* %56 = OpVariable Private 
                                              %59 = OpTypeArray %10 %16 
                                              %60 = OpTypeStruct %7 %59 
                                              %61 = OpTypePointer Uniform %60 
           Uniform struct {f32_3; f32_4[4];}* %62 = OpVariable Uniform 
                                              %80 = OpTypePointer Output %7 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                              %84 = OpTypePointer Uniform %7 
                                          u32 %88 = OpConstant 1 
                                              %89 = OpTypeArray %6 %88 
                                              %90 = OpTypeStruct %10 %6 %89 
                                              %91 = OpTypePointer Output %90 
         Output struct {f32_4; f32; f32[1];}* %92 = OpVariable Output 
                                              %97 = OpTypePointer Output %10 
                                              %99 = OpTypeVector %6 2 
                                             %100 = OpTypePointer Output %99 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                Input f32_4* %102 = OpVariable Input 
                                             %105 = OpTypePointer Input %7 
                                Input f32_3* %106 = OpVariable Input 
                                         u32 %112 = OpConstant 0 
                                             %113 = OpTypePointer Private %6 
                                Private f32* %127 = OpVariable Private 
                                         f32 %132 = OpConstant 3.674022E-40 
                       Output f32_3* vs_TEXCOORD1 = OpVariable Output 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                Input f32_4* %142 = OpVariable Input 
                                             %144 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %12 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                                      OpStore %9 %31 
                               Uniform f32_4* %32 = OpAccessChain %23 %25 %25 
                                        f32_4 %33 = OpLoad %32 
                                        f32_3 %34 = OpVectorShuffle %33 %33 0 1 2 
                                        f32_4 %35 = OpLoad %12 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 0 0 
                                        f32_3 %37 = OpFMul %34 %36 
                                        f32_3 %38 = OpLoad %9 
                                        f32_3 %39 = OpFAdd %37 %38 
                                                      OpStore %9 %39 
                               Uniform f32_4* %41 = OpAccessChain %23 %25 %40 
                                        f32_4 %42 = OpLoad %41 
                                        f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
                                        f32_4 %44 = OpLoad %12 
                                        f32_3 %45 = OpVectorShuffle %44 %44 2 2 2 
                                        f32_3 %46 = OpFMul %43 %45 
                                        f32_3 %47 = OpLoad %9 
                                        f32_3 %48 = OpFAdd %46 %47 
                                                      OpStore %9 %48 
                                        f32_3 %49 = OpLoad %9 
                               Uniform f32_4* %51 = OpAccessChain %23 %25 %50 
                                        f32_4 %52 = OpLoad %51 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %49 %53 
                                                      OpStore %9 %54 
                                        f32_3 %57 = OpLoad %9 
                                        f32_4 %58 = OpVectorShuffle %57 %57 1 1 1 1 
                               Uniform f32_4* %63 = OpAccessChain %62 %26 %26 
                                        f32_4 %64 = OpLoad %63 
                                        f32_4 %65 = OpFMul %58 %64 
                                                      OpStore %56 %65 
                               Uniform f32_4* %66 = OpAccessChain %62 %26 %25 
                                        f32_4 %67 = OpLoad %66 
                                        f32_3 %68 = OpLoad %9 
                                        f32_4 %69 = OpVectorShuffle %68 %68 0 0 0 0 
                                        f32_4 %70 = OpFMul %67 %69 
                                        f32_4 %71 = OpLoad %56 
                                        f32_4 %72 = OpFAdd %70 %71 
                                                      OpStore %56 %72 
                               Uniform f32_4* %73 = OpAccessChain %62 %26 %40 
                                        f32_4 %74 = OpLoad %73 
                                        f32_3 %75 = OpLoad %9 
                                        f32_4 %76 = OpVectorShuffle %75 %75 2 2 2 2 
                                        f32_4 %77 = OpFMul %74 %76 
                                        f32_4 %78 = OpLoad %56 
                                        f32_4 %79 = OpFAdd %77 %78 
                                                      OpStore %56 %79 
                                        f32_3 %82 = OpLoad %9 
                                        f32_3 %83 = OpFNegate %82 
                               Uniform f32_3* %85 = OpAccessChain %62 %25 
                                        f32_3 %86 = OpLoad %85 
                                        f32_3 %87 = OpFAdd %83 %86 
                                                      OpStore vs_TEXCOORD2 %87 
                                        f32_4 %93 = OpLoad %56 
                               Uniform f32_4* %94 = OpAccessChain %62 %26 %50 
                                        f32_4 %95 = OpLoad %94 
                                        f32_4 %96 = OpFAdd %93 %95 
                                Output f32_4* %98 = OpAccessChain %92 %25 
                                                      OpStore %98 %96 
                                       f32_4 %103 = OpLoad %102 
                                       f32_2 %104 = OpVectorShuffle %103 %103 0 1 
                                                      OpStore vs_TEXCOORD0 %104 
                                       f32_3 %107 = OpLoad %106 
                              Uniform f32_4* %108 = OpAccessChain %23 %26 %25 
                                       f32_4 %109 = OpLoad %108 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %107 %110 
                                Private f32* %114 = OpAccessChain %9 %112 
                                                      OpStore %114 %111 
                                       f32_3 %115 = OpLoad %106 
                              Uniform f32_4* %116 = OpAccessChain %23 %26 %26 
                                       f32_4 %117 = OpLoad %116 
                                       f32_3 %118 = OpVectorShuffle %117 %117 0 1 2 
                                         f32 %119 = OpDot %115 %118 
                                Private f32* %120 = OpAccessChain %9 %88 
                                                      OpStore %120 %119 
                                       f32_3 %121 = OpLoad %106 
                              Uniform f32_4* %122 = OpAccessChain %23 %26 %40 
                                       f32_4 %123 = OpLoad %122 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %121 %124 
                                Private f32* %126 = OpAccessChain %9 %19 
                                                      OpStore %126 %125 
                                       f32_3 %128 = OpLoad %9 
                                       f32_3 %129 = OpLoad %9 
                                         f32 %130 = OpDot %128 %129 
                                                      OpStore %127 %130 
                                         f32 %131 = OpLoad %127 
                                         f32 %133 = OpExtInst %1 40 %131 %132 
                                                      OpStore %127 %133 
                                         f32 %134 = OpLoad %127 
                                         f32 %135 = OpExtInst %1 32 %134 
                                                      OpStore %127 %135 
                                         f32 %137 = OpLoad %127 
                                       f32_3 %138 = OpCompositeConstruct %137 %137 %137 
                                       f32_3 %139 = OpLoad %9 
                                       f32_3 %140 = OpFMul %138 %139 
                                                      OpStore vs_TEXCOORD1 %140 
                                       f32_4 %143 = OpLoad %142 
                                                      OpStore vs_TEXCOORD3 %143 
                                 Output f32* %145 = OpAccessChain %92 %25 %88 
                                         f32 %146 = OpLoad %145 
                                         f32 %147 = OpFNegate %146 
                                 Output f32* %148 = OpAccessChain %92 %25 %88 
                                                      OpStore %148 %147 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 13
; Schema: 0
                     OpCapability Shader 
              %1 = OpExtInstImport "GLSL.std.450" 
                     OpMemoryModel Logical GLSL450 
                     OpEntryPoint Fragment %4 "main" %9 
                     OpExecutionMode %4 OriginUpperLeft 
                     OpDecorate %9 RelaxedPrecision 
                     OpDecorate %9 Location 9 
              %2 = OpTypeVoid 
              %3 = OpTypeFunction %2 
              %6 = OpTypeFloat 32 
              %7 = OpTypeVector %6 4 
              %8 = OpTypePointer Output %7 
Output f32_4* %9 = OpVariable Output 
         f32 %10 = OpConstant 3.674022E-40 
       f32_4 %11 = OpConstantComposite %10 %10 %10 %10 
         void %4 = OpFunction None %3 
              %5 = OpLabel 
                     OpStore %9 %11 
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
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "LightweightForward" "QUEUE" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 117850
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = in_COLOR0;
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM float _frenselpower;
	UNITY_UNIFORM float _frenselIntensity;
	UNITY_UNIFORM vec4 _frenselcolor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat12 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD2.xyz;
    u_xlat16_2 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = log2(u_xlat16_2);
    u_xlat0.x = u_xlat0.x * _frenselpower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _frenselIntensity;
    u_xlat4.xyz = u_xlat0.xxx * _frenselcolor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_TEXCOORD3.xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2.xyz = u_xlat4.xyz * u_xlat16_1.xyz;
    u_xlat16_3 = u_xlat0.x * u_xlat16_1.w;
    u_xlat2.w = u_xlat16_3 * vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 150
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %81 %92 %101 %102 %106 %136 %141 %142 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %12 Location 12 
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
                                                      OpDecorate %59 ArrayStride 59 
                                                      OpMemberDecorate %60 0 Offset 60 
                                                      OpMemberDecorate %60 1 Offset 60 
                                                      OpDecorate %60 Block 
                                                      OpDecorate %62 DescriptorSet 62 
                                                      OpDecorate %62 Binding 62 
                                                      OpDecorate vs_TEXCOORD2 Location 81 
                                                      OpMemberDecorate %90 0 BuiltIn 90 
                                                      OpMemberDecorate %90 1 BuiltIn 90 
                                                      OpMemberDecorate %90 2 BuiltIn 90 
                                                      OpDecorate %90 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 101 
                                                      OpDecorate %102 Location 102 
                                                      OpDecorate %106 Location 106 
                                                      OpDecorate vs_TEXCOORD1 Location 136 
                                                      OpDecorate vs_TEXCOORD3 Location 141 
                                                      OpDecorate %142 Location 142 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 4 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_4* %12 = OpVariable Input 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %10 %16 
                                              %18 = OpTypeArray %10 %16 
                                          u32 %19 = OpConstant 2 
                                              %20 = OpTypeArray %10 %19 
                                              %21 = OpTypeStruct %17 %18 %10 %10 %10 %20 %10 %10 %10 %10 %10 %10 %10 %10 %10 %10 %10 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %23 = OpVariable Uniform 
                                              %24 = OpTypeInt 32 1 
                                          i32 %25 = OpConstant 0 
                                          i32 %26 = OpConstant 1 
                                              %27 = OpTypePointer Uniform %10 
                                          i32 %40 = OpConstant 2 
                                          i32 %50 = OpConstant 3 
                                              %55 = OpTypePointer Private %10 
                               Private f32_4* %56 = OpVariable Private 
                                              %59 = OpTypeArray %10 %16 
                                              %60 = OpTypeStruct %7 %59 
                                              %61 = OpTypePointer Uniform %60 
           Uniform struct {f32_3; f32_4[4];}* %62 = OpVariable Uniform 
                                              %80 = OpTypePointer Output %7 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                              %84 = OpTypePointer Uniform %7 
                                          u32 %88 = OpConstant 1 
                                              %89 = OpTypeArray %6 %88 
                                              %90 = OpTypeStruct %10 %6 %89 
                                              %91 = OpTypePointer Output %90 
         Output struct {f32_4; f32; f32[1];}* %92 = OpVariable Output 
                                              %97 = OpTypePointer Output %10 
                                              %99 = OpTypeVector %6 2 
                                             %100 = OpTypePointer Output %99 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                Input f32_4* %102 = OpVariable Input 
                                             %105 = OpTypePointer Input %7 
                                Input f32_3* %106 = OpVariable Input 
                                         u32 %112 = OpConstant 0 
                                             %113 = OpTypePointer Private %6 
                                Private f32* %127 = OpVariable Private 
                                         f32 %132 = OpConstant 3.674022E-40 
                       Output f32_3* vs_TEXCOORD1 = OpVariable Output 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                Input f32_4* %142 = OpVariable Input 
                                             %144 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %13 = OpLoad %12 
                                        f32_3 %14 = OpVectorShuffle %13 %13 1 1 1 
                               Uniform f32_4* %28 = OpAccessChain %23 %25 %26 
                                        f32_4 %29 = OpLoad %28 
                                        f32_3 %30 = OpVectorShuffle %29 %29 0 1 2 
                                        f32_3 %31 = OpFMul %14 %30 
                                                      OpStore %9 %31 
                               Uniform f32_4* %32 = OpAccessChain %23 %25 %25 
                                        f32_4 %33 = OpLoad %32 
                                        f32_3 %34 = OpVectorShuffle %33 %33 0 1 2 
                                        f32_4 %35 = OpLoad %12 
                                        f32_3 %36 = OpVectorShuffle %35 %35 0 0 0 
                                        f32_3 %37 = OpFMul %34 %36 
                                        f32_3 %38 = OpLoad %9 
                                        f32_3 %39 = OpFAdd %37 %38 
                                                      OpStore %9 %39 
                               Uniform f32_4* %41 = OpAccessChain %23 %25 %40 
                                        f32_4 %42 = OpLoad %41 
                                        f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
                                        f32_4 %44 = OpLoad %12 
                                        f32_3 %45 = OpVectorShuffle %44 %44 2 2 2 
                                        f32_3 %46 = OpFMul %43 %45 
                                        f32_3 %47 = OpLoad %9 
                                        f32_3 %48 = OpFAdd %46 %47 
                                                      OpStore %9 %48 
                                        f32_3 %49 = OpLoad %9 
                               Uniform f32_4* %51 = OpAccessChain %23 %25 %50 
                                        f32_4 %52 = OpLoad %51 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_3 %54 = OpFAdd %49 %53 
                                                      OpStore %9 %54 
                                        f32_3 %57 = OpLoad %9 
                                        f32_4 %58 = OpVectorShuffle %57 %57 1 1 1 1 
                               Uniform f32_4* %63 = OpAccessChain %62 %26 %26 
                                        f32_4 %64 = OpLoad %63 
                                        f32_4 %65 = OpFMul %58 %64 
                                                      OpStore %56 %65 
                               Uniform f32_4* %66 = OpAccessChain %62 %26 %25 
                                        f32_4 %67 = OpLoad %66 
                                        f32_3 %68 = OpLoad %9 
                                        f32_4 %69 = OpVectorShuffle %68 %68 0 0 0 0 
                                        f32_4 %70 = OpFMul %67 %69 
                                        f32_4 %71 = OpLoad %56 
                                        f32_4 %72 = OpFAdd %70 %71 
                                                      OpStore %56 %72 
                               Uniform f32_4* %73 = OpAccessChain %62 %26 %40 
                                        f32_4 %74 = OpLoad %73 
                                        f32_3 %75 = OpLoad %9 
                                        f32_4 %76 = OpVectorShuffle %75 %75 2 2 2 2 
                                        f32_4 %77 = OpFMul %74 %76 
                                        f32_4 %78 = OpLoad %56 
                                        f32_4 %79 = OpFAdd %77 %78 
                                                      OpStore %56 %79 
                                        f32_3 %82 = OpLoad %9 
                                        f32_3 %83 = OpFNegate %82 
                               Uniform f32_3* %85 = OpAccessChain %62 %25 
                                        f32_3 %86 = OpLoad %85 
                                        f32_3 %87 = OpFAdd %83 %86 
                                                      OpStore vs_TEXCOORD2 %87 
                                        f32_4 %93 = OpLoad %56 
                               Uniform f32_4* %94 = OpAccessChain %62 %26 %50 
                                        f32_4 %95 = OpLoad %94 
                                        f32_4 %96 = OpFAdd %93 %95 
                                Output f32_4* %98 = OpAccessChain %92 %25 
                                                      OpStore %98 %96 
                                       f32_4 %103 = OpLoad %102 
                                       f32_2 %104 = OpVectorShuffle %103 %103 0 1 
                                                      OpStore vs_TEXCOORD0 %104 
                                       f32_3 %107 = OpLoad %106 
                              Uniform f32_4* %108 = OpAccessChain %23 %26 %25 
                                       f32_4 %109 = OpLoad %108 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %107 %110 
                                Private f32* %114 = OpAccessChain %9 %112 
                                                      OpStore %114 %111 
                                       f32_3 %115 = OpLoad %106 
                              Uniform f32_4* %116 = OpAccessChain %23 %26 %26 
                                       f32_4 %117 = OpLoad %116 
                                       f32_3 %118 = OpVectorShuffle %117 %117 0 1 2 
                                         f32 %119 = OpDot %115 %118 
                                Private f32* %120 = OpAccessChain %9 %88 
                                                      OpStore %120 %119 
                                       f32_3 %121 = OpLoad %106 
                              Uniform f32_4* %122 = OpAccessChain %23 %26 %40 
                                       f32_4 %123 = OpLoad %122 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %121 %124 
                                Private f32* %126 = OpAccessChain %9 %19 
                                                      OpStore %126 %125 
                                       f32_3 %128 = OpLoad %9 
                                       f32_3 %129 = OpLoad %9 
                                         f32 %130 = OpDot %128 %129 
                                                      OpStore %127 %130 
                                         f32 %131 = OpLoad %127 
                                         f32 %133 = OpExtInst %1 40 %131 %132 
                                                      OpStore %127 %133 
                                         f32 %134 = OpLoad %127 
                                         f32 %135 = OpExtInst %1 32 %134 
                                                      OpStore %127 %135 
                                         f32 %137 = OpLoad %127 
                                       f32_3 %138 = OpCompositeConstruct %137 %137 %137 
                                       f32_3 %139 = OpLoad %9 
                                       f32_3 %140 = OpFMul %138 %139 
                                                      OpStore vs_TEXCOORD1 %140 
                                       f32_4 %143 = OpLoad %142 
                                                      OpStore vs_TEXCOORD3 %143 
                                 Output f32* %145 = OpAccessChain %92 %25 %88 
                                         f32 %146 = OpLoad %145 
                                         f32 %147 = OpFNegate %146 
                                 Output f32* %148 = OpAccessChain %92 %25 %88 
                                                      OpStore %148 %147 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 135
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %11 %28 %85 %103 %132 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpDecorate vs_TEXCOORD1 Location 11 
                                             OpDecorate vs_TEXCOORD2 Location 28 
                                             OpDecorate %39 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %44 RelaxedPrecision 
                                             OpDecorate %46 RelaxedPrecision 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpMemberDecorate %53 0 Offset 53 
                                             OpMemberDecorate %53 1 Offset 53 
                                             OpMemberDecorate %53 2 Offset 53 
                                             OpDecorate %53 Block 
                                             OpDecorate %55 DescriptorSet 55 
                                             OpDecorate %55 Binding 55 
                                             OpDecorate vs_TEXCOORD3 Location 85 
                                             OpDecorate %90 RelaxedPrecision 
                                             OpDecorate %93 RelaxedPrecision 
                                             OpDecorate %93 DescriptorSet 93 
                                             OpDecorate %93 Binding 93 
                                             OpDecorate %94 RelaxedPrecision 
                                             OpDecorate %97 RelaxedPrecision 
                                             OpDecorate %97 DescriptorSet 97 
                                             OpDecorate %97 Binding 97 
                                             OpDecorate %98 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 103 
                                             OpDecorate %108 RelaxedPrecision 
                                             OpDecorate %109 RelaxedPrecision 
                                             OpDecorate %113 RelaxedPrecision 
                                             OpDecorate %118 RelaxedPrecision 
                                             OpDecorate %120 RelaxedPrecision 
                                             OpDecorate %132 RelaxedPrecision 
                                             OpDecorate %132 Location 132 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypeVector %6 3 
                                      %8 = OpTypePointer Private %7 
                       Private f32_3* %9 = OpVariable Private 
                                     %10 = OpTypePointer Input %7 
               Input f32_3* vs_TEXCOORD1 = OpVariable Input 
                                     %15 = OpTypeInt 32 0 
                                 u32 %16 = OpConstant 0 
                                     %17 = OpTypePointer Private %6 
                        Private f32* %27 = OpVariable Private 
               Input f32_3* vs_TEXCOORD2 = OpVariable Input 
                      Private f32_3* %34 = OpVariable Private 
                        Private f32* %39 = OpVariable Private 
                                 f32 %45 = OpConstant 3.674022E-40 
                                     %52 = OpTypeVector %6 4 
                                     %53 = OpTypeStruct %6 %6 %52 
                                     %54 = OpTypePointer Uniform %53 
  Uniform struct {f32; f32; f32_4;}* %55 = OpVariable Uniform 
                                     %56 = OpTypeInt 32 1 
                                 i32 %57 = OpConstant 0 
                                     %58 = OpTypePointer Uniform %6 
                                 i32 %69 = OpConstant 1 
                      Private f32_3* %74 = OpVariable Private 
                                 i32 %77 = OpConstant 2 
                                     %78 = OpTypePointer Uniform %52 
                                     %84 = OpTypePointer Input %52 
               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
                                     %89 = OpTypePointer Private %52 
                      Private f32_4* %90 = OpVariable Private 
                                     %91 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %92 = OpTypePointer UniformConstant %91 
UniformConstant read_only Texture2D* %93 = OpVariable UniformConstant 
                                     %95 = OpTypeSampler 
                                     %96 = OpTypePointer UniformConstant %95 
            UniformConstant sampler* %97 = OpVariable UniformConstant 
                                     %99 = OpTypeSampledImage %91 
                                    %101 = OpTypeVector %6 2 
                                    %102 = OpTypePointer Input %101 
               Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                     Private f32_4* %106 = OpVariable Private 
                       Private f32* %113 = OpVariable Private 
                                u32 %116 = OpConstant 3 
                                    %121 = OpTypePointer Input %6 
                                f32 %128 = OpConstant 3.674022E-40 
                                    %131 = OpTypePointer Output %52 
                      Output f32_4* %132 = OpVariable Output 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                               f32_3 %12 = OpLoad vs_TEXCOORD1 
                               f32_3 %13 = OpLoad vs_TEXCOORD1 
                                 f32 %14 = OpDot %12 %13 
                        Private f32* %18 = OpAccessChain %9 %16 
                                             OpStore %18 %14 
                        Private f32* %19 = OpAccessChain %9 %16 
                                 f32 %20 = OpLoad %19 
                                 f32 %21 = OpExtInst %1 32 %20 
                        Private f32* %22 = OpAccessChain %9 %16 
                                             OpStore %22 %21 
                               f32_3 %23 = OpLoad %9 
                               f32_3 %24 = OpVectorShuffle %23 %23 0 0 0 
                               f32_3 %25 = OpLoad vs_TEXCOORD1 
                               f32_3 %26 = OpFMul %24 %25 
                                             OpStore %9 %26 
                               f32_3 %29 = OpLoad vs_TEXCOORD2 
                               f32_3 %30 = OpLoad vs_TEXCOORD2 
                                 f32 %31 = OpDot %29 %30 
                                             OpStore %27 %31 
                                 f32 %32 = OpLoad %27 
                                 f32 %33 = OpExtInst %1 32 %32 
                                             OpStore %27 %33 
                                 f32 %35 = OpLoad %27 
                               f32_3 %36 = OpCompositeConstruct %35 %35 %35 
                               f32_3 %37 = OpLoad vs_TEXCOORD2 
                               f32_3 %38 = OpFMul %36 %37 
                                             OpStore %34 %38 
                               f32_3 %40 = OpLoad %9 
                               f32_3 %41 = OpLoad %34 
                                 f32 %42 = OpDot %40 %41 
                                             OpStore %39 %42 
                                 f32 %43 = OpLoad %39 
                                 f32 %44 = OpFNegate %43 
                                 f32 %46 = OpFAdd %44 %45 
                                             OpStore %39 %46 
                                 f32 %47 = OpLoad %39 
                                 f32 %48 = OpExtInst %1 30 %47 
                        Private f32* %49 = OpAccessChain %9 %16 
                                             OpStore %49 %48 
                        Private f32* %50 = OpAccessChain %9 %16 
                                 f32 %51 = OpLoad %50 
                        Uniform f32* %59 = OpAccessChain %55 %57 
                                 f32 %60 = OpLoad %59 
                                 f32 %61 = OpFMul %51 %60 
                        Private f32* %62 = OpAccessChain %9 %16 
                                             OpStore %62 %61 
                        Private f32* %63 = OpAccessChain %9 %16 
                                 f32 %64 = OpLoad %63 
                                 f32 %65 = OpExtInst %1 29 %64 
                        Private f32* %66 = OpAccessChain %9 %16 
                                             OpStore %66 %65 
                        Private f32* %67 = OpAccessChain %9 %16 
                                 f32 %68 = OpLoad %67 
                        Uniform f32* %70 = OpAccessChain %55 %69 
                                 f32 %71 = OpLoad %70 
                                 f32 %72 = OpFMul %68 %71 
                        Private f32* %73 = OpAccessChain %9 %16 
                                             OpStore %73 %72 
                               f32_3 %75 = OpLoad %9 
                               f32_3 %76 = OpVectorShuffle %75 %75 0 0 0 
                      Uniform f32_4* %79 = OpAccessChain %55 %77 
                               f32_4 %80 = OpLoad %79 
                               f32_3 %81 = OpVectorShuffle %80 %80 0 1 2 
                               f32_3 %82 = OpFMul %76 %81 
                                             OpStore %74 %82 
                               f32_3 %83 = OpLoad %74 
                               f32_4 %86 = OpLoad vs_TEXCOORD3 
                               f32_3 %87 = OpVectorShuffle %86 %86 0 1 2 
                               f32_3 %88 = OpFMul %83 %87 
                                             OpStore %74 %88 
                 read_only Texture2D %94 = OpLoad %93 
                             sampler %98 = OpLoad %97 
         read_only Texture2DSampled %100 = OpSampledImage %94 %98 
                              f32_2 %104 = OpLoad vs_TEXCOORD0 
                              f32_4 %105 = OpImageSampleImplicitLod %100 %104 
                                             OpStore %90 %105 
                              f32_3 %107 = OpLoad %74 
                              f32_4 %108 = OpLoad %90 
                              f32_3 %109 = OpVectorShuffle %108 %108 0 1 2 
                              f32_3 %110 = OpFMul %107 %109 
                              f32_4 %111 = OpLoad %106 
                              f32_4 %112 = OpVectorShuffle %111 %110 4 5 6 3 
                                             OpStore %106 %112 
                       Private f32* %114 = OpAccessChain %9 %16 
                                f32 %115 = OpLoad %114 
                       Private f32* %117 = OpAccessChain %90 %116 
                                f32 %118 = OpLoad %117 
                                f32 %119 = OpFMul %115 %118 
                                             OpStore %113 %119 
                                f32 %120 = OpLoad %113 
                         Input f32* %122 = OpAccessChain vs_TEXCOORD3 %116 
                                f32 %123 = OpLoad %122 
                                f32 %124 = OpFMul %120 %123 
                       Private f32* %125 = OpAccessChain %106 %116 
                                             OpStore %125 %124 
                       Private f32* %126 = OpAccessChain %106 %116 
                                f32 %127 = OpLoad %126 
                                f32 %129 = OpExtInst %1 43 %127 %128 %45 
                       Private f32* %130 = OpAccessChain %106 %116 
                                             OpStore %130 %129 
                              f32_4 %133 = OpLoad %106 
                                             OpStore %132 %133 
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