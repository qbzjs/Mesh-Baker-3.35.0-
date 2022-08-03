//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Particles/Standard Unlit" {
Properties {
_MainTex ("Albedo", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_BumpScale ("Scale", Float) = 1
_BumpMap ("Normal Map", 2D) = "bump" { }
_EmissionColor ("Color", Color) = (0,0,0,1)
_EmissionMap ("Emission", 2D) = "white" { }
_DistortionStrength ("Strength", Float) = 1
_DistortionBlend ("Blend", Range(0, 1)) = 0.5
_SoftParticlesNearFadeDistance ("Soft Particles Near Fade", Float) = 0
_SoftParticlesFarFadeDistance ("Soft Particles Far Fade", Float) = 1
_CameraNearFadeDistance ("Camera Near Fade", Float) = 1
_CameraFarFadeDistance ("Camera Far Fade", Float) = 2
_Mode ("__mode", Float) = 0
_ColorMode ("__colormode", Float) = 0
_FlipbookMode ("__flipbookmode", Float) = 0
_LightingEnabled ("__lightingenabled", Float) = 0
_DistortionEnabled ("__distortionenabled", Float) = 0
_EmissionEnabled ("__emissionenabled", Float) = 0
_BlendOp ("__blendop", Float) = 0
_SrcBlend ("__src", Float) = 1
_DstBlend ("__dst", Float) = 0
_ZWrite ("__zw", Float) = 1
_Cull ("__cull", Float) = 2
_SoftParticlesEnabled ("__softparticlesenabled", Float) = 0
_CameraFadingEnabled ("__camerafadingenabled", Float) = 0
_SoftParticleFadeParams ("__softparticlefadeparams", Vector) = (0,0,0,0)
_CameraFadeParams ("__camerafadeparams", Vector) = (0,0,0,0)
_ColorAddSubDiff ("__coloraddsubdiff", Vector) = (0,0,0,0)
_DistortionStrengthScaled ("__distortionstrengthscaled", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" }
 GrabPass {
  "_GrabTexture"
}
 Pass {
  Name "ShadowCaster"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ColorMask RGB 0
  Cull Off
  GpuProgramID 18548
Program "vp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SHADOWS_DEPTH" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 254
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %66 %227 
                                                      OpDecorate %12 Location 12 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate %66 Location 66 
                                                      OpMemberDecorate %225 0 BuiltIn 225 
                                                      OpMemberDecorate %225 1 BuiltIn 225 
                                                      OpMemberDecorate %225 2 BuiltIn 225 
                                                      OpDecorate %225 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 3 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_3* %12 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %7 %16 %17 %18 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4];}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 3 
                                          i32 %24 = OpConstant 0 
                                              %25 = OpTypePointer Uniform %7 
                                          u32 %30 = OpConstant 0 
                                              %31 = OpTypePointer Private %6 
                                          i32 %34 = OpConstant 1 
                                          u32 %39 = OpConstant 1 
                                          i32 %42 = OpConstant 2 
                                          u32 %47 = OpConstant 2 
                                 Private f32* %49 = OpVariable Private 
                               Private f32_4* %64 = OpVariable Private 
                                              %65 = OpTypePointer Input %7 
                                 Input f32_4* %66 = OpVariable Input 
                               Private f32_4* %93 = OpVariable Private 
                                         f32 %130 = OpConstant 3.674022E-40 
                                             %135 = OpTypePointer Uniform %6 
                                             %150 = OpTypeBool 
                                             %151 = OpTypePointer Private %150 
                               Private bool* %152 = OpVariable Private 
                                         f32 %155 = OpConstant 3.674022E-40 
                                             %158 = OpTypePointer Function %10 
                                         i32 %172 = OpConstant 4 
                                         u32 %199 = OpConstant 3 
                                         f32 %210 = OpConstant 3.674022E-40 
                                Private f32* %213 = OpVariable Private 
                                             %224 = OpTypeArray %6 %39 
                                             %225 = OpTypeStruct %7 %6 %224 
                                             %226 = OpTypePointer Output %225 
        Output struct {f32_4; f32; f32[1];}* %227 = OpVariable Output 
                                             %230 = OpTypePointer Output %7 
                                             %247 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %159 = OpVariable Function 
                                        f32_3 %13 = OpLoad %12 
                               Uniform f32_4* %26 = OpAccessChain %21 %23 %24 
                                        f32_4 %27 = OpLoad %26 
                                        f32_3 %28 = OpVectorShuffle %27 %27 0 1 2 
                                          f32 %29 = OpDot %13 %28 
                                 Private f32* %32 = OpAccessChain %9 %30 
                                                      OpStore %32 %29 
                                        f32_3 %33 = OpLoad %12 
                               Uniform f32_4* %35 = OpAccessChain %21 %23 %34 
                                        f32_4 %36 = OpLoad %35 
                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                                          f32 %38 = OpDot %33 %37 
                                 Private f32* %40 = OpAccessChain %9 %39 
                                                      OpStore %40 %38 
                                        f32_3 %41 = OpLoad %12 
                               Uniform f32_4* %43 = OpAccessChain %21 %23 %42 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                          f32 %46 = OpDot %41 %45 
                                 Private f32* %48 = OpAccessChain %9 %47 
                                                      OpStore %48 %46 
                                        f32_4 %50 = OpLoad %9 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                          f32 %54 = OpDot %51 %53 
                                                      OpStore %49 %54 
                                          f32 %55 = OpLoad %49 
                                          f32 %56 = OpExtInst %1 32 %55 
                                                      OpStore %49 %56 
                                          f32 %57 = OpLoad %49 
                                        f32_3 %58 = OpCompositeConstruct %57 %57 %57 
                                        f32_4 %59 = OpLoad %9 
                                        f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                        f32_3 %61 = OpFMul %58 %60 
                                        f32_4 %62 = OpLoad %9 
                                        f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                      OpStore %9 %63 
                                        f32_4 %67 = OpLoad %66 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %69 = OpAccessChain %21 %42 %34 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpFMul %68 %70 
                                                      OpStore %64 %71 
                               Uniform f32_4* %72 = OpAccessChain %21 %42 %24 
                                        f32_4 %73 = OpLoad %72 
                                        f32_4 %74 = OpLoad %66 
                                        f32_4 %75 = OpVectorShuffle %74 %74 0 0 0 0 
                                        f32_4 %76 = OpFMul %73 %75 
                                        f32_4 %77 = OpLoad %64 
                                        f32_4 %78 = OpFAdd %76 %77 
                                                      OpStore %64 %78 
                               Uniform f32_4* %79 = OpAccessChain %21 %42 %42 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpVectorShuffle %81 %81 2 2 2 2 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %64 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %64 %85 
                               Uniform f32_4* %86 = OpAccessChain %21 %42 %23 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpVectorShuffle %88 %88 3 3 3 3 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %64 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %64 %92 
                                        f32_4 %94 = OpLoad %64 
                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
                                        f32_3 %96 = OpFNegate %95 
                               Uniform f32_4* %97 = OpAccessChain %21 %24 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 3 3 3 
                                       f32_3 %100 = OpFMul %96 %99 
                              Uniform f32_4* %101 = OpAccessChain %21 %24 
                                       f32_4 %102 = OpLoad %101 
                                       f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
                                       f32_3 %104 = OpFAdd %100 %103 
                                       f32_4 %105 = OpLoad %93 
                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
                                                      OpStore %93 %106 
                                       f32_4 %107 = OpLoad %93 
                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
                                       f32_4 %109 = OpLoad %93 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %108 %110 
                                                      OpStore %49 %111 
                                         f32 %112 = OpLoad %49 
                                         f32 %113 = OpExtInst %1 32 %112 
                                                      OpStore %49 %113 
                                         f32 %114 = OpLoad %49 
                                       f32_3 %115 = OpCompositeConstruct %114 %114 %114 
                                       f32_4 %116 = OpLoad %93 
                                       f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
                                       f32_3 %118 = OpFMul %115 %117 
                                       f32_4 %119 = OpLoad %93 
                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
                                                      OpStore %93 %120 
                                       f32_4 %121 = OpLoad %9 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_4 %123 = OpLoad %93 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %122 %124 
                                                      OpStore %49 %125 
                                         f32 %126 = OpLoad %49 
                                         f32 %127 = OpFNegate %126 
                                         f32 %128 = OpLoad %49 
                                         f32 %129 = OpFMul %127 %128 
                                         f32 %131 = OpFAdd %129 %130 
                                                      OpStore %49 %131 
                                         f32 %132 = OpLoad %49 
                                         f32 %133 = OpExtInst %1 31 %132 
                                                      OpStore %49 %133 
                                         f32 %134 = OpLoad %49 
                                Uniform f32* %136 = OpAccessChain %21 %34 %47 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFMul %134 %137 
                                                      OpStore %49 %138 
                                       f32_4 %139 = OpLoad %9 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_3 %141 = OpFNegate %140 
                                         f32 %142 = OpLoad %49 
                                       f32_3 %143 = OpCompositeConstruct %142 %142 %142 
                                       f32_3 %144 = OpFMul %141 %143 
                                       f32_4 %145 = OpLoad %64 
                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
                                       f32_3 %147 = OpFAdd %144 %146 
                                       f32_4 %148 = OpLoad %9 
                                       f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                      OpStore %9 %149 
                                Uniform f32* %153 = OpAccessChain %21 %34 %47 
                                         f32 %154 = OpLoad %153 
                                        bool %156 = OpFOrdNotEqual %154 %155 
                                                      OpStore %152 %156 
                                        bool %157 = OpLoad %152 
                                                      OpSelectionMerge %161 None 
                                                      OpBranchConditional %157 %160 %164 
                                             %160 = OpLabel 
                                       f32_4 %162 = OpLoad %9 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                                      OpStore %159 %163 
                                                      OpBranch %161 
                                             %164 = OpLabel 
                                       f32_4 %165 = OpLoad %64 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                                      OpStore %159 %166 
                                                      OpBranch %161 
                                             %161 = OpLabel 
                                       f32_3 %167 = OpLoad %159 
                                       f32_4 %168 = OpLoad %9 
                                       f32_4 %169 = OpVectorShuffle %168 %167 4 5 6 3 
                                                      OpStore %9 %169 
                                       f32_4 %170 = OpLoad %9 
                                       f32_4 %171 = OpVectorShuffle %170 %170 1 1 1 1 
                              Uniform f32_4* %173 = OpAccessChain %21 %172 %34 
                                       f32_4 %174 = OpLoad %173 
                                       f32_4 %175 = OpFMul %171 %174 
                                                      OpStore %93 %175 
                              Uniform f32_4* %176 = OpAccessChain %21 %172 %24 
                                       f32_4 %177 = OpLoad %176 
                                       f32_4 %178 = OpLoad %9 
                                       f32_4 %179 = OpVectorShuffle %178 %178 0 0 0 0 
                                       f32_4 %180 = OpFMul %177 %179 
                                       f32_4 %181 = OpLoad %93 
                                       f32_4 %182 = OpFAdd %180 %181 
                                                      OpStore %93 %182 
                              Uniform f32_4* %183 = OpAccessChain %21 %172 %42 
                                       f32_4 %184 = OpLoad %183 
                                       f32_4 %185 = OpLoad %9 
                                       f32_4 %186 = OpVectorShuffle %185 %185 2 2 2 2 
                                       f32_4 %187 = OpFMul %184 %186 
                                       f32_4 %188 = OpLoad %93 
                                       f32_4 %189 = OpFAdd %187 %188 
                                                      OpStore %9 %189 
                              Uniform f32_4* %190 = OpAccessChain %21 %172 %23 
                                       f32_4 %191 = OpLoad %190 
                                       f32_4 %192 = OpLoad %64 
                                       f32_4 %193 = OpVectorShuffle %192 %192 3 3 3 3 
                                       f32_4 %194 = OpFMul %191 %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpFAdd %194 %195 
                                                      OpStore %9 %196 
                                Uniform f32* %197 = OpAccessChain %21 %34 %30 
                                         f32 %198 = OpLoad %197 
                                Private f32* %200 = OpAccessChain %9 %199 
                                         f32 %201 = OpLoad %200 
                                         f32 %202 = OpFDiv %198 %201 
                                Private f32* %203 = OpAccessChain %64 %30 
                                                      OpStore %203 %202 
                                Private f32* %204 = OpAccessChain %64 %30 
                                         f32 %205 = OpLoad %204 
                                         f32 %206 = OpExtInst %1 37 %205 %155 
                                Private f32* %207 = OpAccessChain %64 %30 
                                                      OpStore %207 %206 
                                Private f32* %208 = OpAccessChain %64 %30 
                                         f32 %209 = OpLoad %208 
                                         f32 %211 = OpExtInst %1 40 %209 %210 
                                Private f32* %212 = OpAccessChain %64 %30 
                                                      OpStore %212 %211 
                                Private f32* %214 = OpAccessChain %9 %47 
                                         f32 %215 = OpLoad %214 
                                Private f32* %216 = OpAccessChain %64 %30 
                                         f32 %217 = OpLoad %216 
                                         f32 %218 = OpFAdd %215 %217 
                                                      OpStore %213 %218 
                                Private f32* %219 = OpAccessChain %9 %199 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpLoad %213 
                                         f32 %222 = OpExtInst %1 37 %220 %221 
                                Private f32* %223 = OpAccessChain %64 %30 
                                                      OpStore %223 %222 
                                       f32_4 %228 = OpLoad %9 
                                       f32_3 %229 = OpVectorShuffle %228 %228 0 1 3 
                               Output f32_4* %231 = OpAccessChain %227 %24 
                                       f32_4 %232 = OpLoad %231 
                                       f32_4 %233 = OpVectorShuffle %232 %229 4 5 2 6 
                                                      OpStore %231 %233 
                                         f32 %234 = OpLoad %213 
                                         f32 %235 = OpFNegate %234 
                                Private f32* %236 = OpAccessChain %64 %30 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFAdd %235 %237 
                                Private f32* %239 = OpAccessChain %9 %30 
                                                      OpStore %239 %238 
                                Uniform f32* %240 = OpAccessChain %21 %34 %39 
                                         f32 %241 = OpLoad %240 
                                Private f32* %242 = OpAccessChain %9 %30 
                                         f32 %243 = OpLoad %242 
                                         f32 %244 = OpFMul %241 %243 
                                         f32 %245 = OpLoad %213 
                                         f32 %246 = OpFAdd %244 %245 
                                 Output f32* %248 = OpAccessChain %227 %24 %47 
                                                      OpStore %248 %246 
                                 Output f32* %249 = OpAccessChain %227 %24 %39 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpFNegate %250 
                                 Output f32* %252 = OpAccessChain %227 %24 %39 
                                                      OpStore %252 %251 
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
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 254
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %34 %36 %42 %85 %233 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate vs_TEXCOORD1 Location 9 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpMemberDecorate %19 5 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 34 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %36 Location 36 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %42 Location 42 
                                                      OpDecorate %85 Location 85 
                                                      OpMemberDecorate %231 0 BuiltIn 231 
                                                      OpMemberDecorate %231 1 BuiltIn 231 
                                                      OpMemberDecorate %231 2 BuiltIn 231 
                                                      OpDecorate %231 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 2 
                                               %8 = OpTypePointer Output %7 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_2* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 4 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %13 %15 
                                              %17 = OpTypeArray %13 %15 
                                              %18 = OpTypeArray %13 %15 
                                              %19 = OpTypeStruct %13 %13 %16 %17 %18 %13 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 5 
                                              %24 = OpTypePointer Uniform %13 
                                              %33 = OpTypePointer Output %13 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                              %35 = OpTypePointer Input %13 
                                 Input f32_4* %36 = OpVariable Input 
                                              %38 = OpTypePointer Private %13 
                               Private f32_4* %39 = OpVariable Private 
                                              %40 = OpTypeVector %6 3 
                                              %41 = OpTypePointer Input %40 
                                 Input f32_3* %42 = OpVariable Input 
                                          i32 %44 = OpConstant 3 
                                          i32 %45 = OpConstant 0 
                                          u32 %50 = OpConstant 0 
                                              %51 = OpTypePointer Private %6 
                                          i32 %54 = OpConstant 1 
                                          u32 %59 = OpConstant 1 
                                          i32 %62 = OpConstant 2 
                                          u32 %67 = OpConstant 2 
                                 Private f32* %69 = OpVariable Private 
                               Private f32_4* %84 = OpVariable Private 
                                 Input f32_4* %85 = OpVariable Input 
                              Private f32_4* %112 = OpVariable Private 
                                         f32 %149 = OpConstant 3.674022E-40 
                                             %154 = OpTypePointer Uniform %6 
                                             %169 = OpTypeBool 
                                             %170 = OpTypePointer Private %169 
                               Private bool* %171 = OpVariable Private 
                                         f32 %174 = OpConstant 3.674022E-40 
                                             %177 = OpTypePointer Function %40 
                                         i32 %191 = OpConstant 4 
                                         u32 %216 = OpConstant 3 
                                             %230 = OpTypeArray %6 %59 
                                             %231 = OpTypeStruct %13 %6 %230 
                                             %232 = OpTypePointer Output %231 
        Output struct {f32_4; f32; f32[1];}* %233 = OpVariable Output 
                                             %242 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %178 = OpVariable Function 
                                        f32_2 %12 = OpLoad %11 
                               Uniform f32_4* %25 = OpAccessChain %21 %23 
                                        f32_4 %26 = OpLoad %25 
                                        f32_2 %27 = OpVectorShuffle %26 %26 0 1 
                                        f32_2 %28 = OpFMul %12 %27 
                               Uniform f32_4* %29 = OpAccessChain %21 %23 
                                        f32_4 %30 = OpLoad %29 
                                        f32_2 %31 = OpVectorShuffle %30 %30 2 3 
                                        f32_2 %32 = OpFAdd %28 %31 
                                                      OpStore vs_TEXCOORD1 %32 
                                        f32_4 %37 = OpLoad %36 
                                                      OpStore vs_TEXCOORD3 %37 
                                        f32_3 %43 = OpLoad %42 
                               Uniform f32_4* %46 = OpAccessChain %21 %44 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                          f32 %49 = OpDot %43 %48 
                                 Private f32* %52 = OpAccessChain %39 %50 
                                                      OpStore %52 %49 
                                        f32_3 %53 = OpLoad %42 
                               Uniform f32_4* %55 = OpAccessChain %21 %44 %54 
                                        f32_4 %56 = OpLoad %55 
                                        f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                                          f32 %58 = OpDot %53 %57 
                                 Private f32* %60 = OpAccessChain %39 %59 
                                                      OpStore %60 %58 
                                        f32_3 %61 = OpLoad %42 
                               Uniform f32_4* %63 = OpAccessChain %21 %44 %62 
                                        f32_4 %64 = OpLoad %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                          f32 %66 = OpDot %61 %65 
                                 Private f32* %68 = OpAccessChain %39 %67 
                                                      OpStore %68 %66 
                                        f32_4 %70 = OpLoad %39 
                                        f32_3 %71 = OpVectorShuffle %70 %70 0 1 2 
                                        f32_4 %72 = OpLoad %39 
                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
                                          f32 %74 = OpDot %71 %73 
                                                      OpStore %69 %74 
                                          f32 %75 = OpLoad %69 
                                          f32 %76 = OpExtInst %1 32 %75 
                                                      OpStore %69 %76 
                                          f32 %77 = OpLoad %69 
                                        f32_3 %78 = OpCompositeConstruct %77 %77 %77 
                                        f32_4 %79 = OpLoad %39 
                                        f32_3 %80 = OpVectorShuffle %79 %79 0 1 2 
                                        f32_3 %81 = OpFMul %78 %80 
                                        f32_4 %82 = OpLoad %39 
                                        f32_4 %83 = OpVectorShuffle %82 %81 4 5 6 3 
                                                      OpStore %39 %83 
                                        f32_4 %86 = OpLoad %85 
                                        f32_4 %87 = OpVectorShuffle %86 %86 1 1 1 1 
                               Uniform f32_4* %88 = OpAccessChain %21 %62 %54 
                                        f32_4 %89 = OpLoad %88 
                                        f32_4 %90 = OpFMul %87 %89 
                                                      OpStore %84 %90 
                               Uniform f32_4* %91 = OpAccessChain %21 %62 %45 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpLoad %85 
                                        f32_4 %94 = OpVectorShuffle %93 %93 0 0 0 0 
                                        f32_4 %95 = OpFMul %92 %94 
                                        f32_4 %96 = OpLoad %84 
                                        f32_4 %97 = OpFAdd %95 %96 
                                                      OpStore %84 %97 
                               Uniform f32_4* %98 = OpAccessChain %21 %62 %62 
                                        f32_4 %99 = OpLoad %98 
                                       f32_4 %100 = OpLoad %85 
                                       f32_4 %101 = OpVectorShuffle %100 %100 2 2 2 2 
                                       f32_4 %102 = OpFMul %99 %101 
                                       f32_4 %103 = OpLoad %84 
                                       f32_4 %104 = OpFAdd %102 %103 
                                                      OpStore %84 %104 
                              Uniform f32_4* %105 = OpAccessChain %21 %62 %44 
                                       f32_4 %106 = OpLoad %105 
                                       f32_4 %107 = OpLoad %85 
                                       f32_4 %108 = OpVectorShuffle %107 %107 3 3 3 3 
                                       f32_4 %109 = OpFMul %106 %108 
                                       f32_4 %110 = OpLoad %84 
                                       f32_4 %111 = OpFAdd %109 %110 
                                                      OpStore %84 %111 
                                       f32_4 %113 = OpLoad %84 
                                       f32_3 %114 = OpVectorShuffle %113 %113 0 1 2 
                                       f32_3 %115 = OpFNegate %114 
                              Uniform f32_4* %116 = OpAccessChain %21 %45 
                                       f32_4 %117 = OpLoad %116 
                                       f32_3 %118 = OpVectorShuffle %117 %117 3 3 3 
                                       f32_3 %119 = OpFMul %115 %118 
                              Uniform f32_4* %120 = OpAccessChain %21 %45 
                                       f32_4 %121 = OpLoad %120 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_3 %123 = OpFAdd %119 %122 
                                       f32_4 %124 = OpLoad %112 
                                       f32_4 %125 = OpVectorShuffle %124 %123 4 5 6 3 
                                                      OpStore %112 %125 
                                       f32_4 %126 = OpLoad %112 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                       f32_4 %128 = OpLoad %112 
                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
                                         f32 %130 = OpDot %127 %129 
                                                      OpStore %69 %130 
                                         f32 %131 = OpLoad %69 
                                         f32 %132 = OpExtInst %1 32 %131 
                                                      OpStore %69 %132 
                                         f32 %133 = OpLoad %69 
                                       f32_3 %134 = OpCompositeConstruct %133 %133 %133 
                                       f32_4 %135 = OpLoad %112 
                                       f32_3 %136 = OpVectorShuffle %135 %135 0 1 2 
                                       f32_3 %137 = OpFMul %134 %136 
                                       f32_4 %138 = OpLoad %112 
                                       f32_4 %139 = OpVectorShuffle %138 %137 4 5 6 3 
                                                      OpStore %112 %139 
                                       f32_4 %140 = OpLoad %39 
                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
                                       f32_4 %142 = OpLoad %112 
                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
                                         f32 %144 = OpDot %141 %143 
                                                      OpStore %69 %144 
                                         f32 %145 = OpLoad %69 
                                         f32 %146 = OpFNegate %145 
                                         f32 %147 = OpLoad %69 
                                         f32 %148 = OpFMul %146 %147 
                                         f32 %150 = OpFAdd %148 %149 
                                                      OpStore %69 %150 
                                         f32 %151 = OpLoad %69 
                                         f32 %152 = OpExtInst %1 31 %151 
                                                      OpStore %69 %152 
                                         f32 %153 = OpLoad %69 
                                Uniform f32* %155 = OpAccessChain %21 %54 %67 
                                         f32 %156 = OpLoad %155 
                                         f32 %157 = OpFMul %153 %156 
                                                      OpStore %69 %157 
                                       f32_4 %158 = OpLoad %39 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFNegate %159 
                                         f32 %161 = OpLoad %69 
                                       f32_3 %162 = OpCompositeConstruct %161 %161 %161 
                                       f32_3 %163 = OpFMul %160 %162 
                                       f32_4 %164 = OpLoad %84 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
                                       f32_3 %166 = OpFAdd %163 %165 
                                       f32_4 %167 = OpLoad %39 
                                       f32_4 %168 = OpVectorShuffle %167 %166 4 5 6 3 
                                                      OpStore %39 %168 
                                Uniform f32* %172 = OpAccessChain %21 %54 %67 
                                         f32 %173 = OpLoad %172 
                                        bool %175 = OpFOrdNotEqual %173 %174 
                                                      OpStore %171 %175 
                                        bool %176 = OpLoad %171 
                                                      OpSelectionMerge %180 None 
                                                      OpBranchConditional %176 %179 %183 
                                             %179 = OpLabel 
                                       f32_4 %181 = OpLoad %39 
                                       f32_3 %182 = OpVectorShuffle %181 %181 0 1 2 
                                                      OpStore %178 %182 
                                                      OpBranch %180 
                                             %183 = OpLabel 
                                       f32_4 %184 = OpLoad %84 
                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
                                                      OpStore %178 %185 
                                                      OpBranch %180 
                                             %180 = OpLabel 
                                       f32_3 %186 = OpLoad %178 
                                       f32_4 %187 = OpLoad %39 
                                       f32_4 %188 = OpVectorShuffle %187 %186 4 5 6 3 
                                                      OpStore %39 %188 
                                       f32_4 %189 = OpLoad %39 
                                       f32_4 %190 = OpVectorShuffle %189 %189 1 1 1 1 
                              Uniform f32_4* %192 = OpAccessChain %21 %191 %54 
                                       f32_4 %193 = OpLoad %192 
                                       f32_4 %194 = OpFMul %190 %193 
                                                      OpStore %112 %194 
                              Uniform f32_4* %195 = OpAccessChain %21 %191 %45 
                                       f32_4 %196 = OpLoad %195 
                                       f32_4 %197 = OpLoad %39 
                                       f32_4 %198 = OpVectorShuffle %197 %197 0 0 0 0 
                                       f32_4 %199 = OpFMul %196 %198 
                                       f32_4 %200 = OpLoad %112 
                                       f32_4 %201 = OpFAdd %199 %200 
                                                      OpStore %112 %201 
                              Uniform f32_4* %202 = OpAccessChain %21 %191 %62 
                                       f32_4 %203 = OpLoad %202 
                                       f32_4 %204 = OpLoad %39 
                                       f32_4 %205 = OpVectorShuffle %204 %204 2 2 2 2 
                                       f32_4 %206 = OpFMul %203 %205 
                                       f32_4 %207 = OpLoad %112 
                                       f32_4 %208 = OpFAdd %206 %207 
                                                      OpStore %39 %208 
                              Uniform f32_4* %209 = OpAccessChain %21 %191 %44 
                                       f32_4 %210 = OpLoad %209 
                                       f32_4 %211 = OpLoad %84 
                                       f32_4 %212 = OpVectorShuffle %211 %211 3 3 3 3 
                                       f32_4 %213 = OpFMul %210 %212 
                                       f32_4 %214 = OpLoad %39 
                                       f32_4 %215 = OpFAdd %213 %214 
                                                      OpStore %39 %215 
                                Private f32* %217 = OpAccessChain %39 %216 
                                         f32 %218 = OpLoad %217 
                                Private f32* %219 = OpAccessChain %39 %67 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpExtInst %1 37 %218 %220 
                                Private f32* %222 = OpAccessChain %84 %50 
                                                      OpStore %222 %221 
                                Private f32* %223 = OpAccessChain %39 %67 
                                         f32 %224 = OpLoad %223 
                                         f32 %225 = OpFNegate %224 
                                Private f32* %226 = OpAccessChain %84 %50 
                                         f32 %227 = OpLoad %226 
                                         f32 %228 = OpFAdd %225 %227 
                                Private f32* %229 = OpAccessChain %84 %50 
                                                      OpStore %229 %228 
                                Uniform f32* %234 = OpAccessChain %21 %54 %59 
                                         f32 %235 = OpLoad %234 
                                Private f32* %236 = OpAccessChain %84 %50 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFMul %235 %237 
                                Private f32* %239 = OpAccessChain %39 %67 
                                         f32 %240 = OpLoad %239 
                                         f32 %241 = OpFAdd %238 %240 
                                 Output f32* %243 = OpAccessChain %233 %45 %67 
                                                      OpStore %243 %241 
                                       f32_4 %244 = OpLoad %39 
                                       f32_3 %245 = OpVectorShuffle %244 %244 0 1 3 
                               Output f32_4* %246 = OpAccessChain %233 %45 
                                       f32_4 %247 = OpLoad %246 
                                       f32_4 %248 = OpVectorShuffle %247 %245 4 5 2 6 
                                                      OpStore %246 %248 
                                 Output f32* %249 = OpAccessChain %233 %45 %59 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpFNegate %250 
                                 Output f32* %252 = OpAccessChain %233 %45 %59 
                                                      OpStore %252 %251 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 59
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %21 %31 %56 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                             OpDecorate %8 RelaxedPrecision 
                                             OpDecorate %11 RelaxedPrecision 
                                             OpDecorate %11 DescriptorSet 11 
                                             OpDecorate %11 Binding 11 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %15 RelaxedPrecision 
                                             OpDecorate %15 DescriptorSet 15 
                                             OpDecorate %15 Binding 15 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 21 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 Location 31 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %41 RelaxedPrecision 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %56 Location 56 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypePointer Private %6 
                         Private f32* %8 = OpVariable Private 
                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %10 = OpTypePointer UniformConstant %9 
UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
                                     %13 = OpTypeSampler 
                                     %14 = OpTypePointer UniformConstant %13 
            UniformConstant sampler* %15 = OpVariable UniformConstant 
                                     %17 = OpTypeSampledImage %9 
                                     %19 = OpTypeVector %6 2 
                                     %20 = OpTypePointer Input %19 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %23 = OpTypeVector %6 4 
                                     %25 = OpTypeInt 32 0 
                                 u32 %26 = OpConstant 3 
                        Private f32* %28 = OpVariable Private 
                                     %30 = OpTypePointer Input %23 
               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
                                     %32 = OpTypePointer Input %6 
                                 f32 %36 = OpConstant 3.674022E-40 
                                     %38 = OpTypeBool 
                                     %39 = OpTypePointer Private %38 
                       Private bool* %40 = OpVariable Private 
                                 f32 %42 = OpConstant 3.674022E-40 
                                     %45 = OpTypeInt 32 1 
                                 i32 %46 = OpConstant 0 
                                 i32 %47 = OpConstant 1 
                                 i32 %49 = OpConstant -1 
                                     %55 = OpTypePointer Output %23 
                       Output f32_4* %56 = OpVariable Output 
                               f32_4 %57 = OpConstantComposite %42 %42 %42 %42 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %12 = OpLoad %11 
                             sampler %16 = OpLoad %15 
          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
                               f32_2 %22 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
                                 f32 %27 = OpCompositeExtract %24 3 
                                             OpStore %8 %27 
                                 f32 %29 = OpLoad %8 
                          Input f32* %33 = OpAccessChain vs_TEXCOORD3 %26 
                                 f32 %34 = OpLoad %33 
                                 f32 %35 = OpFMul %29 %34 
                                 f32 %37 = OpFAdd %35 %36 
                                             OpStore %28 %37 
                                 f32 %41 = OpLoad %28 
                                bool %43 = OpFOrdLessThan %41 %42 
                                             OpStore %40 %43 
                                bool %44 = OpLoad %40 
                                 i32 %48 = OpSelect %44 %47 %46 
                                 i32 %50 = OpIMul %48 %49 
                                bool %51 = OpINotEqual %50 %46 
                                             OpSelectionMerge %53 None 
                                             OpBranchConditional %51 %52 %53 
                                     %52 = OpLabel 
                                             OpKill
                                     %53 = OpLabel 
                                             OpStore %56 %57 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SHADOWS_CUBE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 236
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %66 %214 
                                                      OpDecorate %12 Location 12 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate %66 Location 66 
                                                      OpMemberDecorate %212 0 BuiltIn 212 
                                                      OpMemberDecorate %212 1 BuiltIn 212 
                                                      OpMemberDecorate %212 2 BuiltIn 212 
                                                      OpDecorate %212 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 3 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_3* %12 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %7 %16 %17 %18 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4];}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 3 
                                          i32 %24 = OpConstant 0 
                                              %25 = OpTypePointer Uniform %7 
                                          u32 %30 = OpConstant 0 
                                              %31 = OpTypePointer Private %6 
                                          i32 %34 = OpConstant 1 
                                          u32 %39 = OpConstant 1 
                                          i32 %42 = OpConstant 2 
                                          u32 %47 = OpConstant 2 
                                 Private f32* %49 = OpVariable Private 
                               Private f32_4* %64 = OpVariable Private 
                                              %65 = OpTypePointer Input %7 
                                 Input f32_4* %66 = OpVariable Input 
                               Private f32_4* %93 = OpVariable Private 
                                         f32 %130 = OpConstant 3.674022E-40 
                                             %135 = OpTypePointer Uniform %6 
                                             %150 = OpTypeBool 
                                             %151 = OpTypePointer Private %150 
                               Private bool* %152 = OpVariable Private 
                                         f32 %155 = OpConstant 3.674022E-40 
                                             %158 = OpTypePointer Function %10 
                                         i32 %172 = OpConstant 4 
                                         u32 %197 = OpConstant 3 
                                             %211 = OpTypeArray %6 %39 
                                             %212 = OpTypeStruct %7 %6 %211 
                                             %213 = OpTypePointer Output %212 
        Output struct {f32_4; f32; f32[1];}* %214 = OpVariable Output 
                                             %223 = OpTypePointer Output %6 
                                             %227 = OpTypePointer Output %7 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %159 = OpVariable Function 
                                        f32_3 %13 = OpLoad %12 
                               Uniform f32_4* %26 = OpAccessChain %21 %23 %24 
                                        f32_4 %27 = OpLoad %26 
                                        f32_3 %28 = OpVectorShuffle %27 %27 0 1 2 
                                          f32 %29 = OpDot %13 %28 
                                 Private f32* %32 = OpAccessChain %9 %30 
                                                      OpStore %32 %29 
                                        f32_3 %33 = OpLoad %12 
                               Uniform f32_4* %35 = OpAccessChain %21 %23 %34 
                                        f32_4 %36 = OpLoad %35 
                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                                          f32 %38 = OpDot %33 %37 
                                 Private f32* %40 = OpAccessChain %9 %39 
                                                      OpStore %40 %38 
                                        f32_3 %41 = OpLoad %12 
                               Uniform f32_4* %43 = OpAccessChain %21 %23 %42 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                          f32 %46 = OpDot %41 %45 
                                 Private f32* %48 = OpAccessChain %9 %47 
                                                      OpStore %48 %46 
                                        f32_4 %50 = OpLoad %9 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                          f32 %54 = OpDot %51 %53 
                                                      OpStore %49 %54 
                                          f32 %55 = OpLoad %49 
                                          f32 %56 = OpExtInst %1 32 %55 
                                                      OpStore %49 %56 
                                          f32 %57 = OpLoad %49 
                                        f32_3 %58 = OpCompositeConstruct %57 %57 %57 
                                        f32_4 %59 = OpLoad %9 
                                        f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                        f32_3 %61 = OpFMul %58 %60 
                                        f32_4 %62 = OpLoad %9 
                                        f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                      OpStore %9 %63 
                                        f32_4 %67 = OpLoad %66 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %69 = OpAccessChain %21 %42 %34 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpFMul %68 %70 
                                                      OpStore %64 %71 
                               Uniform f32_4* %72 = OpAccessChain %21 %42 %24 
                                        f32_4 %73 = OpLoad %72 
                                        f32_4 %74 = OpLoad %66 
                                        f32_4 %75 = OpVectorShuffle %74 %74 0 0 0 0 
                                        f32_4 %76 = OpFMul %73 %75 
                                        f32_4 %77 = OpLoad %64 
                                        f32_4 %78 = OpFAdd %76 %77 
                                                      OpStore %64 %78 
                               Uniform f32_4* %79 = OpAccessChain %21 %42 %42 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpVectorShuffle %81 %81 2 2 2 2 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %64 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %64 %85 
                               Uniform f32_4* %86 = OpAccessChain %21 %42 %23 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpVectorShuffle %88 %88 3 3 3 3 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %64 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %64 %92 
                                        f32_4 %94 = OpLoad %64 
                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
                                        f32_3 %96 = OpFNegate %95 
                               Uniform f32_4* %97 = OpAccessChain %21 %24 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 3 3 3 
                                       f32_3 %100 = OpFMul %96 %99 
                              Uniform f32_4* %101 = OpAccessChain %21 %24 
                                       f32_4 %102 = OpLoad %101 
                                       f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
                                       f32_3 %104 = OpFAdd %100 %103 
                                       f32_4 %105 = OpLoad %93 
                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
                                                      OpStore %93 %106 
                                       f32_4 %107 = OpLoad %93 
                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
                                       f32_4 %109 = OpLoad %93 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %108 %110 
                                                      OpStore %49 %111 
                                         f32 %112 = OpLoad %49 
                                         f32 %113 = OpExtInst %1 32 %112 
                                                      OpStore %49 %113 
                                         f32 %114 = OpLoad %49 
                                       f32_3 %115 = OpCompositeConstruct %114 %114 %114 
                                       f32_4 %116 = OpLoad %93 
                                       f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
                                       f32_3 %118 = OpFMul %115 %117 
                                       f32_4 %119 = OpLoad %93 
                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
                                                      OpStore %93 %120 
                                       f32_4 %121 = OpLoad %9 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_4 %123 = OpLoad %93 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %122 %124 
                                                      OpStore %49 %125 
                                         f32 %126 = OpLoad %49 
                                         f32 %127 = OpFNegate %126 
                                         f32 %128 = OpLoad %49 
                                         f32 %129 = OpFMul %127 %128 
                                         f32 %131 = OpFAdd %129 %130 
                                                      OpStore %49 %131 
                                         f32 %132 = OpLoad %49 
                                         f32 %133 = OpExtInst %1 31 %132 
                                                      OpStore %49 %133 
                                         f32 %134 = OpLoad %49 
                                Uniform f32* %136 = OpAccessChain %21 %34 %47 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFMul %134 %137 
                                                      OpStore %49 %138 
                                       f32_4 %139 = OpLoad %9 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_3 %141 = OpFNegate %140 
                                         f32 %142 = OpLoad %49 
                                       f32_3 %143 = OpCompositeConstruct %142 %142 %142 
                                       f32_3 %144 = OpFMul %141 %143 
                                       f32_4 %145 = OpLoad %64 
                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
                                       f32_3 %147 = OpFAdd %144 %146 
                                       f32_4 %148 = OpLoad %9 
                                       f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                      OpStore %9 %149 
                                Uniform f32* %153 = OpAccessChain %21 %34 %47 
                                         f32 %154 = OpLoad %153 
                                        bool %156 = OpFOrdNotEqual %154 %155 
                                                      OpStore %152 %156 
                                        bool %157 = OpLoad %152 
                                                      OpSelectionMerge %161 None 
                                                      OpBranchConditional %157 %160 %164 
                                             %160 = OpLabel 
                                       f32_4 %162 = OpLoad %9 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                                      OpStore %159 %163 
                                                      OpBranch %161 
                                             %164 = OpLabel 
                                       f32_4 %165 = OpLoad %64 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                                      OpStore %159 %166 
                                                      OpBranch %161 
                                             %161 = OpLabel 
                                       f32_3 %167 = OpLoad %159 
                                       f32_4 %168 = OpLoad %9 
                                       f32_4 %169 = OpVectorShuffle %168 %167 4 5 6 3 
                                                      OpStore %9 %169 
                                       f32_4 %170 = OpLoad %9 
                                       f32_4 %171 = OpVectorShuffle %170 %170 1 1 1 1 
                              Uniform f32_4* %173 = OpAccessChain %21 %172 %34 
                                       f32_4 %174 = OpLoad %173 
                                       f32_4 %175 = OpFMul %171 %174 
                                                      OpStore %93 %175 
                              Uniform f32_4* %176 = OpAccessChain %21 %172 %24 
                                       f32_4 %177 = OpLoad %176 
                                       f32_4 %178 = OpLoad %9 
                                       f32_4 %179 = OpVectorShuffle %178 %178 0 0 0 0 
                                       f32_4 %180 = OpFMul %177 %179 
                                       f32_4 %181 = OpLoad %93 
                                       f32_4 %182 = OpFAdd %180 %181 
                                                      OpStore %93 %182 
                              Uniform f32_4* %183 = OpAccessChain %21 %172 %42 
                                       f32_4 %184 = OpLoad %183 
                                       f32_4 %185 = OpLoad %9 
                                       f32_4 %186 = OpVectorShuffle %185 %185 2 2 2 2 
                                       f32_4 %187 = OpFMul %184 %186 
                                       f32_4 %188 = OpLoad %93 
                                       f32_4 %189 = OpFAdd %187 %188 
                                                      OpStore %9 %189 
                              Uniform f32_4* %190 = OpAccessChain %21 %172 %23 
                                       f32_4 %191 = OpLoad %190 
                                       f32_4 %192 = OpLoad %64 
                                       f32_4 %193 = OpVectorShuffle %192 %192 3 3 3 3 
                                       f32_4 %194 = OpFMul %191 %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpFAdd %194 %195 
                                                      OpStore %9 %196 
                                Private f32* %198 = OpAccessChain %9 %197 
                                         f32 %199 = OpLoad %198 
                                Private f32* %200 = OpAccessChain %9 %47 
                                         f32 %201 = OpLoad %200 
                                         f32 %202 = OpExtInst %1 37 %199 %201 
                                Private f32* %203 = OpAccessChain %64 %30 
                                                      OpStore %203 %202 
                                Private f32* %204 = OpAccessChain %9 %47 
                                         f32 %205 = OpLoad %204 
                                         f32 %206 = OpFNegate %205 
                                Private f32* %207 = OpAccessChain %64 %30 
                                         f32 %208 = OpLoad %207 
                                         f32 %209 = OpFAdd %206 %208 
                                Private f32* %210 = OpAccessChain %64 %30 
                                                      OpStore %210 %209 
                                Uniform f32* %215 = OpAccessChain %21 %34 %39 
                                         f32 %216 = OpLoad %215 
                                Private f32* %217 = OpAccessChain %64 %30 
                                         f32 %218 = OpLoad %217 
                                         f32 %219 = OpFMul %216 %218 
                                Private f32* %220 = OpAccessChain %9 %47 
                                         f32 %221 = OpLoad %220 
                                         f32 %222 = OpFAdd %219 %221 
                                 Output f32* %224 = OpAccessChain %214 %24 %47 
                                                      OpStore %224 %222 
                                       f32_4 %225 = OpLoad %9 
                                       f32_3 %226 = OpVectorShuffle %225 %225 0 1 3 
                               Output f32_4* %228 = OpAccessChain %214 %24 
                                       f32_4 %229 = OpLoad %228 
                                       f32_4 %230 = OpVectorShuffle %229 %226 4 5 2 6 
                                                      OpStore %228 %230 
                                 Output f32* %231 = OpAccessChain %214 %24 %39 
                                         f32 %232 = OpLoad %231 
                                         f32 %233 = OpFNegate %232 
                                 Output f32* %234 = OpAccessChain %214 %24 %39 
                                                      OpStore %234 %233 
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
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 272
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %34 %36 %42 %85 %246 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate vs_TEXCOORD1 Location 9 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpMemberDecorate %19 5 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 34 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %36 Location 36 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %42 Location 42 
                                                      OpDecorate %85 Location 85 
                                                      OpMemberDecorate %244 0 BuiltIn 244 
                                                      OpMemberDecorate %244 1 BuiltIn 244 
                                                      OpMemberDecorate %244 2 BuiltIn 244 
                                                      OpDecorate %244 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 2 
                                               %8 = OpTypePointer Output %7 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_2* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 4 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %13 %15 
                                              %17 = OpTypeArray %13 %15 
                                              %18 = OpTypeArray %13 %15 
                                              %19 = OpTypeStruct %13 %13 %16 %17 %18 %13 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 5 
                                              %24 = OpTypePointer Uniform %13 
                                              %33 = OpTypePointer Output %13 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                              %35 = OpTypePointer Input %13 
                                 Input f32_4* %36 = OpVariable Input 
                                              %38 = OpTypePointer Private %13 
                               Private f32_4* %39 = OpVariable Private 
                                              %40 = OpTypeVector %6 3 
                                              %41 = OpTypePointer Input %40 
                                 Input f32_3* %42 = OpVariable Input 
                                          i32 %44 = OpConstant 3 
                                          i32 %45 = OpConstant 0 
                                          u32 %50 = OpConstant 0 
                                              %51 = OpTypePointer Private %6 
                                          i32 %54 = OpConstant 1 
                                          u32 %59 = OpConstant 1 
                                          i32 %62 = OpConstant 2 
                                          u32 %67 = OpConstant 2 
                                 Private f32* %69 = OpVariable Private 
                               Private f32_4* %84 = OpVariable Private 
                                 Input f32_4* %85 = OpVariable Input 
                              Private f32_4* %112 = OpVariable Private 
                                         f32 %149 = OpConstant 3.674022E-40 
                                             %154 = OpTypePointer Uniform %6 
                                             %169 = OpTypeBool 
                                             %170 = OpTypePointer Private %169 
                               Private bool* %171 = OpVariable Private 
                                         f32 %174 = OpConstant 3.674022E-40 
                                             %177 = OpTypePointer Function %40 
                                         i32 %191 = OpConstant 4 
                                         u32 %218 = OpConstant 3 
                                         f32 %229 = OpConstant 3.674022E-40 
                                Private f32* %232 = OpVariable Private 
                                             %243 = OpTypeArray %6 %59 
                                             %244 = OpTypeStruct %13 %6 %243 
                                             %245 = OpTypePointer Output %244 
        Output struct {f32_4; f32; f32[1];}* %246 = OpVariable Output 
                                             %265 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %178 = OpVariable Function 
                                        f32_2 %12 = OpLoad %11 
                               Uniform f32_4* %25 = OpAccessChain %21 %23 
                                        f32_4 %26 = OpLoad %25 
                                        f32_2 %27 = OpVectorShuffle %26 %26 0 1 
                                        f32_2 %28 = OpFMul %12 %27 
                               Uniform f32_4* %29 = OpAccessChain %21 %23 
                                        f32_4 %30 = OpLoad %29 
                                        f32_2 %31 = OpVectorShuffle %30 %30 2 3 
                                        f32_2 %32 = OpFAdd %28 %31 
                                                      OpStore vs_TEXCOORD1 %32 
                                        f32_4 %37 = OpLoad %36 
                                                      OpStore vs_TEXCOORD3 %37 
                                        f32_3 %43 = OpLoad %42 
                               Uniform f32_4* %46 = OpAccessChain %21 %44 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                                          f32 %49 = OpDot %43 %48 
                                 Private f32* %52 = OpAccessChain %39 %50 
                                                      OpStore %52 %49 
                                        f32_3 %53 = OpLoad %42 
                               Uniform f32_4* %55 = OpAccessChain %21 %44 %54 
                                        f32_4 %56 = OpLoad %55 
                                        f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                                          f32 %58 = OpDot %53 %57 
                                 Private f32* %60 = OpAccessChain %39 %59 
                                                      OpStore %60 %58 
                                        f32_3 %61 = OpLoad %42 
                               Uniform f32_4* %63 = OpAccessChain %21 %44 %62 
                                        f32_4 %64 = OpLoad %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                          f32 %66 = OpDot %61 %65 
                                 Private f32* %68 = OpAccessChain %39 %67 
                                                      OpStore %68 %66 
                                        f32_4 %70 = OpLoad %39 
                                        f32_3 %71 = OpVectorShuffle %70 %70 0 1 2 
                                        f32_4 %72 = OpLoad %39 
                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
                                          f32 %74 = OpDot %71 %73 
                                                      OpStore %69 %74 
                                          f32 %75 = OpLoad %69 
                                          f32 %76 = OpExtInst %1 32 %75 
                                                      OpStore %69 %76 
                                          f32 %77 = OpLoad %69 
                                        f32_3 %78 = OpCompositeConstruct %77 %77 %77 
                                        f32_4 %79 = OpLoad %39 
                                        f32_3 %80 = OpVectorShuffle %79 %79 0 1 2 
                                        f32_3 %81 = OpFMul %78 %80 
                                        f32_4 %82 = OpLoad %39 
                                        f32_4 %83 = OpVectorShuffle %82 %81 4 5 6 3 
                                                      OpStore %39 %83 
                                        f32_4 %86 = OpLoad %85 
                                        f32_4 %87 = OpVectorShuffle %86 %86 1 1 1 1 
                               Uniform f32_4* %88 = OpAccessChain %21 %62 %54 
                                        f32_4 %89 = OpLoad %88 
                                        f32_4 %90 = OpFMul %87 %89 
                                                      OpStore %84 %90 
                               Uniform f32_4* %91 = OpAccessChain %21 %62 %45 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpLoad %85 
                                        f32_4 %94 = OpVectorShuffle %93 %93 0 0 0 0 
                                        f32_4 %95 = OpFMul %92 %94 
                                        f32_4 %96 = OpLoad %84 
                                        f32_4 %97 = OpFAdd %95 %96 
                                                      OpStore %84 %97 
                               Uniform f32_4* %98 = OpAccessChain %21 %62 %62 
                                        f32_4 %99 = OpLoad %98 
                                       f32_4 %100 = OpLoad %85 
                                       f32_4 %101 = OpVectorShuffle %100 %100 2 2 2 2 
                                       f32_4 %102 = OpFMul %99 %101 
                                       f32_4 %103 = OpLoad %84 
                                       f32_4 %104 = OpFAdd %102 %103 
                                                      OpStore %84 %104 
                              Uniform f32_4* %105 = OpAccessChain %21 %62 %44 
                                       f32_4 %106 = OpLoad %105 
                                       f32_4 %107 = OpLoad %85 
                                       f32_4 %108 = OpVectorShuffle %107 %107 3 3 3 3 
                                       f32_4 %109 = OpFMul %106 %108 
                                       f32_4 %110 = OpLoad %84 
                                       f32_4 %111 = OpFAdd %109 %110 
                                                      OpStore %84 %111 
                                       f32_4 %113 = OpLoad %84 
                                       f32_3 %114 = OpVectorShuffle %113 %113 0 1 2 
                                       f32_3 %115 = OpFNegate %114 
                              Uniform f32_4* %116 = OpAccessChain %21 %45 
                                       f32_4 %117 = OpLoad %116 
                                       f32_3 %118 = OpVectorShuffle %117 %117 3 3 3 
                                       f32_3 %119 = OpFMul %115 %118 
                              Uniform f32_4* %120 = OpAccessChain %21 %45 
                                       f32_4 %121 = OpLoad %120 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_3 %123 = OpFAdd %119 %122 
                                       f32_4 %124 = OpLoad %112 
                                       f32_4 %125 = OpVectorShuffle %124 %123 4 5 6 3 
                                                      OpStore %112 %125 
                                       f32_4 %126 = OpLoad %112 
                                       f32_3 %127 = OpVectorShuffle %126 %126 0 1 2 
                                       f32_4 %128 = OpLoad %112 
                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
                                         f32 %130 = OpDot %127 %129 
                                                      OpStore %69 %130 
                                         f32 %131 = OpLoad %69 
                                         f32 %132 = OpExtInst %1 32 %131 
                                                      OpStore %69 %132 
                                         f32 %133 = OpLoad %69 
                                       f32_3 %134 = OpCompositeConstruct %133 %133 %133 
                                       f32_4 %135 = OpLoad %112 
                                       f32_3 %136 = OpVectorShuffle %135 %135 0 1 2 
                                       f32_3 %137 = OpFMul %134 %136 
                                       f32_4 %138 = OpLoad %112 
                                       f32_4 %139 = OpVectorShuffle %138 %137 4 5 6 3 
                                                      OpStore %112 %139 
                                       f32_4 %140 = OpLoad %39 
                                       f32_3 %141 = OpVectorShuffle %140 %140 0 1 2 
                                       f32_4 %142 = OpLoad %112 
                                       f32_3 %143 = OpVectorShuffle %142 %142 0 1 2 
                                         f32 %144 = OpDot %141 %143 
                                                      OpStore %69 %144 
                                         f32 %145 = OpLoad %69 
                                         f32 %146 = OpFNegate %145 
                                         f32 %147 = OpLoad %69 
                                         f32 %148 = OpFMul %146 %147 
                                         f32 %150 = OpFAdd %148 %149 
                                                      OpStore %69 %150 
                                         f32 %151 = OpLoad %69 
                                         f32 %152 = OpExtInst %1 31 %151 
                                                      OpStore %69 %152 
                                         f32 %153 = OpLoad %69 
                                Uniform f32* %155 = OpAccessChain %21 %54 %67 
                                         f32 %156 = OpLoad %155 
                                         f32 %157 = OpFMul %153 %156 
                                                      OpStore %69 %157 
                                       f32_4 %158 = OpLoad %39 
                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
                                       f32_3 %160 = OpFNegate %159 
                                         f32 %161 = OpLoad %69 
                                       f32_3 %162 = OpCompositeConstruct %161 %161 %161 
                                       f32_3 %163 = OpFMul %160 %162 
                                       f32_4 %164 = OpLoad %84 
                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
                                       f32_3 %166 = OpFAdd %163 %165 
                                       f32_4 %167 = OpLoad %39 
                                       f32_4 %168 = OpVectorShuffle %167 %166 4 5 6 3 
                                                      OpStore %39 %168 
                                Uniform f32* %172 = OpAccessChain %21 %54 %67 
                                         f32 %173 = OpLoad %172 
                                        bool %175 = OpFOrdNotEqual %173 %174 
                                                      OpStore %171 %175 
                                        bool %176 = OpLoad %171 
                                                      OpSelectionMerge %180 None 
                                                      OpBranchConditional %176 %179 %183 
                                             %179 = OpLabel 
                                       f32_4 %181 = OpLoad %39 
                                       f32_3 %182 = OpVectorShuffle %181 %181 0 1 2 
                                                      OpStore %178 %182 
                                                      OpBranch %180 
                                             %183 = OpLabel 
                                       f32_4 %184 = OpLoad %84 
                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
                                                      OpStore %178 %185 
                                                      OpBranch %180 
                                             %180 = OpLabel 
                                       f32_3 %186 = OpLoad %178 
                                       f32_4 %187 = OpLoad %39 
                                       f32_4 %188 = OpVectorShuffle %187 %186 4 5 6 3 
                                                      OpStore %39 %188 
                                       f32_4 %189 = OpLoad %39 
                                       f32_4 %190 = OpVectorShuffle %189 %189 1 1 1 1 
                              Uniform f32_4* %192 = OpAccessChain %21 %191 %54 
                                       f32_4 %193 = OpLoad %192 
                                       f32_4 %194 = OpFMul %190 %193 
                                                      OpStore %112 %194 
                              Uniform f32_4* %195 = OpAccessChain %21 %191 %45 
                                       f32_4 %196 = OpLoad %195 
                                       f32_4 %197 = OpLoad %39 
                                       f32_4 %198 = OpVectorShuffle %197 %197 0 0 0 0 
                                       f32_4 %199 = OpFMul %196 %198 
                                       f32_4 %200 = OpLoad %112 
                                       f32_4 %201 = OpFAdd %199 %200 
                                                      OpStore %112 %201 
                              Uniform f32_4* %202 = OpAccessChain %21 %191 %62 
                                       f32_4 %203 = OpLoad %202 
                                       f32_4 %204 = OpLoad %39 
                                       f32_4 %205 = OpVectorShuffle %204 %204 2 2 2 2 
                                       f32_4 %206 = OpFMul %203 %205 
                                       f32_4 %207 = OpLoad %112 
                                       f32_4 %208 = OpFAdd %206 %207 
                                                      OpStore %39 %208 
                              Uniform f32_4* %209 = OpAccessChain %21 %191 %44 
                                       f32_4 %210 = OpLoad %209 
                                       f32_4 %211 = OpLoad %84 
                                       f32_4 %212 = OpVectorShuffle %211 %211 3 3 3 3 
                                       f32_4 %213 = OpFMul %210 %212 
                                       f32_4 %214 = OpLoad %39 
                                       f32_4 %215 = OpFAdd %213 %214 
                                                      OpStore %39 %215 
                                Uniform f32* %216 = OpAccessChain %21 %54 %50 
                                         f32 %217 = OpLoad %216 
                                Private f32* %219 = OpAccessChain %39 %218 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpFDiv %217 %220 
                                Private f32* %222 = OpAccessChain %84 %50 
                                                      OpStore %222 %221 
                                Private f32* %223 = OpAccessChain %84 %50 
                                         f32 %224 = OpLoad %223 
                                         f32 %225 = OpExtInst %1 37 %224 %174 
                                Private f32* %226 = OpAccessChain %84 %50 
                                                      OpStore %226 %225 
                                Private f32* %227 = OpAccessChain %84 %50 
                                         f32 %228 = OpLoad %227 
                                         f32 %230 = OpExtInst %1 40 %228 %229 
                                Private f32* %231 = OpAccessChain %84 %50 
                                                      OpStore %231 %230 
                                Private f32* %233 = OpAccessChain %39 %67 
                                         f32 %234 = OpLoad %233 
                                Private f32* %235 = OpAccessChain %84 %50 
                                         f32 %236 = OpLoad %235 
                                         f32 %237 = OpFAdd %234 %236 
                                                      OpStore %232 %237 
                                Private f32* %238 = OpAccessChain %39 %218 
                                         f32 %239 = OpLoad %238 
                                         f32 %240 = OpLoad %232 
                                         f32 %241 = OpExtInst %1 37 %239 %240 
                                Private f32* %242 = OpAccessChain %84 %50 
                                                      OpStore %242 %241 
                                       f32_4 %247 = OpLoad %39 
                                       f32_3 %248 = OpVectorShuffle %247 %247 0 1 3 
                               Output f32_4* %249 = OpAccessChain %246 %45 
                                       f32_4 %250 = OpLoad %249 
                                       f32_4 %251 = OpVectorShuffle %250 %248 4 5 2 6 
                                                      OpStore %249 %251 
                                         f32 %252 = OpLoad %232 
                                         f32 %253 = OpFNegate %252 
                                Private f32* %254 = OpAccessChain %84 %50 
                                         f32 %255 = OpLoad %254 
                                         f32 %256 = OpFAdd %253 %255 
                                Private f32* %257 = OpAccessChain %39 %50 
                                                      OpStore %257 %256 
                                Uniform f32* %258 = OpAccessChain %21 %54 %59 
                                         f32 %259 = OpLoad %258 
                                Private f32* %260 = OpAccessChain %39 %50 
                                         f32 %261 = OpLoad %260 
                                         f32 %262 = OpFMul %259 %261 
                                         f32 %263 = OpLoad %232 
                                         f32 %264 = OpFAdd %262 %263 
                                 Output f32* %266 = OpAccessChain %246 %45 %67 
                                                      OpStore %266 %264 
                                 Output f32* %267 = OpAccessChain %246 %45 %59 
                                         f32 %268 = OpLoad %267 
                                         f32 %269 = OpFNegate %268 
                                 Output f32* %270 = OpAccessChain %246 %45 %59 
                                                      OpStore %270 %269 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 59
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %21 %31 %56 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                             OpDecorate %8 RelaxedPrecision 
                                             OpDecorate %11 RelaxedPrecision 
                                             OpDecorate %11 DescriptorSet 11 
                                             OpDecorate %11 Binding 11 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %15 RelaxedPrecision 
                                             OpDecorate %15 DescriptorSet 15 
                                             OpDecorate %15 Binding 15 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 21 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 Location 31 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %41 RelaxedPrecision 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %56 Location 56 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypePointer Private %6 
                         Private f32* %8 = OpVariable Private 
                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %10 = OpTypePointer UniformConstant %9 
UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
                                     %13 = OpTypeSampler 
                                     %14 = OpTypePointer UniformConstant %13 
            UniformConstant sampler* %15 = OpVariable UniformConstant 
                                     %17 = OpTypeSampledImage %9 
                                     %19 = OpTypeVector %6 2 
                                     %20 = OpTypePointer Input %19 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %23 = OpTypeVector %6 4 
                                     %25 = OpTypeInt 32 0 
                                 u32 %26 = OpConstant 3 
                        Private f32* %28 = OpVariable Private 
                                     %30 = OpTypePointer Input %23 
               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
                                     %32 = OpTypePointer Input %6 
                                 f32 %36 = OpConstant 3.674022E-40 
                                     %38 = OpTypeBool 
                                     %39 = OpTypePointer Private %38 
                       Private bool* %40 = OpVariable Private 
                                 f32 %42 = OpConstant 3.674022E-40 
                                     %45 = OpTypeInt 32 1 
                                 i32 %46 = OpConstant 0 
                                 i32 %47 = OpConstant 1 
                                 i32 %49 = OpConstant -1 
                                     %55 = OpTypePointer Output %23 
                       Output f32_4* %56 = OpVariable Output 
                               f32_4 %57 = OpConstantComposite %42 %42 %42 %42 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %12 = OpLoad %11 
                             sampler %16 = OpLoad %15 
          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
                               f32_2 %22 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
                                 f32 %27 = OpCompositeExtract %24 3 
                                             OpStore %8 %27 
                                 f32 %29 = OpLoad %8 
                          Input f32* %33 = OpAccessChain vs_TEXCOORD3 %26 
                                 f32 %34 = OpLoad %33 
                                 f32 %35 = OpFMul %29 %34 
                                 f32 %37 = OpFAdd %35 %36 
                                             OpStore %28 %37 
                                 f32 %41 = OpLoad %28 
                                bool %43 = OpFOrdLessThan %41 %42 
                                             OpStore %40 %43 
                                bool %44 = OpLoad %40 
                                 i32 %48 = OpSelect %44 %47 %46 
                                 i32 %50 = OpIMul %48 %49 
                                bool %51 = OpINotEqual %50 %46 
                                             OpSelectionMerge %53 None 
                                             OpBranchConditional %51 %52 %53 
                                     %52 = OpLabel 
                                             OpKill
                                     %53 = OpLabel 
                                             OpStore %56 %57 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 417
; Schema: 0
                                                   OpCapability Shader 
                                            %1 = OpExtInstImport "GLSL.std.450" 
                                                   OpMemoryModel Logical GLSL450 
                                                   OpEntryPoint Vertex %4 "main" %10 %180 %236 %390 
                                                   OpDecorate %10 BuiltIn ViewportIndex 
                                                   OpMemberDecorate %12 0 Offset 12 
                                                   OpMemberDecorate %12 1 Offset 12 
                                                   OpDecorate %12 Block 
                                                   OpDecorate %14 DescriptorSet 14 
                                                   OpDecorate %14 Binding 14 
                                                   OpDecorate %26 ArrayStride 26 
                                                   OpMemberDecorate %27 0 Offset 27 
                                                   OpDecorate %28 ArrayStride 28 
                                                   OpMemberDecorate %29 0 NonWritable 
                                                   OpMemberDecorate %29 0 Offset 29 
                                                   OpDecorate %29 BufferBlock 
                                                   OpDecorate %31 DescriptorSet 31 
                                                   OpDecorate %31 Binding 31 
                                                   OpDecorate %180 Location 180 
                                                   OpDecorate %236 Location 236 
                                                   OpDecorate %258 ArrayStride 258 
                                                   OpMemberDecorate %259 0 Offset 259 
                                                   OpMemberDecorate %259 1 Offset 259 
                                                   OpMemberDecorate %259 2 Offset 259 
                                                   OpDecorate %259 Block 
                                                   OpDecorate %261 DescriptorSet 261 
                                                   OpDecorate %261 Binding 261 
                                                   OpMemberDecorate %388 0 BuiltIn 388 
                                                   OpMemberDecorate %388 1 BuiltIn 388 
                                                   OpMemberDecorate %388 2 BuiltIn 388 
                                                   OpDecorate %388 Block 
                                            %2 = OpTypeVoid 
                                            %3 = OpTypeFunction %2 
                                            %6 = OpTypeInt 32 1 
                                            %7 = OpTypePointer Private %6 
                               Private i32* %8 = OpVariable Private 
                                            %9 = OpTypePointer Input %6 
                                Input i32* %10 = OpVariable Input 
                                           %12 = OpTypeStruct %6 %6 
                                           %13 = OpTypePointer Uniform %12 
               Uniform struct {i32; i32;}* %14 = OpVariable Uniform 
                                       i32 %15 = OpConstant 0 
                                           %16 = OpTypePointer Uniform %6 
                                           %20 = OpTypeFloat 32 
                                           %21 = OpTypeVector %20 4 
                                           %22 = OpTypePointer Private %21 
                            Private f32_4* %23 = OpVariable Private 
                                           %24 = OpTypeInt 32 0 
                                       u32 %25 = OpConstant 14 
                                           %26 = OpTypeArray %24 %25 
                                           %27 = OpTypeStruct %26 
                                           %28 = OpTypeRuntimeArray %27 
                                           %29 = OpTypeStruct %28 
                                           %30 = OpTypePointer Uniform %29 
                       Uniform struct {;}* %31 = OpVariable Uniform 
                                       i32 %33 = OpConstant 7 
                                           %34 = OpTypePointer Uniform %24 
                                       i32 %39 = OpConstant 8 
                                       i32 %44 = OpConstant 6 
                                           %48 = OpTypeVector %20 3 
                            Private f32_4* %52 = OpVariable Private 
                                       u32 %53 = OpConstant 1 
                                           %54 = OpTypePointer Private %20 
                                       u32 %57 = OpConstant 2 
                            Private f32_4* %59 = OpVariable Private 
                                       i32 %61 = OpConstant 1 
                                       i32 %70 = OpConstant 2 
                                       u32 %79 = OpConstant 0 
                                           %81 = OpTypePointer Private %48 
                            Private f32_3* %82 = OpVariable Private 
                                       i32 %84 = OpConstant 3 
                                       i32 %89 = OpConstant 4 
                                       i32 %94 = OpConstant 5 
                            Private f32_3* %99 = OpVariable Private 
                                      i32 %101 = OpConstant 9 
                                      i32 %106 = OpConstant 10 
                                      i32 %111 = OpConstant 11 
                           Private f32_4* %131 = OpVariable Private 
                           Private f32_3* %150 = OpVariable Private 
                             Private f32* %164 = OpVariable Private 
                                      f32 %169 = OpConstant 3.674022E-40 
                                          %179 = OpTypePointer Input %48 
                             Input f32_3* %180 = OpVariable Input 
                           Private f32_3* %186 = OpVariable Private 
                                      u32 %232 = OpConstant 3 
                                          %235 = OpTypePointer Input %21 
                             Input f32_4* %236 = OpVariable Input 
                                      u32 %257 = OpConstant 4 
                                          %258 = OpTypeArray %21 %257 
                                          %259 = OpTypeStruct %21 %21 %258 
                                          %260 = OpTypePointer Uniform %259 
Uniform struct {f32_4; f32_4; f32_4[4];}* %261 = OpVariable Uniform 
                                          %262 = OpTypePointer Uniform %21 
                                          %300 = OpTypePointer Uniform %20 
                                          %315 = OpTypeBool 
                                          %316 = OpTypePointer Private %315 
                            Private bool* %317 = OpVariable Private 
                                      f32 %320 = OpConstant 3.674022E-40 
                                          %323 = OpTypePointer Function %48 
                                      f32 %373 = OpConstant 3.674022E-40 
                             Private f32* %376 = OpVariable Private 
                                          %387 = OpTypeArray %20 %53 
                                          %388 = OpTypeStruct %21 %20 %387 
                                          %389 = OpTypePointer Output %388 
     Output struct {f32_4; f32; f32[1];}* %390 = OpVariable Output 
                                          %393 = OpTypePointer Output %21 
                                          %410 = OpTypePointer Output %20 
                                       void %4 = OpFunction None %3 
                                            %5 = OpLabel 
                          Function f32_3* %324 = OpVariable Function 
                                       i32 %11 = OpLoad %10 
                              Uniform i32* %17 = OpAccessChain %14 %15 
                                       i32 %18 = OpLoad %17 
                                       i32 %19 = OpIAdd %11 %18 
                                                   OpStore %8 %19 
                                       i32 %32 = OpLoad %8 
                              Uniform u32* %35 = OpAccessChain %31 %15 %32 %15 %33 
                                       u32 %36 = OpLoad %35 
                                       f32 %37 = OpBitcast %36 
                                       i32 %38 = OpLoad %8 
                              Uniform u32* %40 = OpAccessChain %31 %15 %38 %15 %39 
                                       u32 %41 = OpLoad %40 
                                       f32 %42 = OpBitcast %41 
                                       i32 %43 = OpLoad %8 
                              Uniform u32* %45 = OpAccessChain %31 %15 %43 %15 %44 
                                       u32 %46 = OpLoad %45 
                                       f32 %47 = OpBitcast %46 
                                     f32_3 %49 = OpCompositeConstruct %37 %42 %47 
                                     f32_4 %50 = OpLoad %23 
                                     f32_4 %51 = OpVectorShuffle %50 %49 4 5 6 3 
                                                   OpStore %23 %51 
                              Private f32* %55 = OpAccessChain %23 %53 
                                       f32 %56 = OpLoad %55 
                              Private f32* %58 = OpAccessChain %52 %57 
                                                   OpStore %58 %56 
                                       i32 %60 = OpLoad %8 
                              Uniform u32* %62 = OpAccessChain %31 %15 %60 %15 %61 
                                       u32 %63 = OpLoad %62 
                                       f32 %64 = OpBitcast %63 
                                       i32 %65 = OpLoad %8 
                              Uniform u32* %66 = OpAccessChain %31 %15 %65 %15 %15 
                                       u32 %67 = OpLoad %66 
                                       f32 %68 = OpBitcast %67 
                                       i32 %69 = OpLoad %8 
                              Uniform u32* %71 = OpAccessChain %31 %15 %69 %15 %70 
                                       u32 %72 = OpLoad %71 
                                       f32 %73 = OpBitcast %72 
                                     f32_3 %74 = OpCompositeConstruct %64 %68 %73 
                                     f32_4 %75 = OpLoad %59 
                                     f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
                                                   OpStore %59 %76 
                              Private f32* %77 = OpAccessChain %59 %57 
                                       f32 %78 = OpLoad %77 
                              Private f32* %80 = OpAccessChain %52 %79 
                                                   OpStore %80 %78 
                                       i32 %83 = OpLoad %8 
                              Uniform u32* %85 = OpAccessChain %31 %15 %83 %15 %84 
                                       u32 %86 = OpLoad %85 
                                       f32 %87 = OpBitcast %86 
                                       i32 %88 = OpLoad %8 
                              Uniform u32* %90 = OpAccessChain %31 %15 %88 %15 %89 
                                       u32 %91 = OpLoad %90 
                                       f32 %92 = OpBitcast %91 
                                       i32 %93 = OpLoad %8 
                              Uniform u32* %95 = OpAccessChain %31 %15 %93 %15 %94 
                                       u32 %96 = OpLoad %95 
                                       f32 %97 = OpBitcast %96 
                                     f32_3 %98 = OpCompositeConstruct %87 %92 %97 
                                                   OpStore %82 %98 
                                      i32 %100 = OpLoad %8 
                             Uniform u32* %102 = OpAccessChain %31 %15 %100 %15 %101 
                                      u32 %103 = OpLoad %102 
                                      f32 %104 = OpBitcast %103 
                                      i32 %105 = OpLoad %8 
                             Uniform u32* %107 = OpAccessChain %31 %15 %105 %15 %106 
                                      u32 %108 = OpLoad %107 
                                      f32 %109 = OpBitcast %108 
                                      i32 %110 = OpLoad %8 
                             Uniform u32* %112 = OpAccessChain %31 %15 %110 %15 %111 
                                      u32 %113 = OpLoad %112 
                                      f32 %114 = OpBitcast %113 
                                    f32_3 %115 = OpCompositeConstruct %104 %109 %114 
                                                   OpStore %99 %115 
                             Private f32* %116 = OpAccessChain %82 %57 
                                      f32 %117 = OpLoad %116 
                             Private f32* %118 = OpAccessChain %52 %53 
                                                   OpStore %118 %117 
                             Private f32* %119 = OpAccessChain %23 %79 
                                      f32 %120 = OpLoad %119 
                             Private f32* %121 = OpAccessChain %59 %57 
                                                   OpStore %121 %120 
                             Private f32* %122 = OpAccessChain %59 %53 
                                      f32 %123 = OpLoad %122 
                             Private f32* %124 = OpAccessChain %23 %79 
                                                   OpStore %124 %123 
                             Private f32* %125 = OpAccessChain %82 %79 
                                      f32 %126 = OpLoad %125 
                             Private f32* %127 = OpAccessChain %23 %53 
                                                   OpStore %127 %126 
                             Private f32* %128 = OpAccessChain %82 %53 
                                      f32 %129 = OpLoad %128 
                             Private f32* %130 = OpAccessChain %59 %53 
                                                   OpStore %130 %129 
                                    f32_4 %132 = OpLoad %52 
                                    f32_3 %133 = OpVectorShuffle %132 %132 2 0 1 
                                    f32_4 %134 = OpLoad %23 
                                    f32_3 %135 = OpVectorShuffle %134 %134 1 2 0 
                                    f32_3 %136 = OpFMul %133 %135 
                                    f32_4 %137 = OpLoad %131 
                                    f32_4 %138 = OpVectorShuffle %137 %136 4 5 6 3 
                                                   OpStore %131 %138 
                                    f32_4 %139 = OpLoad %23 
                                    f32_3 %140 = OpVectorShuffle %139 %139 2 0 1 
                                    f32_4 %141 = OpLoad %52 
                                    f32_3 %142 = OpVectorShuffle %141 %141 1 2 0 
                                    f32_3 %143 = OpFMul %140 %142 
                                    f32_4 %144 = OpLoad %131 
                                    f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
                                    f32_3 %146 = OpFNegate %145 
                                    f32_3 %147 = OpFAdd %143 %146 
                                    f32_4 %148 = OpLoad %131 
                                    f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                   OpStore %131 %149 
                                    f32_4 %151 = OpLoad %52 
                                    f32_3 %152 = OpVectorShuffle %151 %151 1 2 0 
                                    f32_4 %153 = OpLoad %59 
                                    f32_3 %154 = OpVectorShuffle %153 %153 2 0 1 
                                    f32_3 %155 = OpFMul %152 %154 
                                                   OpStore %150 %155 
                                    f32_4 %156 = OpLoad %59 
                                    f32_3 %157 = OpVectorShuffle %156 %156 1 2 0 
                                    f32_4 %158 = OpLoad %52 
                                    f32_3 %159 = OpVectorShuffle %158 %158 2 0 1 
                                    f32_3 %160 = OpFMul %157 %159 
                                    f32_3 %161 = OpLoad %150 
                                    f32_3 %162 = OpFNegate %161 
                                    f32_3 %163 = OpFAdd %160 %162 
                                                   OpStore %150 %163 
                                    f32_4 %165 = OpLoad %23 
                                    f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                    f32_3 %167 = OpLoad %150 
                                      f32 %168 = OpDot %166 %167 
                                                   OpStore %164 %168 
                                      f32 %170 = OpLoad %164 
                                      f32 %171 = OpFDiv %169 %170 
                                                   OpStore %164 %171 
                                      f32 %172 = OpLoad %164 
                                    f32_3 %173 = OpCompositeConstruct %172 %172 %172 
                                    f32_4 %174 = OpLoad %131 
                                    f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
                                    f32_3 %176 = OpFMul %173 %175 
                                    f32_4 %177 = OpLoad %131 
                                    f32_4 %178 = OpVectorShuffle %177 %176 4 5 6 3 
                                                   OpStore %131 %178 
                                    f32_3 %181 = OpLoad %180 
                                    f32_4 %182 = OpLoad %131 
                                    f32_3 %183 = OpVectorShuffle %182 %182 0 1 2 
                                      f32 %184 = OpDot %181 %183 
                             Private f32* %185 = OpAccessChain %131 %53 
                                                   OpStore %185 %184 
                                    f32_4 %187 = OpLoad %23 
                                    f32_3 %188 = OpVectorShuffle %187 %187 2 0 1 
                                    f32_4 %189 = OpLoad %59 
                                    f32_3 %190 = OpVectorShuffle %189 %189 1 2 0 
                                    f32_3 %191 = OpFMul %188 %190 
                                                   OpStore %186 %191 
                                    f32_4 %192 = OpLoad %23 
                                    f32_3 %193 = OpVectorShuffle %192 %192 1 2 0 
                                    f32_4 %194 = OpLoad %59 
                                    f32_3 %195 = OpVectorShuffle %194 %194 2 0 1 
                                    f32_3 %196 = OpFMul %193 %195 
                                    f32_3 %197 = OpLoad %186 
                                    f32_3 %198 = OpFNegate %197 
                                    f32_3 %199 = OpFAdd %196 %198 
                                                   OpStore %186 %199 
                                      f32 %200 = OpLoad %164 
                                    f32_3 %201 = OpCompositeConstruct %200 %200 %200 
                                    f32_3 %202 = OpLoad %186 
                                    f32_3 %203 = OpFMul %201 %202 
                                                   OpStore %186 %203 
                                      f32 %204 = OpLoad %164 
                                    f32_3 %205 = OpCompositeConstruct %204 %204 %204 
                                    f32_3 %206 = OpLoad %150 
                                    f32_3 %207 = OpFMul %205 %206 
                                                   OpStore %150 %207 
                                    f32_3 %208 = OpLoad %180 
                                    f32_3 %209 = OpLoad %150 
                                      f32 %210 = OpDot %208 %209 
                             Private f32* %211 = OpAccessChain %131 %79 
                                                   OpStore %211 %210 
                                    f32_3 %212 = OpLoad %180 
                                    f32_3 %213 = OpLoad %186 
                                      f32 %214 = OpDot %212 %213 
                             Private f32* %215 = OpAccessChain %131 %57 
                                                   OpStore %215 %214 
                                    f32_4 %216 = OpLoad %131 
                                    f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
                                    f32_4 %218 = OpLoad %131 
                                    f32_3 %219 = OpVectorShuffle %218 %218 0 1 2 
                                      f32 %220 = OpDot %217 %219 
                                                   OpStore %164 %220 
                                      f32 %221 = OpLoad %164 
                                      f32 %222 = OpExtInst %1 32 %221 
                                                   OpStore %164 %222 
                                      f32 %223 = OpLoad %164 
                                    f32_3 %224 = OpCompositeConstruct %223 %223 %223 
                                    f32_4 %225 = OpLoad %131 
                                    f32_3 %226 = OpVectorShuffle %225 %225 0 1 2 
                                    f32_3 %227 = OpFMul %224 %226 
                                    f32_4 %228 = OpLoad %131 
                                    f32_4 %229 = OpVectorShuffle %228 %227 4 5 6 3 
                                                   OpStore %131 %229 
                             Private f32* %230 = OpAccessChain %99 %79 
                                      f32 %231 = OpLoad %230 
                             Private f32* %233 = OpAccessChain %23 %232 
                                                   OpStore %233 %231 
                                    f32_4 %234 = OpLoad %23 
                                    f32_4 %237 = OpLoad %236 
                                      f32 %238 = OpDot %234 %237 
                             Private f32* %239 = OpAccessChain %23 %79 
                                                   OpStore %239 %238 
                             Private f32* %240 = OpAccessChain %99 %53 
                                      f32 %241 = OpLoad %240 
                             Private f32* %242 = OpAccessChain %59 %232 
                                                   OpStore %242 %241 
                             Private f32* %243 = OpAccessChain %99 %57 
                                      f32 %244 = OpLoad %243 
                             Private f32* %245 = OpAccessChain %52 %232 
                                                   OpStore %245 %244 
                                    f32_4 %246 = OpLoad %52 
                                    f32_4 %247 = OpLoad %236 
                                      f32 %248 = OpDot %246 %247 
                             Private f32* %249 = OpAccessChain %23 %57 
                                                   OpStore %249 %248 
                                    f32_4 %250 = OpLoad %59 
                                    f32_4 %251 = OpLoad %236 
                                      f32 %252 = OpDot %250 %251 
                             Private f32* %253 = OpAccessChain %23 %53 
                                                   OpStore %253 %252 
                                    f32_4 %254 = OpLoad %23 
                                    f32_3 %255 = OpVectorShuffle %254 %254 0 1 2 
                                    f32_3 %256 = OpFNegate %255 
                           Uniform f32_4* %263 = OpAccessChain %261 %15 
                                    f32_4 %264 = OpLoad %263 
                                    f32_3 %265 = OpVectorShuffle %264 %264 3 3 3 
                                    f32_3 %266 = OpFMul %256 %265 
                           Uniform f32_4* %267 = OpAccessChain %261 %15 
                                    f32_4 %268 = OpLoad %267 
                                    f32_3 %269 = OpVectorShuffle %268 %268 0 1 2 
                                    f32_3 %270 = OpFAdd %266 %269 
                                    f32_4 %271 = OpLoad %52 
                                    f32_4 %272 = OpVectorShuffle %271 %270 4 5 6 3 
                                                   OpStore %52 %272 
                                    f32_4 %273 = OpLoad %52 
                                    f32_3 %274 = OpVectorShuffle %273 %273 0 1 2 
                                    f32_4 %275 = OpLoad %52 
                                    f32_3 %276 = OpVectorShuffle %275 %275 0 1 2 
                                      f32 %277 = OpDot %274 %276 
                                                   OpStore %164 %277 
                                      f32 %278 = OpLoad %164 
                                      f32 %279 = OpExtInst %1 32 %278 
                                                   OpStore %164 %279 
                                      f32 %280 = OpLoad %164 
                                    f32_3 %281 = OpCompositeConstruct %280 %280 %280 
                                    f32_4 %282 = OpLoad %52 
                                    f32_3 %283 = OpVectorShuffle %282 %282 0 1 2 
                                    f32_3 %284 = OpFMul %281 %283 
                                    f32_4 %285 = OpLoad %52 
                                    f32_4 %286 = OpVectorShuffle %285 %284 4 5 6 3 
                                                   OpStore %52 %286 
                                    f32_4 %287 = OpLoad %131 
                                    f32_3 %288 = OpVectorShuffle %287 %287 0 1 2 
                                    f32_4 %289 = OpLoad %52 
                                    f32_3 %290 = OpVectorShuffle %289 %289 0 1 2 
                                      f32 %291 = OpDot %288 %290 
                                                   OpStore %164 %291 
                                      f32 %292 = OpLoad %164 
                                      f32 %293 = OpFNegate %292 
                                      f32 %294 = OpLoad %164 
                                      f32 %295 = OpFMul %293 %294 
                                      f32 %296 = OpFAdd %295 %169 
                                                   OpStore %164 %296 
                                      f32 %297 = OpLoad %164 
                                      f32 %298 = OpExtInst %1 31 %297 
                                                   OpStore %164 %298 
                                      f32 %299 = OpLoad %164 
                             Uniform f32* %301 = OpAccessChain %261 %61 %57 
                                      f32 %302 = OpLoad %301 
                                      f32 %303 = OpFMul %299 %302 
                                                   OpStore %164 %303 
                                    f32_4 %304 = OpLoad %131 
                                    f32_3 %305 = OpVectorShuffle %304 %304 0 1 2 
                                    f32_3 %306 = OpFNegate %305 
                                      f32 %307 = OpLoad %164 
                                    f32_3 %308 = OpCompositeConstruct %307 %307 %307 
                                    f32_3 %309 = OpFMul %306 %308 
                                    f32_4 %310 = OpLoad %23 
                                    f32_3 %311 = OpVectorShuffle %310 %310 0 1 2 
                                    f32_3 %312 = OpFAdd %309 %311 
                                    f32_4 %313 = OpLoad %131 
                                    f32_4 %314 = OpVectorShuffle %313 %312 4 5 6 3 
                                                   OpStore %131 %314 
                             Uniform f32* %318 = OpAccessChain %261 %61 %57 
                                      f32 %319 = OpLoad %318 
                                     bool %321 = OpFOrdNotEqual %319 %320 
                                                   OpStore %317 %321 
                                     bool %322 = OpLoad %317 
                                                   OpSelectionMerge %326 None 
                                                   OpBranchConditional %322 %325 %329 
                                          %325 = OpLabel 
                                    f32_4 %327 = OpLoad %131 
                                    f32_3 %328 = OpVectorShuffle %327 %327 0 1 2 
                                                   OpStore %324 %328 
                                                   OpBranch %326 
                                          %329 = OpLabel 
                                    f32_4 %330 = OpLoad %23 
                                    f32_3 %331 = OpVectorShuffle %330 %330 0 1 2 
                                                   OpStore %324 %331 
                                                   OpBranch %326 
                                          %326 = OpLabel 
                                    f32_3 %332 = OpLoad %324 
                                    f32_4 %333 = OpLoad %131 
                                    f32_4 %334 = OpVectorShuffle %333 %332 4 5 6 3 
                                                   OpStore %131 %334 
                                    f32_4 %335 = OpLoad %131 
                                    f32_4 %336 = OpVectorShuffle %335 %335 1 1 1 1 
                           Uniform f32_4* %337 = OpAccessChain %261 %70 %61 
                                    f32_4 %338 = OpLoad %337 
                                    f32_4 %339 = OpFMul %336 %338 
                                                   OpStore %23 %339 
                           Uniform f32_4* %340 = OpAccessChain %261 %70 %15 
                                    f32_4 %341 = OpLoad %340 
                                    f32_4 %342 = OpLoad %131 
                                    f32_4 %343 = OpVectorShuffle %342 %342 0 0 0 0 
                                    f32_4 %344 = OpFMul %341 %343 
                                    f32_4 %345 = OpLoad %23 
                                    f32_4 %346 = OpFAdd %344 %345 
                                                   OpStore %23 %346 
                           Uniform f32_4* %347 = OpAccessChain %261 %70 %70 
                                    f32_4 %348 = OpLoad %347 
                                    f32_4 %349 = OpLoad %131 
                                    f32_4 %350 = OpVectorShuffle %349 %349 2 2 2 2 
                                    f32_4 %351 = OpFMul %348 %350 
                                    f32_4 %352 = OpLoad %23 
                                    f32_4 %353 = OpFAdd %351 %352 
                                                   OpStore %131 %353 
                           Uniform f32_4* %354 = OpAccessChain %261 %70 %84 
                                    f32_4 %355 = OpLoad %354 
                                    f32_4 %356 = OpLoad %236 
                                    f32_4 %357 = OpVectorShuffle %356 %356 3 3 3 3 
                                    f32_4 %358 = OpFMul %355 %357 
                                    f32_4 %359 = OpLoad %131 
                                    f32_4 %360 = OpFAdd %358 %359 
                                                   OpStore %131 %360 
                             Uniform f32* %361 = OpAccessChain %261 %61 %79 
                                      f32 %362 = OpLoad %361 
                             Private f32* %363 = OpAccessChain %131 %232 
                                      f32 %364 = OpLoad %363 
                                      f32 %365 = OpFDiv %362 %364 
                             Private f32* %366 = OpAccessChain %23 %79 
                                                   OpStore %366 %365 
                             Private f32* %367 = OpAccessChain %23 %79 
                                      f32 %368 = OpLoad %367 
                                      f32 %369 = OpExtInst %1 37 %368 %320 
                             Private f32* %370 = OpAccessChain %23 %79 
                                                   OpStore %370 %369 
                             Private f32* %371 = OpAccessChain %23 %79 
                                      f32 %372 = OpLoad %371 
                                      f32 %374 = OpExtInst %1 40 %372 %373 
                             Private f32* %375 = OpAccessChain %23 %79 
                                                   OpStore %375 %374 
                             Private f32* %377 = OpAccessChain %131 %57 
                                      f32 %378 = OpLoad %377 
                             Private f32* %379 = OpAccessChain %23 %79 
                                      f32 %380 = OpLoad %379 
                                      f32 %381 = OpFAdd %378 %380 
                                                   OpStore %376 %381 
                             Private f32* %382 = OpAccessChain %131 %232 
                                      f32 %383 = OpLoad %382 
                                      f32 %384 = OpLoad %376 
                                      f32 %385 = OpExtInst %1 37 %383 %384 
                             Private f32* %386 = OpAccessChain %23 %79 
                                                   OpStore %386 %385 
                                    f32_4 %391 = OpLoad %131 
                                    f32_3 %392 = OpVectorShuffle %391 %391 0 1 3 
                            Output f32_4* %394 = OpAccessChain %390 %15 
                                    f32_4 %395 = OpLoad %394 
                                    f32_4 %396 = OpVectorShuffle %395 %392 4 5 2 6 
                                                   OpStore %394 %396 
                                      f32 %397 = OpLoad %376 
                                      f32 %398 = OpFNegate %397 
                             Private f32* %399 = OpAccessChain %23 %79 
                                      f32 %400 = OpLoad %399 
                                      f32 %401 = OpFAdd %398 %400 
                             Private f32* %402 = OpAccessChain %131 %79 
                                                   OpStore %402 %401 
                             Uniform f32* %403 = OpAccessChain %261 %61 %53 
                                      f32 %404 = OpLoad %403 
                             Private f32* %405 = OpAccessChain %131 %79 
                                      f32 %406 = OpLoad %405 
                                      f32 %407 = OpFMul %404 %406 
                                      f32 %408 = OpLoad %376 
                                      f32 %409 = OpFAdd %407 %408 
                              Output f32* %411 = OpAccessChain %390 %15 %57 
                                                   OpStore %411 %409 
                              Output f32* %412 = OpAccessChain %390 %15 %53 
                                      f32 %413 = OpLoad %412 
                                      f32 %414 = OpFNegate %413 
                              Output f32* %415 = OpAccessChain %390 %15 %53 
                                                   OpStore %415 %414 
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
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 493
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %10 %102 %134 %147 %149 %288 %342 %472 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %10 BuiltIn ViewportIndex 
                                                      OpMemberDecorate %12 0 Offset 12 
                                                      OpMemberDecorate %12 1 Offset 12 
                                                      OpDecorate %12 Block 
                                                      OpDecorate %14 DescriptorSet 14 
                                                      OpDecorate %14 Binding 14 
                                                      OpDecorate %26 ArrayStride 26 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpDecorate %28 ArrayStride 28 
                                                      OpMemberDecorate %29 0 NonWritable 
                                                      OpMemberDecorate %29 0 Offset 29 
                                                      OpDecorate %29 BufferBlock 
                                                      OpDecorate %31 DescriptorSet 31 
                                                      OpDecorate %31 Binding 31 
                                                      OpDecorate %50 ArrayStride 50 
                                                      OpMemberDecorate %51 0 Offset 51 
                                                      OpMemberDecorate %51 1 Offset 51 
                                                      OpMemberDecorate %51 2 Offset 51 
                                                      OpMemberDecorate %51 3 Offset 51 
                                                      OpMemberDecorate %51 4 Offset 51 
                                                      OpDecorate %51 Block 
                                                      OpDecorate %53 DescriptorSet 53 
                                                      OpDecorate %53 Binding 53 
                                                      OpDecorate %102 Location 102 
                                                      OpDecorate vs_TEXCOORD1 Location 134 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 147 
                                                      OpDecorate %149 RelaxedPrecision 
                                                      OpDecorate %149 Location 149 
                                                      OpDecorate %150 RelaxedPrecision 
                                                      OpDecorate %288 Location 288 
                                                      OpDecorate %342 Location 342 
                                                      OpMemberDecorate %470 0 BuiltIn 470 
                                                      OpMemberDecorate %470 1 BuiltIn 470 
                                                      OpMemberDecorate %470 2 BuiltIn 470 
                                                      OpDecorate %470 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeInt 32 1 
                                               %7 = OpTypePointer Private %6 
                                  Private i32* %8 = OpVariable Private 
                                               %9 = OpTypePointer Input %6 
                                   Input i32* %10 = OpVariable Input 
                                              %12 = OpTypeStruct %6 %6 
                                              %13 = OpTypePointer Uniform %12 
                  Uniform struct {i32; i32;}* %14 = OpVariable Uniform 
                                          i32 %15 = OpConstant 0 
                                              %16 = OpTypePointer Uniform %6 
                                              %20 = OpTypeFloat 32 
                                              %21 = OpTypeVector %20 3 
                                              %22 = OpTypePointer Private %21 
                               Private f32_3* %23 = OpVariable Private 
                                              %24 = OpTypeInt 32 0 
                                          u32 %25 = OpConstant 14 
                                              %26 = OpTypeArray %24 %25 
                                              %27 = OpTypeStruct %26 
                                              %28 = OpTypeRuntimeArray %27 
                                              %29 = OpTypeStruct %28 
                                              %30 = OpTypePointer Uniform %29 
                          Uniform struct {;}* %31 = OpVariable Uniform 
                                          i32 %33 = OpConstant 13 
                                              %34 = OpTypePointer Uniform %24 
                                          u32 %38 = OpConstant 0 
                                              %39 = OpTypePointer Private %20 
                                 Private f32* %45 = OpVariable Private 
                                              %48 = OpTypeVector %20 4 
                                          u32 %49 = OpConstant 4 
                                              %50 = OpTypeArray %48 %49 
                                              %51 = OpTypeStruct %48 %48 %50 %48 %48 
                                              %52 = OpTypePointer Uniform %51 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4; f32_4;}* %53 = OpVariable Uniform 
                                          i32 %54 = OpConstant 3 
                                          u32 %55 = OpConstant 1 
                                              %56 = OpTypePointer Uniform %20 
                                              %75 = OpTypePointer Private %48 
                               Private f32_4* %76 = OpVariable Private 
                                          u32 %79 = OpConstant 2 
                                          u32 %84 = OpConstant 3 
                                          f32 %88 = OpConstant 3.674022E-40 
                                             %100 = OpTypeVector %20 2 
                                             %101 = OpTypePointer Input %100 
                                Input f32_2* %102 = OpVariable Input 
                                             %104 = OpTypePointer Uniform %48 
                                             %114 = OpTypeBool 
                                             %115 = OpTypePointer Private %114 
                               Private bool* %116 = OpVariable Private 
                                         f32 %119 = OpConstant 3.674022E-40 
                                             %122 = OpTypePointer Function %100 
                                             %133 = OpTypePointer Output %100 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                         i32 %137 = OpConstant 4 
                                             %146 = OpTypePointer Output %48 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %148 = OpTypePointer Input %48 
                                Input f32_4* %149 = OpVariable Input 
                                         i32 %152 = OpConstant 7 
                                         i32 %157 = OpConstant 8 
                                         i32 %162 = OpConstant 6 
                              Private f32_4* %169 = OpVariable Private 
                              Private f32_4* %173 = OpVariable Private 
                                         i32 %175 = OpConstant 1 
                                         i32 %184 = OpConstant 2 
                                         i32 %203 = OpConstant 5 
                              Private f32_3* %208 = OpVariable Private 
                                         i32 %210 = OpConstant 9 
                                         i32 %215 = OpConstant 10 
                                         i32 %220 = OpConstant 11 
                              Private f32_4* %240 = OpVariable Private 
                              Private f32_3* %259 = OpVariable Private 
                                Private f32* %273 = OpVariable Private 
                                             %287 = OpTypePointer Input %21 
                                Input f32_3* %288 = OpVariable Input 
                              Private f32_3* %294 = OpVariable Private 
                                Input f32_4* %342 = OpVariable Input 
                                             %418 = OpTypePointer Function %21 
                                             %469 = OpTypeArray %20 %55 
                                             %470 = OpTypeStruct %48 %20 %469 
                                             %471 = OpTypePointer Output %470 
        Output struct {f32_4; f32; f32[1];}* %472 = OpVariable Output 
                                             %481 = OpTypePointer Output %20 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %123 = OpVariable Function 
                             Function f32_3* %419 = OpVariable Function 
                                          i32 %11 = OpLoad %10 
                                 Uniform i32* %17 = OpAccessChain %14 %15 
                                          i32 %18 = OpLoad %17 
                                          i32 %19 = OpIAdd %11 %18 
                                                      OpStore %8 %19 
                                          i32 %32 = OpLoad %8 
                                 Uniform u32* %35 = OpAccessChain %31 %15 %32 %15 %33 
                                          u32 %36 = OpLoad %35 
                                          f32 %37 = OpBitcast %36 
                                 Private f32* %40 = OpAccessChain %23 %38 
                                                      OpStore %40 %37 
                                 Private f32* %41 = OpAccessChain %23 %38 
                                          f32 %42 = OpLoad %41 
                                          f32 %43 = OpExtInst %1 8 %42 
                                 Private f32* %44 = OpAccessChain %23 %38 
                                                      OpStore %44 %43 
                                 Private f32* %46 = OpAccessChain %23 %38 
                                          f32 %47 = OpLoad %46 
                                 Uniform f32* %57 = OpAccessChain %53 %54 %55 
                                          f32 %58 = OpLoad %57 
                                          f32 %59 = OpFDiv %47 %58 
                                                      OpStore %45 %59 
                                          f32 %60 = OpLoad %45 
                                          f32 %61 = OpExtInst %1 8 %60 
                                                      OpStore %45 %61 
                                          f32 %62 = OpLoad %45 
                                          f32 %63 = OpFNegate %62 
                                 Uniform f32* %64 = OpAccessChain %53 %54 %55 
                                          f32 %65 = OpLoad %64 
                                          f32 %66 = OpFMul %63 %65 
                                 Private f32* %67 = OpAccessChain %23 %38 
                                          f32 %68 = OpLoad %67 
                                          f32 %69 = OpFAdd %66 %68 
                                 Private f32* %70 = OpAccessChain %23 %38 
                                                      OpStore %70 %69 
                                 Private f32* %71 = OpAccessChain %23 %38 
                                          f32 %72 = OpLoad %71 
                                          f32 %73 = OpExtInst %1 8 %72 
                                 Private f32* %74 = OpAccessChain %23 %38 
                                                      OpStore %74 %73 
                                 Private f32* %77 = OpAccessChain %23 %38 
                                          f32 %78 = OpLoad %77 
                                 Uniform f32* %80 = OpAccessChain %53 %54 %79 
                                          f32 %81 = OpLoad %80 
                                          f32 %82 = OpFMul %78 %81 
                                 Private f32* %83 = OpAccessChain %76 %38 
                                                      OpStore %83 %82 
                                 Uniform f32* %85 = OpAccessChain %53 %54 %84 
                                          f32 %86 = OpLoad %85 
                                          f32 %87 = OpFNegate %86 
                                          f32 %89 = OpFAdd %87 %88 
                                 Private f32* %90 = OpAccessChain %23 %38 
                                                      OpStore %90 %89 
                                          f32 %91 = OpLoad %45 
                                          f32 %92 = OpFNegate %91 
                                 Uniform f32* %93 = OpAccessChain %53 %54 %84 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFMul %92 %94 
                                 Private f32* %96 = OpAccessChain %23 %38 
                                          f32 %97 = OpLoad %96 
                                          f32 %98 = OpFAdd %95 %97 
                                 Private f32* %99 = OpAccessChain %76 %55 
                                                      OpStore %99 %98 
                                       f32_2 %103 = OpLoad %102 
                              Uniform f32_4* %105 = OpAccessChain %53 %54 
                                       f32_4 %106 = OpLoad %105 
                                       f32_2 %107 = OpVectorShuffle %106 %106 2 3 
                                       f32_2 %108 = OpFMul %103 %107 
                                       f32_4 %109 = OpLoad %76 
                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
                                       f32_2 %111 = OpFAdd %108 %110 
                                       f32_3 %112 = OpLoad %23 
                                       f32_3 %113 = OpVectorShuffle %112 %111 3 4 2 
                                                      OpStore %23 %113 
                                Uniform f32* %117 = OpAccessChain %53 %54 %38 
                                         f32 %118 = OpLoad %117 
                                        bool %120 = OpFOrdNotEqual %118 %119 
                                                      OpStore %116 %120 
                                        bool %121 = OpLoad %116 
                                                      OpSelectionMerge %125 None 
                                                      OpBranchConditional %121 %124 %128 
                                             %124 = OpLabel 
                                       f32_3 %126 = OpLoad %23 
                                       f32_2 %127 = OpVectorShuffle %126 %126 0 1 
                                                      OpStore %123 %127 
                                                      OpBranch %125 
                                             %128 = OpLabel 
                                       f32_2 %129 = OpLoad %102 
                                                      OpStore %123 %129 
                                                      OpBranch %125 
                                             %125 = OpLabel 
                                       f32_2 %130 = OpLoad %123 
                                       f32_3 %131 = OpLoad %23 
                                       f32_3 %132 = OpVectorShuffle %131 %130 3 4 2 
                                                      OpStore %23 %132 
                                       f32_3 %135 = OpLoad %23 
                                       f32_2 %136 = OpVectorShuffle %135 %135 0 1 
                              Uniform f32_4* %138 = OpAccessChain %53 %137 
                                       f32_4 %139 = OpLoad %138 
                                       f32_2 %140 = OpVectorShuffle %139 %139 0 1 
                                       f32_2 %141 = OpFMul %136 %140 
                              Uniform f32_4* %142 = OpAccessChain %53 %137 
                                       f32_4 %143 = OpLoad %142 
                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
                                       f32_2 %145 = OpFAdd %141 %144 
                                                      OpStore vs_TEXCOORD1 %145 
                                       f32_4 %150 = OpLoad %149 
                                                      OpStore vs_TEXCOORD3 %150 
                                         i32 %151 = OpLoad %8 
                                Uniform u32* %153 = OpAccessChain %31 %15 %151 %15 %152 
                                         u32 %154 = OpLoad %153 
                                         f32 %155 = OpBitcast %154 
                                         i32 %156 = OpLoad %8 
                                Uniform u32* %158 = OpAccessChain %31 %15 %156 %15 %157 
                                         u32 %159 = OpLoad %158 
                                         f32 %160 = OpBitcast %159 
                                         i32 %161 = OpLoad %8 
                                Uniform u32* %163 = OpAccessChain %31 %15 %161 %15 %162 
                                         u32 %164 = OpLoad %163 
                                         f32 %165 = OpBitcast %164 
                                       f32_3 %166 = OpCompositeConstruct %155 %160 %165 
                                       f32_4 %167 = OpLoad %76 
                                       f32_4 %168 = OpVectorShuffle %167 %166 4 5 6 3 
                                                      OpStore %76 %168 
                                Private f32* %170 = OpAccessChain %76 %55 
                                         f32 %171 = OpLoad %170 
                                Private f32* %172 = OpAccessChain %169 %79 
                                                      OpStore %172 %171 
                                         i32 %174 = OpLoad %8 
                                Uniform u32* %176 = OpAccessChain %31 %15 %174 %15 %175 
                                         u32 %177 = OpLoad %176 
                                         f32 %178 = OpBitcast %177 
                                         i32 %179 = OpLoad %8 
                                Uniform u32* %180 = OpAccessChain %31 %15 %179 %15 %15 
                                         u32 %181 = OpLoad %180 
                                         f32 %182 = OpBitcast %181 
                                         i32 %183 = OpLoad %8 
                                Uniform u32* %185 = OpAccessChain %31 %15 %183 %15 %184 
                                         u32 %186 = OpLoad %185 
                                         f32 %187 = OpBitcast %186 
                                       f32_3 %188 = OpCompositeConstruct %178 %182 %187 
                                       f32_4 %189 = OpLoad %173 
                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
                                                      OpStore %173 %190 
                                Private f32* %191 = OpAccessChain %173 %79 
                                         f32 %192 = OpLoad %191 
                                Private f32* %193 = OpAccessChain %169 %38 
                                                      OpStore %193 %192 
                                         i32 %194 = OpLoad %8 
                                Uniform u32* %195 = OpAccessChain %31 %15 %194 %15 %54 
                                         u32 %196 = OpLoad %195 
                                         f32 %197 = OpBitcast %196 
                                         i32 %198 = OpLoad %8 
                                Uniform u32* %199 = OpAccessChain %31 %15 %198 %15 %137 
                                         u32 %200 = OpLoad %199 
                                         f32 %201 = OpBitcast %200 
                                         i32 %202 = OpLoad %8 
                                Uniform u32* %204 = OpAccessChain %31 %15 %202 %15 %203 
                                         u32 %205 = OpLoad %204 
                                         f32 %206 = OpBitcast %205 
                                       f32_3 %207 = OpCompositeConstruct %197 %201 %206 
                                                      OpStore %23 %207 
                                         i32 %209 = OpLoad %8 
                                Uniform u32* %211 = OpAccessChain %31 %15 %209 %15 %210 
                                         u32 %212 = OpLoad %211 
                                         f32 %213 = OpBitcast %212 
                                         i32 %214 = OpLoad %8 
                                Uniform u32* %216 = OpAccessChain %31 %15 %214 %15 %215 
                                         u32 %217 = OpLoad %216 
                                         f32 %218 = OpBitcast %217 
                                         i32 %219 = OpLoad %8 
                                Uniform u32* %221 = OpAccessChain %31 %15 %219 %15 %220 
                                         u32 %222 = OpLoad %221 
                                         f32 %223 = OpBitcast %222 
                                       f32_3 %224 = OpCompositeConstruct %213 %218 %223 
                                                      OpStore %208 %224 
                                Private f32* %225 = OpAccessChain %23 %79 
                                         f32 %226 = OpLoad %225 
                                Private f32* %227 = OpAccessChain %169 %55 
                                                      OpStore %227 %226 
                                Private f32* %228 = OpAccessChain %76 %38 
                                         f32 %229 = OpLoad %228 
                                Private f32* %230 = OpAccessChain %173 %79 
                                                      OpStore %230 %229 
                                Private f32* %231 = OpAccessChain %173 %55 
                                         f32 %232 = OpLoad %231 
                                Private f32* %233 = OpAccessChain %76 %38 
                                                      OpStore %233 %232 
                                Private f32* %234 = OpAccessChain %23 %38 
                                         f32 %235 = OpLoad %234 
                                Private f32* %236 = OpAccessChain %76 %55 
                                                      OpStore %236 %235 
                                Private f32* %237 = OpAccessChain %23 %55 
                                         f32 %238 = OpLoad %237 
                                Private f32* %239 = OpAccessChain %173 %55 
                                                      OpStore %239 %238 
                                       f32_4 %241 = OpLoad %169 
                                       f32_3 %242 = OpVectorShuffle %241 %241 2 0 1 
                                       f32_4 %243 = OpLoad %76 
                                       f32_3 %244 = OpVectorShuffle %243 %243 1 2 0 
                                       f32_3 %245 = OpFMul %242 %244 
                                       f32_4 %246 = OpLoad %240 
                                       f32_4 %247 = OpVectorShuffle %246 %245 4 5 6 3 
                                                      OpStore %240 %247 
                                       f32_4 %248 = OpLoad %76 
                                       f32_3 %249 = OpVectorShuffle %248 %248 2 0 1 
                                       f32_4 %250 = OpLoad %169 
                                       f32_3 %251 = OpVectorShuffle %250 %250 1 2 0 
                                       f32_3 %252 = OpFMul %249 %251 
                                       f32_4 %253 = OpLoad %240 
                                       f32_3 %254 = OpVectorShuffle %253 %253 0 1 2 
                                       f32_3 %255 = OpFNegate %254 
                                       f32_3 %256 = OpFAdd %252 %255 
                                       f32_4 %257 = OpLoad %240 
                                       f32_4 %258 = OpVectorShuffle %257 %256 4 5 6 3 
                                                      OpStore %240 %258 
                                       f32_4 %260 = OpLoad %169 
                                       f32_3 %261 = OpVectorShuffle %260 %260 1 2 0 
                                       f32_4 %262 = OpLoad %173 
                                       f32_3 %263 = OpVectorShuffle %262 %262 2 0 1 
                                       f32_3 %264 = OpFMul %261 %263 
                                                      OpStore %259 %264 
                                       f32_4 %265 = OpLoad %173 
                                       f32_3 %266 = OpVectorShuffle %265 %265 1 2 0 
                                       f32_4 %267 = OpLoad %169 
                                       f32_3 %268 = OpVectorShuffle %267 %267 2 0 1 
                                       f32_3 %269 = OpFMul %266 %268 
                                       f32_3 %270 = OpLoad %259 
                                       f32_3 %271 = OpFNegate %270 
                                       f32_3 %272 = OpFAdd %269 %271 
                                                      OpStore %259 %272 
                                       f32_4 %274 = OpLoad %76 
                                       f32_3 %275 = OpVectorShuffle %274 %274 0 1 2 
                                       f32_3 %276 = OpLoad %259 
                                         f32 %277 = OpDot %275 %276 
                                                      OpStore %273 %277 
                                         f32 %278 = OpLoad %273 
                                         f32 %279 = OpFDiv %88 %278 
                                                      OpStore %273 %279 
                                         f32 %280 = OpLoad %273 
                                       f32_3 %281 = OpCompositeConstruct %280 %280 %280 
                                       f32_4 %282 = OpLoad %240 
                                       f32_3 %283 = OpVectorShuffle %282 %282 0 1 2 
                                       f32_3 %284 = OpFMul %281 %283 
                                       f32_4 %285 = OpLoad %240 
                                       f32_4 %286 = OpVectorShuffle %285 %284 4 5 6 3 
                                                      OpStore %240 %286 
                                       f32_3 %289 = OpLoad %288 
                                       f32_4 %290 = OpLoad %240 
                                       f32_3 %291 = OpVectorShuffle %290 %290 0 1 2 
                                         f32 %292 = OpDot %289 %291 
                                Private f32* %293 = OpAccessChain %240 %55 
                                                      OpStore %293 %292 
                                       f32_4 %295 = OpLoad %76 
                                       f32_3 %296 = OpVectorShuffle %295 %295 2 0 1 
                                       f32_4 %297 = OpLoad %173 
                                       f32_3 %298 = OpVectorShuffle %297 %297 1 2 0 
                                       f32_3 %299 = OpFMul %296 %298 
                                                      OpStore %294 %299 
                                       f32_4 %300 = OpLoad %76 
                                       f32_3 %301 = OpVectorShuffle %300 %300 1 2 0 
                                       f32_4 %302 = OpLoad %173 
                                       f32_3 %303 = OpVectorShuffle %302 %302 2 0 1 
                                       f32_3 %304 = OpFMul %301 %303 
                                       f32_3 %305 = OpLoad %294 
                                       f32_3 %306 = OpFNegate %305 
                                       f32_3 %307 = OpFAdd %304 %306 
                                                      OpStore %294 %307 
                                         f32 %308 = OpLoad %273 
                                       f32_3 %309 = OpCompositeConstruct %308 %308 %308 
                                       f32_3 %310 = OpLoad %294 
                                       f32_3 %311 = OpFMul %309 %310 
                                                      OpStore %294 %311 
                                         f32 %312 = OpLoad %273 
                                       f32_3 %313 = OpCompositeConstruct %312 %312 %312 
                                       f32_3 %314 = OpLoad %259 
                                       f32_3 %315 = OpFMul %313 %314 
                                                      OpStore %259 %315 
                                       f32_3 %316 = OpLoad %288 
                                       f32_3 %317 = OpLoad %259 
                                         f32 %318 = OpDot %316 %317 
                                Private f32* %319 = OpAccessChain %240 %38 
                                                      OpStore %319 %318 
                                       f32_3 %320 = OpLoad %288 
                                       f32_3 %321 = OpLoad %294 
                                         f32 %322 = OpDot %320 %321 
                                Private f32* %323 = OpAccessChain %240 %79 
                                                      OpStore %323 %322 
                                       f32_4 %324 = OpLoad %240 
                                       f32_3 %325 = OpVectorShuffle %324 %324 0 1 2 
                                       f32_4 %326 = OpLoad %240 
                                       f32_3 %327 = OpVectorShuffle %326 %326 0 1 2 
                                         f32 %328 = OpDot %325 %327 
                                                      OpStore %273 %328 
                                         f32 %329 = OpLoad %273 
                                         f32 %330 = OpExtInst %1 32 %329 
                                                      OpStore %273 %330 
                                         f32 %331 = OpLoad %273 
                                       f32_3 %332 = OpCompositeConstruct %331 %331 %331 
                                       f32_4 %333 = OpLoad %240 
                                       f32_3 %334 = OpVectorShuffle %333 %333 0 1 2 
                                       f32_3 %335 = OpFMul %332 %334 
                                       f32_4 %336 = OpLoad %240 
                                       f32_4 %337 = OpVectorShuffle %336 %335 4 5 6 3 
                                                      OpStore %240 %337 
                                Private f32* %338 = OpAccessChain %208 %38 
                                         f32 %339 = OpLoad %338 
                                Private f32* %340 = OpAccessChain %76 %84 
                                                      OpStore %340 %339 
                                       f32_4 %341 = OpLoad %76 
                                       f32_4 %343 = OpLoad %342 
                                         f32 %344 = OpDot %341 %343 
                                Private f32* %345 = OpAccessChain %76 %38 
                                                      OpStore %345 %344 
                                Private f32* %346 = OpAccessChain %208 %55 
                                         f32 %347 = OpLoad %346 
                                Private f32* %348 = OpAccessChain %173 %84 
                                                      OpStore %348 %347 
                                Private f32* %349 = OpAccessChain %208 %79 
                                         f32 %350 = OpLoad %349 
                                Private f32* %351 = OpAccessChain %169 %84 
                                                      OpStore %351 %350 
                                       f32_4 %352 = OpLoad %169 
                                       f32_4 %353 = OpLoad %342 
                                         f32 %354 = OpDot %352 %353 
                                Private f32* %355 = OpAccessChain %76 %79 
                                                      OpStore %355 %354 
                                       f32_4 %356 = OpLoad %173 
                                       f32_4 %357 = OpLoad %342 
                                         f32 %358 = OpDot %356 %357 
                                Private f32* %359 = OpAccessChain %76 %55 
                                                      OpStore %359 %358 
                                       f32_4 %360 = OpLoad %76 
                                       f32_3 %361 = OpVectorShuffle %360 %360 0 1 2 
                                       f32_3 %362 = OpFNegate %361 
                              Uniform f32_4* %363 = OpAccessChain %53 %15 
                                       f32_4 %364 = OpLoad %363 
                                       f32_3 %365 = OpVectorShuffle %364 %364 3 3 3 
                                       f32_3 %366 = OpFMul %362 %365 
                              Uniform f32_4* %367 = OpAccessChain %53 %15 
                                       f32_4 %368 = OpLoad %367 
                                       f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                       f32_3 %370 = OpFAdd %366 %369 
                                       f32_4 %371 = OpLoad %169 
                                       f32_4 %372 = OpVectorShuffle %371 %370 4 5 6 3 
                                                      OpStore %169 %372 
                                       f32_4 %373 = OpLoad %169 
                                       f32_3 %374 = OpVectorShuffle %373 %373 0 1 2 
                                       f32_4 %375 = OpLoad %169 
                                       f32_3 %376 = OpVectorShuffle %375 %375 0 1 2 
                                         f32 %377 = OpDot %374 %376 
                                                      OpStore %273 %377 
                                         f32 %378 = OpLoad %273 
                                         f32 %379 = OpExtInst %1 32 %378 
                                                      OpStore %273 %379 
                                         f32 %380 = OpLoad %273 
                                       f32_3 %381 = OpCompositeConstruct %380 %380 %380 
                                       f32_4 %382 = OpLoad %169 
                                       f32_3 %383 = OpVectorShuffle %382 %382 0 1 2 
                                       f32_3 %384 = OpFMul %381 %383 
                                       f32_4 %385 = OpLoad %169 
                                       f32_4 %386 = OpVectorShuffle %385 %384 4 5 6 3 
                                                      OpStore %169 %386 
                                       f32_4 %387 = OpLoad %240 
                                       f32_3 %388 = OpVectorShuffle %387 %387 0 1 2 
                                       f32_4 %389 = OpLoad %169 
                                       f32_3 %390 = OpVectorShuffle %389 %389 0 1 2 
                                         f32 %391 = OpDot %388 %390 
                                                      OpStore %273 %391 
                                         f32 %392 = OpLoad %273 
                                         f32 %393 = OpFNegate %392 
                                         f32 %394 = OpLoad %273 
                                         f32 %395 = OpFMul %393 %394 
                                         f32 %396 = OpFAdd %395 %88 
                                                      OpStore %273 %396 
                                         f32 %397 = OpLoad %273 
                                         f32 %398 = OpExtInst %1 31 %397 
                                                      OpStore %273 %398 
                                         f32 %399 = OpLoad %273 
                                Uniform f32* %400 = OpAccessChain %53 %175 %79 
                                         f32 %401 = OpLoad %400 
                                         f32 %402 = OpFMul %399 %401 
                                                      OpStore %273 %402 
                                       f32_4 %403 = OpLoad %240 
                                       f32_3 %404 = OpVectorShuffle %403 %403 0 1 2 
                                       f32_3 %405 = OpFNegate %404 
                                         f32 %406 = OpLoad %273 
                                       f32_3 %407 = OpCompositeConstruct %406 %406 %406 
                                       f32_3 %408 = OpFMul %405 %407 
                                       f32_4 %409 = OpLoad %76 
                                       f32_3 %410 = OpVectorShuffle %409 %409 0 1 2 
                                       f32_3 %411 = OpFAdd %408 %410 
                                       f32_4 %412 = OpLoad %240 
                                       f32_4 %413 = OpVectorShuffle %412 %411 4 5 6 3 
                                                      OpStore %240 %413 
                                Uniform f32* %414 = OpAccessChain %53 %175 %79 
                                         f32 %415 = OpLoad %414 
                                        bool %416 = OpFOrdNotEqual %415 %119 
                                                      OpStore %116 %416 
                                        bool %417 = OpLoad %116 
                                                      OpSelectionMerge %421 None 
                                                      OpBranchConditional %417 %420 %424 
                                             %420 = OpLabel 
                                       f32_4 %422 = OpLoad %240 
                                       f32_3 %423 = OpVectorShuffle %422 %422 0 1 2 
                                                      OpStore %419 %423 
                                                      OpBranch %421 
                                             %424 = OpLabel 
                                       f32_4 %425 = OpLoad %76 
                                       f32_3 %426 = OpVectorShuffle %425 %425 0 1 2 
                                                      OpStore %419 %426 
                                                      OpBranch %421 
                                             %421 = OpLabel 
                                       f32_3 %427 = OpLoad %419 
                                       f32_4 %428 = OpLoad %240 
                                       f32_4 %429 = OpVectorShuffle %428 %427 4 5 6 3 
                                                      OpStore %240 %429 
                                       f32_4 %430 = OpLoad %240 
                                       f32_4 %431 = OpVectorShuffle %430 %430 1 1 1 1 
                              Uniform f32_4* %432 = OpAccessChain %53 %184 %175 
                                       f32_4 %433 = OpLoad %432 
                                       f32_4 %434 = OpFMul %431 %433 
                                                      OpStore %76 %434 
                              Uniform f32_4* %435 = OpAccessChain %53 %184 %15 
                                       f32_4 %436 = OpLoad %435 
                                       f32_4 %437 = OpLoad %240 
                                       f32_4 %438 = OpVectorShuffle %437 %437 0 0 0 0 
                                       f32_4 %439 = OpFMul %436 %438 
                                       f32_4 %440 = OpLoad %76 
                                       f32_4 %441 = OpFAdd %439 %440 
                                                      OpStore %76 %441 
                              Uniform f32_4* %442 = OpAccessChain %53 %184 %184 
                                       f32_4 %443 = OpLoad %442 
                                       f32_4 %444 = OpLoad %240 
                                       f32_4 %445 = OpVectorShuffle %444 %444 2 2 2 2 
                                       f32_4 %446 = OpFMul %443 %445 
                                       f32_4 %447 = OpLoad %76 
                                       f32_4 %448 = OpFAdd %446 %447 
                                                      OpStore %240 %448 
                              Uniform f32_4* %449 = OpAccessChain %53 %184 %54 
                                       f32_4 %450 = OpLoad %449 
                                       f32_4 %451 = OpLoad %342 
                                       f32_4 %452 = OpVectorShuffle %451 %451 3 3 3 3 
                                       f32_4 %453 = OpFMul %450 %452 
                                       f32_4 %454 = OpLoad %240 
                                       f32_4 %455 = OpFAdd %453 %454 
                                                      OpStore %240 %455 
                                Private f32* %456 = OpAccessChain %240 %84 
                                         f32 %457 = OpLoad %456 
                                Private f32* %458 = OpAccessChain %240 %79 
                                         f32 %459 = OpLoad %458 
                                         f32 %460 = OpExtInst %1 37 %457 %459 
                                Private f32* %461 = OpAccessChain %76 %38 
                                                      OpStore %461 %460 
                                Private f32* %462 = OpAccessChain %240 %79 
                                         f32 %463 = OpLoad %462 
                                         f32 %464 = OpFNegate %463 
                                Private f32* %465 = OpAccessChain %76 %38 
                                         f32 %466 = OpLoad %465 
                                         f32 %467 = OpFAdd %464 %466 
                                Private f32* %468 = OpAccessChain %76 %38 
                                                      OpStore %468 %467 
                                Uniform f32* %473 = OpAccessChain %53 %175 %55 
                                         f32 %474 = OpLoad %473 
                                Private f32* %475 = OpAccessChain %76 %38 
                                         f32 %476 = OpLoad %475 
                                         f32 %477 = OpFMul %474 %476 
                                Private f32* %478 = OpAccessChain %240 %79 
                                         f32 %479 = OpLoad %478 
                                         f32 %480 = OpFAdd %477 %479 
                                 Output f32* %482 = OpAccessChain %472 %15 %79 
                                                      OpStore %482 %480 
                                       f32_4 %483 = OpLoad %240 
                                       f32_3 %484 = OpVectorShuffle %483 %483 0 1 3 
                               Output f32_4* %485 = OpAccessChain %472 %15 
                                       f32_4 %486 = OpLoad %485 
                                       f32_4 %487 = OpVectorShuffle %486 %484 4 5 2 6 
                                                      OpStore %485 %487 
                                 Output f32* %488 = OpAccessChain %472 %15 %55 
                                         f32 %489 = OpLoad %488 
                                         f32 %490 = OpFNegate %489 
                                 Output f32* %491 = OpAccessChain %472 %15 %55 
                                                      OpStore %491 %490 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 59
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %21 %31 %56 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                             OpDecorate %8 RelaxedPrecision 
                                             OpDecorate %11 RelaxedPrecision 
                                             OpDecorate %11 DescriptorSet 11 
                                             OpDecorate %11 Binding 11 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %15 RelaxedPrecision 
                                             OpDecorate %15 DescriptorSet 15 
                                             OpDecorate %15 Binding 15 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 21 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 Location 31 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %41 RelaxedPrecision 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %56 Location 56 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypePointer Private %6 
                         Private f32* %8 = OpVariable Private 
                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %10 = OpTypePointer UniformConstant %9 
UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
                                     %13 = OpTypeSampler 
                                     %14 = OpTypePointer UniformConstant %13 
            UniformConstant sampler* %15 = OpVariable UniformConstant 
                                     %17 = OpTypeSampledImage %9 
                                     %19 = OpTypeVector %6 2 
                                     %20 = OpTypePointer Input %19 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %23 = OpTypeVector %6 4 
                                     %25 = OpTypeInt 32 0 
                                 u32 %26 = OpConstant 3 
                        Private f32* %28 = OpVariable Private 
                                     %30 = OpTypePointer Input %23 
               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
                                     %32 = OpTypePointer Input %6 
                                 f32 %36 = OpConstant 3.674022E-40 
                                     %38 = OpTypeBool 
                                     %39 = OpTypePointer Private %38 
                       Private bool* %40 = OpVariable Private 
                                 f32 %42 = OpConstant 3.674022E-40 
                                     %45 = OpTypeInt 32 1 
                                 i32 %46 = OpConstant 0 
                                 i32 %47 = OpConstant 1 
                                 i32 %49 = OpConstant -1 
                                     %55 = OpTypePointer Output %23 
                       Output f32_4* %56 = OpVariable Output 
                               f32_4 %57 = OpConstantComposite %42 %42 %42 %42 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %12 = OpLoad %11 
                             sampler %16 = OpLoad %15 
          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
                               f32_2 %22 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
                                 f32 %27 = OpCompositeExtract %24 3 
                                             OpStore %8 %27 
                                 f32 %29 = OpLoad %8 
                          Input f32* %33 = OpAccessChain vs_TEXCOORD3 %26 
                                 f32 %34 = OpLoad %33 
                                 f32 %35 = OpFMul %29 %34 
                                 f32 %37 = OpFAdd %35 %36 
                                             OpStore %28 %37 
                                 f32 %41 = OpLoad %28 
                                bool %43 = OpFOrdLessThan %41 %42 
                                             OpStore %40 %43 
                                bool %44 = OpLoad %40 
                                 i32 %48 = OpSelect %44 %47 %46 
                                 i32 %50 = OpIMul %48 %49 
                                bool %51 = OpINotEqual %50 %46 
                                             OpSelectionMerge %53 None 
                                             OpBranchConditional %51 %52 %53 
                                     %52 = OpLabel 
                                             OpKill
                                     %53 = OpLabel 
                                             OpStore %56 %57 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 399
; Schema: 0
                                                   OpCapability Shader 
                                            %1 = OpExtInstImport "GLSL.std.450" 
                                                   OpMemoryModel Logical GLSL450 
                                                   OpEntryPoint Vertex %4 "main" %10 %180 %236 %377 
                                                   OpDecorate %10 BuiltIn ViewportIndex 
                                                   OpMemberDecorate %12 0 Offset 12 
                                                   OpMemberDecorate %12 1 Offset 12 
                                                   OpDecorate %12 Block 
                                                   OpDecorate %14 DescriptorSet 14 
                                                   OpDecorate %14 Binding 14 
                                                   OpDecorate %26 ArrayStride 26 
                                                   OpMemberDecorate %27 0 Offset 27 
                                                   OpDecorate %28 ArrayStride 28 
                                                   OpMemberDecorate %29 0 NonWritable 
                                                   OpMemberDecorate %29 0 Offset 29 
                                                   OpDecorate %29 BufferBlock 
                                                   OpDecorate %31 DescriptorSet 31 
                                                   OpDecorate %31 Binding 31 
                                                   OpDecorate %180 Location 180 
                                                   OpDecorate %236 Location 236 
                                                   OpDecorate %258 ArrayStride 258 
                                                   OpMemberDecorate %259 0 Offset 259 
                                                   OpMemberDecorate %259 1 Offset 259 
                                                   OpMemberDecorate %259 2 Offset 259 
                                                   OpDecorate %259 Block 
                                                   OpDecorate %261 DescriptorSet 261 
                                                   OpDecorate %261 Binding 261 
                                                   OpMemberDecorate %375 0 BuiltIn 375 
                                                   OpMemberDecorate %375 1 BuiltIn 375 
                                                   OpMemberDecorate %375 2 BuiltIn 375 
                                                   OpDecorate %375 Block 
                                            %2 = OpTypeVoid 
                                            %3 = OpTypeFunction %2 
                                            %6 = OpTypeInt 32 1 
                                            %7 = OpTypePointer Private %6 
                               Private i32* %8 = OpVariable Private 
                                            %9 = OpTypePointer Input %6 
                                Input i32* %10 = OpVariable Input 
                                           %12 = OpTypeStruct %6 %6 
                                           %13 = OpTypePointer Uniform %12 
               Uniform struct {i32; i32;}* %14 = OpVariable Uniform 
                                       i32 %15 = OpConstant 0 
                                           %16 = OpTypePointer Uniform %6 
                                           %20 = OpTypeFloat 32 
                                           %21 = OpTypeVector %20 4 
                                           %22 = OpTypePointer Private %21 
                            Private f32_4* %23 = OpVariable Private 
                                           %24 = OpTypeInt 32 0 
                                       u32 %25 = OpConstant 14 
                                           %26 = OpTypeArray %24 %25 
                                           %27 = OpTypeStruct %26 
                                           %28 = OpTypeRuntimeArray %27 
                                           %29 = OpTypeStruct %28 
                                           %30 = OpTypePointer Uniform %29 
                       Uniform struct {;}* %31 = OpVariable Uniform 
                                       i32 %33 = OpConstant 7 
                                           %34 = OpTypePointer Uniform %24 
                                       i32 %39 = OpConstant 8 
                                       i32 %44 = OpConstant 6 
                                           %48 = OpTypeVector %20 3 
                            Private f32_4* %52 = OpVariable Private 
                                       u32 %53 = OpConstant 1 
                                           %54 = OpTypePointer Private %20 
                                       u32 %57 = OpConstant 2 
                            Private f32_4* %59 = OpVariable Private 
                                       i32 %61 = OpConstant 1 
                                       i32 %70 = OpConstant 2 
                                       u32 %79 = OpConstant 0 
                                           %81 = OpTypePointer Private %48 
                            Private f32_3* %82 = OpVariable Private 
                                       i32 %84 = OpConstant 3 
                                       i32 %89 = OpConstant 4 
                                       i32 %94 = OpConstant 5 
                            Private f32_3* %99 = OpVariable Private 
                                      i32 %101 = OpConstant 9 
                                      i32 %106 = OpConstant 10 
                                      i32 %111 = OpConstant 11 
                           Private f32_4* %131 = OpVariable Private 
                           Private f32_3* %150 = OpVariable Private 
                             Private f32* %164 = OpVariable Private 
                                      f32 %169 = OpConstant 3.674022E-40 
                                          %179 = OpTypePointer Input %48 
                             Input f32_3* %180 = OpVariable Input 
                           Private f32_3* %186 = OpVariable Private 
                                      u32 %232 = OpConstant 3 
                                          %235 = OpTypePointer Input %21 
                             Input f32_4* %236 = OpVariable Input 
                                      u32 %257 = OpConstant 4 
                                          %258 = OpTypeArray %21 %257 
                                          %259 = OpTypeStruct %21 %21 %258 
                                          %260 = OpTypePointer Uniform %259 
Uniform struct {f32_4; f32_4; f32_4[4];}* %261 = OpVariable Uniform 
                                          %262 = OpTypePointer Uniform %21 
                                          %300 = OpTypePointer Uniform %20 
                                          %315 = OpTypeBool 
                                          %316 = OpTypePointer Private %315 
                            Private bool* %317 = OpVariable Private 
                                      f32 %320 = OpConstant 3.674022E-40 
                                          %323 = OpTypePointer Function %48 
                                          %374 = OpTypeArray %20 %53 
                                          %375 = OpTypeStruct %21 %20 %374 
                                          %376 = OpTypePointer Output %375 
     Output struct {f32_4; f32; f32[1];}* %377 = OpVariable Output 
                                          %386 = OpTypePointer Output %20 
                                          %390 = OpTypePointer Output %21 
                                       void %4 = OpFunction None %3 
                                            %5 = OpLabel 
                          Function f32_3* %324 = OpVariable Function 
                                       i32 %11 = OpLoad %10 
                              Uniform i32* %17 = OpAccessChain %14 %15 
                                       i32 %18 = OpLoad %17 
                                       i32 %19 = OpIAdd %11 %18 
                                                   OpStore %8 %19 
                                       i32 %32 = OpLoad %8 
                              Uniform u32* %35 = OpAccessChain %31 %15 %32 %15 %33 
                                       u32 %36 = OpLoad %35 
                                       f32 %37 = OpBitcast %36 
                                       i32 %38 = OpLoad %8 
                              Uniform u32* %40 = OpAccessChain %31 %15 %38 %15 %39 
                                       u32 %41 = OpLoad %40 
                                       f32 %42 = OpBitcast %41 
                                       i32 %43 = OpLoad %8 
                              Uniform u32* %45 = OpAccessChain %31 %15 %43 %15 %44 
                                       u32 %46 = OpLoad %45 
                                       f32 %47 = OpBitcast %46 
                                     f32_3 %49 = OpCompositeConstruct %37 %42 %47 
                                     f32_4 %50 = OpLoad %23 
                                     f32_4 %51 = OpVectorShuffle %50 %49 4 5 6 3 
                                                   OpStore %23 %51 
                              Private f32* %55 = OpAccessChain %23 %53 
                                       f32 %56 = OpLoad %55 
                              Private f32* %58 = OpAccessChain %52 %57 
                                                   OpStore %58 %56 
                                       i32 %60 = OpLoad %8 
                              Uniform u32* %62 = OpAccessChain %31 %15 %60 %15 %61 
                                       u32 %63 = OpLoad %62 
                                       f32 %64 = OpBitcast %63 
                                       i32 %65 = OpLoad %8 
                              Uniform u32* %66 = OpAccessChain %31 %15 %65 %15 %15 
                                       u32 %67 = OpLoad %66 
                                       f32 %68 = OpBitcast %67 
                                       i32 %69 = OpLoad %8 
                              Uniform u32* %71 = OpAccessChain %31 %15 %69 %15 %70 
                                       u32 %72 = OpLoad %71 
                                       f32 %73 = OpBitcast %72 
                                     f32_3 %74 = OpCompositeConstruct %64 %68 %73 
                                     f32_4 %75 = OpLoad %59 
                                     f32_4 %76 = OpVectorShuffle %75 %74 4 5 6 3 
                                                   OpStore %59 %76 
                              Private f32* %77 = OpAccessChain %59 %57 
                                       f32 %78 = OpLoad %77 
                              Private f32* %80 = OpAccessChain %52 %79 
                                                   OpStore %80 %78 
                                       i32 %83 = OpLoad %8 
                              Uniform u32* %85 = OpAccessChain %31 %15 %83 %15 %84 
                                       u32 %86 = OpLoad %85 
                                       f32 %87 = OpBitcast %86 
                                       i32 %88 = OpLoad %8 
                              Uniform u32* %90 = OpAccessChain %31 %15 %88 %15 %89 
                                       u32 %91 = OpLoad %90 
                                       f32 %92 = OpBitcast %91 
                                       i32 %93 = OpLoad %8 
                              Uniform u32* %95 = OpAccessChain %31 %15 %93 %15 %94 
                                       u32 %96 = OpLoad %95 
                                       f32 %97 = OpBitcast %96 
                                     f32_3 %98 = OpCompositeConstruct %87 %92 %97 
                                                   OpStore %82 %98 
                                      i32 %100 = OpLoad %8 
                             Uniform u32* %102 = OpAccessChain %31 %15 %100 %15 %101 
                                      u32 %103 = OpLoad %102 
                                      f32 %104 = OpBitcast %103 
                                      i32 %105 = OpLoad %8 
                             Uniform u32* %107 = OpAccessChain %31 %15 %105 %15 %106 
                                      u32 %108 = OpLoad %107 
                                      f32 %109 = OpBitcast %108 
                                      i32 %110 = OpLoad %8 
                             Uniform u32* %112 = OpAccessChain %31 %15 %110 %15 %111 
                                      u32 %113 = OpLoad %112 
                                      f32 %114 = OpBitcast %113 
                                    f32_3 %115 = OpCompositeConstruct %104 %109 %114 
                                                   OpStore %99 %115 
                             Private f32* %116 = OpAccessChain %82 %57 
                                      f32 %117 = OpLoad %116 
                             Private f32* %118 = OpAccessChain %52 %53 
                                                   OpStore %118 %117 
                             Private f32* %119 = OpAccessChain %23 %79 
                                      f32 %120 = OpLoad %119 
                             Private f32* %121 = OpAccessChain %59 %57 
                                                   OpStore %121 %120 
                             Private f32* %122 = OpAccessChain %59 %53 
                                      f32 %123 = OpLoad %122 
                             Private f32* %124 = OpAccessChain %23 %79 
                                                   OpStore %124 %123 
                             Private f32* %125 = OpAccessChain %82 %79 
                                      f32 %126 = OpLoad %125 
                             Private f32* %127 = OpAccessChain %23 %53 
                                                   OpStore %127 %126 
                             Private f32* %128 = OpAccessChain %82 %53 
                                      f32 %129 = OpLoad %128 
                             Private f32* %130 = OpAccessChain %59 %53 
                                                   OpStore %130 %129 
                                    f32_4 %132 = OpLoad %52 
                                    f32_3 %133 = OpVectorShuffle %132 %132 2 0 1 
                                    f32_4 %134 = OpLoad %23 
                                    f32_3 %135 = OpVectorShuffle %134 %134 1 2 0 
                                    f32_3 %136 = OpFMul %133 %135 
                                    f32_4 %137 = OpLoad %131 
                                    f32_4 %138 = OpVectorShuffle %137 %136 4 5 6 3 
                                                   OpStore %131 %138 
                                    f32_4 %139 = OpLoad %23 
                                    f32_3 %140 = OpVectorShuffle %139 %139 2 0 1 
                                    f32_4 %141 = OpLoad %52 
                                    f32_3 %142 = OpVectorShuffle %141 %141 1 2 0 
                                    f32_3 %143 = OpFMul %140 %142 
                                    f32_4 %144 = OpLoad %131 
                                    f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
                                    f32_3 %146 = OpFNegate %145 
                                    f32_3 %147 = OpFAdd %143 %146 
                                    f32_4 %148 = OpLoad %131 
                                    f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                   OpStore %131 %149 
                                    f32_4 %151 = OpLoad %52 
                                    f32_3 %152 = OpVectorShuffle %151 %151 1 2 0 
                                    f32_4 %153 = OpLoad %59 
                                    f32_3 %154 = OpVectorShuffle %153 %153 2 0 1 
                                    f32_3 %155 = OpFMul %152 %154 
                                                   OpStore %150 %155 
                                    f32_4 %156 = OpLoad %59 
                                    f32_3 %157 = OpVectorShuffle %156 %156 1 2 0 
                                    f32_4 %158 = OpLoad %52 
                                    f32_3 %159 = OpVectorShuffle %158 %158 2 0 1 
                                    f32_3 %160 = OpFMul %157 %159 
                                    f32_3 %161 = OpLoad %150 
                                    f32_3 %162 = OpFNegate %161 
                                    f32_3 %163 = OpFAdd %160 %162 
                                                   OpStore %150 %163 
                                    f32_4 %165 = OpLoad %23 
                                    f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                    f32_3 %167 = OpLoad %150 
                                      f32 %168 = OpDot %166 %167 
                                                   OpStore %164 %168 
                                      f32 %170 = OpLoad %164 
                                      f32 %171 = OpFDiv %169 %170 
                                                   OpStore %164 %171 
                                      f32 %172 = OpLoad %164 
                                    f32_3 %173 = OpCompositeConstruct %172 %172 %172 
                                    f32_4 %174 = OpLoad %131 
                                    f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
                                    f32_3 %176 = OpFMul %173 %175 
                                    f32_4 %177 = OpLoad %131 
                                    f32_4 %178 = OpVectorShuffle %177 %176 4 5 6 3 
                                                   OpStore %131 %178 
                                    f32_3 %181 = OpLoad %180 
                                    f32_4 %182 = OpLoad %131 
                                    f32_3 %183 = OpVectorShuffle %182 %182 0 1 2 
                                      f32 %184 = OpDot %181 %183 
                             Private f32* %185 = OpAccessChain %131 %53 
                                                   OpStore %185 %184 
                                    f32_4 %187 = OpLoad %23 
                                    f32_3 %188 = OpVectorShuffle %187 %187 2 0 1 
                                    f32_4 %189 = OpLoad %59 
                                    f32_3 %190 = OpVectorShuffle %189 %189 1 2 0 
                                    f32_3 %191 = OpFMul %188 %190 
                                                   OpStore %186 %191 
                                    f32_4 %192 = OpLoad %23 
                                    f32_3 %193 = OpVectorShuffle %192 %192 1 2 0 
                                    f32_4 %194 = OpLoad %59 
                                    f32_3 %195 = OpVectorShuffle %194 %194 2 0 1 
                                    f32_3 %196 = OpFMul %193 %195 
                                    f32_3 %197 = OpLoad %186 
                                    f32_3 %198 = OpFNegate %197 
                                    f32_3 %199 = OpFAdd %196 %198 
                                                   OpStore %186 %199 
                                      f32 %200 = OpLoad %164 
                                    f32_3 %201 = OpCompositeConstruct %200 %200 %200 
                                    f32_3 %202 = OpLoad %186 
                                    f32_3 %203 = OpFMul %201 %202 
                                                   OpStore %186 %203 
                                      f32 %204 = OpLoad %164 
                                    f32_3 %205 = OpCompositeConstruct %204 %204 %204 
                                    f32_3 %206 = OpLoad %150 
                                    f32_3 %207 = OpFMul %205 %206 
                                                   OpStore %150 %207 
                                    f32_3 %208 = OpLoad %180 
                                    f32_3 %209 = OpLoad %150 
                                      f32 %210 = OpDot %208 %209 
                             Private f32* %211 = OpAccessChain %131 %79 
                                                   OpStore %211 %210 
                                    f32_3 %212 = OpLoad %180 
                                    f32_3 %213 = OpLoad %186 
                                      f32 %214 = OpDot %212 %213 
                             Private f32* %215 = OpAccessChain %131 %57 
                                                   OpStore %215 %214 
                                    f32_4 %216 = OpLoad %131 
                                    f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
                                    f32_4 %218 = OpLoad %131 
                                    f32_3 %219 = OpVectorShuffle %218 %218 0 1 2 
                                      f32 %220 = OpDot %217 %219 
                                                   OpStore %164 %220 
                                      f32 %221 = OpLoad %164 
                                      f32 %222 = OpExtInst %1 32 %221 
                                                   OpStore %164 %222 
                                      f32 %223 = OpLoad %164 
                                    f32_3 %224 = OpCompositeConstruct %223 %223 %223 
                                    f32_4 %225 = OpLoad %131 
                                    f32_3 %226 = OpVectorShuffle %225 %225 0 1 2 
                                    f32_3 %227 = OpFMul %224 %226 
                                    f32_4 %228 = OpLoad %131 
                                    f32_4 %229 = OpVectorShuffle %228 %227 4 5 6 3 
                                                   OpStore %131 %229 
                             Private f32* %230 = OpAccessChain %99 %79 
                                      f32 %231 = OpLoad %230 
                             Private f32* %233 = OpAccessChain %23 %232 
                                                   OpStore %233 %231 
                                    f32_4 %234 = OpLoad %23 
                                    f32_4 %237 = OpLoad %236 
                                      f32 %238 = OpDot %234 %237 
                             Private f32* %239 = OpAccessChain %23 %79 
                                                   OpStore %239 %238 
                             Private f32* %240 = OpAccessChain %99 %53 
                                      f32 %241 = OpLoad %240 
                             Private f32* %242 = OpAccessChain %59 %232 
                                                   OpStore %242 %241 
                             Private f32* %243 = OpAccessChain %99 %57 
                                      f32 %244 = OpLoad %243 
                             Private f32* %245 = OpAccessChain %52 %232 
                                                   OpStore %245 %244 
                                    f32_4 %246 = OpLoad %52 
                                    f32_4 %247 = OpLoad %236 
                                      f32 %248 = OpDot %246 %247 
                             Private f32* %249 = OpAccessChain %23 %57 
                                                   OpStore %249 %248 
                                    f32_4 %250 = OpLoad %59 
                                    f32_4 %251 = OpLoad %236 
                                      f32 %252 = OpDot %250 %251 
                             Private f32* %253 = OpAccessChain %23 %53 
                                                   OpStore %253 %252 
                                    f32_4 %254 = OpLoad %23 
                                    f32_3 %255 = OpVectorShuffle %254 %254 0 1 2 
                                    f32_3 %256 = OpFNegate %255 
                           Uniform f32_4* %263 = OpAccessChain %261 %15 
                                    f32_4 %264 = OpLoad %263 
                                    f32_3 %265 = OpVectorShuffle %264 %264 3 3 3 
                                    f32_3 %266 = OpFMul %256 %265 
                           Uniform f32_4* %267 = OpAccessChain %261 %15 
                                    f32_4 %268 = OpLoad %267 
                                    f32_3 %269 = OpVectorShuffle %268 %268 0 1 2 
                                    f32_3 %270 = OpFAdd %266 %269 
                                    f32_4 %271 = OpLoad %52 
                                    f32_4 %272 = OpVectorShuffle %271 %270 4 5 6 3 
                                                   OpStore %52 %272 
                                    f32_4 %273 = OpLoad %52 
                                    f32_3 %274 = OpVectorShuffle %273 %273 0 1 2 
                                    f32_4 %275 = OpLoad %52 
                                    f32_3 %276 = OpVectorShuffle %275 %275 0 1 2 
                                      f32 %277 = OpDot %274 %276 
                                                   OpStore %164 %277 
                                      f32 %278 = OpLoad %164 
                                      f32 %279 = OpExtInst %1 32 %278 
                                                   OpStore %164 %279 
                                      f32 %280 = OpLoad %164 
                                    f32_3 %281 = OpCompositeConstruct %280 %280 %280 
                                    f32_4 %282 = OpLoad %52 
                                    f32_3 %283 = OpVectorShuffle %282 %282 0 1 2 
                                    f32_3 %284 = OpFMul %281 %283 
                                    f32_4 %285 = OpLoad %52 
                                    f32_4 %286 = OpVectorShuffle %285 %284 4 5 6 3 
                                                   OpStore %52 %286 
                                    f32_4 %287 = OpLoad %131 
                                    f32_3 %288 = OpVectorShuffle %287 %287 0 1 2 
                                    f32_4 %289 = OpLoad %52 
                                    f32_3 %290 = OpVectorShuffle %289 %289 0 1 2 
                                      f32 %291 = OpDot %288 %290 
                                                   OpStore %164 %291 
                                      f32 %292 = OpLoad %164 
                                      f32 %293 = OpFNegate %292 
                                      f32 %294 = OpLoad %164 
                                      f32 %295 = OpFMul %293 %294 
                                      f32 %296 = OpFAdd %295 %169 
                                                   OpStore %164 %296 
                                      f32 %297 = OpLoad %164 
                                      f32 %298 = OpExtInst %1 31 %297 
                                                   OpStore %164 %298 
                                      f32 %299 = OpLoad %164 
                             Uniform f32* %301 = OpAccessChain %261 %61 %57 
                                      f32 %302 = OpLoad %301 
                                      f32 %303 = OpFMul %299 %302 
                                                   OpStore %164 %303 
                                    f32_4 %304 = OpLoad %131 
                                    f32_3 %305 = OpVectorShuffle %304 %304 0 1 2 
                                    f32_3 %306 = OpFNegate %305 
                                      f32 %307 = OpLoad %164 
                                    f32_3 %308 = OpCompositeConstruct %307 %307 %307 
                                    f32_3 %309 = OpFMul %306 %308 
                                    f32_4 %310 = OpLoad %23 
                                    f32_3 %311 = OpVectorShuffle %310 %310 0 1 2 
                                    f32_3 %312 = OpFAdd %309 %311 
                                    f32_4 %313 = OpLoad %131 
                                    f32_4 %314 = OpVectorShuffle %313 %312 4 5 6 3 
                                                   OpStore %131 %314 
                             Uniform f32* %318 = OpAccessChain %261 %61 %57 
                                      f32 %319 = OpLoad %318 
                                     bool %321 = OpFOrdNotEqual %319 %320 
                                                   OpStore %317 %321 
                                     bool %322 = OpLoad %317 
                                                   OpSelectionMerge %326 None 
                                                   OpBranchConditional %322 %325 %329 
                                          %325 = OpLabel 
                                    f32_4 %327 = OpLoad %131 
                                    f32_3 %328 = OpVectorShuffle %327 %327 0 1 2 
                                                   OpStore %324 %328 
                                                   OpBranch %326 
                                          %329 = OpLabel 
                                    f32_4 %330 = OpLoad %23 
                                    f32_3 %331 = OpVectorShuffle %330 %330 0 1 2 
                                                   OpStore %324 %331 
                                                   OpBranch %326 
                                          %326 = OpLabel 
                                    f32_3 %332 = OpLoad %324 
                                    f32_4 %333 = OpLoad %131 
                                    f32_4 %334 = OpVectorShuffle %333 %332 4 5 6 3 
                                                   OpStore %131 %334 
                                    f32_4 %335 = OpLoad %131 
                                    f32_4 %336 = OpVectorShuffle %335 %335 1 1 1 1 
                           Uniform f32_4* %337 = OpAccessChain %261 %70 %61 
                                    f32_4 %338 = OpLoad %337 
                                    f32_4 %339 = OpFMul %336 %338 
                                                   OpStore %23 %339 
                           Uniform f32_4* %340 = OpAccessChain %261 %70 %15 
                                    f32_4 %341 = OpLoad %340 
                                    f32_4 %342 = OpLoad %131 
                                    f32_4 %343 = OpVectorShuffle %342 %342 0 0 0 0 
                                    f32_4 %344 = OpFMul %341 %343 
                                    f32_4 %345 = OpLoad %23 
                                    f32_4 %346 = OpFAdd %344 %345 
                                                   OpStore %23 %346 
                           Uniform f32_4* %347 = OpAccessChain %261 %70 %70 
                                    f32_4 %348 = OpLoad %347 
                                    f32_4 %349 = OpLoad %131 
                                    f32_4 %350 = OpVectorShuffle %349 %349 2 2 2 2 
                                    f32_4 %351 = OpFMul %348 %350 
                                    f32_4 %352 = OpLoad %23 
                                    f32_4 %353 = OpFAdd %351 %352 
                                                   OpStore %131 %353 
                           Uniform f32_4* %354 = OpAccessChain %261 %70 %84 
                                    f32_4 %355 = OpLoad %354 
                                    f32_4 %356 = OpLoad %236 
                                    f32_4 %357 = OpVectorShuffle %356 %356 3 3 3 3 
                                    f32_4 %358 = OpFMul %355 %357 
                                    f32_4 %359 = OpLoad %131 
                                    f32_4 %360 = OpFAdd %358 %359 
                                                   OpStore %131 %360 
                             Private f32* %361 = OpAccessChain %131 %232 
                                      f32 %362 = OpLoad %361 
                             Private f32* %363 = OpAccessChain %131 %57 
                                      f32 %364 = OpLoad %363 
                                      f32 %365 = OpExtInst %1 37 %362 %364 
                             Private f32* %366 = OpAccessChain %23 %79 
                                                   OpStore %366 %365 
                             Private f32* %367 = OpAccessChain %131 %57 
                                      f32 %368 = OpLoad %367 
                                      f32 %369 = OpFNegate %368 
                             Private f32* %370 = OpAccessChain %23 %79 
                                      f32 %371 = OpLoad %370 
                                      f32 %372 = OpFAdd %369 %371 
                             Private f32* %373 = OpAccessChain %23 %79 
                                                   OpStore %373 %372 
                             Uniform f32* %378 = OpAccessChain %261 %61 %53 
                                      f32 %379 = OpLoad %378 
                             Private f32* %380 = OpAccessChain %23 %79 
                                      f32 %381 = OpLoad %380 
                                      f32 %382 = OpFMul %379 %381 
                             Private f32* %383 = OpAccessChain %131 %57 
                                      f32 %384 = OpLoad %383 
                                      f32 %385 = OpFAdd %382 %384 
                              Output f32* %387 = OpAccessChain %377 %15 %57 
                                                   OpStore %387 %385 
                                    f32_4 %388 = OpLoad %131 
                                    f32_3 %389 = OpVectorShuffle %388 %388 0 1 3 
                            Output f32_4* %391 = OpAccessChain %377 %15 
                                    f32_4 %392 = OpLoad %391 
                                    f32_4 %393 = OpVectorShuffle %392 %389 4 5 2 6 
                                                   OpStore %391 %393 
                              Output f32* %394 = OpAccessChain %377 %15 %53 
                                      f32 %395 = OpLoad %394 
                                      f32 %396 = OpFNegate %395 
                              Output f32* %397 = OpAccessChain %377 %15 %53 
                                                   OpStore %397 %396 
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
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec2 vs_TEXCOORD1;
layout(location = 1) out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat7.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(52 >> 2) + 0]);
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat14 = u_xlat7.x / unity_ParticleUVShiftData.y;
    u_xlat14 = floor(u_xlat14);
    u_xlat7.x = (-u_xlat14) * unity_ParticleUVShiftData.y + u_xlat7.x;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = u_xlat7.x * unity_ParticleUVShiftData.z;
    u_xlat7.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat14) * unity_ParticleUVShiftData.w + u_xlat7.x;
    u_xlat7.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb21 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat7.xy = (bool(u_xlatb21)) ? u_xlat7.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat7.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3 = in_COLOR0;
    u_xlat1.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(24 >> 2) + 0]));
    u_xlat2.z = u_xlat1.y;
    u_xlat3.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(0 >> 2) + 2]));
    u_xlat2.x = u_xlat3.z;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(12 >> 2) + 2]));
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati0].value[(36 >> 2) + 2]));
    u_xlat2.y = u_xlat7.z;
    u_xlat3.z = u_xlat1.x;
    u_xlat1.x = u_xlat3.y;
    u_xlat1.y = u_xlat7.x;
    u_xlat3.y = u_xlat7.y;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat0.xyz);
    u_xlat5.xyz = u_xlat2.yzx * u_xlat3.zxy;
    u_xlat5.xyz = u_xlat3.yzx * u_xlat2.zxy + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat5.xyz);
    u_xlat21 = float(1.0) / float(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.y = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.zxy * u_xlat3.yzx;
    u_xlat6.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat6.xyz);
    u_xlat6.xyz = vec3(u_xlat21) * u_xlat6.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, u_xlat5.xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, u_xlat6.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.w = u_xlat4.x;
    u_xlat1.x = dot(u_xlat1, in_POSITION0);
    u_xlat3.w = u_xlat4.y;
    u_xlat2.w = u_xlat4.z;
    u_xlat1.z = dot(u_xlat2, in_POSITION0);
    u_xlat1.y = dot(u_xlat3, in_POSITION0);
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
    u_xlat21 = sqrt(u_xlat21);
    u_xlat21 = u_xlat21 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat21) + u_xlat1.xyz;
    u_xlatb21 = unity_LightShadowBias.z!=0.0;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat14 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat14);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat14) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat14;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec2 vs_TEXCOORD1;
layout(location = 1) in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_1 = u_xlat16_0 * vs_TEXCOORD3.w + -0.5;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 510
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %10 %102 %134 %147 %149 %288 %342 %484 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %10 BuiltIn ViewportIndex 
                                                      OpMemberDecorate %12 0 Offset 12 
                                                      OpMemberDecorate %12 1 Offset 12 
                                                      OpDecorate %12 Block 
                                                      OpDecorate %14 DescriptorSet 14 
                                                      OpDecorate %14 Binding 14 
                                                      OpDecorate %26 ArrayStride 26 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpDecorate %28 ArrayStride 28 
                                                      OpMemberDecorate %29 0 NonWritable 
                                                      OpMemberDecorate %29 0 Offset 29 
                                                      OpDecorate %29 BufferBlock 
                                                      OpDecorate %31 DescriptorSet 31 
                                                      OpDecorate %31 Binding 31 
                                                      OpDecorate %50 ArrayStride 50 
                                                      OpMemberDecorate %51 0 Offset 51 
                                                      OpMemberDecorate %51 1 Offset 51 
                                                      OpMemberDecorate %51 2 Offset 51 
                                                      OpMemberDecorate %51 3 Offset 51 
                                                      OpMemberDecorate %51 4 Offset 51 
                                                      OpDecorate %51 Block 
                                                      OpDecorate %53 DescriptorSet 53 
                                                      OpDecorate %53 Binding 53 
                                                      OpDecorate %102 Location 102 
                                                      OpDecorate vs_TEXCOORD1 Location 134 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 147 
                                                      OpDecorate %149 RelaxedPrecision 
                                                      OpDecorate %149 Location 149 
                                                      OpDecorate %150 RelaxedPrecision 
                                                      OpDecorate %288 Location 288 
                                                      OpDecorate %342 Location 342 
                                                      OpMemberDecorate %482 0 BuiltIn 482 
                                                      OpMemberDecorate %482 1 BuiltIn 482 
                                                      OpMemberDecorate %482 2 BuiltIn 482 
                                                      OpDecorate %482 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeInt 32 1 
                                               %7 = OpTypePointer Private %6 
                                  Private i32* %8 = OpVariable Private 
                                               %9 = OpTypePointer Input %6 
                                   Input i32* %10 = OpVariable Input 
                                              %12 = OpTypeStruct %6 %6 
                                              %13 = OpTypePointer Uniform %12 
                  Uniform struct {i32; i32;}* %14 = OpVariable Uniform 
                                          i32 %15 = OpConstant 0 
                                              %16 = OpTypePointer Uniform %6 
                                              %20 = OpTypeFloat 32 
                                              %21 = OpTypeVector %20 3 
                                              %22 = OpTypePointer Private %21 
                               Private f32_3* %23 = OpVariable Private 
                                              %24 = OpTypeInt 32 0 
                                          u32 %25 = OpConstant 14 
                                              %26 = OpTypeArray %24 %25 
                                              %27 = OpTypeStruct %26 
                                              %28 = OpTypeRuntimeArray %27 
                                              %29 = OpTypeStruct %28 
                                              %30 = OpTypePointer Uniform %29 
                          Uniform struct {;}* %31 = OpVariable Uniform 
                                          i32 %33 = OpConstant 13 
                                              %34 = OpTypePointer Uniform %24 
                                          u32 %38 = OpConstant 0 
                                              %39 = OpTypePointer Private %20 
                                 Private f32* %45 = OpVariable Private 
                                              %48 = OpTypeVector %20 4 
                                          u32 %49 = OpConstant 4 
                                              %50 = OpTypeArray %48 %49 
                                              %51 = OpTypeStruct %48 %48 %50 %48 %48 
                                              %52 = OpTypePointer Uniform %51 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4; f32_4;}* %53 = OpVariable Uniform 
                                          i32 %54 = OpConstant 3 
                                          u32 %55 = OpConstant 1 
                                              %56 = OpTypePointer Uniform %20 
                                              %75 = OpTypePointer Private %48 
                               Private f32_4* %76 = OpVariable Private 
                                          u32 %79 = OpConstant 2 
                                          u32 %84 = OpConstant 3 
                                          f32 %88 = OpConstant 3.674022E-40 
                                             %100 = OpTypeVector %20 2 
                                             %101 = OpTypePointer Input %100 
                                Input f32_2* %102 = OpVariable Input 
                                             %104 = OpTypePointer Uniform %48 
                                             %114 = OpTypeBool 
                                             %115 = OpTypePointer Private %114 
                               Private bool* %116 = OpVariable Private 
                                         f32 %119 = OpConstant 3.674022E-40 
                                             %122 = OpTypePointer Function %100 
                                             %133 = OpTypePointer Output %100 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                         i32 %137 = OpConstant 4 
                                             %146 = OpTypePointer Output %48 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %148 = OpTypePointer Input %48 
                                Input f32_4* %149 = OpVariable Input 
                                         i32 %152 = OpConstant 7 
                                         i32 %157 = OpConstant 8 
                                         i32 %162 = OpConstant 6 
                              Private f32_4* %169 = OpVariable Private 
                              Private f32_4* %173 = OpVariable Private 
                                         i32 %175 = OpConstant 1 
                                         i32 %184 = OpConstant 2 
                                         i32 %203 = OpConstant 5 
                              Private f32_3* %208 = OpVariable Private 
                                         i32 %210 = OpConstant 9 
                                         i32 %215 = OpConstant 10 
                                         i32 %220 = OpConstant 11 
                              Private f32_4* %240 = OpVariable Private 
                              Private f32_3* %259 = OpVariable Private 
                                Private f32* %273 = OpVariable Private 
                                             %287 = OpTypePointer Input %21 
                                Input f32_3* %288 = OpVariable Input 
                              Private f32_3* %294 = OpVariable Private 
                                Input f32_4* %342 = OpVariable Input 
                                             %418 = OpTypePointer Function %21 
                                         f32 %468 = OpConstant 3.674022E-40 
                                             %481 = OpTypeArray %20 %55 
                                             %482 = OpTypeStruct %48 %20 %481 
                                             %483 = OpTypePointer Output %482 
        Output struct {f32_4; f32; f32[1];}* %484 = OpVariable Output 
                                             %503 = OpTypePointer Output %20 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %123 = OpVariable Function 
                             Function f32_3* %419 = OpVariable Function 
                                          i32 %11 = OpLoad %10 
                                 Uniform i32* %17 = OpAccessChain %14 %15 
                                          i32 %18 = OpLoad %17 
                                          i32 %19 = OpIAdd %11 %18 
                                                      OpStore %8 %19 
                                          i32 %32 = OpLoad %8 
                                 Uniform u32* %35 = OpAccessChain %31 %15 %32 %15 %33 
                                          u32 %36 = OpLoad %35 
                                          f32 %37 = OpBitcast %36 
                                 Private f32* %40 = OpAccessChain %23 %38 
                                                      OpStore %40 %37 
                                 Private f32* %41 = OpAccessChain %23 %38 
                                          f32 %42 = OpLoad %41 
                                          f32 %43 = OpExtInst %1 8 %42 
                                 Private f32* %44 = OpAccessChain %23 %38 
                                                      OpStore %44 %43 
                                 Private f32* %46 = OpAccessChain %23 %38 
                                          f32 %47 = OpLoad %46 
                                 Uniform f32* %57 = OpAccessChain %53 %54 %55 
                                          f32 %58 = OpLoad %57 
                                          f32 %59 = OpFDiv %47 %58 
                                                      OpStore %45 %59 
                                          f32 %60 = OpLoad %45 
                                          f32 %61 = OpExtInst %1 8 %60 
                                                      OpStore %45 %61 
                                          f32 %62 = OpLoad %45 
                                          f32 %63 = OpFNegate %62 
                                 Uniform f32* %64 = OpAccessChain %53 %54 %55 
                                          f32 %65 = OpLoad %64 
                                          f32 %66 = OpFMul %63 %65 
                                 Private f32* %67 = OpAccessChain %23 %38 
                                          f32 %68 = OpLoad %67 
                                          f32 %69 = OpFAdd %66 %68 
                                 Private f32* %70 = OpAccessChain %23 %38 
                                                      OpStore %70 %69 
                                 Private f32* %71 = OpAccessChain %23 %38 
                                          f32 %72 = OpLoad %71 
                                          f32 %73 = OpExtInst %1 8 %72 
                                 Private f32* %74 = OpAccessChain %23 %38 
                                                      OpStore %74 %73 
                                 Private f32* %77 = OpAccessChain %23 %38 
                                          f32 %78 = OpLoad %77 
                                 Uniform f32* %80 = OpAccessChain %53 %54 %79 
                                          f32 %81 = OpLoad %80 
                                          f32 %82 = OpFMul %78 %81 
                                 Private f32* %83 = OpAccessChain %76 %38 
                                                      OpStore %83 %82 
                                 Uniform f32* %85 = OpAccessChain %53 %54 %84 
                                          f32 %86 = OpLoad %85 
                                          f32 %87 = OpFNegate %86 
                                          f32 %89 = OpFAdd %87 %88 
                                 Private f32* %90 = OpAccessChain %23 %38 
                                                      OpStore %90 %89 
                                          f32 %91 = OpLoad %45 
                                          f32 %92 = OpFNegate %91 
                                 Uniform f32* %93 = OpAccessChain %53 %54 %84 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFMul %92 %94 
                                 Private f32* %96 = OpAccessChain %23 %38 
                                          f32 %97 = OpLoad %96 
                                          f32 %98 = OpFAdd %95 %97 
                                 Private f32* %99 = OpAccessChain %76 %55 
                                                      OpStore %99 %98 
                                       f32_2 %103 = OpLoad %102 
                              Uniform f32_4* %105 = OpAccessChain %53 %54 
                                       f32_4 %106 = OpLoad %105 
                                       f32_2 %107 = OpVectorShuffle %106 %106 2 3 
                                       f32_2 %108 = OpFMul %103 %107 
                                       f32_4 %109 = OpLoad %76 
                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
                                       f32_2 %111 = OpFAdd %108 %110 
                                       f32_3 %112 = OpLoad %23 
                                       f32_3 %113 = OpVectorShuffle %112 %111 3 4 2 
                                                      OpStore %23 %113 
                                Uniform f32* %117 = OpAccessChain %53 %54 %38 
                                         f32 %118 = OpLoad %117 
                                        bool %120 = OpFOrdNotEqual %118 %119 
                                                      OpStore %116 %120 
                                        bool %121 = OpLoad %116 
                                                      OpSelectionMerge %125 None 
                                                      OpBranchConditional %121 %124 %128 
                                             %124 = OpLabel 
                                       f32_3 %126 = OpLoad %23 
                                       f32_2 %127 = OpVectorShuffle %126 %126 0 1 
                                                      OpStore %123 %127 
                                                      OpBranch %125 
                                             %128 = OpLabel 
                                       f32_2 %129 = OpLoad %102 
                                                      OpStore %123 %129 
                                                      OpBranch %125 
                                             %125 = OpLabel 
                                       f32_2 %130 = OpLoad %123 
                                       f32_3 %131 = OpLoad %23 
                                       f32_3 %132 = OpVectorShuffle %131 %130 3 4 2 
                                                      OpStore %23 %132 
                                       f32_3 %135 = OpLoad %23 
                                       f32_2 %136 = OpVectorShuffle %135 %135 0 1 
                              Uniform f32_4* %138 = OpAccessChain %53 %137 
                                       f32_4 %139 = OpLoad %138 
                                       f32_2 %140 = OpVectorShuffle %139 %139 0 1 
                                       f32_2 %141 = OpFMul %136 %140 
                              Uniform f32_4* %142 = OpAccessChain %53 %137 
                                       f32_4 %143 = OpLoad %142 
                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
                                       f32_2 %145 = OpFAdd %141 %144 
                                                      OpStore vs_TEXCOORD1 %145 
                                       f32_4 %150 = OpLoad %149 
                                                      OpStore vs_TEXCOORD3 %150 
                                         i32 %151 = OpLoad %8 
                                Uniform u32* %153 = OpAccessChain %31 %15 %151 %15 %152 
                                         u32 %154 = OpLoad %153 
                                         f32 %155 = OpBitcast %154 
                                         i32 %156 = OpLoad %8 
                                Uniform u32* %158 = OpAccessChain %31 %15 %156 %15 %157 
                                         u32 %159 = OpLoad %158 
                                         f32 %160 = OpBitcast %159 
                                         i32 %161 = OpLoad %8 
                                Uniform u32* %163 = OpAccessChain %31 %15 %161 %15 %162 
                                         u32 %164 = OpLoad %163 
                                         f32 %165 = OpBitcast %164 
                                       f32_3 %166 = OpCompositeConstruct %155 %160 %165 
                                       f32_4 %167 = OpLoad %76 
                                       f32_4 %168 = OpVectorShuffle %167 %166 4 5 6 3 
                                                      OpStore %76 %168 
                                Private f32* %170 = OpAccessChain %76 %55 
                                         f32 %171 = OpLoad %170 
                                Private f32* %172 = OpAccessChain %169 %79 
                                                      OpStore %172 %171 
                                         i32 %174 = OpLoad %8 
                                Uniform u32* %176 = OpAccessChain %31 %15 %174 %15 %175 
                                         u32 %177 = OpLoad %176 
                                         f32 %178 = OpBitcast %177 
                                         i32 %179 = OpLoad %8 
                                Uniform u32* %180 = OpAccessChain %31 %15 %179 %15 %15 
                                         u32 %181 = OpLoad %180 
                                         f32 %182 = OpBitcast %181 
                                         i32 %183 = OpLoad %8 
                                Uniform u32* %185 = OpAccessChain %31 %15 %183 %15 %184 
                                         u32 %186 = OpLoad %185 
                                         f32 %187 = OpBitcast %186 
                                       f32_3 %188 = OpCompositeConstruct %178 %182 %187 
                                       f32_4 %189 = OpLoad %173 
                                       f32_4 %190 = OpVectorShuffle %189 %188 4 5 6 3 
                                                      OpStore %173 %190 
                                Private f32* %191 = OpAccessChain %173 %79 
                                         f32 %192 = OpLoad %191 
                                Private f32* %193 = OpAccessChain %169 %38 
                                                      OpStore %193 %192 
                                         i32 %194 = OpLoad %8 
                                Uniform u32* %195 = OpAccessChain %31 %15 %194 %15 %54 
                                         u32 %196 = OpLoad %195 
                                         f32 %197 = OpBitcast %196 
                                         i32 %198 = OpLoad %8 
                                Uniform u32* %199 = OpAccessChain %31 %15 %198 %15 %137 
                                         u32 %200 = OpLoad %199 
                                         f32 %201 = OpBitcast %200 
                                         i32 %202 = OpLoad %8 
                                Uniform u32* %204 = OpAccessChain %31 %15 %202 %15 %203 
                                         u32 %205 = OpLoad %204 
                                         f32 %206 = OpBitcast %205 
                                       f32_3 %207 = OpCompositeConstruct %197 %201 %206 
                                                      OpStore %23 %207 
                                         i32 %209 = OpLoad %8 
                                Uniform u32* %211 = OpAccessChain %31 %15 %209 %15 %210 
                                         u32 %212 = OpLoad %211 
                                         f32 %213 = OpBitcast %212 
                                         i32 %214 = OpLoad %8 
                                Uniform u32* %216 = OpAccessChain %31 %15 %214 %15 %215 
                                         u32 %217 = OpLoad %216 
                                         f32 %218 = OpBitcast %217 
                                         i32 %219 = OpLoad %8 
                                Uniform u32* %221 = OpAccessChain %31 %15 %219 %15 %220 
                                         u32 %222 = OpLoad %221 
                                         f32 %223 = OpBitcast %222 
                                       f32_3 %224 = OpCompositeConstruct %213 %218 %223 
                                                      OpStore %208 %224 
                                Private f32* %225 = OpAccessChain %23 %79 
                                         f32 %226 = OpLoad %225 
                                Private f32* %227 = OpAccessChain %169 %55 
                                                      OpStore %227 %226 
                                Private f32* %228 = OpAccessChain %76 %38 
                                         f32 %229 = OpLoad %228 
                                Private f32* %230 = OpAccessChain %173 %79 
                                                      OpStore %230 %229 
                                Private f32* %231 = OpAccessChain %173 %55 
                                         f32 %232 = OpLoad %231 
                                Private f32* %233 = OpAccessChain %76 %38 
                                                      OpStore %233 %232 
                                Private f32* %234 = OpAccessChain %23 %38 
                                         f32 %235 = OpLoad %234 
                                Private f32* %236 = OpAccessChain %76 %55 
                                                      OpStore %236 %235 
                                Private f32* %237 = OpAccessChain %23 %55 
                                         f32 %238 = OpLoad %237 
                                Private f32* %239 = OpAccessChain %173 %55 
                                                      OpStore %239 %238 
                                       f32_4 %241 = OpLoad %169 
                                       f32_3 %242 = OpVectorShuffle %241 %241 2 0 1 
                                       f32_4 %243 = OpLoad %76 
                                       f32_3 %244 = OpVectorShuffle %243 %243 1 2 0 
                                       f32_3 %245 = OpFMul %242 %244 
                                       f32_4 %246 = OpLoad %240 
                                       f32_4 %247 = OpVectorShuffle %246 %245 4 5 6 3 
                                                      OpStore %240 %247 
                                       f32_4 %248 = OpLoad %76 
                                       f32_3 %249 = OpVectorShuffle %248 %248 2 0 1 
                                       f32_4 %250 = OpLoad %169 
                                       f32_3 %251 = OpVectorShuffle %250 %250 1 2 0 
                                       f32_3 %252 = OpFMul %249 %251 
                                       f32_4 %253 = OpLoad %240 
                                       f32_3 %254 = OpVectorShuffle %253 %253 0 1 2 
                                       f32_3 %255 = OpFNegate %254 
                                       f32_3 %256 = OpFAdd %252 %255 
                                       f32_4 %257 = OpLoad %240 
                                       f32_4 %258 = OpVectorShuffle %257 %256 4 5 6 3 
                                                      OpStore %240 %258 
                                       f32_4 %260 = OpLoad %169 
                                       f32_3 %261 = OpVectorShuffle %260 %260 1 2 0 
                                       f32_4 %262 = OpLoad %173 
                                       f32_3 %263 = OpVectorShuffle %262 %262 2 0 1 
                                       f32_3 %264 = OpFMul %261 %263 
                                                      OpStore %259 %264 
                                       f32_4 %265 = OpLoad %173 
                                       f32_3 %266 = OpVectorShuffle %265 %265 1 2 0 
                                       f32_4 %267 = OpLoad %169 
                                       f32_3 %268 = OpVectorShuffle %267 %267 2 0 1 
                                       f32_3 %269 = OpFMul %266 %268 
                                       f32_3 %270 = OpLoad %259 
                                       f32_3 %271 = OpFNegate %270 
                                       f32_3 %272 = OpFAdd %269 %271 
                                                      OpStore %259 %272 
                                       f32_4 %274 = OpLoad %76 
                                       f32_3 %275 = OpVectorShuffle %274 %274 0 1 2 
                                       f32_3 %276 = OpLoad %259 
                                         f32 %277 = OpDot %275 %276 
                                                      OpStore %273 %277 
                                         f32 %278 = OpLoad %273 
                                         f32 %279 = OpFDiv %88 %278 
                                                      OpStore %273 %279 
                                         f32 %280 = OpLoad %273 
                                       f32_3 %281 = OpCompositeConstruct %280 %280 %280 
                                       f32_4 %282 = OpLoad %240 
                                       f32_3 %283 = OpVectorShuffle %282 %282 0 1 2 
                                       f32_3 %284 = OpFMul %281 %283 
                                       f32_4 %285 = OpLoad %240 
                                       f32_4 %286 = OpVectorShuffle %285 %284 4 5 6 3 
                                                      OpStore %240 %286 
                                       f32_3 %289 = OpLoad %288 
                                       f32_4 %290 = OpLoad %240 
                                       f32_3 %291 = OpVectorShuffle %290 %290 0 1 2 
                                         f32 %292 = OpDot %289 %291 
                                Private f32* %293 = OpAccessChain %240 %55 
                                                      OpStore %293 %292 
                                       f32_4 %295 = OpLoad %76 
                                       f32_3 %296 = OpVectorShuffle %295 %295 2 0 1 
                                       f32_4 %297 = OpLoad %173 
                                       f32_3 %298 = OpVectorShuffle %297 %297 1 2 0 
                                       f32_3 %299 = OpFMul %296 %298 
                                                      OpStore %294 %299 
                                       f32_4 %300 = OpLoad %76 
                                       f32_3 %301 = OpVectorShuffle %300 %300 1 2 0 
                                       f32_4 %302 = OpLoad %173 
                                       f32_3 %303 = OpVectorShuffle %302 %302 2 0 1 
                                       f32_3 %304 = OpFMul %301 %303 
                                       f32_3 %305 = OpLoad %294 
                                       f32_3 %306 = OpFNegate %305 
                                       f32_3 %307 = OpFAdd %304 %306 
                                                      OpStore %294 %307 
                                         f32 %308 = OpLoad %273 
                                       f32_3 %309 = OpCompositeConstruct %308 %308 %308 
                                       f32_3 %310 = OpLoad %294 
                                       f32_3 %311 = OpFMul %309 %310 
                                                      OpStore %294 %311 
                                         f32 %312 = OpLoad %273 
                                       f32_3 %313 = OpCompositeConstruct %312 %312 %312 
                                       f32_3 %314 = OpLoad %259 
                                       f32_3 %315 = OpFMul %313 %314 
                                                      OpStore %259 %315 
                                       f32_3 %316 = OpLoad %288 
                                       f32_3 %317 = OpLoad %259 
                                         f32 %318 = OpDot %316 %317 
                                Private f32* %319 = OpAccessChain %240 %38 
                                                      OpStore %319 %318 
                                       f32_3 %320 = OpLoad %288 
                                       f32_3 %321 = OpLoad %294 
                                         f32 %322 = OpDot %320 %321 
                                Private f32* %323 = OpAccessChain %240 %79 
                                                      OpStore %323 %322 
                                       f32_4 %324 = OpLoad %240 
                                       f32_3 %325 = OpVectorShuffle %324 %324 0 1 2 
                                       f32_4 %326 = OpLoad %240 
                                       f32_3 %327 = OpVectorShuffle %326 %326 0 1 2 
                                         f32 %328 = OpDot %325 %327 
                                                      OpStore %273 %328 
                                         f32 %329 = OpLoad %273 
                                         f32 %330 = OpExtInst %1 32 %329 
                                                      OpStore %273 %330 
                                         f32 %331 = OpLoad %273 
                                       f32_3 %332 = OpCompositeConstruct %331 %331 %331 
                                       f32_4 %333 = OpLoad %240 
                                       f32_3 %334 = OpVectorShuffle %333 %333 0 1 2 
                                       f32_3 %335 = OpFMul %332 %334 
                                       f32_4 %336 = OpLoad %240 
                                       f32_4 %337 = OpVectorShuffle %336 %335 4 5 6 3 
                                                      OpStore %240 %337 
                                Private f32* %338 = OpAccessChain %208 %38 
                                         f32 %339 = OpLoad %338 
                                Private f32* %340 = OpAccessChain %76 %84 
                                                      OpStore %340 %339 
                                       f32_4 %341 = OpLoad %76 
                                       f32_4 %343 = OpLoad %342 
                                         f32 %344 = OpDot %341 %343 
                                Private f32* %345 = OpAccessChain %76 %38 
                                                      OpStore %345 %344 
                                Private f32* %346 = OpAccessChain %208 %55 
                                         f32 %347 = OpLoad %346 
                                Private f32* %348 = OpAccessChain %173 %84 
                                                      OpStore %348 %347 
                                Private f32* %349 = OpAccessChain %208 %79 
                                         f32 %350 = OpLoad %349 
                                Private f32* %351 = OpAccessChain %169 %84 
                                                      OpStore %351 %350 
                                       f32_4 %352 = OpLoad %169 
                                       f32_4 %353 = OpLoad %342 
                                         f32 %354 = OpDot %352 %353 
                                Private f32* %355 = OpAccessChain %76 %79 
                                                      OpStore %355 %354 
                                       f32_4 %356 = OpLoad %173 
                                       f32_4 %357 = OpLoad %342 
                                         f32 %358 = OpDot %356 %357 
                                Private f32* %359 = OpAccessChain %76 %55 
                                                      OpStore %359 %358 
                                       f32_4 %360 = OpLoad %76 
                                       f32_3 %361 = OpVectorShuffle %360 %360 0 1 2 
                                       f32_3 %362 = OpFNegate %361 
                              Uniform f32_4* %363 = OpAccessChain %53 %15 
                                       f32_4 %364 = OpLoad %363 
                                       f32_3 %365 = OpVectorShuffle %364 %364 3 3 3 
                                       f32_3 %366 = OpFMul %362 %365 
                              Uniform f32_4* %367 = OpAccessChain %53 %15 
                                       f32_4 %368 = OpLoad %367 
                                       f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                       f32_3 %370 = OpFAdd %366 %369 
                                       f32_4 %371 = OpLoad %169 
                                       f32_4 %372 = OpVectorShuffle %371 %370 4 5 6 3 
                                                      OpStore %169 %372 
                                       f32_4 %373 = OpLoad %169 
                                       f32_3 %374 = OpVectorShuffle %373 %373 0 1 2 
                                       f32_4 %375 = OpLoad %169 
                                       f32_3 %376 = OpVectorShuffle %375 %375 0 1 2 
                                         f32 %377 = OpDot %374 %376 
                                                      OpStore %273 %377 
                                         f32 %378 = OpLoad %273 
                                         f32 %379 = OpExtInst %1 32 %378 
                                                      OpStore %273 %379 
                                         f32 %380 = OpLoad %273 
                                       f32_3 %381 = OpCompositeConstruct %380 %380 %380 
                                       f32_4 %382 = OpLoad %169 
                                       f32_3 %383 = OpVectorShuffle %382 %382 0 1 2 
                                       f32_3 %384 = OpFMul %381 %383 
                                       f32_4 %385 = OpLoad %169 
                                       f32_4 %386 = OpVectorShuffle %385 %384 4 5 6 3 
                                                      OpStore %169 %386 
                                       f32_4 %387 = OpLoad %240 
                                       f32_3 %388 = OpVectorShuffle %387 %387 0 1 2 
                                       f32_4 %389 = OpLoad %169 
                                       f32_3 %390 = OpVectorShuffle %389 %389 0 1 2 
                                         f32 %391 = OpDot %388 %390 
                                                      OpStore %273 %391 
                                         f32 %392 = OpLoad %273 
                                         f32 %393 = OpFNegate %392 
                                         f32 %394 = OpLoad %273 
                                         f32 %395 = OpFMul %393 %394 
                                         f32 %396 = OpFAdd %395 %88 
                                                      OpStore %273 %396 
                                         f32 %397 = OpLoad %273 
                                         f32 %398 = OpExtInst %1 31 %397 
                                                      OpStore %273 %398 
                                         f32 %399 = OpLoad %273 
                                Uniform f32* %400 = OpAccessChain %53 %175 %79 
                                         f32 %401 = OpLoad %400 
                                         f32 %402 = OpFMul %399 %401 
                                                      OpStore %273 %402 
                                       f32_4 %403 = OpLoad %240 
                                       f32_3 %404 = OpVectorShuffle %403 %403 0 1 2 
                                       f32_3 %405 = OpFNegate %404 
                                         f32 %406 = OpLoad %273 
                                       f32_3 %407 = OpCompositeConstruct %406 %406 %406 
                                       f32_3 %408 = OpFMul %405 %407 
                                       f32_4 %409 = OpLoad %76 
                                       f32_3 %410 = OpVectorShuffle %409 %409 0 1 2 
                                       f32_3 %411 = OpFAdd %408 %410 
                                       f32_4 %412 = OpLoad %240 
                                       f32_4 %413 = OpVectorShuffle %412 %411 4 5 6 3 
                                                      OpStore %240 %413 
                                Uniform f32* %414 = OpAccessChain %53 %175 %79 
                                         f32 %415 = OpLoad %414 
                                        bool %416 = OpFOrdNotEqual %415 %119 
                                                      OpStore %116 %416 
                                        bool %417 = OpLoad %116 
                                                      OpSelectionMerge %421 None 
                                                      OpBranchConditional %417 %420 %424 
                                             %420 = OpLabel 
                                       f32_4 %422 = OpLoad %240 
                                       f32_3 %423 = OpVectorShuffle %422 %422 0 1 2 
                                                      OpStore %419 %423 
                                                      OpBranch %421 
                                             %424 = OpLabel 
                                       f32_4 %425 = OpLoad %76 
                                       f32_3 %426 = OpVectorShuffle %425 %425 0 1 2 
                                                      OpStore %419 %426 
                                                      OpBranch %421 
                                             %421 = OpLabel 
                                       f32_3 %427 = OpLoad %419 
                                       f32_4 %428 = OpLoad %240 
                                       f32_4 %429 = OpVectorShuffle %428 %427 4 5 6 3 
                                                      OpStore %240 %429 
                                       f32_4 %430 = OpLoad %240 
                                       f32_4 %431 = OpVectorShuffle %430 %430 1 1 1 1 
                              Uniform f32_4* %432 = OpAccessChain %53 %184 %175 
                                       f32_4 %433 = OpLoad %432 
                                       f32_4 %434 = OpFMul %431 %433 
                                                      OpStore %76 %434 
                              Uniform f32_4* %435 = OpAccessChain %53 %184 %15 
                                       f32_4 %436 = OpLoad %435 
                                       f32_4 %437 = OpLoad %240 
                                       f32_4 %438 = OpVectorShuffle %437 %437 0 0 0 0 
                                       f32_4 %439 = OpFMul %436 %438 
                                       f32_4 %440 = OpLoad %76 
                                       f32_4 %441 = OpFAdd %439 %440 
                                                      OpStore %76 %441 
                              Uniform f32_4* %442 = OpAccessChain %53 %184 %184 
                                       f32_4 %443 = OpLoad %442 
                                       f32_4 %444 = OpLoad %240 
                                       f32_4 %445 = OpVectorShuffle %444 %444 2 2 2 2 
                                       f32_4 %446 = OpFMul %443 %445 
                                       f32_4 %447 = OpLoad %76 
                                       f32_4 %448 = OpFAdd %446 %447 
                                                      OpStore %240 %448 
                              Uniform f32_4* %449 = OpAccessChain %53 %184 %54 
                                       f32_4 %450 = OpLoad %449 
                                       f32_4 %451 = OpLoad %342 
                                       f32_4 %452 = OpVectorShuffle %451 %451 3 3 3 3 
                                       f32_4 %453 = OpFMul %450 %452 
                                       f32_4 %454 = OpLoad %240 
                                       f32_4 %455 = OpFAdd %453 %454 
                                                      OpStore %240 %455 
                                Uniform f32* %456 = OpAccessChain %53 %175 %38 
                                         f32 %457 = OpLoad %456 
                                Private f32* %458 = OpAccessChain %240 %84 
                                         f32 %459 = OpLoad %458 
                                         f32 %460 = OpFDiv %457 %459 
                                Private f32* %461 = OpAccessChain %76 %38 
                                                      OpStore %461 %460 
                                Private f32* %462 = OpAccessChain %76 %38 
                                         f32 %463 = OpLoad %462 
                                         f32 %464 = OpExtInst %1 37 %463 %119 
                                Private f32* %465 = OpAccessChain %76 %38 
                                                      OpStore %465 %464 
                                Private f32* %466 = OpAccessChain %76 %38 
                                         f32 %467 = OpLoad %466 
                                         f32 %469 = OpExtInst %1 40 %467 %468 
                                Private f32* %470 = OpAccessChain %76 %38 
                                                      OpStore %470 %469 
                                Private f32* %471 = OpAccessChain %240 %79 
                                         f32 %472 = OpLoad %471 
                                Private f32* %473 = OpAccessChain %76 %38 
                                         f32 %474 = OpLoad %473 
                                         f32 %475 = OpFAdd %472 %474 
                                                      OpStore %45 %475 
                                Private f32* %476 = OpAccessChain %240 %84 
                                         f32 %477 = OpLoad %476 
                                         f32 %478 = OpLoad %45 
                                         f32 %479 = OpExtInst %1 37 %477 %478 
                                Private f32* %480 = OpAccessChain %76 %38 
                                                      OpStore %480 %479 
                                       f32_4 %485 = OpLoad %240 
                                       f32_3 %486 = OpVectorShuffle %485 %485 0 1 3 
                               Output f32_4* %487 = OpAccessChain %484 %15 
                                       f32_4 %488 = OpLoad %487 
                                       f32_4 %489 = OpVectorShuffle %488 %486 4 5 2 6 
                                                      OpStore %487 %489 
                                         f32 %490 = OpLoad %45 
                                         f32 %491 = OpFNegate %490 
                                Private f32* %492 = OpAccessChain %76 %38 
                                         f32 %493 = OpLoad %492 
                                         f32 %494 = OpFAdd %491 %493 
                                Private f32* %495 = OpAccessChain %240 %38 
                                                      OpStore %495 %494 
                                Uniform f32* %496 = OpAccessChain %53 %175 %55 
                                         f32 %497 = OpLoad %496 
                                Private f32* %498 = OpAccessChain %240 %38 
                                         f32 %499 = OpLoad %498 
                                         f32 %500 = OpFMul %497 %499 
                                         f32 %501 = OpLoad %45 
                                         f32 %502 = OpFAdd %500 %501 
                                 Output f32* %504 = OpAccessChain %484 %15 %79 
                                                      OpStore %504 %502 
                                 Output f32* %505 = OpAccessChain %484 %15 %55 
                                         f32 %506 = OpLoad %505 
                                         f32 %507 = OpFNegate %506 
                                 Output f32* %508 = OpAccessChain %484 %15 %55 
                                                      OpStore %508 %507 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 59
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %21 %31 %56 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                             OpDecorate %8 RelaxedPrecision 
                                             OpDecorate %11 RelaxedPrecision 
                                             OpDecorate %11 DescriptorSet 11 
                                             OpDecorate %11 Binding 11 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %15 RelaxedPrecision 
                                             OpDecorate %15 DescriptorSet 15 
                                             OpDecorate %15 Binding 15 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 21 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD3 Location 31 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %41 RelaxedPrecision 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %56 Location 56 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypePointer Private %6 
                         Private f32* %8 = OpVariable Private 
                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %10 = OpTypePointer UniformConstant %9 
UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
                                     %13 = OpTypeSampler 
                                     %14 = OpTypePointer UniformConstant %13 
            UniformConstant sampler* %15 = OpVariable UniformConstant 
                                     %17 = OpTypeSampledImage %9 
                                     %19 = OpTypeVector %6 2 
                                     %20 = OpTypePointer Input %19 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %23 = OpTypeVector %6 4 
                                     %25 = OpTypeInt 32 0 
                                 u32 %26 = OpConstant 3 
                        Private f32* %28 = OpVariable Private 
                                     %30 = OpTypePointer Input %23 
               Input f32_4* vs_TEXCOORD3 = OpVariable Input 
                                     %32 = OpTypePointer Input %6 
                                 f32 %36 = OpConstant 3.674022E-40 
                                     %38 = OpTypeBool 
                                     %39 = OpTypePointer Private %38 
                       Private bool* %40 = OpVariable Private 
                                 f32 %42 = OpConstant 3.674022E-40 
                                     %45 = OpTypeInt 32 1 
                                 i32 %46 = OpConstant 0 
                                 i32 %47 = OpConstant 1 
                                 i32 %49 = OpConstant -1 
                                     %55 = OpTypePointer Output %23 
                       Output f32_4* %56 = OpVariable Output 
                               f32_4 %57 = OpConstantComposite %42 %42 %42 %42 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %12 = OpLoad %11 
                             sampler %16 = OpLoad %15 
          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
                               f32_2 %22 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %18 %22 
                                 f32 %27 = OpCompositeExtract %24 3 
                                             OpStore %8 %27 
                                 f32 %29 = OpLoad %8 
                          Input f32* %33 = OpAccessChain vs_TEXCOORD3 %26 
                                 f32 %34 = OpLoad %33 
                                 f32 %35 = OpFMul %29 %34 
                                 f32 %37 = OpFAdd %35 %36 
                                             OpStore %28 %37 
                                 f32 %41 = OpLoad %28 
                                bool %43 = OpFOrdLessThan %41 %42 
                                             OpStore %40 %43 
                                bool %44 = OpLoad %40 
                                 i32 %48 = OpSelect %44 %47 %46 
                                 i32 %50 = OpIMul %48 %49 
                                bool %51 = OpINotEqual %50 %46 
                                             OpSelectionMerge %53 None 
                                             OpBranchConditional %51 %52 %53 
                                     %52 = OpLabel 
                                             OpKill
                                     %53 = OpLabel 
                                             OpStore %56 %57 
                                             OpReturn
                                             OpFunctionEnd
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "vulkan " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "vulkan " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_CUBE" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SHADOWS_DEPTH" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
}
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderType" = "Opaque" }
  Blend Zero Zero, Zero Zero
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 253844
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
; Bound: 105
; Schema: 0
                                                     OpCapability Shader 
                                              %1 = OpExtInstImport "GLSL.std.450" 
                                                     OpMemoryModel Logical GLSL450 
                                                     OpEntryPoint Vertex %4 "main" %11 %72 %82 %83 %87 %89 
                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                     OpDecorate %11 Location 11 
                                                     OpDecorate %16 ArrayStride 16 
                                                     OpDecorate %17 ArrayStride 17 
                                                     OpMemberDecorate %18 0 Offset 18 
                                                     OpMemberDecorate %18 1 Offset 18 
                                                     OpMemberDecorate %18 2 Offset 18 
                                                     OpDecorate %18 Block 
                                                     OpDecorate %20 DescriptorSet 20 
                                                     OpDecorate %20 Binding 20 
                                                     OpMemberDecorate %70 0 BuiltIn 70 
                                                     OpMemberDecorate %70 1 BuiltIn 70 
                                                     OpMemberDecorate %70 2 BuiltIn 70 
                                                     OpDecorate %70 Block 
                                                     OpDecorate %82 Location 82 
                                                     OpDecorate %83 RelaxedPrecision 
                                                     OpDecorate %83 Location 83 
                                                     OpDecorate %84 RelaxedPrecision 
                                                     OpDecorate vs_TEXCOORD1 Location 87 
                                                     OpDecorate %89 Location 89 
                                              %2 = OpTypeVoid 
                                              %3 = OpTypeFunction %2 
                                              %6 = OpTypeFloat 32 
                                              %7 = OpTypeVector %6 4 
                                              %8 = OpTypePointer Private %7 
                               Private f32_4* %9 = OpVariable Private 
                                             %10 = OpTypePointer Input %7 
                                Input f32_4* %11 = OpVariable Input 
                                             %14 = OpTypeInt 32 0 
                                         u32 %15 = OpConstant 4 
                                             %16 = OpTypeArray %7 %15 
                                             %17 = OpTypeArray %7 %15 
                                             %18 = OpTypeStruct %16 %17 %7 
                                             %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
                                             %21 = OpTypeInt 32 1 
                                         i32 %22 = OpConstant 0 
                                         i32 %23 = OpConstant 1 
                                             %24 = OpTypePointer Uniform %7 
                                         i32 %35 = OpConstant 2 
                                         i32 %44 = OpConstant 3 
                              Private f32_4* %48 = OpVariable Private 
                                         u32 %68 = OpConstant 1 
                                             %69 = OpTypeArray %6 %68 
                                             %70 = OpTypeStruct %7 %6 %69 
                                             %71 = OpTypePointer Output %70 
        Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
                                             %80 = OpTypePointer Output %7 
                               Output f32_4* %82 = OpVariable Output 
                                Input f32_4* %83 = OpVariable Input 
                                             %85 = OpTypeVector %6 2 
                                             %86 = OpTypePointer Output %85 
                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %88 = OpTypePointer Input %85 
                                Input f32_2* %89 = OpVariable Input 
                                             %99 = OpTypePointer Output %6 
                                         void %4 = OpFunction None %3 
                                              %5 = OpLabel 
                                       f32_4 %12 = OpLoad %11 
                                       f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                              Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                       f32_4 %26 = OpLoad %25 
                                       f32_4 %27 = OpFMul %13 %26 
                                                     OpStore %9 %27 
                              Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                       f32_4 %29 = OpLoad %28 
                                       f32_4 %30 = OpLoad %11 
                                       f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                       f32_4 %32 = OpFMul %29 %31 
                                       f32_4 %33 = OpLoad %9 
                                       f32_4 %34 = OpFAdd %32 %33 
                                                     OpStore %9 %34 
                              Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                       f32_4 %37 = OpLoad %36 
                                       f32_4 %38 = OpLoad %11 
                                       f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                       f32_4 %40 = OpFMul %37 %39 
                                       f32_4 %41 = OpLoad %9 
                                       f32_4 %42 = OpFAdd %40 %41 
                                                     OpStore %9 %42 
                                       f32_4 %43 = OpLoad %9 
                              Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                       f32_4 %46 = OpLoad %45 
                                       f32_4 %47 = OpFAdd %43 %46 
                                                     OpStore %9 %47 
                                       f32_4 %49 = OpLoad %9 
                                       f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                              Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                       f32_4 %52 = OpLoad %51 
                                       f32_4 %53 = OpFMul %50 %52 
                                                     OpStore %48 %53 
                              Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                       f32_4 %55 = OpLoad %54 
                                       f32_4 %56 = OpLoad %9 
                                       f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                       f32_4 %58 = OpFMul %55 %57 
                                       f32_4 %59 = OpLoad %48 
                                       f32_4 %60 = OpFAdd %58 %59 
                                                     OpStore %48 %60 
                              Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                       f32_4 %62 = OpLoad %61 
                                       f32_4 %63 = OpLoad %9 
                                       f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                       f32_4 %65 = OpFMul %62 %64 
                                       f32_4 %66 = OpLoad %48 
                                       f32_4 %67 = OpFAdd %65 %66 
                                                     OpStore %48 %67 
                              Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
                                       f32_4 %74 = OpLoad %73 
                                       f32_4 %75 = OpLoad %9 
                                       f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
                                       f32_4 %77 = OpFMul %74 %76 
                                       f32_4 %78 = OpLoad %48 
                                       f32_4 %79 = OpFAdd %77 %78 
                               Output f32_4* %81 = OpAccessChain %72 %22 
                                                     OpStore %81 %79 
                                       f32_4 %84 = OpLoad %83 
                                                     OpStore %82 %84 
                                       f32_2 %90 = OpLoad %89 
                              Uniform f32_4* %91 = OpAccessChain %20 %35 
                                       f32_4 %92 = OpLoad %91 
                                       f32_2 %93 = OpVectorShuffle %92 %92 0 1 
                                       f32_2 %94 = OpFMul %90 %93 
                              Uniform f32_4* %95 = OpAccessChain %20 %35 
                                       f32_4 %96 = OpLoad %95 
                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
                                       f32_2 %98 = OpFAdd %94 %97 
                                                     OpStore vs_TEXCOORD1 %98 
                                Output f32* %100 = OpAccessChain %72 %22 %68 
                                        f32 %101 = OpLoad %100 
                                        f32 %102 = OpFNegate %101 
                                Output f32* %103 = OpAccessChain %72 %22 %68 
                                                     OpStore %103 %102 
                                                     OpReturn
                                                     OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 57
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %47 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %47 Location 47 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 
                                     %30 = OpTypePointer Uniform %29 
            Uniform struct {f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 0 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                     %46 = OpTypePointer Output %24 
                       Output f32_4* %47 = OpVariable Output 
                                 f32 %51 = OpConstant 3.674022E-40 
                                     %52 = OpTypeInt 32 0 
                                 u32 %53 = OpConstant 3 
                                     %54 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                                             OpStore %39 %45 
                               f32_3 %48 = OpLoad %39 
                               f32_4 %49 = OpLoad %47 
                               f32_4 %50 = OpVectorShuffle %49 %48 4 5 6 3 
                                             OpStore %47 %50 
                         Output f32* %55 = OpAccessChain %47 %53 
                                             OpStore %55 %51 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 105
; Schema: 0
                                                     OpCapability Shader 
                                              %1 = OpExtInstImport "GLSL.std.450" 
                                                     OpMemoryModel Logical GLSL450 
                                                     OpEntryPoint Vertex %4 "main" %11 %72 %82 %83 %87 %89 
                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                     OpDecorate %11 Location 11 
                                                     OpDecorate %16 ArrayStride 16 
                                                     OpDecorate %17 ArrayStride 17 
                                                     OpMemberDecorate %18 0 Offset 18 
                                                     OpMemberDecorate %18 1 Offset 18 
                                                     OpMemberDecorate %18 2 Offset 18 
                                                     OpDecorate %18 Block 
                                                     OpDecorate %20 DescriptorSet 20 
                                                     OpDecorate %20 Binding 20 
                                                     OpMemberDecorate %70 0 BuiltIn 70 
                                                     OpMemberDecorate %70 1 BuiltIn 70 
                                                     OpMemberDecorate %70 2 BuiltIn 70 
                                                     OpDecorate %70 Block 
                                                     OpDecorate %82 Location 82 
                                                     OpDecorate %83 RelaxedPrecision 
                                                     OpDecorate %83 Location 83 
                                                     OpDecorate %84 RelaxedPrecision 
                                                     OpDecorate vs_TEXCOORD1 Location 87 
                                                     OpDecorate %89 Location 89 
                                              %2 = OpTypeVoid 
                                              %3 = OpTypeFunction %2 
                                              %6 = OpTypeFloat 32 
                                              %7 = OpTypeVector %6 4 
                                              %8 = OpTypePointer Private %7 
                               Private f32_4* %9 = OpVariable Private 
                                             %10 = OpTypePointer Input %7 
                                Input f32_4* %11 = OpVariable Input 
                                             %14 = OpTypeInt 32 0 
                                         u32 %15 = OpConstant 4 
                                             %16 = OpTypeArray %7 %15 
                                             %17 = OpTypeArray %7 %15 
                                             %18 = OpTypeStruct %16 %17 %7 
                                             %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
                                             %21 = OpTypeInt 32 1 
                                         i32 %22 = OpConstant 0 
                                         i32 %23 = OpConstant 1 
                                             %24 = OpTypePointer Uniform %7 
                                         i32 %35 = OpConstant 2 
                                         i32 %44 = OpConstant 3 
                              Private f32_4* %48 = OpVariable Private 
                                         u32 %68 = OpConstant 1 
                                             %69 = OpTypeArray %6 %68 
                                             %70 = OpTypeStruct %7 %6 %69 
                                             %71 = OpTypePointer Output %70 
        Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
                                             %80 = OpTypePointer Output %7 
                               Output f32_4* %82 = OpVariable Output 
                                Input f32_4* %83 = OpVariable Input 
                                             %85 = OpTypeVector %6 2 
                                             %86 = OpTypePointer Output %85 
                      Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %88 = OpTypePointer Input %85 
                                Input f32_2* %89 = OpVariable Input 
                                             %99 = OpTypePointer Output %6 
                                         void %4 = OpFunction None %3 
                                              %5 = OpLabel 
                                       f32_4 %12 = OpLoad %11 
                                       f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                              Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                       f32_4 %26 = OpLoad %25 
                                       f32_4 %27 = OpFMul %13 %26 
                                                     OpStore %9 %27 
                              Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                       f32_4 %29 = OpLoad %28 
                                       f32_4 %30 = OpLoad %11 
                                       f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                       f32_4 %32 = OpFMul %29 %31 
                                       f32_4 %33 = OpLoad %9 
                                       f32_4 %34 = OpFAdd %32 %33 
                                                     OpStore %9 %34 
                              Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                       f32_4 %37 = OpLoad %36 
                                       f32_4 %38 = OpLoad %11 
                                       f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                       f32_4 %40 = OpFMul %37 %39 
                                       f32_4 %41 = OpLoad %9 
                                       f32_4 %42 = OpFAdd %40 %41 
                                                     OpStore %9 %42 
                                       f32_4 %43 = OpLoad %9 
                              Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                       f32_4 %46 = OpLoad %45 
                                       f32_4 %47 = OpFAdd %43 %46 
                                                     OpStore %9 %47 
                                       f32_4 %49 = OpLoad %9 
                                       f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                              Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                       f32_4 %52 = OpLoad %51 
                                       f32_4 %53 = OpFMul %50 %52 
                                                     OpStore %48 %53 
                              Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                       f32_4 %55 = OpLoad %54 
                                       f32_4 %56 = OpLoad %9 
                                       f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                       f32_4 %58 = OpFMul %55 %57 
                                       f32_4 %59 = OpLoad %48 
                                       f32_4 %60 = OpFAdd %58 %59 
                                                     OpStore %48 %60 
                              Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                       f32_4 %62 = OpLoad %61 
                                       f32_4 %63 = OpLoad %9 
                                       f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                       f32_4 %65 = OpFMul %62 %64 
                                       f32_4 %66 = OpLoad %48 
                                       f32_4 %67 = OpFAdd %65 %66 
                                                     OpStore %48 %67 
                              Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
                                       f32_4 %74 = OpLoad %73 
                                       f32_4 %75 = OpLoad %9 
                                       f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
                                       f32_4 %77 = OpFMul %74 %76 
                                       f32_4 %78 = OpLoad %48 
                                       f32_4 %79 = OpFAdd %77 %78 
                               Output f32_4* %81 = OpAccessChain %72 %22 
                                                     OpStore %81 %79 
                                       f32_4 %84 = OpLoad %83 
                                                     OpStore %82 %84 
                                       f32_2 %90 = OpLoad %89 
                              Uniform f32_4* %91 = OpAccessChain %20 %35 
                                       f32_4 %92 = OpLoad %91 
                                       f32_2 %93 = OpVectorShuffle %92 %92 0 1 
                                       f32_2 %94 = OpFMul %90 %93 
                              Uniform f32_4* %95 = OpAccessChain %20 %35 
                                       f32_4 %96 = OpLoad %95 
                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
                                       f32_2 %98 = OpFAdd %94 %97 
                                                     OpStore vs_TEXCOORD1 %98 
                                Output f32* %100 = OpAccessChain %72 %22 %68 
                                        f32 %101 = OpLoad %100 
                                        f32 %102 = OpFNegate %101 
                                Output f32* %103 = OpAccessChain %72 %22 %68 
                                                     OpStore %103 %102 
                                                     OpReturn
                                                     OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 46
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %39 %43 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpMemberDecorate %27 0 RelaxedPrecision 
                                             OpMemberDecorate %27 0 Offset 27 
                                             OpDecorate %27 Block 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %39 Location 39 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %43 Location 43 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypeVector %6 4 
                                      %8 = OpTypePointer Private %7 
                       Private f32_4* %9 = OpVariable Private 
                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %11 = OpTypePointer UniformConstant %10 
UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                     %14 = OpTypeSampler 
                                     %15 = OpTypePointer UniformConstant %14 
            UniformConstant sampler* %16 = OpVariable UniformConstant 
                                     %18 = OpTypeSampledImage %10 
                                     %20 = OpTypeVector %6 2 
                                     %21 = OpTypePointer Input %20 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %25 = OpVariable Private 
                                     %27 = OpTypeStruct %7 
                                     %28 = OpTypePointer Uniform %27 
            Uniform struct {f32_4;}* %29 = OpVariable Uniform 
                                     %30 = OpTypeInt 32 1 
                                 i32 %31 = OpConstant 0 
                                     %32 = OpTypePointer Uniform %7 
                      Private f32_4* %36 = OpVariable Private 
                                     %38 = OpTypePointer Input %7 
                        Input f32_4* %39 = OpVariable Input 
                                     %42 = OpTypePointer Output %7 
                       Output f32_4* %43 = OpVariable Output 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                             OpStore %9 %24 
                               f32_4 %26 = OpLoad %9 
                      Uniform f32_4* %33 = OpAccessChain %29 %31 
                               f32_4 %34 = OpLoad %33 
                               f32_4 %35 = OpFMul %26 %34 
                                             OpStore %25 %35 
                               f32_4 %37 = OpLoad %25 
                               f32_4 %40 = OpLoad %39 
                               f32_4 %41 = OpFMul %37 %40 
                                             OpStore %36 %41 
                               f32_4 %44 = OpLoad %36 
                                             OpStore %43 %44 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 359
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %208 %215 %266 %312 %342 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %157 ArrayStride 157 
                                                      OpMemberDecorate %158 0 Offset 158 
                                                      OpMemberDecorate %158 1 Offset 158 
                                                      OpMemberDecorate %158 2 Offset 158 
                                                      OpMemberDecorate %158 3 Offset 158 
                                                      OpDecorate %158 Block 
                                                      OpDecorate %160 DescriptorSet 160 
                                                      OpDecorate %160 Binding 160 
                                                      OpMemberDecorate %206 0 BuiltIn 206 
                                                      OpMemberDecorate %206 1 BuiltIn 206 
                                                      OpMemberDecorate %206 2 BuiltIn 206 
                                                      OpDecorate %206 Block 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %215 Location 215 
                                                      OpDecorate %216 RelaxedPrecision 
                                                      OpDecorate %219 RelaxedPrecision 
                                                      OpDecorate %266 Location 266 
                                                      OpDecorate %312 Location 312 
                                                      OpDecorate vs_TEXCOORD1 Location 342 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                                             %134 = OpTypeVector %6 2 
                                             %135 = OpTypePointer Private %134 
                              Private f32_2* %136 = OpVariable Private 
                                         i32 %138 = OpConstant 13 
                                Private f32* %150 = OpVariable Private 
                                         u32 %156 = OpConstant 4 
                                             %157 = OpTypeArray %7 %156 
                                             %158 = OpTypeStruct %157 %7 %6 %7 
                                             %159 = OpTypePointer Uniform %158 
Uniform struct {f32_4[4]; f32_4; f32; f32_4;}* %160 = OpVariable Uniform 
                                             %161 = OpTypePointer Uniform %7 
                                             %205 = OpTypeArray %6 %89 
                                             %206 = OpTypeStruct %7 %6 %205 
                                             %207 = OpTypePointer Output %206 
        Output struct {f32_4; f32; f32[1];}* %208 = OpVariable Output 
                                             %213 = OpTypePointer Output %7 
                                Input f32_4* %215 = OpVariable Input 
                                         f32 %217 = OpConstant 3.674022E-40 
                                       f32_4 %218 = OpConstantComposite %217 %217 %217 %217 
                                             %220 = OpTypePointer Uniform %6 
                                       f32_4 %226 = OpConstantComposite %17 %17 %17 %17 
                                             %228 = OpTypeVector %18 3 
                                             %229 = OpTypePointer Private %228 
                              Private u32_3* %230 = OpVariable Private 
                                         u32 %234 = OpConstant 255 
                                             %236 = OpTypePointer Private %18 
                                         i32 %250 = OpConstant 16 
                                         u32 %256 = OpConstant 24 
                               Output f32_4* %266 = OpVariable Output 
                                         f32 %268 = OpConstant 3.674022E-40 
                                       f32_4 %269 = OpConstantComposite %268 %268 %268 %268 
                                Private f32* %281 = OpVariable Private 
                                             %311 = OpTypePointer Input %134 
                                Input f32_2* %312 = OpVariable Input 
                                             %322 = OpTypeBool 
                                             %323 = OpTypePointer Private %322 
                               Private bool* %324 = OpVariable Private 
                                         f32 %327 = OpConstant 3.674022E-40 
                                             %330 = OpTypePointer Function %134 
                                             %341 = OpTypePointer Output %134 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %353 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %331 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %137 = OpLoad %24 
                                Uniform u32* %139 = OpAccessChain %43 %31 %137 %31 %138 
                                         u32 %140 = OpLoad %139 
                                         f32 %141 = OpBitcast %140 
                                Private f32* %142 = OpAccessChain %136 %66 
                                                      OpStore %142 %141 
                                Private f32* %143 = OpAccessChain %136 %66 
                                         f32 %144 = OpLoad %143 
                                         f32 %145 = OpExtInst %1 8 %144 
                                Private f32* %146 = OpAccessChain %136 %66 
                                                      OpStore %146 %145 
                                Private f32* %147 = OpAccessChain %112 %89 
                                         f32 %148 = OpLoad %147 
                                Private f32* %149 = OpAccessChain %62 %19 
                                                      OpStore %149 %148 
                                       f32_4 %151 = OpLoad %62 
                                       f32_4 %152 = OpLoad %9 
                                         f32 %153 = OpDot %151 %152 
                                                      OpStore %150 %153 
                                         f32 %154 = OpLoad %150 
                                       f32_4 %155 = OpCompositeConstruct %154 %154 %154 %154 
                              Uniform f32_4* %162 = OpAccessChain %160 %31 %55 
                                       f32_4 %163 = OpLoad %162 
                                       f32_4 %164 = OpFMul %155 %163 
                                                      OpStore %62 %164 
                                Private f32* %165 = OpAccessChain %36 %89 
                                         f32 %166 = OpLoad %165 
                                Private f32* %167 = OpAccessChain %68 %66 
                                                      OpStore %167 %166 
                                Private f32* %168 = OpAccessChain %68 %63 
                                         f32 %169 = OpLoad %168 
                                Private f32* %170 = OpAccessChain %36 %89 
                                                      OpStore %170 %169 
                                Private f32* %171 = OpAccessChain %92 %66 
                                         f32 %172 = OpLoad %171 
                                Private f32* %173 = OpAccessChain %68 %63 
                                                      OpStore %173 %172 
                                Private f32* %174 = OpAccessChain %92 %63 
                                         f32 %175 = OpLoad %174 
                                Private f32* %176 = OpAccessChain %36 %63 
                                                      OpStore %176 %175 
                                Private f32* %177 = OpAccessChain %112 %66 
                                         f32 %178 = OpLoad %177 
                                Private f32* %179 = OpAccessChain %68 %19 
                                                      OpStore %179 %178 
                                       f32_4 %180 = OpLoad %68 
                                       f32_4 %181 = OpLoad %9 
                                         f32 %182 = OpDot %180 %181 
                                Private f32* %183 = OpAccessChain %92 %66 
                                                      OpStore %183 %182 
                              Uniform f32_4* %184 = OpAccessChain %160 %31 %31 
                                       f32_4 %185 = OpLoad %184 
                                       f32_3 %186 = OpLoad %92 
                                       f32_4 %187 = OpVectorShuffle %186 %186 0 0 0 0 
                                       f32_4 %188 = OpFMul %185 %187 
                                       f32_4 %189 = OpLoad %62 
                                       f32_4 %190 = OpFAdd %188 %189 
                                                      OpStore %62 %190 
                                Private f32* %191 = OpAccessChain %112 %63 
                                         f32 %192 = OpLoad %191 
                                Private f32* %193 = OpAccessChain %36 %19 
                                                      OpStore %193 %192 
                                       f32_4 %194 = OpLoad %36 
                                       f32_4 %195 = OpLoad %9 
                                         f32 %196 = OpDot %194 %195 
                                Private f32* %197 = OpAccessChain %9 %66 
                                                      OpStore %197 %196 
                              Uniform f32_4* %198 = OpAccessChain %160 %31 %45 
                                       f32_4 %199 = OpLoad %198 
                                       f32_4 %200 = OpLoad %9 
                                       f32_4 %201 = OpVectorShuffle %200 %200 0 0 0 0 
                                       f32_4 %202 = OpFMul %199 %201 
                                       f32_4 %203 = OpLoad %62 
                                       f32_4 %204 = OpFAdd %202 %203 
                                                      OpStore %9 %204 
                                       f32_4 %209 = OpLoad %9 
                              Uniform f32_4* %210 = OpAccessChain %160 %31 %75 
                                       f32_4 %211 = OpLoad %210 
                                       f32_4 %212 = OpFAdd %209 %211 
                               Output f32_4* %214 = OpAccessChain %208 %31 
                                                      OpStore %214 %212 
                                       f32_4 %216 = OpLoad %215 
                                       f32_4 %219 = OpFAdd %216 %218 
                                                      OpStore %9 %219 
                                Uniform f32* %221 = OpAccessChain %160 %45 
                                         f32 %222 = OpLoad %221 
                                       f32_4 %223 = OpCompositeConstruct %222 %222 %222 %222 
                                       f32_4 %224 = OpLoad %9 
                                       f32_4 %225 = OpFMul %223 %224 
                                       f32_4 %227 = OpFAdd %225 %226 
                                                      OpStore %9 %227 
                                Private f32* %231 = OpAccessChain %112 %19 
                                         f32 %232 = OpLoad %231 
                                         u32 %233 = OpBitcast %232 
                                         u32 %235 = OpBitwiseAnd %233 %234 
                                Private u32* %237 = OpAccessChain %230 %66 
                                                      OpStore %237 %235 
                                Private u32* %238 = OpAccessChain %230 %66 
                                         u32 %239 = OpLoad %238 
                                         f32 %240 = OpConvertUToF %239 
                                Private f32* %241 = OpAccessChain %36 %66 
                                                      OpStore %241 %240 
                                Private f32* %242 = OpAccessChain %112 %19 
                                         f32 %243 = OpLoad %242 
                                         u32 %244 = OpBitcast %243 
                                         u32 %245 = OpBitFieldUExtract %244 %104 %104 
                                Private u32* %246 = OpAccessChain %230 %66 
                                                      OpStore %246 %245 
                                Private f32* %247 = OpAccessChain %112 %19 
                                         f32 %248 = OpLoad %247 
                                         u32 %249 = OpBitcast %248 
                                         u32 %251 = OpBitFieldUExtract %249 %250 %104 
                                Private u32* %252 = OpAccessChain %230 %89 
                                                      OpStore %252 %251 
                                Private f32* %253 = OpAccessChain %112 %19 
                                         f32 %254 = OpLoad %253 
                                         u32 %255 = OpBitcast %254 
                                         u32 %257 = OpShiftRightLogical %255 %256 
                                Private u32* %258 = OpAccessChain %230 %63 
                                                      OpStore %258 %257 
                                       u32_3 %259 = OpLoad %230 
                                       f32_3 %260 = OpConvertUToF %259 
                                       f32_4 %261 = OpLoad %36 
                                       f32_4 %262 = OpVectorShuffle %261 %260 0 4 5 6 
                                                      OpStore %36 %262 
                                       f32_4 %263 = OpLoad %9 
                                       f32_4 %264 = OpLoad %36 
                                       f32_4 %265 = OpFMul %263 %264 
                                                      OpStore %9 %265 
                                       f32_4 %267 = OpLoad %9 
                                       f32_4 %270 = OpFMul %267 %269 
                                                      OpStore %266 %270 
                                Private f32* %271 = OpAccessChain %136 %66 
                                         f32 %272 = OpLoad %271 
                                Uniform f32* %273 = OpAccessChain %160 %55 %89 
                                         f32 %274 = OpLoad %273 
                                         f32 %275 = OpFDiv %272 %274 
                                Private f32* %276 = OpAccessChain %9 %66 
                                                      OpStore %276 %275 
                                Private f32* %277 = OpAccessChain %9 %66 
                                         f32 %278 = OpLoad %277 
                                         f32 %279 = OpExtInst %1 8 %278 
                                Private f32* %280 = OpAccessChain %9 %66 
                                                      OpStore %280 %279 
                                Private f32* %282 = OpAccessChain %9 %66 
                                         f32 %283 = OpLoad %282 
                                         f32 %284 = OpFNegate %283 
                                Uniform f32* %285 = OpAccessChain %160 %55 %89 
                                         f32 %286 = OpLoad %285 
                                         f32 %287 = OpFMul %284 %286 
                                Private f32* %288 = OpAccessChain %136 %66 
                                         f32 %289 = OpLoad %288 
                                         f32 %290 = OpFAdd %287 %289 
                                                      OpStore %281 %290 
                                         f32 %291 = OpLoad %281 
                                         f32 %292 = OpExtInst %1 8 %291 
                                                      OpStore %281 %292 
                                         f32 %293 = OpLoad %281 
                                Uniform f32* %294 = OpAccessChain %160 %55 %63 
                                         f32 %295 = OpLoad %294 
                                         f32 %296 = OpFMul %293 %295 
                                Private f32* %297 = OpAccessChain %136 %66 
                                                      OpStore %297 %296 
                                Uniform f32* %298 = OpAccessChain %160 %55 %19 
                                         f32 %299 = OpLoad %298 
                                         f32 %300 = OpFNegate %299 
                                         f32 %301 = OpFAdd %300 %17 
                                                      OpStore %281 %301 
                                Private f32* %302 = OpAccessChain %9 %66 
                                         f32 %303 = OpLoad %302 
                                         f32 %304 = OpFNegate %303 
                                Uniform f32* %305 = OpAccessChain %160 %55 %19 
                                         f32 %306 = OpLoad %305 
                                         f32 %307 = OpFMul %304 %306 
                                         f32 %308 = OpLoad %281 
                                         f32 %309 = OpFAdd %307 %308 
                                Private f32* %310 = OpAccessChain %136 %89 
                                                      OpStore %310 %309 
                                       f32_2 %313 = OpLoad %312 
                              Uniform f32_4* %314 = OpAccessChain %160 %55 
                                       f32_4 %315 = OpLoad %314 
                                       f32_2 %316 = OpVectorShuffle %315 %315 2 3 
                                       f32_2 %317 = OpFMul %313 %316 
                                       f32_2 %318 = OpLoad %136 
                                       f32_2 %319 = OpFAdd %317 %318 
                                       f32_4 %320 = OpLoad %9 
                                       f32_4 %321 = OpVectorShuffle %320 %319 4 5 2 3 
                                                      OpStore %9 %321 
                                Uniform f32* %325 = OpAccessChain %160 %55 %66 
                                         f32 %326 = OpLoad %325 
                                        bool %328 = OpFOrdNotEqual %326 %327 
                                                      OpStore %324 %328 
                                        bool %329 = OpLoad %324 
                                                      OpSelectionMerge %333 None 
                                                      OpBranchConditional %329 %332 %336 
                                             %332 = OpLabel 
                                       f32_4 %334 = OpLoad %9 
                                       f32_2 %335 = OpVectorShuffle %334 %334 0 1 
                                                      OpStore %331 %335 
                                                      OpBranch %333 
                                             %336 = OpLabel 
                                       f32_2 %337 = OpLoad %312 
                                                      OpStore %331 %337 
                                                      OpBranch %333 
                                             %333 = OpLabel 
                                       f32_2 %338 = OpLoad %331 
                                       f32_4 %339 = OpLoad %9 
                                       f32_4 %340 = OpVectorShuffle %339 %338 4 5 2 3 
                                                      OpStore %9 %340 
                                       f32_4 %343 = OpLoad %9 
                                       f32_2 %344 = OpVectorShuffle %343 %343 0 1 
                              Uniform f32_4* %345 = OpAccessChain %160 %75 
                                       f32_4 %346 = OpLoad %345 
                                       f32_2 %347 = OpVectorShuffle %346 %346 0 1 
                                       f32_2 %348 = OpFMul %344 %347 
                              Uniform f32_4* %349 = OpAccessChain %160 %75 
                                       f32_4 %350 = OpLoad %349 
                                       f32_2 %351 = OpVectorShuffle %350 %350 2 3 
                                       f32_2 %352 = OpFAdd %348 %351 
                                                      OpStore vs_TEXCOORD1 %352 
                                 Output f32* %354 = OpAccessChain %208 %31 %89 
                                         f32 %355 = OpLoad %354 
                                         f32 %356 = OpFNegate %355 
                                 Output f32* %357 = OpAccessChain %208 %31 %89 
                                                      OpStore %357 %356 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 57
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %47 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %47 Location 47 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 
                                     %30 = OpTypePointer Uniform %29 
            Uniform struct {f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 0 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                     %46 = OpTypePointer Output %24 
                       Output f32_4* %47 = OpVariable Output 
                                 f32 %51 = OpConstant 3.674022E-40 
                                     %52 = OpTypeInt 32 0 
                                 u32 %53 = OpConstant 3 
                                     %54 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                                             OpStore %39 %45 
                               f32_3 %48 = OpLoad %39 
                               f32_4 %49 = OpLoad %47 
                               f32_4 %50 = OpVectorShuffle %49 %48 4 5 6 3 
                                             OpStore %47 %50 
                         Output f32* %55 = OpAccessChain %47 %53 
                                             OpStore %55 %51 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec2 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6 = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.x = u_xlat6 * unity_ParticleUVShiftData.z;
    u_xlat6 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat6;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 359
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %208 %215 %266 %312 %342 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %157 ArrayStride 157 
                                                      OpMemberDecorate %158 0 Offset 158 
                                                      OpMemberDecorate %158 1 Offset 158 
                                                      OpMemberDecorate %158 2 Offset 158 
                                                      OpMemberDecorate %158 3 Offset 158 
                                                      OpDecorate %158 Block 
                                                      OpDecorate %160 DescriptorSet 160 
                                                      OpDecorate %160 Binding 160 
                                                      OpMemberDecorate %206 0 BuiltIn 206 
                                                      OpMemberDecorate %206 1 BuiltIn 206 
                                                      OpMemberDecorate %206 2 BuiltIn 206 
                                                      OpDecorate %206 Block 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %215 Location 215 
                                                      OpDecorate %216 RelaxedPrecision 
                                                      OpDecorate %219 RelaxedPrecision 
                                                      OpDecorate %266 Location 266 
                                                      OpDecorate %312 Location 312 
                                                      OpDecorate vs_TEXCOORD1 Location 342 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                                             %134 = OpTypeVector %6 2 
                                             %135 = OpTypePointer Private %134 
                              Private f32_2* %136 = OpVariable Private 
                                         i32 %138 = OpConstant 13 
                                Private f32* %150 = OpVariable Private 
                                         u32 %156 = OpConstant 4 
                                             %157 = OpTypeArray %7 %156 
                                             %158 = OpTypeStruct %157 %7 %6 %7 
                                             %159 = OpTypePointer Uniform %158 
Uniform struct {f32_4[4]; f32_4; f32; f32_4;}* %160 = OpVariable Uniform 
                                             %161 = OpTypePointer Uniform %7 
                                             %205 = OpTypeArray %6 %89 
                                             %206 = OpTypeStruct %7 %6 %205 
                                             %207 = OpTypePointer Output %206 
        Output struct {f32_4; f32; f32[1];}* %208 = OpVariable Output 
                                             %213 = OpTypePointer Output %7 
                                Input f32_4* %215 = OpVariable Input 
                                         f32 %217 = OpConstant 3.674022E-40 
                                       f32_4 %218 = OpConstantComposite %217 %217 %217 %217 
                                             %220 = OpTypePointer Uniform %6 
                                       f32_4 %226 = OpConstantComposite %17 %17 %17 %17 
                                             %228 = OpTypeVector %18 3 
                                             %229 = OpTypePointer Private %228 
                              Private u32_3* %230 = OpVariable Private 
                                         u32 %234 = OpConstant 255 
                                             %236 = OpTypePointer Private %18 
                                         i32 %250 = OpConstant 16 
                                         u32 %256 = OpConstant 24 
                               Output f32_4* %266 = OpVariable Output 
                                         f32 %268 = OpConstant 3.674022E-40 
                                       f32_4 %269 = OpConstantComposite %268 %268 %268 %268 
                                Private f32* %281 = OpVariable Private 
                                             %311 = OpTypePointer Input %134 
                                Input f32_2* %312 = OpVariable Input 
                                             %322 = OpTypeBool 
                                             %323 = OpTypePointer Private %322 
                               Private bool* %324 = OpVariable Private 
                                         f32 %327 = OpConstant 3.674022E-40 
                                             %330 = OpTypePointer Function %134 
                                             %341 = OpTypePointer Output %134 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %353 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %331 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %137 = OpLoad %24 
                                Uniform u32* %139 = OpAccessChain %43 %31 %137 %31 %138 
                                         u32 %140 = OpLoad %139 
                                         f32 %141 = OpBitcast %140 
                                Private f32* %142 = OpAccessChain %136 %66 
                                                      OpStore %142 %141 
                                Private f32* %143 = OpAccessChain %136 %66 
                                         f32 %144 = OpLoad %143 
                                         f32 %145 = OpExtInst %1 8 %144 
                                Private f32* %146 = OpAccessChain %136 %66 
                                                      OpStore %146 %145 
                                Private f32* %147 = OpAccessChain %112 %89 
                                         f32 %148 = OpLoad %147 
                                Private f32* %149 = OpAccessChain %62 %19 
                                                      OpStore %149 %148 
                                       f32_4 %151 = OpLoad %62 
                                       f32_4 %152 = OpLoad %9 
                                         f32 %153 = OpDot %151 %152 
                                                      OpStore %150 %153 
                                         f32 %154 = OpLoad %150 
                                       f32_4 %155 = OpCompositeConstruct %154 %154 %154 %154 
                              Uniform f32_4* %162 = OpAccessChain %160 %31 %55 
                                       f32_4 %163 = OpLoad %162 
                                       f32_4 %164 = OpFMul %155 %163 
                                                      OpStore %62 %164 
                                Private f32* %165 = OpAccessChain %36 %89 
                                         f32 %166 = OpLoad %165 
                                Private f32* %167 = OpAccessChain %68 %66 
                                                      OpStore %167 %166 
                                Private f32* %168 = OpAccessChain %68 %63 
                                         f32 %169 = OpLoad %168 
                                Private f32* %170 = OpAccessChain %36 %89 
                                                      OpStore %170 %169 
                                Private f32* %171 = OpAccessChain %92 %66 
                                         f32 %172 = OpLoad %171 
                                Private f32* %173 = OpAccessChain %68 %63 
                                                      OpStore %173 %172 
                                Private f32* %174 = OpAccessChain %92 %63 
                                         f32 %175 = OpLoad %174 
                                Private f32* %176 = OpAccessChain %36 %63 
                                                      OpStore %176 %175 
                                Private f32* %177 = OpAccessChain %112 %66 
                                         f32 %178 = OpLoad %177 
                                Private f32* %179 = OpAccessChain %68 %19 
                                                      OpStore %179 %178 
                                       f32_4 %180 = OpLoad %68 
                                       f32_4 %181 = OpLoad %9 
                                         f32 %182 = OpDot %180 %181 
                                Private f32* %183 = OpAccessChain %92 %66 
                                                      OpStore %183 %182 
                              Uniform f32_4* %184 = OpAccessChain %160 %31 %31 
                                       f32_4 %185 = OpLoad %184 
                                       f32_3 %186 = OpLoad %92 
                                       f32_4 %187 = OpVectorShuffle %186 %186 0 0 0 0 
                                       f32_4 %188 = OpFMul %185 %187 
                                       f32_4 %189 = OpLoad %62 
                                       f32_4 %190 = OpFAdd %188 %189 
                                                      OpStore %62 %190 
                                Private f32* %191 = OpAccessChain %112 %63 
                                         f32 %192 = OpLoad %191 
                                Private f32* %193 = OpAccessChain %36 %19 
                                                      OpStore %193 %192 
                                       f32_4 %194 = OpLoad %36 
                                       f32_4 %195 = OpLoad %9 
                                         f32 %196 = OpDot %194 %195 
                                Private f32* %197 = OpAccessChain %9 %66 
                                                      OpStore %197 %196 
                              Uniform f32_4* %198 = OpAccessChain %160 %31 %45 
                                       f32_4 %199 = OpLoad %198 
                                       f32_4 %200 = OpLoad %9 
                                       f32_4 %201 = OpVectorShuffle %200 %200 0 0 0 0 
                                       f32_4 %202 = OpFMul %199 %201 
                                       f32_4 %203 = OpLoad %62 
                                       f32_4 %204 = OpFAdd %202 %203 
                                                      OpStore %9 %204 
                                       f32_4 %209 = OpLoad %9 
                              Uniform f32_4* %210 = OpAccessChain %160 %31 %75 
                                       f32_4 %211 = OpLoad %210 
                                       f32_4 %212 = OpFAdd %209 %211 
                               Output f32_4* %214 = OpAccessChain %208 %31 
                                                      OpStore %214 %212 
                                       f32_4 %216 = OpLoad %215 
                                       f32_4 %219 = OpFAdd %216 %218 
                                                      OpStore %9 %219 
                                Uniform f32* %221 = OpAccessChain %160 %45 
                                         f32 %222 = OpLoad %221 
                                       f32_4 %223 = OpCompositeConstruct %222 %222 %222 %222 
                                       f32_4 %224 = OpLoad %9 
                                       f32_4 %225 = OpFMul %223 %224 
                                       f32_4 %227 = OpFAdd %225 %226 
                                                      OpStore %9 %227 
                                Private f32* %231 = OpAccessChain %112 %19 
                                         f32 %232 = OpLoad %231 
                                         u32 %233 = OpBitcast %232 
                                         u32 %235 = OpBitwiseAnd %233 %234 
                                Private u32* %237 = OpAccessChain %230 %66 
                                                      OpStore %237 %235 
                                Private u32* %238 = OpAccessChain %230 %66 
                                         u32 %239 = OpLoad %238 
                                         f32 %240 = OpConvertUToF %239 
                                Private f32* %241 = OpAccessChain %36 %66 
                                                      OpStore %241 %240 
                                Private f32* %242 = OpAccessChain %112 %19 
                                         f32 %243 = OpLoad %242 
                                         u32 %244 = OpBitcast %243 
                                         u32 %245 = OpBitFieldUExtract %244 %104 %104 
                                Private u32* %246 = OpAccessChain %230 %66 
                                                      OpStore %246 %245 
                                Private f32* %247 = OpAccessChain %112 %19 
                                         f32 %248 = OpLoad %247 
                                         u32 %249 = OpBitcast %248 
                                         u32 %251 = OpBitFieldUExtract %249 %250 %104 
                                Private u32* %252 = OpAccessChain %230 %89 
                                                      OpStore %252 %251 
                                Private f32* %253 = OpAccessChain %112 %19 
                                         f32 %254 = OpLoad %253 
                                         u32 %255 = OpBitcast %254 
                                         u32 %257 = OpShiftRightLogical %255 %256 
                                Private u32* %258 = OpAccessChain %230 %63 
                                                      OpStore %258 %257 
                                       u32_3 %259 = OpLoad %230 
                                       f32_3 %260 = OpConvertUToF %259 
                                       f32_4 %261 = OpLoad %36 
                                       f32_4 %262 = OpVectorShuffle %261 %260 0 4 5 6 
                                                      OpStore %36 %262 
                                       f32_4 %263 = OpLoad %9 
                                       f32_4 %264 = OpLoad %36 
                                       f32_4 %265 = OpFMul %263 %264 
                                                      OpStore %9 %265 
                                       f32_4 %267 = OpLoad %9 
                                       f32_4 %270 = OpFMul %267 %269 
                                                      OpStore %266 %270 
                                Private f32* %271 = OpAccessChain %136 %66 
                                         f32 %272 = OpLoad %271 
                                Uniform f32* %273 = OpAccessChain %160 %55 %89 
                                         f32 %274 = OpLoad %273 
                                         f32 %275 = OpFDiv %272 %274 
                                Private f32* %276 = OpAccessChain %9 %66 
                                                      OpStore %276 %275 
                                Private f32* %277 = OpAccessChain %9 %66 
                                         f32 %278 = OpLoad %277 
                                         f32 %279 = OpExtInst %1 8 %278 
                                Private f32* %280 = OpAccessChain %9 %66 
                                                      OpStore %280 %279 
                                Private f32* %282 = OpAccessChain %9 %66 
                                         f32 %283 = OpLoad %282 
                                         f32 %284 = OpFNegate %283 
                                Uniform f32* %285 = OpAccessChain %160 %55 %89 
                                         f32 %286 = OpLoad %285 
                                         f32 %287 = OpFMul %284 %286 
                                Private f32* %288 = OpAccessChain %136 %66 
                                         f32 %289 = OpLoad %288 
                                         f32 %290 = OpFAdd %287 %289 
                                                      OpStore %281 %290 
                                         f32 %291 = OpLoad %281 
                                         f32 %292 = OpExtInst %1 8 %291 
                                                      OpStore %281 %292 
                                         f32 %293 = OpLoad %281 
                                Uniform f32* %294 = OpAccessChain %160 %55 %63 
                                         f32 %295 = OpLoad %294 
                                         f32 %296 = OpFMul %293 %295 
                                Private f32* %297 = OpAccessChain %136 %66 
                                                      OpStore %297 %296 
                                Uniform f32* %298 = OpAccessChain %160 %55 %19 
                                         f32 %299 = OpLoad %298 
                                         f32 %300 = OpFNegate %299 
                                         f32 %301 = OpFAdd %300 %17 
                                                      OpStore %281 %301 
                                Private f32* %302 = OpAccessChain %9 %66 
                                         f32 %303 = OpLoad %302 
                                         f32 %304 = OpFNegate %303 
                                Uniform f32* %305 = OpAccessChain %160 %55 %19 
                                         f32 %306 = OpLoad %305 
                                         f32 %307 = OpFMul %304 %306 
                                         f32 %308 = OpLoad %281 
                                         f32 %309 = OpFAdd %307 %308 
                                Private f32* %310 = OpAccessChain %136 %89 
                                                      OpStore %310 %309 
                                       f32_2 %313 = OpLoad %312 
                              Uniform f32_4* %314 = OpAccessChain %160 %55 
                                       f32_4 %315 = OpLoad %314 
                                       f32_2 %316 = OpVectorShuffle %315 %315 2 3 
                                       f32_2 %317 = OpFMul %313 %316 
                                       f32_2 %318 = OpLoad %136 
                                       f32_2 %319 = OpFAdd %317 %318 
                                       f32_4 %320 = OpLoad %9 
                                       f32_4 %321 = OpVectorShuffle %320 %319 4 5 2 3 
                                                      OpStore %9 %321 
                                Uniform f32* %325 = OpAccessChain %160 %55 %66 
                                         f32 %326 = OpLoad %325 
                                        bool %328 = OpFOrdNotEqual %326 %327 
                                                      OpStore %324 %328 
                                        bool %329 = OpLoad %324 
                                                      OpSelectionMerge %333 None 
                                                      OpBranchConditional %329 %332 %336 
                                             %332 = OpLabel 
                                       f32_4 %334 = OpLoad %9 
                                       f32_2 %335 = OpVectorShuffle %334 %334 0 1 
                                                      OpStore %331 %335 
                                                      OpBranch %333 
                                             %336 = OpLabel 
                                       f32_2 %337 = OpLoad %312 
                                                      OpStore %331 %337 
                                                      OpBranch %333 
                                             %333 = OpLabel 
                                       f32_2 %338 = OpLoad %331 
                                       f32_4 %339 = OpLoad %9 
                                       f32_4 %340 = OpVectorShuffle %339 %338 4 5 2 3 
                                                      OpStore %9 %340 
                                       f32_4 %343 = OpLoad %9 
                                       f32_2 %344 = OpVectorShuffle %343 %343 0 1 
                              Uniform f32_4* %345 = OpAccessChain %160 %75 
                                       f32_4 %346 = OpLoad %345 
                                       f32_2 %347 = OpVectorShuffle %346 %346 0 1 
                                       f32_2 %348 = OpFMul %344 %347 
                              Uniform f32_4* %349 = OpAccessChain %160 %75 
                                       f32_4 %350 = OpLoad %349 
                                       f32_2 %351 = OpVectorShuffle %350 %350 2 3 
                                       f32_2 %352 = OpFAdd %348 %351 
                                                      OpStore vs_TEXCOORD1 %352 
                                 Output f32* %354 = OpAccessChain %208 %31 %89 
                                         f32 %355 = OpLoad %354 
                                         f32 %356 = OpFNegate %355 
                                 Output f32* %357 = OpAccessChain %208 %31 %89 
                                                      OpStore %357 %356 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 46
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %39 %43 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpMemberDecorate %27 0 RelaxedPrecision 
                                             OpMemberDecorate %27 0 Offset 27 
                                             OpDecorate %27 Block 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %39 Location 39 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %43 Location 43 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypeVector %6 4 
                                      %8 = OpTypePointer Private %7 
                       Private f32_4* %9 = OpVariable Private 
                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %11 = OpTypePointer UniformConstant %10 
UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                     %14 = OpTypeSampler 
                                     %15 = OpTypePointer UniformConstant %14 
            UniformConstant sampler* %16 = OpVariable UniformConstant 
                                     %18 = OpTypeSampledImage %10 
                                     %20 = OpTypeVector %6 2 
                                     %21 = OpTypePointer Input %20 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %25 = OpVariable Private 
                                     %27 = OpTypeStruct %7 
                                     %28 = OpTypePointer Uniform %27 
            Uniform struct {f32_4;}* %29 = OpVariable Uniform 
                                     %30 = OpTypeInt 32 1 
                                 i32 %31 = OpConstant 0 
                                     %32 = OpTypePointer Uniform %7 
                      Private f32_4* %36 = OpVariable Private 
                                     %38 = OpTypePointer Input %7 
                        Input f32_4* %39 = OpVariable Input 
                                     %42 = OpTypePointer Output %7 
                       Output f32_4* %43 = OpVariable Output 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                             OpStore %9 %24 
                               f32_4 %26 = OpLoad %9 
                      Uniform f32_4* %33 = OpAccessChain %29 %31 
                               f32_4 %34 = OpLoad %33 
                               f32_4 %35 = OpFMul %26 %34 
                                             OpStore %25 %35 
                               f32_4 %37 = OpLoad %25 
                               f32_4 %40 = OpLoad %39 
                               f32_4 %41 = OpFMul %37 %40 
                                             OpStore %36 %41 
                               f32_4 %44 = OpLoad %36 
                                             OpStore %43 %44 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD0 = exp2(u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 151
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %79 %124 %128 %129 %133 %135 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpMemberDecorate %18 0 Offset 18 
                                                      OpMemberDecorate %18 1 Offset 18 
                                                      OpMemberDecorate %18 2 Offset 18 
                                                      OpMemberDecorate %18 3 Offset 18 
                                                      OpMemberDecorate %18 4 Offset 18 
                                                      OpDecorate %18 Block 
                                                      OpDecorate %20 DescriptorSet 20 
                                                      OpDecorate %20 Binding 20 
                                                      OpMemberDecorate %77 0 BuiltIn 77 
                                                      OpMemberDecorate %77 1 BuiltIn 77 
                                                      OpMemberDecorate %77 2 BuiltIn 77 
                                                      OpDecorate %77 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 124 
                                                      OpDecorate %128 Location 128 
                                                      OpDecorate %129 RelaxedPrecision 
                                                      OpDecorate %129 Location 129 
                                                      OpDecorate %130 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 133 
                                                      OpDecorate %135 Location 135 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeStruct %7 %16 %17 %7 %7 
                                              %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32_4;}* %20 = OpVariable Uniform 
                                              %21 = OpTypeInt 32 1 
                                          i32 %22 = OpConstant 1 
                                              %23 = OpTypePointer Uniform %7 
                                          i32 %27 = OpConstant 0 
                                          i32 %35 = OpConstant 2 
                                          i32 %44 = OpConstant 3 
                               Private f32_4* %48 = OpVariable Private 
                                          u32 %75 = OpConstant 1 
                                              %76 = OpTypeArray %6 %75 
                                              %77 = OpTypeStruct %7 %6 %76 
                                              %78 = OpTypePointer Output %77 
         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                              %81 = OpTypePointer Output %7 
                                          u32 %83 = OpConstant 2 
                                              %84 = OpTypePointer Private %6 
                                              %87 = OpTypePointer Uniform %6 
                                          u32 %91 = OpConstant 0 
                                          f32 %96 = OpConstant 3.674022E-40 
                                         f32 %107 = OpConstant 3.674022E-40 
                                             %123 = OpTypePointer Output %6 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                               Output f32_4* %128 = OpVariable Output 
                                Input f32_4* %129 = OpVariable Input 
                                             %131 = OpTypeVector %6 2 
                                             %132 = OpTypePointer Output %131 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %134 = OpTypePointer Input %131 
                                Input f32_2* %135 = OpVariable Input 
                                         i32 %137 = OpConstant 4 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                        f32_4 %25 = OpLoad %24 
                                        f32_4 %26 = OpFMul %13 %25 
                                                      OpStore %9 %26 
                               Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                        f32_4 %29 = OpLoad %28 
                                        f32_4 %30 = OpLoad %11 
                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                        f32_4 %32 = OpFMul %29 %31 
                                        f32_4 %33 = OpLoad %9 
                                        f32_4 %34 = OpFAdd %32 %33 
                                                      OpStore %9 %34 
                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                        f32_4 %37 = OpLoad %36 
                                        f32_4 %38 = OpLoad %11 
                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                        f32_4 %40 = OpFMul %37 %39 
                                        f32_4 %41 = OpLoad %9 
                                        f32_4 %42 = OpFAdd %40 %41 
                                                      OpStore %9 %42 
                                        f32_4 %43 = OpLoad %9 
                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                        f32_4 %46 = OpLoad %45 
                                        f32_4 %47 = OpFAdd %43 %46 
                                                      OpStore %9 %47 
                                        f32_4 %49 = OpLoad %9 
                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                               Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                        f32_4 %52 = OpLoad %51 
                                        f32_4 %53 = OpFMul %50 %52 
                                                      OpStore %48 %53 
                               Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                        f32_4 %55 = OpLoad %54 
                                        f32_4 %56 = OpLoad %9 
                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                        f32_4 %58 = OpFMul %55 %57 
                                        f32_4 %59 = OpLoad %48 
                                        f32_4 %60 = OpFAdd %58 %59 
                                                      OpStore %48 %60 
                               Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                        f32_4 %62 = OpLoad %61 
                                        f32_4 %63 = OpLoad %9 
                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                        f32_4 %65 = OpFMul %62 %64 
                                        f32_4 %66 = OpLoad %48 
                                        f32_4 %67 = OpFAdd %65 %66 
                                                      OpStore %48 %67 
                               Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                        f32_4 %69 = OpLoad %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                        f32_4 %72 = OpFMul %69 %71 
                                        f32_4 %73 = OpLoad %48 
                                        f32_4 %74 = OpFAdd %72 %73 
                                                      OpStore %9 %74 
                                        f32_4 %80 = OpLoad %9 
                                Output f32_4* %82 = OpAccessChain %79 %27 
                                                      OpStore %82 %80 
                                 Private f32* %85 = OpAccessChain %9 %83 
                                          f32 %86 = OpLoad %85 
                                 Uniform f32* %88 = OpAccessChain %20 %27 %75 
                                          f32 %89 = OpLoad %88 
                                          f32 %90 = OpFDiv %86 %89 
                                 Private f32* %92 = OpAccessChain %9 %91 
                                                      OpStore %92 %90 
                                 Private f32* %93 = OpAccessChain %9 %91 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFNegate %94 
                                          f32 %97 = OpFAdd %95 %96 
                                 Private f32* %98 = OpAccessChain %9 %91 
                                                      OpStore %98 %97 
                                 Private f32* %99 = OpAccessChain %9 %91 
                                         f32 %100 = OpLoad %99 
                                Uniform f32* %101 = OpAccessChain %20 %27 %83 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                Private f32* %104 = OpAccessChain %9 %91 
                                                      OpStore %104 %103 
                                Private f32* %105 = OpAccessChain %9 %91 
                                         f32 %106 = OpLoad %105 
                                         f32 %108 = OpExtInst %1 40 %106 %107 
                                Private f32* %109 = OpAccessChain %9 %91 
                                                      OpStore %109 %108 
                                Private f32* %110 = OpAccessChain %9 %91 
                                         f32 %111 = OpLoad %110 
                                Uniform f32* %112 = OpAccessChain %20 %44 %91 
                                         f32 %113 = OpLoad %112 
                                         f32 %114 = OpFMul %111 %113 
                                Private f32* %115 = OpAccessChain %9 %91 
                                                      OpStore %115 %114 
                                Private f32* %116 = OpAccessChain %9 %91 
                                         f32 %117 = OpLoad %116 
                                Private f32* %118 = OpAccessChain %9 %91 
                                         f32 %119 = OpLoad %118 
                                         f32 %120 = OpFNegate %119 
                                         f32 %121 = OpFMul %117 %120 
                                Private f32* %122 = OpAccessChain %9 %91 
                                                      OpStore %122 %121 
                                Private f32* %125 = OpAccessChain %9 %91 
                                         f32 %126 = OpLoad %125 
                                         f32 %127 = OpExtInst %1 29 %126 
                                                      OpStore vs_TEXCOORD0 %127 
                                       f32_4 %130 = OpLoad %129 
                                                      OpStore %128 %130 
                                       f32_2 %136 = OpLoad %135 
                              Uniform f32_4* %138 = OpAccessChain %20 %137 
                                       f32_4 %139 = OpLoad %138 
                                       f32_2 %140 = OpVectorShuffle %139 %139 0 1 
                                       f32_2 %141 = OpFMul %136 %140 
                              Uniform f32_4* %142 = OpAccessChain %20 %137 
                                       f32_4 %143 = OpLoad %142 
                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
                                       f32_2 %145 = OpFAdd %141 %144 
                                                      OpStore vs_TEXCOORD1 %145 
                                 Output f32* %146 = OpAccessChain %79 %27 %75 
                                         f32 %147 = OpLoad %146 
                                         f32 %148 = OpFNegate %147 
                                 Output f32* %149 = OpAccessChain %79 %27 %75 
                                                      OpStore %149 %148 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 79
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %55 %70 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpMemberDecorate %29 1 RelaxedPrecision 
                                             OpMemberDecorate %29 1 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %49 RelaxedPrecision 
                                             OpDecorate %50 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 55 
                                             OpDecorate %66 RelaxedPrecision 
                                             OpDecorate %67 RelaxedPrecision 
                                             OpDecorate %70 RelaxedPrecision 
                                             OpDecorate %70 Location 70 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 %24 
                                     %30 = OpTypePointer Uniform %29 
     Uniform struct {f32_4; f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 1 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                 i32 %46 = OpConstant 0 
                                     %52 = OpTypePointer Private %6 
                        Private f32* %53 = OpVariable Private 
                                     %54 = OpTypePointer Input %6 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                 f32 %58 = OpConstant 3.674022E-40 
                                 f32 %59 = OpConstant 3.674022E-40 
                                     %69 = OpTypePointer Output %24 
                       Output f32_4* %70 = OpVariable Output 
                                     %74 = OpTypeInt 32 0 
                                 u32 %75 = OpConstant 3 
                                     %76 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                      Uniform f32_4* %47 = OpAccessChain %31 %46 
                               f32_4 %48 = OpLoad %47 
                               f32_3 %49 = OpVectorShuffle %48 %48 0 1 2 
                               f32_3 %50 = OpFNegate %49 
                               f32_3 %51 = OpFAdd %45 %50 
                                             OpStore %39 %51 
                                 f32 %56 = OpLoad vs_TEXCOORD0 
                                             OpStore %53 %56 
                                 f32 %57 = OpLoad %53 
                                 f32 %60 = OpExtInst %1 43 %57 %58 %59 
                                             OpStore %53 %60 
                                 f32 %61 = OpLoad %53 
                               f32_3 %62 = OpCompositeConstruct %61 %61 %61 
                               f32_3 %63 = OpLoad %39 
                               f32_3 %64 = OpFMul %62 %63 
                      Uniform f32_4* %65 = OpAccessChain %31 %46 
                               f32_4 %66 = OpLoad %65 
                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
                               f32_3 %68 = OpFAdd %64 %67 
                                             OpStore %39 %68 
                               f32_3 %71 = OpLoad %39 
                               f32_4 %72 = OpLoad %70 
                               f32_4 %73 = OpVectorShuffle %72 %71 4 5 6 3 
                                             OpStore %70 %73 
                         Output f32* %77 = OpAccessChain %70 %75 
                                             OpStore %77 %59 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD0 = exp2(u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 151
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %79 %124 %128 %129 %133 %135 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpMemberDecorate %18 0 Offset 18 
                                                      OpMemberDecorate %18 1 Offset 18 
                                                      OpMemberDecorate %18 2 Offset 18 
                                                      OpMemberDecorate %18 3 Offset 18 
                                                      OpMemberDecorate %18 4 Offset 18 
                                                      OpDecorate %18 Block 
                                                      OpDecorate %20 DescriptorSet 20 
                                                      OpDecorate %20 Binding 20 
                                                      OpMemberDecorate %77 0 BuiltIn 77 
                                                      OpMemberDecorate %77 1 BuiltIn 77 
                                                      OpMemberDecorate %77 2 BuiltIn 77 
                                                      OpDecorate %77 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 124 
                                                      OpDecorate %128 Location 128 
                                                      OpDecorate %129 RelaxedPrecision 
                                                      OpDecorate %129 Location 129 
                                                      OpDecorate %130 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 133 
                                                      OpDecorate %135 Location 135 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeStruct %7 %16 %17 %7 %7 
                                              %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32_4;}* %20 = OpVariable Uniform 
                                              %21 = OpTypeInt 32 1 
                                          i32 %22 = OpConstant 1 
                                              %23 = OpTypePointer Uniform %7 
                                          i32 %27 = OpConstant 0 
                                          i32 %35 = OpConstant 2 
                                          i32 %44 = OpConstant 3 
                               Private f32_4* %48 = OpVariable Private 
                                          u32 %75 = OpConstant 1 
                                              %76 = OpTypeArray %6 %75 
                                              %77 = OpTypeStruct %7 %6 %76 
                                              %78 = OpTypePointer Output %77 
         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                              %81 = OpTypePointer Output %7 
                                          u32 %83 = OpConstant 2 
                                              %84 = OpTypePointer Private %6 
                                              %87 = OpTypePointer Uniform %6 
                                          u32 %91 = OpConstant 0 
                                          f32 %96 = OpConstant 3.674022E-40 
                                         f32 %107 = OpConstant 3.674022E-40 
                                             %123 = OpTypePointer Output %6 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                               Output f32_4* %128 = OpVariable Output 
                                Input f32_4* %129 = OpVariable Input 
                                             %131 = OpTypeVector %6 2 
                                             %132 = OpTypePointer Output %131 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %134 = OpTypePointer Input %131 
                                Input f32_2* %135 = OpVariable Input 
                                         i32 %137 = OpConstant 4 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                        f32_4 %25 = OpLoad %24 
                                        f32_4 %26 = OpFMul %13 %25 
                                                      OpStore %9 %26 
                               Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                        f32_4 %29 = OpLoad %28 
                                        f32_4 %30 = OpLoad %11 
                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                        f32_4 %32 = OpFMul %29 %31 
                                        f32_4 %33 = OpLoad %9 
                                        f32_4 %34 = OpFAdd %32 %33 
                                                      OpStore %9 %34 
                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                        f32_4 %37 = OpLoad %36 
                                        f32_4 %38 = OpLoad %11 
                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                        f32_4 %40 = OpFMul %37 %39 
                                        f32_4 %41 = OpLoad %9 
                                        f32_4 %42 = OpFAdd %40 %41 
                                                      OpStore %9 %42 
                                        f32_4 %43 = OpLoad %9 
                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                        f32_4 %46 = OpLoad %45 
                                        f32_4 %47 = OpFAdd %43 %46 
                                                      OpStore %9 %47 
                                        f32_4 %49 = OpLoad %9 
                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                               Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                        f32_4 %52 = OpLoad %51 
                                        f32_4 %53 = OpFMul %50 %52 
                                                      OpStore %48 %53 
                               Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                        f32_4 %55 = OpLoad %54 
                                        f32_4 %56 = OpLoad %9 
                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                        f32_4 %58 = OpFMul %55 %57 
                                        f32_4 %59 = OpLoad %48 
                                        f32_4 %60 = OpFAdd %58 %59 
                                                      OpStore %48 %60 
                               Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                        f32_4 %62 = OpLoad %61 
                                        f32_4 %63 = OpLoad %9 
                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                        f32_4 %65 = OpFMul %62 %64 
                                        f32_4 %66 = OpLoad %48 
                                        f32_4 %67 = OpFAdd %65 %66 
                                                      OpStore %48 %67 
                               Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                        f32_4 %69 = OpLoad %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                        f32_4 %72 = OpFMul %69 %71 
                                        f32_4 %73 = OpLoad %48 
                                        f32_4 %74 = OpFAdd %72 %73 
                                                      OpStore %9 %74 
                                        f32_4 %80 = OpLoad %9 
                                Output f32_4* %82 = OpAccessChain %79 %27 
                                                      OpStore %82 %80 
                                 Private f32* %85 = OpAccessChain %9 %83 
                                          f32 %86 = OpLoad %85 
                                 Uniform f32* %88 = OpAccessChain %20 %27 %75 
                                          f32 %89 = OpLoad %88 
                                          f32 %90 = OpFDiv %86 %89 
                                 Private f32* %92 = OpAccessChain %9 %91 
                                                      OpStore %92 %90 
                                 Private f32* %93 = OpAccessChain %9 %91 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFNegate %94 
                                          f32 %97 = OpFAdd %95 %96 
                                 Private f32* %98 = OpAccessChain %9 %91 
                                                      OpStore %98 %97 
                                 Private f32* %99 = OpAccessChain %9 %91 
                                         f32 %100 = OpLoad %99 
                                Uniform f32* %101 = OpAccessChain %20 %27 %83 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                Private f32* %104 = OpAccessChain %9 %91 
                                                      OpStore %104 %103 
                                Private f32* %105 = OpAccessChain %9 %91 
                                         f32 %106 = OpLoad %105 
                                         f32 %108 = OpExtInst %1 40 %106 %107 
                                Private f32* %109 = OpAccessChain %9 %91 
                                                      OpStore %109 %108 
                                Private f32* %110 = OpAccessChain %9 %91 
                                         f32 %111 = OpLoad %110 
                                Uniform f32* %112 = OpAccessChain %20 %44 %91 
                                         f32 %113 = OpLoad %112 
                                         f32 %114 = OpFMul %111 %113 
                                Private f32* %115 = OpAccessChain %9 %91 
                                                      OpStore %115 %114 
                                Private f32* %116 = OpAccessChain %9 %91 
                                         f32 %117 = OpLoad %116 
                                Private f32* %118 = OpAccessChain %9 %91 
                                         f32 %119 = OpLoad %118 
                                         f32 %120 = OpFNegate %119 
                                         f32 %121 = OpFMul %117 %120 
                                Private f32* %122 = OpAccessChain %9 %91 
                                                      OpStore %122 %121 
                                Private f32* %125 = OpAccessChain %9 %91 
                                         f32 %126 = OpLoad %125 
                                         f32 %127 = OpExtInst %1 29 %126 
                                                      OpStore vs_TEXCOORD0 %127 
                                       f32_4 %130 = OpLoad %129 
                                                      OpStore %128 %130 
                                       f32_2 %136 = OpLoad %135 
                              Uniform f32_4* %138 = OpAccessChain %20 %137 
                                       f32_4 %139 = OpLoad %138 
                                       f32_2 %140 = OpVectorShuffle %139 %139 0 1 
                                       f32_2 %141 = OpFMul %136 %140 
                              Uniform f32_4* %142 = OpAccessChain %20 %137 
                                       f32_4 %143 = OpLoad %142 
                                       f32_2 %144 = OpVectorShuffle %143 %143 2 3 
                                       f32_2 %145 = OpFAdd %141 %144 
                                                      OpStore vs_TEXCOORD1 %145 
                                 Output f32* %146 = OpAccessChain %79 %27 %75 
                                         f32 %147 = OpLoad %146 
                                         f32 %148 = OpFNegate %147 
                                 Output f32* %149 = OpAccessChain %79 %27 %75 
                                                      OpStore %149 %148 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 110
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %35 %50 %66 %92 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpMemberDecorate %12 0 RelaxedPrecision 
                                             OpMemberDecorate %12 0 Offset 12 
                                             OpMemberDecorate %12 1 RelaxedPrecision 
                                             OpMemberDecorate %12 1 Offset 12 
                                             OpMemberDecorate %12 2 Offset 12 
                                             OpDecorate %12 Block 
                                             OpDecorate %14 DescriptorSet 14 
                                             OpDecorate %14 Binding 14 
                                             OpDecorate %22 RelaxedPrecision 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %25 DescriptorSet 25 
                                             OpDecorate %25 Binding 25 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %30 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 35 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %39 RelaxedPrecision 
                                             OpDecorate %42 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %50 Location 50 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %57 RelaxedPrecision 
                                             OpDecorate %58 RelaxedPrecision 
                                             OpDecorate %61 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 66 
                                             OpDecorate %83 RelaxedPrecision 
                                             OpDecorate %84 RelaxedPrecision 
                                             OpDecorate %92 RelaxedPrecision 
                                             OpDecorate %92 Location 92 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeBool 
                                      %7 = OpTypePointer Private %6 
                        Private bool* %8 = OpVariable Private 
                                      %9 = OpTypeFloat 32 
                                     %10 = OpTypeVector %9 4 
                                     %11 = OpTypeInt 32 1 
                                     %12 = OpTypeStruct %10 %10 %11 
                                     %13 = OpTypePointer Uniform %12 
Uniform struct {f32_4; f32_4; i32;}* %14 = OpVariable Uniform 
                                 i32 %15 = OpConstant 2 
                                     %16 = OpTypePointer Uniform %11 
                                 i32 %19 = OpConstant 1 
                                     %21 = OpTypePointer Private %10 
                      Private f32_4* %22 = OpVariable Private 
                                     %23 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
                                     %24 = OpTypePointer UniformConstant %23 
UniformConstant read_only Texture2D* %25 = OpVariable UniformConstant 
                                     %27 = OpTypeSampler 
                                     %28 = OpTypePointer UniformConstant %27 
            UniformConstant sampler* %29 = OpVariable UniformConstant 
                                     %31 = OpTypeSampledImage %23 
                                     %33 = OpTypeVector %9 2 
                                     %34 = OpTypePointer Input %33 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %38 = OpVariable Private 
                                     %40 = OpTypePointer Uniform %10 
                                     %44 = OpTypeVector %9 3 
                                     %45 = OpTypePointer Private %44 
                      Private f32_3* %46 = OpVariable Private 
                                     %49 = OpTypePointer Input %10 
                        Input f32_4* %50 = OpVariable Input 
                                 i32 %54 = OpConstant 0 
                      Private f32_4* %60 = OpVariable Private 
                      Private f32_3* %64 = OpVariable Private 
                                     %65 = OpTypePointer Input %9 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                     %68 = OpTypeInt 32 0 
                                 u32 %69 = OpConstant 0 
                                     %70 = OpTypePointer Private %9 
                                 f32 %74 = OpConstant 3.674022E-40 
                                 f32 %75 = OpConstant 3.674022E-40 
                                     %91 = OpTypePointer Output %10 
                       Output f32_4* %92 = OpVariable Output 
                                 u32 %93 = OpConstant 3 
                                     %96 = OpTypePointer Output %9 
                                     %99 = OpTypePointer Function %44 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                    Function f32_3* %100 = OpVariable Function 
                        Uniform i32* %17 = OpAccessChain %14 %15 
                                 i32 %18 = OpLoad %17 
                                bool %20 = OpIEqual %18 %19 
                                             OpStore %8 %20 
                 read_only Texture2D %26 = OpLoad %25 
                             sampler %30 = OpLoad %29 
          read_only Texture2DSampled %32 = OpSampledImage %26 %30 
                               f32_2 %36 = OpLoad vs_TEXCOORD1 
                               f32_4 %37 = OpImageSampleImplicitLod %32 %36 
                                             OpStore %22 %37 
                               f32_4 %39 = OpLoad %22 
                      Uniform f32_4* %41 = OpAccessChain %14 %19 
                               f32_4 %42 = OpLoad %41 
                               f32_4 %43 = OpFMul %39 %42 
                                             OpStore %38 %43 
                               f32_4 %47 = OpLoad %38 
                               f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                               f32_4 %51 = OpLoad %50 
                               f32_3 %52 = OpVectorShuffle %51 %51 0 1 2 
                               f32_3 %53 = OpFMul %48 %52 
                      Uniform f32_4* %55 = OpAccessChain %14 %54 
                               f32_4 %56 = OpLoad %55 
                               f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                               f32_3 %58 = OpFNegate %57 
                               f32_3 %59 = OpFAdd %53 %58 
                                             OpStore %46 %59 
                               f32_4 %61 = OpLoad %38 
                               f32_4 %62 = OpLoad %50 
                               f32_4 %63 = OpFMul %61 %62 
                                             OpStore %60 %63 
                                 f32 %67 = OpLoad vs_TEXCOORD0 
                        Private f32* %71 = OpAccessChain %64 %69 
                                             OpStore %71 %67 
                        Private f32* %72 = OpAccessChain %64 %69 
                                 f32 %73 = OpLoad %72 
                                 f32 %76 = OpExtInst %1 43 %73 %74 %75 
                        Private f32* %77 = OpAccessChain %64 %69 
                                             OpStore %77 %76 
                               f32_3 %78 = OpLoad %64 
                               f32_3 %79 = OpVectorShuffle %78 %78 0 0 0 
                               f32_3 %80 = OpLoad %46 
                               f32_3 %81 = OpFMul %79 %80 
                      Uniform f32_4* %82 = OpAccessChain %14 %54 
                               f32_4 %83 = OpLoad %82 
                               f32_3 %84 = OpVectorShuffle %83 %83 0 1 2 
                               f32_3 %85 = OpFAdd %81 %84 
                                             OpStore %46 %85 
                               f32_4 %86 = OpLoad %60 
                               f32_3 %87 = OpVectorShuffle %86 %86 0 1 2 
                               f32_3 %88 = OpLoad %64 
                               f32_3 %89 = OpVectorShuffle %88 %88 0 0 0 
                               f32_3 %90 = OpFMul %87 %89 
                                             OpStore %64 %90 
                        Private f32* %94 = OpAccessChain %60 %93 
                                 f32 %95 = OpLoad %94 
                         Output f32* %97 = OpAccessChain %92 %93 
                                             OpStore %97 %95 
                                bool %98 = OpLoad %8 
                                             OpSelectionMerge %102 None 
                                             OpBranchConditional %98 %101 %104 
                                    %101 = OpLabel 
                              f32_3 %103 = OpLoad %64 
                                             OpStore %100 %103 
                                             OpBranch %102 
                                    %104 = OpLabel 
                              f32_3 %105 = OpLoad %46 
                                             OpStore %100 %105 
                                             OpBranch %102 
                                    %102 = OpLabel 
                              f32_3 %106 = OpLoad %100 
                              f32_4 %107 = OpLoad %92 
                              f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
                                             OpStore %92 %108 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD0 = exp2(u_xlat0.x);
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 398
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %207 %248 %252 %302 %353 %382 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %152 ArrayStride 152 
                                                      OpMemberDecorate %153 0 Offset 153 
                                                      OpMemberDecorate %153 1 Offset 153 
                                                      OpMemberDecorate %153 2 Offset 153 
                                                      OpMemberDecorate %153 3 Offset 153 
                                                      OpMemberDecorate %153 4 Offset 153 
                                                      OpMemberDecorate %153 5 Offset 153 
                                                      OpDecorate %153 Block 
                                                      OpDecorate %155 DescriptorSet 155 
                                                      OpDecorate %155 Binding 155 
                                                      OpMemberDecorate %205 0 BuiltIn 205 
                                                      OpMemberDecorate %205 1 BuiltIn 205 
                                                      OpMemberDecorate %205 2 BuiltIn 205 
                                                      OpDecorate %205 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 248 
                                                      OpDecorate %252 RelaxedPrecision 
                                                      OpDecorate %252 Location 252 
                                                      OpDecorate %253 RelaxedPrecision 
                                                      OpDecorate %256 RelaxedPrecision 
                                                      OpDecorate %302 Location 302 
                                                      OpDecorate %353 Location 353 
                                                      OpDecorate vs_TEXCOORD1 Location 382 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                                Private f32* %134 = OpVariable Private 
                                         i32 %136 = OpConstant 13 
                                Private f32* %145 = OpVariable Private 
                                         u32 %151 = OpConstant 4 
                                             %152 = OpTypeArray %7 %151 
                                             %153 = OpTypeStruct %7 %152 %7 %7 %6 %7 
                                             %154 = OpTypePointer Uniform %153 
Uniform struct {f32_4; f32_4[4]; f32_4; f32_4; f32; f32_4;}* %155 = OpVariable Uniform 
                                             %156 = OpTypePointer Uniform %7 
                                             %204 = OpTypeArray %6 %89 
                                             %205 = OpTypeStruct %7 %6 %204 
                                             %206 = OpTypePointer Output %205 
        Output struct {f32_4; f32; f32[1];}* %207 = OpVariable Output 
                                             %209 = OpTypePointer Output %7 
                                             %213 = OpTypePointer Uniform %6 
                                         f32 %231 = OpConstant 3.674022E-40 
                                             %247 = OpTypePointer Output %6 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                                Input f32_4* %252 = OpVariable Input 
                                         f32 %254 = OpConstant 3.674022E-40 
                                       f32_4 %255 = OpConstantComposite %254 %254 %254 %254 
                                       f32_4 %262 = OpConstantComposite %17 %17 %17 %17 
                                             %264 = OpTypeVector %18 3 
                                             %265 = OpTypePointer Private %264 
                              Private u32_3* %266 = OpVariable Private 
                                         u32 %270 = OpConstant 255 
                                             %272 = OpTypePointer Private %18 
                                         i32 %286 = OpConstant 16 
                                         u32 %292 = OpConstant 24 
                               Output f32_4* %302 = OpVariable Output 
                                         f32 %304 = OpConstant 3.674022E-40 
                                       f32_4 %305 = OpConstantComposite %304 %304 %304 %304 
                                             %316 = OpTypeVector %6 2 
                                             %317 = OpTypePointer Private %316 
                              Private f32_2* %318 = OpVariable Private 
                                Private f32* %338 = OpVariable Private 
                                             %352 = OpTypePointer Input %316 
                                Input f32_2* %353 = OpVariable Input 
                                             %363 = OpTypeBool 
                                             %364 = OpTypePointer Private %363 
                               Private bool* %365 = OpVariable Private 
                                             %370 = OpTypePointer Function %316 
                                             %381 = OpTypePointer Output %316 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %371 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %135 = OpLoad %24 
                                Uniform u32* %137 = OpAccessChain %43 %31 %135 %31 %136 
                                         u32 %138 = OpLoad %137 
                                         f32 %139 = OpBitcast %138 
                                                      OpStore %134 %139 
                                         f32 %140 = OpLoad %134 
                                         f32 %141 = OpExtInst %1 8 %140 
                                                      OpStore %134 %141 
                                Private f32* %142 = OpAccessChain %112 %89 
                                         f32 %143 = OpLoad %142 
                                Private f32* %144 = OpAccessChain %62 %19 
                                                      OpStore %144 %143 
                                       f32_4 %146 = OpLoad %62 
                                       f32_4 %147 = OpLoad %9 
                                         f32 %148 = OpDot %146 %147 
                                                      OpStore %145 %148 
                                         f32 %149 = OpLoad %145 
                                       f32_4 %150 = OpCompositeConstruct %149 %149 %149 %149 
                              Uniform f32_4* %157 = OpAccessChain %155 %55 %55 
                                       f32_4 %158 = OpLoad %157 
                                       f32_4 %159 = OpFMul %150 %158 
                                                      OpStore %62 %159 
                                Private f32* %160 = OpAccessChain %36 %89 
                                         f32 %161 = OpLoad %160 
                                Private f32* %162 = OpAccessChain %68 %66 
                                                      OpStore %162 %161 
                                Private f32* %163 = OpAccessChain %68 %63 
                                         f32 %164 = OpLoad %163 
                                Private f32* %165 = OpAccessChain %36 %89 
                                                      OpStore %165 %164 
                                Private f32* %166 = OpAccessChain %92 %66 
                                         f32 %167 = OpLoad %166 
                                Private f32* %168 = OpAccessChain %68 %63 
                                                      OpStore %168 %167 
                                Private f32* %169 = OpAccessChain %92 %63 
                                         f32 %170 = OpLoad %169 
                                Private f32* %171 = OpAccessChain %36 %63 
                                                      OpStore %171 %170 
                                Private f32* %172 = OpAccessChain %112 %66 
                                         f32 %173 = OpLoad %172 
                                Private f32* %174 = OpAccessChain %68 %19 
                                                      OpStore %174 %173 
                                       f32_4 %175 = OpLoad %68 
                                       f32_4 %176 = OpLoad %9 
                                         f32 %177 = OpDot %175 %176 
                                Private f32* %178 = OpAccessChain %92 %66 
                                                      OpStore %178 %177 
                              Uniform f32_4* %179 = OpAccessChain %155 %55 %31 
                                       f32_4 %180 = OpLoad %179 
                                       f32_3 %181 = OpLoad %92 
                                       f32_4 %182 = OpVectorShuffle %181 %181 0 0 0 0 
                                       f32_4 %183 = OpFMul %180 %182 
                                       f32_4 %184 = OpLoad %62 
                                       f32_4 %185 = OpFAdd %183 %184 
                                                      OpStore %62 %185 
                                Private f32* %186 = OpAccessChain %112 %63 
                                         f32 %187 = OpLoad %186 
                                Private f32* %188 = OpAccessChain %36 %19 
                                                      OpStore %188 %187 
                                       f32_4 %189 = OpLoad %36 
                                       f32_4 %190 = OpLoad %9 
                                         f32 %191 = OpDot %189 %190 
                                Private f32* %192 = OpAccessChain %9 %66 
                                                      OpStore %192 %191 
                              Uniform f32_4* %193 = OpAccessChain %155 %55 %45 
                                       f32_4 %194 = OpLoad %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpVectorShuffle %195 %195 0 0 0 0 
                                       f32_4 %197 = OpFMul %194 %196 
                                       f32_4 %198 = OpLoad %62 
                                       f32_4 %199 = OpFAdd %197 %198 
                                                      OpStore %9 %199 
                                       f32_4 %200 = OpLoad %9 
                              Uniform f32_4* %201 = OpAccessChain %155 %55 %75 
                                       f32_4 %202 = OpLoad %201 
                                       f32_4 %203 = OpFAdd %200 %202 
                                                      OpStore %9 %203 
                                       f32_4 %208 = OpLoad %9 
                               Output f32_4* %210 = OpAccessChain %207 %31 
                                                      OpStore %210 %208 
                                Private f32* %211 = OpAccessChain %9 %63 
                                         f32 %212 = OpLoad %211 
                                Uniform f32* %214 = OpAccessChain %155 %31 %89 
                                         f32 %215 = OpLoad %214 
                                         f32 %216 = OpFDiv %212 %215 
                                Private f32* %217 = OpAccessChain %9 %66 
                                                      OpStore %217 %216 
                                Private f32* %218 = OpAccessChain %9 %66 
                                         f32 %219 = OpLoad %218 
                                         f32 %220 = OpFNegate %219 
                                         f32 %221 = OpFAdd %220 %17 
                                Private f32* %222 = OpAccessChain %9 %66 
                                                      OpStore %222 %221 
                                Private f32* %223 = OpAccessChain %9 %66 
                                         f32 %224 = OpLoad %223 
                                Uniform f32* %225 = OpAccessChain %155 %31 %63 
                                         f32 %226 = OpLoad %225 
                                         f32 %227 = OpFMul %224 %226 
                                Private f32* %228 = OpAccessChain %9 %66 
                                                      OpStore %228 %227 
                                Private f32* %229 = OpAccessChain %9 %66 
                                         f32 %230 = OpLoad %229 
                                         f32 %232 = OpExtInst %1 40 %230 %231 
                                Private f32* %233 = OpAccessChain %9 %66 
                                                      OpStore %233 %232 
                                Private f32* %234 = OpAccessChain %9 %66 
                                         f32 %235 = OpLoad %234 
                                Uniform f32* %236 = OpAccessChain %155 %45 %66 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFMul %235 %237 
                                Private f32* %239 = OpAccessChain %9 %66 
                                                      OpStore %239 %238 
                                Private f32* %240 = OpAccessChain %9 %66 
                                         f32 %241 = OpLoad %240 
                                Private f32* %242 = OpAccessChain %9 %66 
                                         f32 %243 = OpLoad %242 
                                         f32 %244 = OpFNegate %243 
                                         f32 %245 = OpFMul %241 %244 
                                Private f32* %246 = OpAccessChain %9 %66 
                                                      OpStore %246 %245 
                                Private f32* %249 = OpAccessChain %9 %66 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpExtInst %1 29 %250 
                                                      OpStore vs_TEXCOORD0 %251 
                                       f32_4 %253 = OpLoad %252 
                                       f32_4 %256 = OpFAdd %253 %255 
                                                      OpStore %9 %256 
                                Uniform f32* %257 = OpAccessChain %155 %70 
                                         f32 %258 = OpLoad %257 
                                       f32_4 %259 = OpCompositeConstruct %258 %258 %258 %258 
                                       f32_4 %260 = OpLoad %9 
                                       f32_4 %261 = OpFMul %259 %260 
                                       f32_4 %263 = OpFAdd %261 %262 
                                                      OpStore %9 %263 
                                Private f32* %267 = OpAccessChain %112 %19 
                                         f32 %268 = OpLoad %267 
                                         u32 %269 = OpBitcast %268 
                                         u32 %271 = OpBitwiseAnd %269 %270 
                                Private u32* %273 = OpAccessChain %266 %66 
                                                      OpStore %273 %271 
                                Private u32* %274 = OpAccessChain %266 %66 
                                         u32 %275 = OpLoad %274 
                                         f32 %276 = OpConvertUToF %275 
                                Private f32* %277 = OpAccessChain %36 %66 
                                                      OpStore %277 %276 
                                Private f32* %278 = OpAccessChain %112 %19 
                                         f32 %279 = OpLoad %278 
                                         u32 %280 = OpBitcast %279 
                                         u32 %281 = OpBitFieldUExtract %280 %104 %104 
                                Private u32* %282 = OpAccessChain %266 %66 
                                                      OpStore %282 %281 
                                Private f32* %283 = OpAccessChain %112 %19 
                                         f32 %284 = OpLoad %283 
                                         u32 %285 = OpBitcast %284 
                                         u32 %287 = OpBitFieldUExtract %285 %286 %104 
                                Private u32* %288 = OpAccessChain %266 %89 
                                                      OpStore %288 %287 
                                Private f32* %289 = OpAccessChain %112 %19 
                                         f32 %290 = OpLoad %289 
                                         u32 %291 = OpBitcast %290 
                                         u32 %293 = OpShiftRightLogical %291 %292 
                                Private u32* %294 = OpAccessChain %266 %63 
                                                      OpStore %294 %293 
                                       u32_3 %295 = OpLoad %266 
                                       f32_3 %296 = OpConvertUToF %295 
                                       f32_4 %297 = OpLoad %36 
                                       f32_4 %298 = OpVectorShuffle %297 %296 0 4 5 6 
                                                      OpStore %36 %298 
                                       f32_4 %299 = OpLoad %9 
                                       f32_4 %300 = OpLoad %36 
                                       f32_4 %301 = OpFMul %299 %300 
                                                      OpStore %9 %301 
                                       f32_4 %303 = OpLoad %9 
                                       f32_4 %306 = OpFMul %303 %305 
                                                      OpStore %302 %306 
                                         f32 %307 = OpLoad %134 
                                Uniform f32* %308 = OpAccessChain %155 %75 %89 
                                         f32 %309 = OpLoad %308 
                                         f32 %310 = OpFDiv %307 %309 
                                Private f32* %311 = OpAccessChain %9 %66 
                                                      OpStore %311 %310 
                                Private f32* %312 = OpAccessChain %9 %66 
                                         f32 %313 = OpLoad %312 
                                         f32 %314 = OpExtInst %1 8 %313 
                                Private f32* %315 = OpAccessChain %9 %66 
                                                      OpStore %315 %314 
                                Private f32* %319 = OpAccessChain %9 %66 
                                         f32 %320 = OpLoad %319 
                                         f32 %321 = OpFNegate %320 
                                Uniform f32* %322 = OpAccessChain %155 %75 %89 
                                         f32 %323 = OpLoad %322 
                                         f32 %324 = OpFMul %321 %323 
                                         f32 %325 = OpLoad %134 
                                         f32 %326 = OpFAdd %324 %325 
                                Private f32* %327 = OpAccessChain %318 %66 
                                                      OpStore %327 %326 
                                Private f32* %328 = OpAccessChain %318 %66 
                                         f32 %329 = OpLoad %328 
                                         f32 %330 = OpExtInst %1 8 %329 
                                Private f32* %331 = OpAccessChain %318 %66 
                                                      OpStore %331 %330 
                                Private f32* %332 = OpAccessChain %318 %66 
                                         f32 %333 = OpLoad %332 
                                Uniform f32* %334 = OpAccessChain %155 %75 %63 
                                         f32 %335 = OpLoad %334 
                                         f32 %336 = OpFMul %333 %335 
                                Private f32* %337 = OpAccessChain %318 %66 
                                                      OpStore %337 %336 
                                Uniform f32* %339 = OpAccessChain %155 %75 %19 
                                         f32 %340 = OpLoad %339 
                                         f32 %341 = OpFNegate %340 
                                         f32 %342 = OpFAdd %341 %17 
                                                      OpStore %338 %342 
                                Private f32* %343 = OpAccessChain %9 %66 
                                         f32 %344 = OpLoad %343 
                                         f32 %345 = OpFNegate %344 
                                Uniform f32* %346 = OpAccessChain %155 %75 %19 
                                         f32 %347 = OpLoad %346 
                                         f32 %348 = OpFMul %345 %347 
                                         f32 %349 = OpLoad %338 
                                         f32 %350 = OpFAdd %348 %349 
                                Private f32* %351 = OpAccessChain %318 %89 
                                                      OpStore %351 %350 
                                       f32_2 %354 = OpLoad %353 
                              Uniform f32_4* %355 = OpAccessChain %155 %75 
                                       f32_4 %356 = OpLoad %355 
                                       f32_2 %357 = OpVectorShuffle %356 %356 2 3 
                                       f32_2 %358 = OpFMul %354 %357 
                                       f32_2 %359 = OpLoad %318 
                                       f32_2 %360 = OpFAdd %358 %359 
                                       f32_4 %361 = OpLoad %9 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 2 3 
                                                      OpStore %9 %362 
                                Uniform f32* %366 = OpAccessChain %155 %75 %66 
                                         f32 %367 = OpLoad %366 
                                        bool %368 = OpFOrdNotEqual %367 %231 
                                                      OpStore %365 %368 
                                        bool %369 = OpLoad %365 
                                                      OpSelectionMerge %373 None 
                                                      OpBranchConditional %369 %372 %376 
                                             %372 = OpLabel 
                                       f32_4 %374 = OpLoad %9 
                                       f32_2 %375 = OpVectorShuffle %374 %374 0 1 
                                                      OpStore %371 %375 
                                                      OpBranch %373 
                                             %376 = OpLabel 
                                       f32_2 %377 = OpLoad %353 
                                                      OpStore %371 %377 
                                                      OpBranch %373 
                                             %373 = OpLabel 
                                       f32_2 %378 = OpLoad %371 
                                       f32_4 %379 = OpLoad %9 
                                       f32_4 %380 = OpVectorShuffle %379 %378 4 5 2 3 
                                                      OpStore %9 %380 
                                       f32_4 %383 = OpLoad %9 
                                       f32_2 %384 = OpVectorShuffle %383 %383 0 1 
                              Uniform f32_4* %385 = OpAccessChain %155 %80 
                                       f32_4 %386 = OpLoad %385 
                                       f32_2 %387 = OpVectorShuffle %386 %386 0 1 
                                       f32_2 %388 = OpFMul %384 %387 
                              Uniform f32_4* %389 = OpAccessChain %155 %80 
                                       f32_4 %390 = OpLoad %389 
                                       f32_2 %391 = OpVectorShuffle %390 %390 2 3 
                                       f32_2 %392 = OpFAdd %388 %391 
                                                      OpStore vs_TEXCOORD1 %392 
                                 Output f32* %393 = OpAccessChain %207 %31 %89 
                                         f32 %394 = OpLoad %393 
                                         f32 %395 = OpFNegate %394 
                                 Output f32* %396 = OpAccessChain %207 %31 %89 
                                                      OpStore %396 %395 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 79
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %55 %70 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpMemberDecorate %29 1 RelaxedPrecision 
                                             OpMemberDecorate %29 1 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %49 RelaxedPrecision 
                                             OpDecorate %50 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 55 
                                             OpDecorate %66 RelaxedPrecision 
                                             OpDecorate %67 RelaxedPrecision 
                                             OpDecorate %70 RelaxedPrecision 
                                             OpDecorate %70 Location 70 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 %24 
                                     %30 = OpTypePointer Uniform %29 
     Uniform struct {f32_4; f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 1 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                 i32 %46 = OpConstant 0 
                                     %52 = OpTypePointer Private %6 
                        Private f32* %53 = OpVariable Private 
                                     %54 = OpTypePointer Input %6 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                 f32 %58 = OpConstant 3.674022E-40 
                                 f32 %59 = OpConstant 3.674022E-40 
                                     %69 = OpTypePointer Output %24 
                       Output f32_4* %70 = OpVariable Output 
                                     %74 = OpTypeInt 32 0 
                                 u32 %75 = OpConstant 3 
                                     %76 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                      Uniform f32_4* %47 = OpAccessChain %31 %46 
                               f32_4 %48 = OpLoad %47 
                               f32_3 %49 = OpVectorShuffle %48 %48 0 1 2 
                               f32_3 %50 = OpFNegate %49 
                               f32_3 %51 = OpFAdd %45 %50 
                                             OpStore %39 %51 
                                 f32 %56 = OpLoad vs_TEXCOORD0 
                                             OpStore %53 %56 
                                 f32 %57 = OpLoad %53 
                                 f32 %60 = OpExtInst %1 43 %57 %58 %59 
                                             OpStore %53 %60 
                                 f32 %61 = OpLoad %53 
                               f32_3 %62 = OpCompositeConstruct %61 %61 %61 
                               f32_3 %63 = OpLoad %39 
                               f32_3 %64 = OpFMul %62 %63 
                      Uniform f32_4* %65 = OpAccessChain %31 %46 
                               f32_4 %66 = OpLoad %65 
                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
                               f32_3 %68 = OpFAdd %64 %67 
                                             OpStore %39 %68 
                               f32_3 %71 = OpLoad %39 
                               f32_4 %72 = OpLoad %70 
                               f32_4 %73 = OpVectorShuffle %72 %71 4 5 6 3 
                                             OpStore %70 %73 
                         Output f32* %77 = OpAccessChain %70 %75 
                                             OpStore %77 %59 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
float u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec2 u_xlat6;
vec3 u_xlat7;
uvec3 u_xlatu7;
bool u_xlatb12;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1 = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1 = floor(u_xlat1);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD0 = exp2(u_xlat0.x);
    u_xlat0 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(unity_ParticleUseMeshColors) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat2.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat2.yzw = vec3(u_xlatu7.xyz);
    u_xlat0 = u_xlat0 * u_xlat2;
    vs_COLOR0 = u_xlat0 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat0.x = u_xlat1 / unity_ParticleUVShiftData.y;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat6.x = (-u_xlat0.x) * unity_ParticleUVShiftData.y + u_xlat1;
    u_xlat6.x = floor(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * unity_ParticleUVShiftData.z;
    u_xlat18 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat6.y = (-u_xlat0.x) * unity_ParticleUVShiftData.w + u_xlat18;
    u_xlat0.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat6.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat0.xy = (bool(u_xlatb12)) ? u_xlat0.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlatb0 = _DstBlend==1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 398
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %207 %248 %252 %302 %353 %382 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %152 ArrayStride 152 
                                                      OpMemberDecorate %153 0 Offset 153 
                                                      OpMemberDecorate %153 1 Offset 153 
                                                      OpMemberDecorate %153 2 Offset 153 
                                                      OpMemberDecorate %153 3 Offset 153 
                                                      OpMemberDecorate %153 4 Offset 153 
                                                      OpMemberDecorate %153 5 Offset 153 
                                                      OpDecorate %153 Block 
                                                      OpDecorate %155 DescriptorSet 155 
                                                      OpDecorate %155 Binding 155 
                                                      OpMemberDecorate %205 0 BuiltIn 205 
                                                      OpMemberDecorate %205 1 BuiltIn 205 
                                                      OpMemberDecorate %205 2 BuiltIn 205 
                                                      OpDecorate %205 Block 
                                                      OpDecorate vs_TEXCOORD0 Location 248 
                                                      OpDecorate %252 RelaxedPrecision 
                                                      OpDecorate %252 Location 252 
                                                      OpDecorate %253 RelaxedPrecision 
                                                      OpDecorate %256 RelaxedPrecision 
                                                      OpDecorate %302 Location 302 
                                                      OpDecorate %353 Location 353 
                                                      OpDecorate vs_TEXCOORD1 Location 382 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                                Private f32* %134 = OpVariable Private 
                                         i32 %136 = OpConstant 13 
                                Private f32* %145 = OpVariable Private 
                                         u32 %151 = OpConstant 4 
                                             %152 = OpTypeArray %7 %151 
                                             %153 = OpTypeStruct %7 %152 %7 %7 %6 %7 
                                             %154 = OpTypePointer Uniform %153 
Uniform struct {f32_4; f32_4[4]; f32_4; f32_4; f32; f32_4;}* %155 = OpVariable Uniform 
                                             %156 = OpTypePointer Uniform %7 
                                             %204 = OpTypeArray %6 %89 
                                             %205 = OpTypeStruct %7 %6 %204 
                                             %206 = OpTypePointer Output %205 
        Output struct {f32_4; f32; f32[1];}* %207 = OpVariable Output 
                                             %209 = OpTypePointer Output %7 
                                             %213 = OpTypePointer Uniform %6 
                                         f32 %231 = OpConstant 3.674022E-40 
                                             %247 = OpTypePointer Output %6 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                                Input f32_4* %252 = OpVariable Input 
                                         f32 %254 = OpConstant 3.674022E-40 
                                       f32_4 %255 = OpConstantComposite %254 %254 %254 %254 
                                       f32_4 %262 = OpConstantComposite %17 %17 %17 %17 
                                             %264 = OpTypeVector %18 3 
                                             %265 = OpTypePointer Private %264 
                              Private u32_3* %266 = OpVariable Private 
                                         u32 %270 = OpConstant 255 
                                             %272 = OpTypePointer Private %18 
                                         i32 %286 = OpConstant 16 
                                         u32 %292 = OpConstant 24 
                               Output f32_4* %302 = OpVariable Output 
                                         f32 %304 = OpConstant 3.674022E-40 
                                       f32_4 %305 = OpConstantComposite %304 %304 %304 %304 
                                             %316 = OpTypeVector %6 2 
                                             %317 = OpTypePointer Private %316 
                              Private f32_2* %318 = OpVariable Private 
                                Private f32* %338 = OpVariable Private 
                                             %352 = OpTypePointer Input %316 
                                Input f32_2* %353 = OpVariable Input 
                                             %363 = OpTypeBool 
                                             %364 = OpTypePointer Private %363 
                               Private bool* %365 = OpVariable Private 
                                             %370 = OpTypePointer Function %316 
                                             %381 = OpTypePointer Output %316 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %371 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %135 = OpLoad %24 
                                Uniform u32* %137 = OpAccessChain %43 %31 %135 %31 %136 
                                         u32 %138 = OpLoad %137 
                                         f32 %139 = OpBitcast %138 
                                                      OpStore %134 %139 
                                         f32 %140 = OpLoad %134 
                                         f32 %141 = OpExtInst %1 8 %140 
                                                      OpStore %134 %141 
                                Private f32* %142 = OpAccessChain %112 %89 
                                         f32 %143 = OpLoad %142 
                                Private f32* %144 = OpAccessChain %62 %19 
                                                      OpStore %144 %143 
                                       f32_4 %146 = OpLoad %62 
                                       f32_4 %147 = OpLoad %9 
                                         f32 %148 = OpDot %146 %147 
                                                      OpStore %145 %148 
                                         f32 %149 = OpLoad %145 
                                       f32_4 %150 = OpCompositeConstruct %149 %149 %149 %149 
                              Uniform f32_4* %157 = OpAccessChain %155 %55 %55 
                                       f32_4 %158 = OpLoad %157 
                                       f32_4 %159 = OpFMul %150 %158 
                                                      OpStore %62 %159 
                                Private f32* %160 = OpAccessChain %36 %89 
                                         f32 %161 = OpLoad %160 
                                Private f32* %162 = OpAccessChain %68 %66 
                                                      OpStore %162 %161 
                                Private f32* %163 = OpAccessChain %68 %63 
                                         f32 %164 = OpLoad %163 
                                Private f32* %165 = OpAccessChain %36 %89 
                                                      OpStore %165 %164 
                                Private f32* %166 = OpAccessChain %92 %66 
                                         f32 %167 = OpLoad %166 
                                Private f32* %168 = OpAccessChain %68 %63 
                                                      OpStore %168 %167 
                                Private f32* %169 = OpAccessChain %92 %63 
                                         f32 %170 = OpLoad %169 
                                Private f32* %171 = OpAccessChain %36 %63 
                                                      OpStore %171 %170 
                                Private f32* %172 = OpAccessChain %112 %66 
                                         f32 %173 = OpLoad %172 
                                Private f32* %174 = OpAccessChain %68 %19 
                                                      OpStore %174 %173 
                                       f32_4 %175 = OpLoad %68 
                                       f32_4 %176 = OpLoad %9 
                                         f32 %177 = OpDot %175 %176 
                                Private f32* %178 = OpAccessChain %92 %66 
                                                      OpStore %178 %177 
                              Uniform f32_4* %179 = OpAccessChain %155 %55 %31 
                                       f32_4 %180 = OpLoad %179 
                                       f32_3 %181 = OpLoad %92 
                                       f32_4 %182 = OpVectorShuffle %181 %181 0 0 0 0 
                                       f32_4 %183 = OpFMul %180 %182 
                                       f32_4 %184 = OpLoad %62 
                                       f32_4 %185 = OpFAdd %183 %184 
                                                      OpStore %62 %185 
                                Private f32* %186 = OpAccessChain %112 %63 
                                         f32 %187 = OpLoad %186 
                                Private f32* %188 = OpAccessChain %36 %19 
                                                      OpStore %188 %187 
                                       f32_4 %189 = OpLoad %36 
                                       f32_4 %190 = OpLoad %9 
                                         f32 %191 = OpDot %189 %190 
                                Private f32* %192 = OpAccessChain %9 %66 
                                                      OpStore %192 %191 
                              Uniform f32_4* %193 = OpAccessChain %155 %55 %45 
                                       f32_4 %194 = OpLoad %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpVectorShuffle %195 %195 0 0 0 0 
                                       f32_4 %197 = OpFMul %194 %196 
                                       f32_4 %198 = OpLoad %62 
                                       f32_4 %199 = OpFAdd %197 %198 
                                                      OpStore %9 %199 
                                       f32_4 %200 = OpLoad %9 
                              Uniform f32_4* %201 = OpAccessChain %155 %55 %75 
                                       f32_4 %202 = OpLoad %201 
                                       f32_4 %203 = OpFAdd %200 %202 
                                                      OpStore %9 %203 
                                       f32_4 %208 = OpLoad %9 
                               Output f32_4* %210 = OpAccessChain %207 %31 
                                                      OpStore %210 %208 
                                Private f32* %211 = OpAccessChain %9 %63 
                                         f32 %212 = OpLoad %211 
                                Uniform f32* %214 = OpAccessChain %155 %31 %89 
                                         f32 %215 = OpLoad %214 
                                         f32 %216 = OpFDiv %212 %215 
                                Private f32* %217 = OpAccessChain %9 %66 
                                                      OpStore %217 %216 
                                Private f32* %218 = OpAccessChain %9 %66 
                                         f32 %219 = OpLoad %218 
                                         f32 %220 = OpFNegate %219 
                                         f32 %221 = OpFAdd %220 %17 
                                Private f32* %222 = OpAccessChain %9 %66 
                                                      OpStore %222 %221 
                                Private f32* %223 = OpAccessChain %9 %66 
                                         f32 %224 = OpLoad %223 
                                Uniform f32* %225 = OpAccessChain %155 %31 %63 
                                         f32 %226 = OpLoad %225 
                                         f32 %227 = OpFMul %224 %226 
                                Private f32* %228 = OpAccessChain %9 %66 
                                                      OpStore %228 %227 
                                Private f32* %229 = OpAccessChain %9 %66 
                                         f32 %230 = OpLoad %229 
                                         f32 %232 = OpExtInst %1 40 %230 %231 
                                Private f32* %233 = OpAccessChain %9 %66 
                                                      OpStore %233 %232 
                                Private f32* %234 = OpAccessChain %9 %66 
                                         f32 %235 = OpLoad %234 
                                Uniform f32* %236 = OpAccessChain %155 %45 %66 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFMul %235 %237 
                                Private f32* %239 = OpAccessChain %9 %66 
                                                      OpStore %239 %238 
                                Private f32* %240 = OpAccessChain %9 %66 
                                         f32 %241 = OpLoad %240 
                                Private f32* %242 = OpAccessChain %9 %66 
                                         f32 %243 = OpLoad %242 
                                         f32 %244 = OpFNegate %243 
                                         f32 %245 = OpFMul %241 %244 
                                Private f32* %246 = OpAccessChain %9 %66 
                                                      OpStore %246 %245 
                                Private f32* %249 = OpAccessChain %9 %66 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpExtInst %1 29 %250 
                                                      OpStore vs_TEXCOORD0 %251 
                                       f32_4 %253 = OpLoad %252 
                                       f32_4 %256 = OpFAdd %253 %255 
                                                      OpStore %9 %256 
                                Uniform f32* %257 = OpAccessChain %155 %70 
                                         f32 %258 = OpLoad %257 
                                       f32_4 %259 = OpCompositeConstruct %258 %258 %258 %258 
                                       f32_4 %260 = OpLoad %9 
                                       f32_4 %261 = OpFMul %259 %260 
                                       f32_4 %263 = OpFAdd %261 %262 
                                                      OpStore %9 %263 
                                Private f32* %267 = OpAccessChain %112 %19 
                                         f32 %268 = OpLoad %267 
                                         u32 %269 = OpBitcast %268 
                                         u32 %271 = OpBitwiseAnd %269 %270 
                                Private u32* %273 = OpAccessChain %266 %66 
                                                      OpStore %273 %271 
                                Private u32* %274 = OpAccessChain %266 %66 
                                         u32 %275 = OpLoad %274 
                                         f32 %276 = OpConvertUToF %275 
                                Private f32* %277 = OpAccessChain %36 %66 
                                                      OpStore %277 %276 
                                Private f32* %278 = OpAccessChain %112 %19 
                                         f32 %279 = OpLoad %278 
                                         u32 %280 = OpBitcast %279 
                                         u32 %281 = OpBitFieldUExtract %280 %104 %104 
                                Private u32* %282 = OpAccessChain %266 %66 
                                                      OpStore %282 %281 
                                Private f32* %283 = OpAccessChain %112 %19 
                                         f32 %284 = OpLoad %283 
                                         u32 %285 = OpBitcast %284 
                                         u32 %287 = OpBitFieldUExtract %285 %286 %104 
                                Private u32* %288 = OpAccessChain %266 %89 
                                                      OpStore %288 %287 
                                Private f32* %289 = OpAccessChain %112 %19 
                                         f32 %290 = OpLoad %289 
                                         u32 %291 = OpBitcast %290 
                                         u32 %293 = OpShiftRightLogical %291 %292 
                                Private u32* %294 = OpAccessChain %266 %63 
                                                      OpStore %294 %293 
                                       u32_3 %295 = OpLoad %266 
                                       f32_3 %296 = OpConvertUToF %295 
                                       f32_4 %297 = OpLoad %36 
                                       f32_4 %298 = OpVectorShuffle %297 %296 0 4 5 6 
                                                      OpStore %36 %298 
                                       f32_4 %299 = OpLoad %9 
                                       f32_4 %300 = OpLoad %36 
                                       f32_4 %301 = OpFMul %299 %300 
                                                      OpStore %9 %301 
                                       f32_4 %303 = OpLoad %9 
                                       f32_4 %306 = OpFMul %303 %305 
                                                      OpStore %302 %306 
                                         f32 %307 = OpLoad %134 
                                Uniform f32* %308 = OpAccessChain %155 %75 %89 
                                         f32 %309 = OpLoad %308 
                                         f32 %310 = OpFDiv %307 %309 
                                Private f32* %311 = OpAccessChain %9 %66 
                                                      OpStore %311 %310 
                                Private f32* %312 = OpAccessChain %9 %66 
                                         f32 %313 = OpLoad %312 
                                         f32 %314 = OpExtInst %1 8 %313 
                                Private f32* %315 = OpAccessChain %9 %66 
                                                      OpStore %315 %314 
                                Private f32* %319 = OpAccessChain %9 %66 
                                         f32 %320 = OpLoad %319 
                                         f32 %321 = OpFNegate %320 
                                Uniform f32* %322 = OpAccessChain %155 %75 %89 
                                         f32 %323 = OpLoad %322 
                                         f32 %324 = OpFMul %321 %323 
                                         f32 %325 = OpLoad %134 
                                         f32 %326 = OpFAdd %324 %325 
                                Private f32* %327 = OpAccessChain %318 %66 
                                                      OpStore %327 %326 
                                Private f32* %328 = OpAccessChain %318 %66 
                                         f32 %329 = OpLoad %328 
                                         f32 %330 = OpExtInst %1 8 %329 
                                Private f32* %331 = OpAccessChain %318 %66 
                                                      OpStore %331 %330 
                                Private f32* %332 = OpAccessChain %318 %66 
                                         f32 %333 = OpLoad %332 
                                Uniform f32* %334 = OpAccessChain %155 %75 %63 
                                         f32 %335 = OpLoad %334 
                                         f32 %336 = OpFMul %333 %335 
                                Private f32* %337 = OpAccessChain %318 %66 
                                                      OpStore %337 %336 
                                Uniform f32* %339 = OpAccessChain %155 %75 %19 
                                         f32 %340 = OpLoad %339 
                                         f32 %341 = OpFNegate %340 
                                         f32 %342 = OpFAdd %341 %17 
                                                      OpStore %338 %342 
                                Private f32* %343 = OpAccessChain %9 %66 
                                         f32 %344 = OpLoad %343 
                                         f32 %345 = OpFNegate %344 
                                Uniform f32* %346 = OpAccessChain %155 %75 %19 
                                         f32 %347 = OpLoad %346 
                                         f32 %348 = OpFMul %345 %347 
                                         f32 %349 = OpLoad %338 
                                         f32 %350 = OpFAdd %348 %349 
                                Private f32* %351 = OpAccessChain %318 %89 
                                                      OpStore %351 %350 
                                       f32_2 %354 = OpLoad %353 
                              Uniform f32_4* %355 = OpAccessChain %155 %75 
                                       f32_4 %356 = OpLoad %355 
                                       f32_2 %357 = OpVectorShuffle %356 %356 2 3 
                                       f32_2 %358 = OpFMul %354 %357 
                                       f32_2 %359 = OpLoad %318 
                                       f32_2 %360 = OpFAdd %358 %359 
                                       f32_4 %361 = OpLoad %9 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 2 3 
                                                      OpStore %9 %362 
                                Uniform f32* %366 = OpAccessChain %155 %75 %66 
                                         f32 %367 = OpLoad %366 
                                        bool %368 = OpFOrdNotEqual %367 %231 
                                                      OpStore %365 %368 
                                        bool %369 = OpLoad %365 
                                                      OpSelectionMerge %373 None 
                                                      OpBranchConditional %369 %372 %376 
                                             %372 = OpLabel 
                                       f32_4 %374 = OpLoad %9 
                                       f32_2 %375 = OpVectorShuffle %374 %374 0 1 
                                                      OpStore %371 %375 
                                                      OpBranch %373 
                                             %376 = OpLabel 
                                       f32_2 %377 = OpLoad %353 
                                                      OpStore %371 %377 
                                                      OpBranch %373 
                                             %373 = OpLabel 
                                       f32_2 %378 = OpLoad %371 
                                       f32_4 %379 = OpLoad %9 
                                       f32_4 %380 = OpVectorShuffle %379 %378 4 5 2 3 
                                                      OpStore %9 %380 
                                       f32_4 %383 = OpLoad %9 
                                       f32_2 %384 = OpVectorShuffle %383 %383 0 1 
                              Uniform f32_4* %385 = OpAccessChain %155 %80 
                                       f32_4 %386 = OpLoad %385 
                                       f32_2 %387 = OpVectorShuffle %386 %386 0 1 
                                       f32_2 %388 = OpFMul %384 %387 
                              Uniform f32_4* %389 = OpAccessChain %155 %80 
                                       f32_4 %390 = OpLoad %389 
                                       f32_2 %391 = OpVectorShuffle %390 %390 2 3 
                                       f32_2 %392 = OpFAdd %388 %391 
                                                      OpStore vs_TEXCOORD1 %392 
                                 Output f32* %393 = OpAccessChain %207 %31 %89 
                                         f32 %394 = OpLoad %393 
                                         f32 %395 = OpFNegate %394 
                                 Output f32* %396 = OpAccessChain %207 %31 %89 
                                                      OpStore %396 %395 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 110
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %35 %50 %66 %92 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpMemberDecorate %12 0 RelaxedPrecision 
                                             OpMemberDecorate %12 0 Offset 12 
                                             OpMemberDecorate %12 1 RelaxedPrecision 
                                             OpMemberDecorate %12 1 Offset 12 
                                             OpMemberDecorate %12 2 Offset 12 
                                             OpDecorate %12 Block 
                                             OpDecorate %14 DescriptorSet 14 
                                             OpDecorate %14 Binding 14 
                                             OpDecorate %22 RelaxedPrecision 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %25 DescriptorSet 25 
                                             OpDecorate %25 Binding 25 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %30 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 35 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %39 RelaxedPrecision 
                                             OpDecorate %42 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %50 Location 50 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %57 RelaxedPrecision 
                                             OpDecorate %58 RelaxedPrecision 
                                             OpDecorate %61 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 66 
                                             OpDecorate %83 RelaxedPrecision 
                                             OpDecorate %84 RelaxedPrecision 
                                             OpDecorate %92 RelaxedPrecision 
                                             OpDecorate %92 Location 92 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeBool 
                                      %7 = OpTypePointer Private %6 
                        Private bool* %8 = OpVariable Private 
                                      %9 = OpTypeFloat 32 
                                     %10 = OpTypeVector %9 4 
                                     %11 = OpTypeInt 32 1 
                                     %12 = OpTypeStruct %10 %10 %11 
                                     %13 = OpTypePointer Uniform %12 
Uniform struct {f32_4; f32_4; i32;}* %14 = OpVariable Uniform 
                                 i32 %15 = OpConstant 2 
                                     %16 = OpTypePointer Uniform %11 
                                 i32 %19 = OpConstant 1 
                                     %21 = OpTypePointer Private %10 
                      Private f32_4* %22 = OpVariable Private 
                                     %23 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
                                     %24 = OpTypePointer UniformConstant %23 
UniformConstant read_only Texture2D* %25 = OpVariable UniformConstant 
                                     %27 = OpTypeSampler 
                                     %28 = OpTypePointer UniformConstant %27 
            UniformConstant sampler* %29 = OpVariable UniformConstant 
                                     %31 = OpTypeSampledImage %23 
                                     %33 = OpTypeVector %9 2 
                                     %34 = OpTypePointer Input %33 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %38 = OpVariable Private 
                                     %40 = OpTypePointer Uniform %10 
                                     %44 = OpTypeVector %9 3 
                                     %45 = OpTypePointer Private %44 
                      Private f32_3* %46 = OpVariable Private 
                                     %49 = OpTypePointer Input %10 
                        Input f32_4* %50 = OpVariable Input 
                                 i32 %54 = OpConstant 0 
                      Private f32_4* %60 = OpVariable Private 
                      Private f32_3* %64 = OpVariable Private 
                                     %65 = OpTypePointer Input %9 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                     %68 = OpTypeInt 32 0 
                                 u32 %69 = OpConstant 0 
                                     %70 = OpTypePointer Private %9 
                                 f32 %74 = OpConstant 3.674022E-40 
                                 f32 %75 = OpConstant 3.674022E-40 
                                     %91 = OpTypePointer Output %10 
                       Output f32_4* %92 = OpVariable Output 
                                 u32 %93 = OpConstant 3 
                                     %96 = OpTypePointer Output %9 
                                     %99 = OpTypePointer Function %44 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                    Function f32_3* %100 = OpVariable Function 
                        Uniform i32* %17 = OpAccessChain %14 %15 
                                 i32 %18 = OpLoad %17 
                                bool %20 = OpIEqual %18 %19 
                                             OpStore %8 %20 
                 read_only Texture2D %26 = OpLoad %25 
                             sampler %30 = OpLoad %29 
          read_only Texture2DSampled %32 = OpSampledImage %26 %30 
                               f32_2 %36 = OpLoad vs_TEXCOORD1 
                               f32_4 %37 = OpImageSampleImplicitLod %32 %36 
                                             OpStore %22 %37 
                               f32_4 %39 = OpLoad %22 
                      Uniform f32_4* %41 = OpAccessChain %14 %19 
                               f32_4 %42 = OpLoad %41 
                               f32_4 %43 = OpFMul %39 %42 
                                             OpStore %38 %43 
                               f32_4 %47 = OpLoad %38 
                               f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                               f32_4 %51 = OpLoad %50 
                               f32_3 %52 = OpVectorShuffle %51 %51 0 1 2 
                               f32_3 %53 = OpFMul %48 %52 
                      Uniform f32_4* %55 = OpAccessChain %14 %54 
                               f32_4 %56 = OpLoad %55 
                               f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                               f32_3 %58 = OpFNegate %57 
                               f32_3 %59 = OpFAdd %53 %58 
                                             OpStore %46 %59 
                               f32_4 %61 = OpLoad %38 
                               f32_4 %62 = OpLoad %50 
                               f32_4 %63 = OpFMul %61 %62 
                                             OpStore %60 %63 
                                 f32 %67 = OpLoad vs_TEXCOORD0 
                        Private f32* %71 = OpAccessChain %64 %69 
                                             OpStore %71 %67 
                        Private f32* %72 = OpAccessChain %64 %69 
                                 f32 %73 = OpLoad %72 
                                 f32 %76 = OpExtInst %1 43 %73 %74 %75 
                        Private f32* %77 = OpAccessChain %64 %69 
                                             OpStore %77 %76 
                               f32_3 %78 = OpLoad %64 
                               f32_3 %79 = OpVectorShuffle %78 %78 0 0 0 
                               f32_3 %80 = OpLoad %46 
                               f32_3 %81 = OpFMul %79 %80 
                      Uniform f32_4* %82 = OpAccessChain %14 %54 
                               f32_4 %83 = OpLoad %82 
                               f32_3 %84 = OpVectorShuffle %83 %83 0 1 2 
                               f32_3 %85 = OpFAdd %81 %84 
                                             OpStore %46 %85 
                               f32_4 %86 = OpLoad %60 
                               f32_3 %87 = OpVectorShuffle %86 %86 0 1 2 
                               f32_3 %88 = OpLoad %64 
                               f32_3 %89 = OpVectorShuffle %88 %88 0 0 0 
                               f32_3 %90 = OpFMul %87 %89 
                                             OpStore %64 %90 
                        Private f32* %94 = OpAccessChain %60 %93 
                                 f32 %95 = OpLoad %94 
                         Output f32* %97 = OpAccessChain %92 %93 
                                             OpStore %97 %95 
                                bool %98 = OpLoad %8 
                                             OpSelectionMerge %102 None 
                                             OpBranchConditional %98 %101 %104 
                                    %101 = OpLabel 
                              f32_3 %103 = OpLoad %64 
                                             OpStore %100 %103 
                                             OpBranch %102 
                                    %104 = OpLabel 
                              f32_3 %105 = OpLoad %46 
                                             OpStore %100 %105 
                                             OpBranch %102 
                                    %102 = OpLabel 
                              f32_3 %106 = OpLoad %100 
                              f32_4 %107 = OpLoad %92 
                              f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
                                             OpStore %92 %108 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SOFTPARTICLES_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 177
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %89 %91 %139 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpMemberDecorate %78 0 BuiltIn 78 
                                                      OpMemberDecorate %78 1 BuiltIn 78 
                                                      OpMemberDecorate %78 2 BuiltIn 78 
                                                      OpDecorate %78 Block 
                                                      OpDecorate %84 Location 84 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %85 Location 85 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 89 
                                                      OpDecorate %91 Location 91 
                                                      OpDecorate vs_TEXCOORD3 Location 139 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 1 
                                              %24 = OpTypePointer Uniform %7 
                                          i32 %28 = OpConstant 0 
                                          i32 %36 = OpConstant 2 
                                          i32 %45 = OpConstant 3 
                               Private f32_4* %49 = OpVariable Private 
                                          u32 %76 = OpConstant 1 
                                              %77 = OpTypeArray %6 %76 
                                              %78 = OpTypeStruct %7 %6 %77 
                                              %79 = OpTypePointer Output %78 
         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
                                              %82 = OpTypePointer Output %7 
                                Output f32_4* %84 = OpVariable Output 
                                 Input f32_4* %85 = OpVariable Input 
                                              %87 = OpTypeVector %6 2 
                                              %88 = OpTypePointer Output %87 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                              %90 = OpTypePointer Input %87 
                                 Input f32_2* %91 = OpVariable Input 
                                          i32 %93 = OpConstant 4 
                                             %102 = OpTypePointer Private %6 
                                Private f32* %103 = OpVariable Private 
                                         u32 %106 = OpConstant 2 
                                             %107 = OpTypePointer Uniform %6 
                                         u32 %113 = OpConstant 0 
                                         u32 %131 = OpConstant 3 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %143 = OpTypePointer Output %6 
                                         f32 %153 = OpConstant 3.674022E-40 
                                       f32_2 %158 = OpConstantComposite %153 %153 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
                                        f32_4 %26 = OpLoad %25 
                                        f32_4 %27 = OpFMul %13 %26 
                                                      OpStore %9 %27 
                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
                                        f32_4 %30 = OpLoad %29 
                                        f32_4 %31 = OpLoad %11 
                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
                                        f32_4 %33 = OpFMul %30 %32 
                                        f32_4 %34 = OpLoad %9 
                                        f32_4 %35 = OpFAdd %33 %34 
                                                      OpStore %9 %35 
                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
                                        f32_4 %38 = OpLoad %37 
                                        f32_4 %39 = OpLoad %11 
                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
                                        f32_4 %41 = OpFMul %38 %40 
                                        f32_4 %42 = OpLoad %9 
                                        f32_4 %43 = OpFAdd %41 %42 
                                                      OpStore %9 %43 
                                        f32_4 %44 = OpLoad %9 
                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_4 %48 = OpFAdd %44 %47 
                                                      OpStore %9 %48 
                                        f32_4 %50 = OpLoad %9 
                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
                                        f32_4 %53 = OpLoad %52 
                                        f32_4 %54 = OpFMul %51 %53 
                                                      OpStore %49 %54 
                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
                                        f32_4 %56 = OpLoad %55 
                                        f32_4 %57 = OpLoad %9 
                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
                                        f32_4 %59 = OpFMul %56 %58 
                                        f32_4 %60 = OpLoad %49 
                                        f32_4 %61 = OpFAdd %59 %60 
                                                      OpStore %49 %61 
                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
                                        f32_4 %63 = OpLoad %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
                                        f32_4 %66 = OpFMul %63 %65 
                                        f32_4 %67 = OpLoad %49 
                                        f32_4 %68 = OpFAdd %66 %67 
                                                      OpStore %49 %68 
                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpLoad %9 
                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
                                        f32_4 %73 = OpFMul %70 %72 
                                        f32_4 %74 = OpLoad %49 
                                        f32_4 %75 = OpFAdd %73 %74 
                                                      OpStore %49 %75 
                                        f32_4 %81 = OpLoad %49 
                                Output f32_4* %83 = OpAccessChain %80 %28 
                                                      OpStore %83 %81 
                                        f32_4 %86 = OpLoad %85 
                                                      OpStore %84 %86 
                                        f32_2 %92 = OpLoad %91 
                               Uniform f32_4* %94 = OpAccessChain %21 %93 
                                        f32_4 %95 = OpLoad %94 
                                        f32_2 %96 = OpVectorShuffle %95 %95 0 1 
                                        f32_2 %97 = OpFMul %92 %96 
                               Uniform f32_4* %98 = OpAccessChain %21 %93 
                                        f32_4 %99 = OpLoad %98 
                                       f32_2 %100 = OpVectorShuffle %99 %99 2 3 
                                       f32_2 %101 = OpFAdd %97 %100 
                                                      OpStore vs_TEXCOORD1 %101 
                                Private f32* %104 = OpAccessChain %9 %76 
                                         f32 %105 = OpLoad %104 
                                Uniform f32* %108 = OpAccessChain %21 %36 %23 %106 
                                         f32 %109 = OpLoad %108 
                                         f32 %110 = OpFMul %105 %109 
                                                      OpStore %103 %110 
                                Uniform f32* %111 = OpAccessChain %21 %36 %28 %106 
                                         f32 %112 = OpLoad %111 
                                Private f32* %114 = OpAccessChain %9 %113 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %112 %115 
                                         f32 %117 = OpLoad %103 
                                         f32 %118 = OpFAdd %116 %117 
                                Private f32* %119 = OpAccessChain %9 %113 
                                                      OpStore %119 %118 
                                Uniform f32* %120 = OpAccessChain %21 %36 %36 %106 
                                         f32 %121 = OpLoad %120 
                                Private f32* %122 = OpAccessChain %9 %106 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                Private f32* %125 = OpAccessChain %9 %113 
                                         f32 %126 = OpLoad %125 
                                         f32 %127 = OpFAdd %124 %126 
                                Private f32* %128 = OpAccessChain %9 %113 
                                                      OpStore %128 %127 
                                Uniform f32* %129 = OpAccessChain %21 %36 %45 %106 
                                         f32 %130 = OpLoad %129 
                                Private f32* %132 = OpAccessChain %9 %131 
                                         f32 %133 = OpLoad %132 
                                         f32 %134 = OpFMul %130 %133 
                                Private f32* %135 = OpAccessChain %9 %113 
                                         f32 %136 = OpLoad %135 
                                         f32 %137 = OpFAdd %134 %136 
                                Private f32* %138 = OpAccessChain %9 %113 
                                                      OpStore %138 %137 
                                Private f32* %140 = OpAccessChain %9 %113 
                                         f32 %141 = OpLoad %140 
                                         f32 %142 = OpFNegate %141 
                                 Output f32* %144 = OpAccessChain vs_TEXCOORD3 %106 
                                                      OpStore %144 %142 
                                Private f32* %145 = OpAccessChain %49 %76 
                                         f32 %146 = OpLoad %145 
                                Uniform f32* %147 = OpAccessChain %21 %28 %113 
                                         f32 %148 = OpLoad %147 
                                         f32 %149 = OpFMul %146 %148 
                                Private f32* %150 = OpAccessChain %9 %113 
                                                      OpStore %150 %149 
                                Private f32* %151 = OpAccessChain %9 %113 
                                         f32 %152 = OpLoad %151 
                                         f32 %154 = OpFMul %152 %153 
                                Private f32* %155 = OpAccessChain %9 %131 
                                                      OpStore %155 %154 
                                       f32_4 %156 = OpLoad %49 
                                       f32_2 %157 = OpVectorShuffle %156 %156 0 3 
                                       f32_2 %159 = OpFMul %157 %158 
                                       f32_4 %160 = OpLoad %9 
                                       f32_4 %161 = OpVectorShuffle %160 %159 4 1 5 3 
                                                      OpStore %9 %161 
                                Private f32* %162 = OpAccessChain %49 %131 
                                         f32 %163 = OpLoad %162 
                                 Output f32* %164 = OpAccessChain vs_TEXCOORD3 %131 
                                                      OpStore %164 %163 
                                       f32_4 %165 = OpLoad %9 
                                       f32_2 %166 = OpVectorShuffle %165 %165 2 2 
                                       f32_4 %167 = OpLoad %9 
                                       f32_2 %168 = OpVectorShuffle %167 %167 0 3 
                                       f32_2 %169 = OpFAdd %166 %168 
                                       f32_4 %170 = OpLoad vs_TEXCOORD3 
                                       f32_4 %171 = OpVectorShuffle %170 %169 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %171 
                                 Output f32* %172 = OpAccessChain %80 %28 %76 
                                         f32 %173 = OpLoad %172 
                                         f32 %174 = OpFNegate %173 
                                 Output f32* %175 = OpAccessChain %80 %28 %76 
                                                      OpStore %175 %174 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 57
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %47 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %47 Location 47 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 
                                     %30 = OpTypePointer Uniform %29 
            Uniform struct {f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 0 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                     %46 = OpTypePointer Output %24 
                       Output f32_4* %47 = OpVariable Output 
                                 f32 %51 = OpConstant 3.674022E-40 
                                     %52 = OpTypeInt 32 0 
                                 u32 %53 = OpConstant 3 
                                     %54 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                                             OpStore %39 %45 
                               f32_3 %48 = OpLoad %39 
                               f32_4 %49 = OpLoad %47 
                               f32_4 %50 = OpVectorShuffle %49 %48 4 5 6 3 
                                             OpStore %47 %50 
                         Output f32* %55 = OpAccessChain %47 %53 
                                             OpStore %55 %51 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 177
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %89 %91 %139 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpMemberDecorate %78 0 BuiltIn 78 
                                                      OpMemberDecorate %78 1 BuiltIn 78 
                                                      OpMemberDecorate %78 2 BuiltIn 78 
                                                      OpDecorate %78 Block 
                                                      OpDecorate %84 Location 84 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %85 Location 85 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 89 
                                                      OpDecorate %91 Location 91 
                                                      OpDecorate vs_TEXCOORD3 Location 139 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 1 
                                              %24 = OpTypePointer Uniform %7 
                                          i32 %28 = OpConstant 0 
                                          i32 %36 = OpConstant 2 
                                          i32 %45 = OpConstant 3 
                               Private f32_4* %49 = OpVariable Private 
                                          u32 %76 = OpConstant 1 
                                              %77 = OpTypeArray %6 %76 
                                              %78 = OpTypeStruct %7 %6 %77 
                                              %79 = OpTypePointer Output %78 
         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
                                              %82 = OpTypePointer Output %7 
                                Output f32_4* %84 = OpVariable Output 
                                 Input f32_4* %85 = OpVariable Input 
                                              %87 = OpTypeVector %6 2 
                                              %88 = OpTypePointer Output %87 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                              %90 = OpTypePointer Input %87 
                                 Input f32_2* %91 = OpVariable Input 
                                          i32 %93 = OpConstant 4 
                                             %102 = OpTypePointer Private %6 
                                Private f32* %103 = OpVariable Private 
                                         u32 %106 = OpConstant 2 
                                             %107 = OpTypePointer Uniform %6 
                                         u32 %113 = OpConstant 0 
                                         u32 %131 = OpConstant 3 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %143 = OpTypePointer Output %6 
                                         f32 %153 = OpConstant 3.674022E-40 
                                       f32_2 %158 = OpConstantComposite %153 %153 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
                                        f32_4 %26 = OpLoad %25 
                                        f32_4 %27 = OpFMul %13 %26 
                                                      OpStore %9 %27 
                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
                                        f32_4 %30 = OpLoad %29 
                                        f32_4 %31 = OpLoad %11 
                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
                                        f32_4 %33 = OpFMul %30 %32 
                                        f32_4 %34 = OpLoad %9 
                                        f32_4 %35 = OpFAdd %33 %34 
                                                      OpStore %9 %35 
                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
                                        f32_4 %38 = OpLoad %37 
                                        f32_4 %39 = OpLoad %11 
                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
                                        f32_4 %41 = OpFMul %38 %40 
                                        f32_4 %42 = OpLoad %9 
                                        f32_4 %43 = OpFAdd %41 %42 
                                                      OpStore %9 %43 
                                        f32_4 %44 = OpLoad %9 
                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_4 %48 = OpFAdd %44 %47 
                                                      OpStore %9 %48 
                                        f32_4 %50 = OpLoad %9 
                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
                                        f32_4 %53 = OpLoad %52 
                                        f32_4 %54 = OpFMul %51 %53 
                                                      OpStore %49 %54 
                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
                                        f32_4 %56 = OpLoad %55 
                                        f32_4 %57 = OpLoad %9 
                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
                                        f32_4 %59 = OpFMul %56 %58 
                                        f32_4 %60 = OpLoad %49 
                                        f32_4 %61 = OpFAdd %59 %60 
                                                      OpStore %49 %61 
                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
                                        f32_4 %63 = OpLoad %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
                                        f32_4 %66 = OpFMul %63 %65 
                                        f32_4 %67 = OpLoad %49 
                                        f32_4 %68 = OpFAdd %66 %67 
                                                      OpStore %49 %68 
                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpLoad %9 
                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
                                        f32_4 %73 = OpFMul %70 %72 
                                        f32_4 %74 = OpLoad %49 
                                        f32_4 %75 = OpFAdd %73 %74 
                                                      OpStore %49 %75 
                                        f32_4 %81 = OpLoad %49 
                                Output f32_4* %83 = OpAccessChain %80 %28 
                                                      OpStore %83 %81 
                                        f32_4 %86 = OpLoad %85 
                                                      OpStore %84 %86 
                                        f32_2 %92 = OpLoad %91 
                               Uniform f32_4* %94 = OpAccessChain %21 %93 
                                        f32_4 %95 = OpLoad %94 
                                        f32_2 %96 = OpVectorShuffle %95 %95 0 1 
                                        f32_2 %97 = OpFMul %92 %96 
                               Uniform f32_4* %98 = OpAccessChain %21 %93 
                                        f32_4 %99 = OpLoad %98 
                                       f32_2 %100 = OpVectorShuffle %99 %99 2 3 
                                       f32_2 %101 = OpFAdd %97 %100 
                                                      OpStore vs_TEXCOORD1 %101 
                                Private f32* %104 = OpAccessChain %9 %76 
                                         f32 %105 = OpLoad %104 
                                Uniform f32* %108 = OpAccessChain %21 %36 %23 %106 
                                         f32 %109 = OpLoad %108 
                                         f32 %110 = OpFMul %105 %109 
                                                      OpStore %103 %110 
                                Uniform f32* %111 = OpAccessChain %21 %36 %28 %106 
                                         f32 %112 = OpLoad %111 
                                Private f32* %114 = OpAccessChain %9 %113 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %112 %115 
                                         f32 %117 = OpLoad %103 
                                         f32 %118 = OpFAdd %116 %117 
                                Private f32* %119 = OpAccessChain %9 %113 
                                                      OpStore %119 %118 
                                Uniform f32* %120 = OpAccessChain %21 %36 %36 %106 
                                         f32 %121 = OpLoad %120 
                                Private f32* %122 = OpAccessChain %9 %106 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                Private f32* %125 = OpAccessChain %9 %113 
                                         f32 %126 = OpLoad %125 
                                         f32 %127 = OpFAdd %124 %126 
                                Private f32* %128 = OpAccessChain %9 %113 
                                                      OpStore %128 %127 
                                Uniform f32* %129 = OpAccessChain %21 %36 %45 %106 
                                         f32 %130 = OpLoad %129 
                                Private f32* %132 = OpAccessChain %9 %131 
                                         f32 %133 = OpLoad %132 
                                         f32 %134 = OpFMul %130 %133 
                                Private f32* %135 = OpAccessChain %9 %113 
                                         f32 %136 = OpLoad %135 
                                         f32 %137 = OpFAdd %134 %136 
                                Private f32* %138 = OpAccessChain %9 %113 
                                                      OpStore %138 %137 
                                Private f32* %140 = OpAccessChain %9 %113 
                                         f32 %141 = OpLoad %140 
                                         f32 %142 = OpFNegate %141 
                                 Output f32* %144 = OpAccessChain vs_TEXCOORD3 %106 
                                                      OpStore %144 %142 
                                Private f32* %145 = OpAccessChain %49 %76 
                                         f32 %146 = OpLoad %145 
                                Uniform f32* %147 = OpAccessChain %21 %28 %113 
                                         f32 %148 = OpLoad %147 
                                         f32 %149 = OpFMul %146 %148 
                                Private f32* %150 = OpAccessChain %9 %113 
                                                      OpStore %150 %149 
                                Private f32* %151 = OpAccessChain %9 %113 
                                         f32 %152 = OpLoad %151 
                                         f32 %154 = OpFMul %152 %153 
                                Private f32* %155 = OpAccessChain %9 %131 
                                                      OpStore %155 %154 
                                       f32_4 %156 = OpLoad %49 
                                       f32_2 %157 = OpVectorShuffle %156 %156 0 3 
                                       f32_2 %159 = OpFMul %157 %158 
                                       f32_4 %160 = OpLoad %9 
                                       f32_4 %161 = OpVectorShuffle %160 %159 4 1 5 3 
                                                      OpStore %9 %161 
                                Private f32* %162 = OpAccessChain %49 %131 
                                         f32 %163 = OpLoad %162 
                                 Output f32* %164 = OpAccessChain vs_TEXCOORD3 %131 
                                                      OpStore %164 %163 
                                       f32_4 %165 = OpLoad %9 
                                       f32_2 %166 = OpVectorShuffle %165 %165 2 2 
                                       f32_4 %167 = OpLoad %9 
                                       f32_2 %168 = OpVectorShuffle %167 %167 0 3 
                                       f32_2 %169 = OpFAdd %166 %168 
                                       f32_4 %170 = OpLoad vs_TEXCOORD3 
                                       f32_4 %171 = OpVectorShuffle %170 %169 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %171 
                                 Output f32* %172 = OpAccessChain %80 %28 %76 
                                         f32 %173 = OpLoad %172 
                                         f32 %174 = OpFNegate %173 
                                 Output f32* %175 = OpAccessChain %80 %28 %76 
                                                      OpStore %175 %174 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 46
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %39 %43 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpMemberDecorate %27 0 RelaxedPrecision 
                                             OpMemberDecorate %27 0 Offset 27 
                                             OpDecorate %27 Block 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %39 Location 39 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %43 Location 43 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypeVector %6 4 
                                      %8 = OpTypePointer Private %7 
                       Private f32_4* %9 = OpVariable Private 
                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %11 = OpTypePointer UniformConstant %10 
UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                     %14 = OpTypeSampler 
                                     %15 = OpTypePointer UniformConstant %14 
            UniformConstant sampler* %16 = OpVariable UniformConstant 
                                     %18 = OpTypeSampledImage %10 
                                     %20 = OpTypeVector %6 2 
                                     %21 = OpTypePointer Input %20 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %25 = OpVariable Private 
                                     %27 = OpTypeStruct %7 
                                     %28 = OpTypePointer Uniform %27 
            Uniform struct {f32_4;}* %29 = OpVariable Uniform 
                                     %30 = OpTypeInt 32 1 
                                 i32 %31 = OpConstant 0 
                                     %32 = OpTypePointer Uniform %7 
                      Private f32_4* %36 = OpVariable Private 
                                     %38 = OpTypePointer Input %7 
                        Input f32_4* %39 = OpVariable Input 
                                     %42 = OpTypePointer Output %7 
                       Output f32_4* %43 = OpVariable Output 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                             OpStore %9 %24 
                               f32_4 %26 = OpLoad %9 
                      Uniform f32_4* %33 = OpAccessChain %29 %31 
                               f32_4 %34 = OpLoad %33 
                               f32_4 %35 = OpFMul %26 %34 
                                             OpStore %25 %35 
                               f32_4 %37 = OpLoad %25 
                               f32_4 %40 = OpLoad %39 
                               f32_4 %41 = OpFMul %37 %40 
                                             OpStore %36 %41 
                               f32_4 %44 = OpLoad %36 
                                             OpStore %43 %44 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 416
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %233 %246 %249 %301 %346 %377 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %155 ArrayStride 155 
                                                      OpDecorate %156 ArrayStride 156 
                                                      OpMemberDecorate %157 0 Offset 157 
                                                      OpMemberDecorate %157 1 Offset 157 
                                                      OpMemberDecorate %157 2 Offset 157 
                                                      OpMemberDecorate %157 3 Offset 157 
                                                      OpMemberDecorate %157 4 Offset 157 
                                                      OpMemberDecorate %157 5 Offset 157 
                                                      OpDecorate %157 Block 
                                                      OpDecorate %159 DescriptorSet 159 
                                                      OpDecorate %159 Binding 159 
                                                      OpDecorate vs_TEXCOORD3 Location 233 
                                                      OpMemberDecorate %244 0 BuiltIn 244 
                                                      OpMemberDecorate %244 1 BuiltIn 244 
                                                      OpMemberDecorate %244 2 BuiltIn 244 
                                                      OpDecorate %244 Block 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %250 RelaxedPrecision 
                                                      OpDecorate %253 RelaxedPrecision 
                                                      OpDecorate %301 Location 301 
                                                      OpDecorate %346 Location 346 
                                                      OpDecorate vs_TEXCOORD1 Location 377 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                              Private f32_4* %134 = OpVariable Private 
                                         i32 %136 = OpConstant 13 
                                Private f32* %148 = OpVariable Private 
                                         u32 %154 = OpConstant 4 
                                             %155 = OpTypeArray %7 %154 
                                             %156 = OpTypeArray %7 %154 
                                             %157 = OpTypeStruct %7 %155 %156 %7 %6 %7 
                                             %158 = OpTypePointer Uniform %157 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32_4;}* %159 = OpVariable Uniform 
                                             %160 = OpTypePointer Uniform %7 
                                             %165 = OpTypePointer Uniform %6 
                                             %232 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %237 = OpTypePointer Output %6 
                                             %243 = OpTypeArray %6 %89 
                                             %244 = OpTypeStruct %7 %6 %243 
                                             %245 = OpTypePointer Output %244 
        Output struct {f32_4; f32; f32[1];}* %246 = OpVariable Output 
                                Input f32_4* %249 = OpVariable Input 
                                         f32 %251 = OpConstant 3.674022E-40 
                                       f32_4 %252 = OpConstantComposite %251 %251 %251 %251 
                                       f32_4 %259 = OpConstantComposite %17 %17 %17 %17 
                                             %261 = OpTypePointer Private %18 
                                Private u32* %262 = OpVariable Private 
                                         u32 %266 = OpConstant 255 
                                             %271 = OpTypeVector %18 2 
                                             %272 = OpTypePointer Private %271 
                              Private u32_2* %273 = OpVariable Private 
                                         i32 %282 = OpConstant 16 
                                         u32 %288 = OpConstant 24 
                                             %294 = OpTypeVector %6 2 
                               Output f32_4* %301 = OpVariable Output 
                                         f32 %303 = OpConstant 3.674022E-40 
                                       f32_4 %304 = OpConstantComposite %303 %303 %303 %303 
                                Private f32* %306 = OpVariable Private 
                                             %345 = OpTypePointer Input %294 
                                Input f32_2* %346 = OpVariable Input 
                                             %357 = OpTypeBool 
                                             %358 = OpTypePointer Private %357 
                               Private bool* %359 = OpVariable Private 
                                         f32 %362 = OpConstant 3.674022E-40 
                                             %365 = OpTypePointer Function %294 
                                             %376 = OpTypePointer Output %294 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                         f32 %396 = OpConstant 3.674022E-40 
                                       f32_3 %397 = OpConstantComposite %396 %396 %396 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %366 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %135 = OpLoad %24 
                                Uniform u32* %137 = OpAccessChain %43 %31 %135 %31 %136 
                                         u32 %138 = OpLoad %137 
                                         f32 %139 = OpBitcast %138 
                                Private f32* %140 = OpAccessChain %134 %66 
                                                      OpStore %140 %139 
                                Private f32* %141 = OpAccessChain %134 %66 
                                         f32 %142 = OpLoad %141 
                                         f32 %143 = OpExtInst %1 8 %142 
                                Private f32* %144 = OpAccessChain %134 %66 
                                                      OpStore %144 %143 
                                Private f32* %145 = OpAccessChain %112 %89 
                                         f32 %146 = OpLoad %145 
                                Private f32* %147 = OpAccessChain %62 %19 
                                                      OpStore %147 %146 
                                       f32_4 %149 = OpLoad %62 
                                       f32_4 %150 = OpLoad %9 
                                         f32 %151 = OpDot %149 %150 
                                                      OpStore %148 %151 
                                         f32 %152 = OpLoad %148 
                                       f32_4 %153 = OpCompositeConstruct %152 %152 %152 %152 
                              Uniform f32_4* %161 = OpAccessChain %159 %45 %55 
                                       f32_4 %162 = OpLoad %161 
                                       f32_4 %163 = OpFMul %153 %162 
                                                      OpStore %62 %163 
                                         f32 %164 = OpLoad %148 
                                Uniform f32* %166 = OpAccessChain %159 %55 %55 %63 
                                         f32 %167 = OpLoad %166 
                                         f32 %168 = OpFMul %164 %167 
                                                      OpStore %148 %168 
                                Private f32* %169 = OpAccessChain %36 %89 
                                         f32 %170 = OpLoad %169 
                                Private f32* %171 = OpAccessChain %68 %66 
                                                      OpStore %171 %170 
                                Private f32* %172 = OpAccessChain %68 %63 
                                         f32 %173 = OpLoad %172 
                                Private f32* %174 = OpAccessChain %36 %89 
                                                      OpStore %174 %173 
                                Private f32* %175 = OpAccessChain %92 %66 
                                         f32 %176 = OpLoad %175 
                                Private f32* %177 = OpAccessChain %68 %63 
                                                      OpStore %177 %176 
                                Private f32* %178 = OpAccessChain %92 %63 
                                         f32 %179 = OpLoad %178 
                                Private f32* %180 = OpAccessChain %36 %63 
                                                      OpStore %180 %179 
                                Private f32* %181 = OpAccessChain %112 %66 
                                         f32 %182 = OpLoad %181 
                                Private f32* %183 = OpAccessChain %68 %19 
                                                      OpStore %183 %182 
                                       f32_4 %184 = OpLoad %68 
                                       f32_4 %185 = OpLoad %9 
                                         f32 %186 = OpDot %184 %185 
                                Private f32* %187 = OpAccessChain %92 %66 
                                                      OpStore %187 %186 
                              Uniform f32_4* %188 = OpAccessChain %159 %45 %31 
                                       f32_4 %189 = OpLoad %188 
                                       f32_3 %190 = OpLoad %92 
                                       f32_4 %191 = OpVectorShuffle %190 %190 0 0 0 0 
                                       f32_4 %192 = OpFMul %189 %191 
                                       f32_4 %193 = OpLoad %62 
                                       f32_4 %194 = OpFAdd %192 %193 
                                                      OpStore %62 %194 
                                Uniform f32* %195 = OpAccessChain %159 %55 %31 %63 
                                         f32 %196 = OpLoad %195 
                                Private f32* %197 = OpAccessChain %92 %66 
                                         f32 %198 = OpLoad %197 
                                         f32 %199 = OpFMul %196 %198 
                                         f32 %200 = OpLoad %148 
                                         f32 %201 = OpFAdd %199 %200 
                                Private f32* %202 = OpAccessChain %92 %66 
                                                      OpStore %202 %201 
                                Private f32* %203 = OpAccessChain %112 %63 
                                         f32 %204 = OpLoad %203 
                                Private f32* %205 = OpAccessChain %36 %19 
                                                      OpStore %205 %204 
                                       f32_4 %206 = OpLoad %36 
                                       f32_4 %207 = OpLoad %9 
                                         f32 %208 = OpDot %206 %207 
                                Private f32* %209 = OpAccessChain %9 %66 
                                                      OpStore %209 %208 
                              Uniform f32_4* %210 = OpAccessChain %159 %45 %45 
                                       f32_4 %211 = OpLoad %210 
                                       f32_4 %212 = OpLoad %9 
                                       f32_4 %213 = OpVectorShuffle %212 %212 0 0 0 0 
                                       f32_4 %214 = OpFMul %211 %213 
                                       f32_4 %215 = OpLoad %62 
                                       f32_4 %216 = OpFAdd %214 %215 
                                                      OpStore %36 %216 
                                Uniform f32* %217 = OpAccessChain %159 %55 %45 %63 
                                         f32 %218 = OpLoad %217 
                                Private f32* %219 = OpAccessChain %9 %66 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpFMul %218 %220 
                                Private f32* %222 = OpAccessChain %92 %66 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFAdd %221 %223 
                                Private f32* %225 = OpAccessChain %9 %66 
                                                      OpStore %225 %224 
                                Private f32* %226 = OpAccessChain %9 %66 
                                         f32 %227 = OpLoad %226 
                                Uniform f32* %228 = OpAccessChain %159 %55 %75 %63 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpFAdd %227 %229 
                                Private f32* %231 = OpAccessChain %9 %66 
                                                      OpStore %231 %230 
                                Private f32* %234 = OpAccessChain %9 %66 
                                         f32 %235 = OpLoad %234 
                                         f32 %236 = OpFNegate %235 
                                 Output f32* %238 = OpAccessChain vs_TEXCOORD3 %63 
                                                      OpStore %238 %236 
                                       f32_4 %239 = OpLoad %36 
                              Uniform f32_4* %240 = OpAccessChain %159 %45 %75 
                                       f32_4 %241 = OpLoad %240 
                                       f32_4 %242 = OpFAdd %239 %241 
                                                      OpStore %9 %242 
                                       f32_4 %247 = OpLoad %9 
                               Output f32_4* %248 = OpAccessChain %246 %31 
                                                      OpStore %248 %247 
                                       f32_4 %250 = OpLoad %249 
                                       f32_4 %253 = OpFAdd %250 %252 
                                                      OpStore %36 %253 
                                Uniform f32* %254 = OpAccessChain %159 %70 
                                         f32 %255 = OpLoad %254 
                                       f32_4 %256 = OpCompositeConstruct %255 %255 %255 %255 
                                       f32_4 %257 = OpLoad %36 
                                       f32_4 %258 = OpFMul %256 %257 
                                       f32_4 %260 = OpFAdd %258 %259 
                                                      OpStore %36 %260 
                                Private f32* %263 = OpAccessChain %112 %19 
                                         f32 %264 = OpLoad %263 
                                         u32 %265 = OpBitcast %264 
                                         u32 %267 = OpBitwiseAnd %265 %266 
                                                      OpStore %262 %267 
                                         u32 %268 = OpLoad %262 
                                         f32 %269 = OpConvertUToF %268 
                                Private f32* %270 = OpAccessChain %62 %66 
                                                      OpStore %270 %269 
                                Private f32* %274 = OpAccessChain %112 %19 
                                         f32 %275 = OpLoad %274 
                                         u32 %276 = OpBitcast %275 
                                         u32 %277 = OpBitFieldUExtract %276 %104 %104 
                                Private u32* %278 = OpAccessChain %273 %66 
                                                      OpStore %278 %277 
                                Private f32* %279 = OpAccessChain %112 %19 
                                         f32 %280 = OpLoad %279 
                                         u32 %281 = OpBitcast %280 
                                         u32 %283 = OpBitFieldUExtract %281 %282 %104 
                                Private u32* %284 = OpAccessChain %273 %89 
                                                      OpStore %284 %283 
                                Private f32* %285 = OpAccessChain %112 %19 
                                         f32 %286 = OpLoad %285 
                                         u32 %287 = OpBitcast %286 
                                         u32 %289 = OpShiftRightLogical %287 %288 
                                                      OpStore %262 %289 
                                         u32 %290 = OpLoad %262 
                                         f32 %291 = OpConvertUToF %290 
                                Private f32* %292 = OpAccessChain %62 %19 
                                                      OpStore %292 %291 
                                       u32_2 %293 = OpLoad %273 
                                       f32_2 %295 = OpConvertUToF %293 
                                       f32_4 %296 = OpLoad %62 
                                       f32_4 %297 = OpVectorShuffle %296 %295 0 4 5 3 
                                                      OpStore %62 %297 
                                       f32_4 %298 = OpLoad %36 
                                       f32_4 %299 = OpLoad %62 
                                       f32_4 %300 = OpFMul %298 %299 
                                                      OpStore %36 %300 
                                       f32_4 %302 = OpLoad %36 
                                       f32_4 %305 = OpFMul %302 %304 
                                                      OpStore %301 %305 
                                Private f32* %307 = OpAccessChain %134 %66 
                                         f32 %308 = OpLoad %307 
                                Uniform f32* %309 = OpAccessChain %159 %75 %89 
                                         f32 %310 = OpLoad %309 
                                         f32 %311 = OpFDiv %308 %310 
                                                      OpStore %306 %311 
                                         f32 %312 = OpLoad %306 
                                         f32 %313 = OpExtInst %1 8 %312 
                                                      OpStore %306 %313 
                                         f32 %314 = OpLoad %306 
                                         f32 %315 = OpFNegate %314 
                                Uniform f32* %316 = OpAccessChain %159 %75 %89 
                                         f32 %317 = OpLoad %316 
                                         f32 %318 = OpFMul %315 %317 
                                Private f32* %319 = OpAccessChain %134 %66 
                                         f32 %320 = OpLoad %319 
                                         f32 %321 = OpFAdd %318 %320 
                                Private f32* %322 = OpAccessChain %134 %66 
                                                      OpStore %322 %321 
                                Private f32* %323 = OpAccessChain %134 %66 
                                         f32 %324 = OpLoad %323 
                                         f32 %325 = OpExtInst %1 8 %324 
                                Private f32* %326 = OpAccessChain %134 %66 
                                                      OpStore %326 %325 
                                Private f32* %327 = OpAccessChain %134 %66 
                                         f32 %328 = OpLoad %327 
                                Uniform f32* %329 = OpAccessChain %159 %75 %63 
                                         f32 %330 = OpLoad %329 
                                         f32 %331 = OpFMul %328 %330 
                                Private f32* %332 = OpAccessChain %134 %66 
                                                      OpStore %332 %331 
                                Uniform f32* %333 = OpAccessChain %159 %75 %19 
                                         f32 %334 = OpLoad %333 
                                         f32 %335 = OpFNegate %334 
                                         f32 %336 = OpFAdd %335 %17 
                                                      OpStore %148 %336 
                                         f32 %337 = OpLoad %306 
                                         f32 %338 = OpFNegate %337 
                                Uniform f32* %339 = OpAccessChain %159 %75 %19 
                                         f32 %340 = OpLoad %339 
                                         f32 %341 = OpFMul %338 %340 
                                         f32 %342 = OpLoad %148 
                                         f32 %343 = OpFAdd %341 %342 
                                Private f32* %344 = OpAccessChain %134 %89 
                                                      OpStore %344 %343 
                                       f32_2 %347 = OpLoad %346 
                              Uniform f32_4* %348 = OpAccessChain %159 %75 
                                       f32_4 %349 = OpLoad %348 
                                       f32_2 %350 = OpVectorShuffle %349 %349 2 3 
                                       f32_2 %351 = OpFMul %347 %350 
                                       f32_4 %352 = OpLoad %134 
                                       f32_2 %353 = OpVectorShuffle %352 %352 0 1 
                                       f32_2 %354 = OpFAdd %351 %353 
                                       f32_4 %355 = OpLoad %134 
                                       f32_4 %356 = OpVectorShuffle %355 %354 4 5 2 3 
                                                      OpStore %134 %356 
                                Uniform f32* %360 = OpAccessChain %159 %75 %66 
                                         f32 %361 = OpLoad %360 
                                        bool %363 = OpFOrdNotEqual %361 %362 
                                                      OpStore %359 %363 
                                        bool %364 = OpLoad %359 
                                                      OpSelectionMerge %368 None 
                                                      OpBranchConditional %364 %367 %371 
                                             %367 = OpLabel 
                                       f32_4 %369 = OpLoad %134 
                                       f32_2 %370 = OpVectorShuffle %369 %369 0 1 
                                                      OpStore %366 %370 
                                                      OpBranch %368 
                                             %371 = OpLabel 
                                       f32_2 %372 = OpLoad %346 
                                                      OpStore %366 %372 
                                                      OpBranch %368 
                                             %368 = OpLabel 
                                       f32_2 %373 = OpLoad %366 
                                       f32_4 %374 = OpLoad %134 
                                       f32_4 %375 = OpVectorShuffle %374 %373 4 5 2 3 
                                                      OpStore %134 %375 
                                       f32_4 %378 = OpLoad %134 
                                       f32_2 %379 = OpVectorShuffle %378 %378 0 1 
                              Uniform f32_4* %380 = OpAccessChain %159 %80 
                                       f32_4 %381 = OpLoad %380 
                                       f32_2 %382 = OpVectorShuffle %381 %381 0 1 
                                       f32_2 %383 = OpFMul %379 %382 
                              Uniform f32_4* %384 = OpAccessChain %159 %80 
                                       f32_4 %385 = OpLoad %384 
                                       f32_2 %386 = OpVectorShuffle %385 %385 2 3 
                                       f32_2 %387 = OpFAdd %383 %386 
                                                      OpStore vs_TEXCOORD1 %387 
                                Private f32* %388 = OpAccessChain %9 %89 
                                         f32 %389 = OpLoad %388 
                                Uniform f32* %390 = OpAccessChain %159 %31 %66 
                                         f32 %391 = OpLoad %390 
                                         f32 %392 = OpFMul %389 %391 
                                Private f32* %393 = OpAccessChain %9 %89 
                                                      OpStore %393 %392 
                                       f32_4 %394 = OpLoad %9 
                                       f32_3 %395 = OpVectorShuffle %394 %394 0 3 1 
                                       f32_3 %398 = OpFMul %395 %397 
                                       f32_4 %399 = OpLoad %134 
                                       f32_4 %400 = OpVectorShuffle %399 %398 4 1 5 6 
                                                      OpStore %134 %400 
                                Private f32* %401 = OpAccessChain %9 %19 
                                         f32 %402 = OpLoad %401 
                                 Output f32* %403 = OpAccessChain vs_TEXCOORD3 %19 
                                                      OpStore %403 %402 
                                       f32_4 %404 = OpLoad %134 
                                       f32_2 %405 = OpVectorShuffle %404 %404 2 2 
                                       f32_4 %406 = OpLoad %134 
                                       f32_2 %407 = OpVectorShuffle %406 %406 0 3 
                                       f32_2 %408 = OpFAdd %405 %407 
                                       f32_4 %409 = OpLoad vs_TEXCOORD3 
                                       f32_4 %410 = OpVectorShuffle %409 %408 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %410 
                                 Output f32* %411 = OpAccessChain %246 %31 %89 
                                         f32 %412 = OpLoad %411 
                                         f32 %413 = OpFNegate %412 
                                 Output f32* %414 = OpAccessChain %246 %31 %89 
                                                      OpStore %414 %413 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 57
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %47 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %47 Location 47 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 
                                     %30 = OpTypePointer Uniform %29 
            Uniform struct {f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 0 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                     %46 = OpTypePointer Output %24 
                       Output f32_4* %47 = OpVariable Output 
                                 f32 %51 = OpConstant 3.674022E-40 
                                     %52 = OpTypeInt 32 0 
                                 u32 %53 = OpConstant 3 
                                     %54 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                                             OpStore %39 %45 
                               f32_3 %48 = OpLoad %39 
                               f32_4 %49 = OpLoad %47 
                               f32_4 %50 = OpVectorShuffle %49 %48 4 5 6 3 
                                             OpStore %47 %50 
                         Output f32* %55 = OpAccessChain %47 %53 
                                             OpStore %55 %51 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp vec2 vs_TEXCOORD1;
layout(location = 2) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec2 u_xlatu7;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu12 = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu12);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu12 = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.w = float(u_xlatu12);
    u_xlat3.yz = vec2(u_xlatu7.xy);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat12 = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat12 = floor(u_xlat12);
    u_xlat1.x = (-u_xlat12) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat13 = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat1.y = (-u_xlat12) * unity_ParticleUVShiftData.w + u_xlat13;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat1.xy;
    u_xlatb12 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb12)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 416
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %233 %246 %249 %301 %346 %377 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %155 ArrayStride 155 
                                                      OpDecorate %156 ArrayStride 156 
                                                      OpMemberDecorate %157 0 Offset 157 
                                                      OpMemberDecorate %157 1 Offset 157 
                                                      OpMemberDecorate %157 2 Offset 157 
                                                      OpMemberDecorate %157 3 Offset 157 
                                                      OpMemberDecorate %157 4 Offset 157 
                                                      OpMemberDecorate %157 5 Offset 157 
                                                      OpDecorate %157 Block 
                                                      OpDecorate %159 DescriptorSet 159 
                                                      OpDecorate %159 Binding 159 
                                                      OpDecorate vs_TEXCOORD3 Location 233 
                                                      OpMemberDecorate %244 0 BuiltIn 244 
                                                      OpMemberDecorate %244 1 BuiltIn 244 
                                                      OpMemberDecorate %244 2 BuiltIn 244 
                                                      OpDecorate %244 Block 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %250 RelaxedPrecision 
                                                      OpDecorate %253 RelaxedPrecision 
                                                      OpDecorate %301 Location 301 
                                                      OpDecorate %346 Location 346 
                                                      OpDecorate vs_TEXCOORD1 Location 377 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                              Private f32_4* %134 = OpVariable Private 
                                         i32 %136 = OpConstant 13 
                                Private f32* %148 = OpVariable Private 
                                         u32 %154 = OpConstant 4 
                                             %155 = OpTypeArray %7 %154 
                                             %156 = OpTypeArray %7 %154 
                                             %157 = OpTypeStruct %7 %155 %156 %7 %6 %7 
                                             %158 = OpTypePointer Uniform %157 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32; f32_4;}* %159 = OpVariable Uniform 
                                             %160 = OpTypePointer Uniform %7 
                                             %165 = OpTypePointer Uniform %6 
                                             %232 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %237 = OpTypePointer Output %6 
                                             %243 = OpTypeArray %6 %89 
                                             %244 = OpTypeStruct %7 %6 %243 
                                             %245 = OpTypePointer Output %244 
        Output struct {f32_4; f32; f32[1];}* %246 = OpVariable Output 
                                Input f32_4* %249 = OpVariable Input 
                                         f32 %251 = OpConstant 3.674022E-40 
                                       f32_4 %252 = OpConstantComposite %251 %251 %251 %251 
                                       f32_4 %259 = OpConstantComposite %17 %17 %17 %17 
                                             %261 = OpTypePointer Private %18 
                                Private u32* %262 = OpVariable Private 
                                         u32 %266 = OpConstant 255 
                                             %271 = OpTypeVector %18 2 
                                             %272 = OpTypePointer Private %271 
                              Private u32_2* %273 = OpVariable Private 
                                         i32 %282 = OpConstant 16 
                                         u32 %288 = OpConstant 24 
                                             %294 = OpTypeVector %6 2 
                               Output f32_4* %301 = OpVariable Output 
                                         f32 %303 = OpConstant 3.674022E-40 
                                       f32_4 %304 = OpConstantComposite %303 %303 %303 %303 
                                Private f32* %306 = OpVariable Private 
                                             %345 = OpTypePointer Input %294 
                                Input f32_2* %346 = OpVariable Input 
                                             %357 = OpTypeBool 
                                             %358 = OpTypePointer Private %357 
                               Private bool* %359 = OpVariable Private 
                                         f32 %362 = OpConstant 3.674022E-40 
                                             %365 = OpTypePointer Function %294 
                                             %376 = OpTypePointer Output %294 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                         f32 %396 = OpConstant 3.674022E-40 
                                       f32_3 %397 = OpConstantComposite %396 %396 %396 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %366 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %135 = OpLoad %24 
                                Uniform u32* %137 = OpAccessChain %43 %31 %135 %31 %136 
                                         u32 %138 = OpLoad %137 
                                         f32 %139 = OpBitcast %138 
                                Private f32* %140 = OpAccessChain %134 %66 
                                                      OpStore %140 %139 
                                Private f32* %141 = OpAccessChain %134 %66 
                                         f32 %142 = OpLoad %141 
                                         f32 %143 = OpExtInst %1 8 %142 
                                Private f32* %144 = OpAccessChain %134 %66 
                                                      OpStore %144 %143 
                                Private f32* %145 = OpAccessChain %112 %89 
                                         f32 %146 = OpLoad %145 
                                Private f32* %147 = OpAccessChain %62 %19 
                                                      OpStore %147 %146 
                                       f32_4 %149 = OpLoad %62 
                                       f32_4 %150 = OpLoad %9 
                                         f32 %151 = OpDot %149 %150 
                                                      OpStore %148 %151 
                                         f32 %152 = OpLoad %148 
                                       f32_4 %153 = OpCompositeConstruct %152 %152 %152 %152 
                              Uniform f32_4* %161 = OpAccessChain %159 %45 %55 
                                       f32_4 %162 = OpLoad %161 
                                       f32_4 %163 = OpFMul %153 %162 
                                                      OpStore %62 %163 
                                         f32 %164 = OpLoad %148 
                                Uniform f32* %166 = OpAccessChain %159 %55 %55 %63 
                                         f32 %167 = OpLoad %166 
                                         f32 %168 = OpFMul %164 %167 
                                                      OpStore %148 %168 
                                Private f32* %169 = OpAccessChain %36 %89 
                                         f32 %170 = OpLoad %169 
                                Private f32* %171 = OpAccessChain %68 %66 
                                                      OpStore %171 %170 
                                Private f32* %172 = OpAccessChain %68 %63 
                                         f32 %173 = OpLoad %172 
                                Private f32* %174 = OpAccessChain %36 %89 
                                                      OpStore %174 %173 
                                Private f32* %175 = OpAccessChain %92 %66 
                                         f32 %176 = OpLoad %175 
                                Private f32* %177 = OpAccessChain %68 %63 
                                                      OpStore %177 %176 
                                Private f32* %178 = OpAccessChain %92 %63 
                                         f32 %179 = OpLoad %178 
                                Private f32* %180 = OpAccessChain %36 %63 
                                                      OpStore %180 %179 
                                Private f32* %181 = OpAccessChain %112 %66 
                                         f32 %182 = OpLoad %181 
                                Private f32* %183 = OpAccessChain %68 %19 
                                                      OpStore %183 %182 
                                       f32_4 %184 = OpLoad %68 
                                       f32_4 %185 = OpLoad %9 
                                         f32 %186 = OpDot %184 %185 
                                Private f32* %187 = OpAccessChain %92 %66 
                                                      OpStore %187 %186 
                              Uniform f32_4* %188 = OpAccessChain %159 %45 %31 
                                       f32_4 %189 = OpLoad %188 
                                       f32_3 %190 = OpLoad %92 
                                       f32_4 %191 = OpVectorShuffle %190 %190 0 0 0 0 
                                       f32_4 %192 = OpFMul %189 %191 
                                       f32_4 %193 = OpLoad %62 
                                       f32_4 %194 = OpFAdd %192 %193 
                                                      OpStore %62 %194 
                                Uniform f32* %195 = OpAccessChain %159 %55 %31 %63 
                                         f32 %196 = OpLoad %195 
                                Private f32* %197 = OpAccessChain %92 %66 
                                         f32 %198 = OpLoad %197 
                                         f32 %199 = OpFMul %196 %198 
                                         f32 %200 = OpLoad %148 
                                         f32 %201 = OpFAdd %199 %200 
                                Private f32* %202 = OpAccessChain %92 %66 
                                                      OpStore %202 %201 
                                Private f32* %203 = OpAccessChain %112 %63 
                                         f32 %204 = OpLoad %203 
                                Private f32* %205 = OpAccessChain %36 %19 
                                                      OpStore %205 %204 
                                       f32_4 %206 = OpLoad %36 
                                       f32_4 %207 = OpLoad %9 
                                         f32 %208 = OpDot %206 %207 
                                Private f32* %209 = OpAccessChain %9 %66 
                                                      OpStore %209 %208 
                              Uniform f32_4* %210 = OpAccessChain %159 %45 %45 
                                       f32_4 %211 = OpLoad %210 
                                       f32_4 %212 = OpLoad %9 
                                       f32_4 %213 = OpVectorShuffle %212 %212 0 0 0 0 
                                       f32_4 %214 = OpFMul %211 %213 
                                       f32_4 %215 = OpLoad %62 
                                       f32_4 %216 = OpFAdd %214 %215 
                                                      OpStore %36 %216 
                                Uniform f32* %217 = OpAccessChain %159 %55 %45 %63 
                                         f32 %218 = OpLoad %217 
                                Private f32* %219 = OpAccessChain %9 %66 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpFMul %218 %220 
                                Private f32* %222 = OpAccessChain %92 %66 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFAdd %221 %223 
                                Private f32* %225 = OpAccessChain %9 %66 
                                                      OpStore %225 %224 
                                Private f32* %226 = OpAccessChain %9 %66 
                                         f32 %227 = OpLoad %226 
                                Uniform f32* %228 = OpAccessChain %159 %55 %75 %63 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpFAdd %227 %229 
                                Private f32* %231 = OpAccessChain %9 %66 
                                                      OpStore %231 %230 
                                Private f32* %234 = OpAccessChain %9 %66 
                                         f32 %235 = OpLoad %234 
                                         f32 %236 = OpFNegate %235 
                                 Output f32* %238 = OpAccessChain vs_TEXCOORD3 %63 
                                                      OpStore %238 %236 
                                       f32_4 %239 = OpLoad %36 
                              Uniform f32_4* %240 = OpAccessChain %159 %45 %75 
                                       f32_4 %241 = OpLoad %240 
                                       f32_4 %242 = OpFAdd %239 %241 
                                                      OpStore %9 %242 
                                       f32_4 %247 = OpLoad %9 
                               Output f32_4* %248 = OpAccessChain %246 %31 
                                                      OpStore %248 %247 
                                       f32_4 %250 = OpLoad %249 
                                       f32_4 %253 = OpFAdd %250 %252 
                                                      OpStore %36 %253 
                                Uniform f32* %254 = OpAccessChain %159 %70 
                                         f32 %255 = OpLoad %254 
                                       f32_4 %256 = OpCompositeConstruct %255 %255 %255 %255 
                                       f32_4 %257 = OpLoad %36 
                                       f32_4 %258 = OpFMul %256 %257 
                                       f32_4 %260 = OpFAdd %258 %259 
                                                      OpStore %36 %260 
                                Private f32* %263 = OpAccessChain %112 %19 
                                         f32 %264 = OpLoad %263 
                                         u32 %265 = OpBitcast %264 
                                         u32 %267 = OpBitwiseAnd %265 %266 
                                                      OpStore %262 %267 
                                         u32 %268 = OpLoad %262 
                                         f32 %269 = OpConvertUToF %268 
                                Private f32* %270 = OpAccessChain %62 %66 
                                                      OpStore %270 %269 
                                Private f32* %274 = OpAccessChain %112 %19 
                                         f32 %275 = OpLoad %274 
                                         u32 %276 = OpBitcast %275 
                                         u32 %277 = OpBitFieldUExtract %276 %104 %104 
                                Private u32* %278 = OpAccessChain %273 %66 
                                                      OpStore %278 %277 
                                Private f32* %279 = OpAccessChain %112 %19 
                                         f32 %280 = OpLoad %279 
                                         u32 %281 = OpBitcast %280 
                                         u32 %283 = OpBitFieldUExtract %281 %282 %104 
                                Private u32* %284 = OpAccessChain %273 %89 
                                                      OpStore %284 %283 
                                Private f32* %285 = OpAccessChain %112 %19 
                                         f32 %286 = OpLoad %285 
                                         u32 %287 = OpBitcast %286 
                                         u32 %289 = OpShiftRightLogical %287 %288 
                                                      OpStore %262 %289 
                                         u32 %290 = OpLoad %262 
                                         f32 %291 = OpConvertUToF %290 
                                Private f32* %292 = OpAccessChain %62 %19 
                                                      OpStore %292 %291 
                                       u32_2 %293 = OpLoad %273 
                                       f32_2 %295 = OpConvertUToF %293 
                                       f32_4 %296 = OpLoad %62 
                                       f32_4 %297 = OpVectorShuffle %296 %295 0 4 5 3 
                                                      OpStore %62 %297 
                                       f32_4 %298 = OpLoad %36 
                                       f32_4 %299 = OpLoad %62 
                                       f32_4 %300 = OpFMul %298 %299 
                                                      OpStore %36 %300 
                                       f32_4 %302 = OpLoad %36 
                                       f32_4 %305 = OpFMul %302 %304 
                                                      OpStore %301 %305 
                                Private f32* %307 = OpAccessChain %134 %66 
                                         f32 %308 = OpLoad %307 
                                Uniform f32* %309 = OpAccessChain %159 %75 %89 
                                         f32 %310 = OpLoad %309 
                                         f32 %311 = OpFDiv %308 %310 
                                                      OpStore %306 %311 
                                         f32 %312 = OpLoad %306 
                                         f32 %313 = OpExtInst %1 8 %312 
                                                      OpStore %306 %313 
                                         f32 %314 = OpLoad %306 
                                         f32 %315 = OpFNegate %314 
                                Uniform f32* %316 = OpAccessChain %159 %75 %89 
                                         f32 %317 = OpLoad %316 
                                         f32 %318 = OpFMul %315 %317 
                                Private f32* %319 = OpAccessChain %134 %66 
                                         f32 %320 = OpLoad %319 
                                         f32 %321 = OpFAdd %318 %320 
                                Private f32* %322 = OpAccessChain %134 %66 
                                                      OpStore %322 %321 
                                Private f32* %323 = OpAccessChain %134 %66 
                                         f32 %324 = OpLoad %323 
                                         f32 %325 = OpExtInst %1 8 %324 
                                Private f32* %326 = OpAccessChain %134 %66 
                                                      OpStore %326 %325 
                                Private f32* %327 = OpAccessChain %134 %66 
                                         f32 %328 = OpLoad %327 
                                Uniform f32* %329 = OpAccessChain %159 %75 %63 
                                         f32 %330 = OpLoad %329 
                                         f32 %331 = OpFMul %328 %330 
                                Private f32* %332 = OpAccessChain %134 %66 
                                                      OpStore %332 %331 
                                Uniform f32* %333 = OpAccessChain %159 %75 %19 
                                         f32 %334 = OpLoad %333 
                                         f32 %335 = OpFNegate %334 
                                         f32 %336 = OpFAdd %335 %17 
                                                      OpStore %148 %336 
                                         f32 %337 = OpLoad %306 
                                         f32 %338 = OpFNegate %337 
                                Uniform f32* %339 = OpAccessChain %159 %75 %19 
                                         f32 %340 = OpLoad %339 
                                         f32 %341 = OpFMul %338 %340 
                                         f32 %342 = OpLoad %148 
                                         f32 %343 = OpFAdd %341 %342 
                                Private f32* %344 = OpAccessChain %134 %89 
                                                      OpStore %344 %343 
                                       f32_2 %347 = OpLoad %346 
                              Uniform f32_4* %348 = OpAccessChain %159 %75 
                                       f32_4 %349 = OpLoad %348 
                                       f32_2 %350 = OpVectorShuffle %349 %349 2 3 
                                       f32_2 %351 = OpFMul %347 %350 
                                       f32_4 %352 = OpLoad %134 
                                       f32_2 %353 = OpVectorShuffle %352 %352 0 1 
                                       f32_2 %354 = OpFAdd %351 %353 
                                       f32_4 %355 = OpLoad %134 
                                       f32_4 %356 = OpVectorShuffle %355 %354 4 5 2 3 
                                                      OpStore %134 %356 
                                Uniform f32* %360 = OpAccessChain %159 %75 %66 
                                         f32 %361 = OpLoad %360 
                                        bool %363 = OpFOrdNotEqual %361 %362 
                                                      OpStore %359 %363 
                                        bool %364 = OpLoad %359 
                                                      OpSelectionMerge %368 None 
                                                      OpBranchConditional %364 %367 %371 
                                             %367 = OpLabel 
                                       f32_4 %369 = OpLoad %134 
                                       f32_2 %370 = OpVectorShuffle %369 %369 0 1 
                                                      OpStore %366 %370 
                                                      OpBranch %368 
                                             %371 = OpLabel 
                                       f32_2 %372 = OpLoad %346 
                                                      OpStore %366 %372 
                                                      OpBranch %368 
                                             %368 = OpLabel 
                                       f32_2 %373 = OpLoad %366 
                                       f32_4 %374 = OpLoad %134 
                                       f32_4 %375 = OpVectorShuffle %374 %373 4 5 2 3 
                                                      OpStore %134 %375 
                                       f32_4 %378 = OpLoad %134 
                                       f32_2 %379 = OpVectorShuffle %378 %378 0 1 
                              Uniform f32_4* %380 = OpAccessChain %159 %80 
                                       f32_4 %381 = OpLoad %380 
                                       f32_2 %382 = OpVectorShuffle %381 %381 0 1 
                                       f32_2 %383 = OpFMul %379 %382 
                              Uniform f32_4* %384 = OpAccessChain %159 %80 
                                       f32_4 %385 = OpLoad %384 
                                       f32_2 %386 = OpVectorShuffle %385 %385 2 3 
                                       f32_2 %387 = OpFAdd %383 %386 
                                                      OpStore vs_TEXCOORD1 %387 
                                Private f32* %388 = OpAccessChain %9 %89 
                                         f32 %389 = OpLoad %388 
                                Uniform f32* %390 = OpAccessChain %159 %31 %66 
                                         f32 %391 = OpLoad %390 
                                         f32 %392 = OpFMul %389 %391 
                                Private f32* %393 = OpAccessChain %9 %89 
                                                      OpStore %393 %392 
                                       f32_4 %394 = OpLoad %9 
                                       f32_3 %395 = OpVectorShuffle %394 %394 0 3 1 
                                       f32_3 %398 = OpFMul %395 %397 
                                       f32_4 %399 = OpLoad %134 
                                       f32_4 %400 = OpVectorShuffle %399 %398 4 1 5 6 
                                                      OpStore %134 %400 
                                Private f32* %401 = OpAccessChain %9 %19 
                                         f32 %402 = OpLoad %401 
                                 Output f32* %403 = OpAccessChain vs_TEXCOORD3 %19 
                                                      OpStore %403 %402 
                                       f32_4 %404 = OpLoad %134 
                                       f32_2 %405 = OpVectorShuffle %404 %404 2 2 
                                       f32_4 %406 = OpLoad %134 
                                       f32_2 %407 = OpVectorShuffle %406 %406 0 3 
                                       f32_2 %408 = OpFAdd %405 %407 
                                       f32_4 %409 = OpLoad vs_TEXCOORD3 
                                       f32_4 %410 = OpVectorShuffle %409 %408 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %410 
                                 Output f32* %411 = OpAccessChain %246 %31 %89 
                                         f32 %412 = OpLoad %411 
                                         f32 %413 = OpFNegate %412 
                                 Output f32* %414 = OpAccessChain %246 %31 %89 
                                                      OpStore %414 %413 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 46
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %39 %43 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpMemberDecorate %27 0 RelaxedPrecision 
                                             OpMemberDecorate %27 0 Offset 27 
                                             OpDecorate %27 Block 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %34 RelaxedPrecision 
                                             OpDecorate %35 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %39 Location 39 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %43 Location 43 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypeVector %6 4 
                                      %8 = OpTypePointer Private %7 
                       Private f32_4* %9 = OpVariable Private 
                                     %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %11 = OpTypePointer UniformConstant %10 
UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                     %14 = OpTypeSampler 
                                     %15 = OpTypePointer UniformConstant %14 
            UniformConstant sampler* %16 = OpVariable UniformConstant 
                                     %18 = OpTypeSampledImage %10 
                                     %20 = OpTypeVector %6 2 
                                     %21 = OpTypePointer Input %20 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %25 = OpVariable Private 
                                     %27 = OpTypeStruct %7 
                                     %28 = OpTypePointer Uniform %27 
            Uniform struct {f32_4;}* %29 = OpVariable Uniform 
                                     %30 = OpTypeInt 32 1 
                                 i32 %31 = OpConstant 0 
                                     %32 = OpTypePointer Uniform %7 
                      Private f32_4* %36 = OpVariable Private 
                                     %38 = OpTypePointer Input %7 
                        Input f32_4* %39 = OpVariable Input 
                                     %42 = OpTypePointer Output %7 
                       Output f32_4* %43 = OpVariable Output 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                             OpStore %9 %24 
                               f32_4 %26 = OpLoad %9 
                      Uniform f32_4* %33 = OpAccessChain %29 %31 
                               f32_4 %34 = OpLoad %33 
                               f32_4 %35 = OpFMul %26 %34 
                                             OpStore %25 %35 
                               f32_4 %37 = OpLoad %25 
                               f32_4 %40 = OpLoad %39 
                               f32_4 %41 = OpFMul %37 %40 
                                             OpStore %36 %41 
                               f32_4 %44 = OpLoad %36 
                                             OpStore %43 %44 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.x;
    u_xlat5 = u_xlat5 * (-u_xlat5);
    vs_TEXCOORD0 = exp2(u_xlat5);
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 206
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %118 %123 %125 %169 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpMemberDecorate %19 5 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpMemberDecorate %78 0 BuiltIn 78 
                                                      OpMemberDecorate %78 1 BuiltIn 78 
                                                      OpMemberDecorate %78 2 BuiltIn 78 
                                                      OpDecorate %78 Block 
                                                      OpDecorate %84 Location 84 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %85 Location 85 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 118 
                                                      OpDecorate vs_TEXCOORD1 Location 123 
                                                      OpDecorate %125 Location 125 
                                                      OpDecorate vs_TEXCOORD3 Location 169 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 %7 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4;}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 1 
                                              %24 = OpTypePointer Uniform %7 
                                          i32 %28 = OpConstant 0 
                                          i32 %36 = OpConstant 2 
                                          i32 %45 = OpConstant 3 
                               Private f32_4* %49 = OpVariable Private 
                                          u32 %76 = OpConstant 1 
                                              %77 = OpTypeArray %6 %76 
                                              %78 = OpTypeStruct %7 %6 %77 
                                              %79 = OpTypePointer Output %78 
         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
                                              %82 = OpTypePointer Output %7 
                                Output f32_4* %84 = OpVariable Output 
                                 Input f32_4* %85 = OpVariable Input 
                                              %87 = OpTypePointer Private %6 
                                 Private f32* %88 = OpVariable Private 
                                          u32 %89 = OpConstant 2 
                                              %92 = OpTypePointer Uniform %6 
                                          f32 %98 = OpConstant 3.674022E-40 
                                         f32 %105 = OpConstant 3.674022E-40 
                                         i32 %108 = OpConstant 4 
                                         u32 %109 = OpConstant 0 
                                             %117 = OpTypePointer Output %6 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                                             %121 = OpTypeVector %6 2 
                                             %122 = OpTypePointer Output %121 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %124 = OpTypePointer Input %121 
                                Input f32_2* %125 = OpVariable Input 
                                         i32 %127 = OpConstant 5 
                                Private f32* %136 = OpVariable Private 
                                         u32 %161 = OpConstant 3 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                         f32 %182 = OpConstant 3.674022E-40 
                                       f32_2 %187 = OpConstantComposite %182 %182 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
                                        f32_4 %26 = OpLoad %25 
                                        f32_4 %27 = OpFMul %13 %26 
                                                      OpStore %9 %27 
                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
                                        f32_4 %30 = OpLoad %29 
                                        f32_4 %31 = OpLoad %11 
                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
                                        f32_4 %33 = OpFMul %30 %32 
                                        f32_4 %34 = OpLoad %9 
                                        f32_4 %35 = OpFAdd %33 %34 
                                                      OpStore %9 %35 
                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
                                        f32_4 %38 = OpLoad %37 
                                        f32_4 %39 = OpLoad %11 
                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
                                        f32_4 %41 = OpFMul %38 %40 
                                        f32_4 %42 = OpLoad %9 
                                        f32_4 %43 = OpFAdd %41 %42 
                                                      OpStore %9 %43 
                                        f32_4 %44 = OpLoad %9 
                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_4 %48 = OpFAdd %44 %47 
                                                      OpStore %9 %48 
                                        f32_4 %50 = OpLoad %9 
                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
                                        f32_4 %53 = OpLoad %52 
                                        f32_4 %54 = OpFMul %51 %53 
                                                      OpStore %49 %54 
                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
                                        f32_4 %56 = OpLoad %55 
                                        f32_4 %57 = OpLoad %9 
                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
                                        f32_4 %59 = OpFMul %56 %58 
                                        f32_4 %60 = OpLoad %49 
                                        f32_4 %61 = OpFAdd %59 %60 
                                                      OpStore %49 %61 
                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
                                        f32_4 %63 = OpLoad %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
                                        f32_4 %66 = OpFMul %63 %65 
                                        f32_4 %67 = OpLoad %49 
                                        f32_4 %68 = OpFAdd %66 %67 
                                                      OpStore %49 %68 
                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpLoad %9 
                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
                                        f32_4 %73 = OpFMul %70 %72 
                                        f32_4 %74 = OpLoad %49 
                                        f32_4 %75 = OpFAdd %73 %74 
                                                      OpStore %49 %75 
                                        f32_4 %81 = OpLoad %49 
                                Output f32_4* %83 = OpAccessChain %80 %28 
                                                      OpStore %83 %81 
                                        f32_4 %86 = OpLoad %85 
                                                      OpStore %84 %86 
                                 Private f32* %90 = OpAccessChain %49 %89 
                                          f32 %91 = OpLoad %90 
                                 Uniform f32* %93 = OpAccessChain %21 %28 %76 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFDiv %91 %94 
                                                      OpStore %88 %95 
                                          f32 %96 = OpLoad %88 
                                          f32 %97 = OpFNegate %96 
                                          f32 %99 = OpFAdd %97 %98 
                                                      OpStore %88 %99 
                                         f32 %100 = OpLoad %88 
                                Uniform f32* %101 = OpAccessChain %21 %28 %89 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                                      OpStore %88 %103 
                                         f32 %104 = OpLoad %88 
                                         f32 %106 = OpExtInst %1 40 %104 %105 
                                                      OpStore %88 %106 
                                         f32 %107 = OpLoad %88 
                                Uniform f32* %110 = OpAccessChain %21 %108 %109 
                                         f32 %111 = OpLoad %110 
                                         f32 %112 = OpFMul %107 %111 
                                                      OpStore %88 %112 
                                         f32 %113 = OpLoad %88 
                                         f32 %114 = OpLoad %88 
                                         f32 %115 = OpFNegate %114 
                                         f32 %116 = OpFMul %113 %115 
                                                      OpStore %88 %116 
                                         f32 %119 = OpLoad %88 
                                         f32 %120 = OpExtInst %1 29 %119 
                                                      OpStore vs_TEXCOORD0 %120 
                                       f32_2 %126 = OpLoad %125 
                              Uniform f32_4* %128 = OpAccessChain %21 %127 
                                       f32_4 %129 = OpLoad %128 
                                       f32_2 %130 = OpVectorShuffle %129 %129 0 1 
                                       f32_2 %131 = OpFMul %126 %130 
                              Uniform f32_4* %132 = OpAccessChain %21 %127 
                                       f32_4 %133 = OpLoad %132 
                                       f32_2 %134 = OpVectorShuffle %133 %133 2 3 
                                       f32_2 %135 = OpFAdd %131 %134 
                                                      OpStore vs_TEXCOORD1 %135 
                                Private f32* %137 = OpAccessChain %9 %76 
                                         f32 %138 = OpLoad %137 
                                Uniform f32* %139 = OpAccessChain %21 %36 %23 %89 
                                         f32 %140 = OpLoad %139 
                                         f32 %141 = OpFMul %138 %140 
                                                      OpStore %136 %141 
                                Uniform f32* %142 = OpAccessChain %21 %36 %28 %89 
                                         f32 %143 = OpLoad %142 
                                Private f32* %144 = OpAccessChain %9 %109 
                                         f32 %145 = OpLoad %144 
                                         f32 %146 = OpFMul %143 %145 
                                         f32 %147 = OpLoad %136 
                                         f32 %148 = OpFAdd %146 %147 
                                Private f32* %149 = OpAccessChain %9 %109 
                                                      OpStore %149 %148 
                                Uniform f32* %150 = OpAccessChain %21 %36 %36 %89 
                                         f32 %151 = OpLoad %150 
                                Private f32* %152 = OpAccessChain %9 %89 
                                         f32 %153 = OpLoad %152 
                                         f32 %154 = OpFMul %151 %153 
                                Private f32* %155 = OpAccessChain %9 %109 
                                         f32 %156 = OpLoad %155 
                                         f32 %157 = OpFAdd %154 %156 
                                Private f32* %158 = OpAccessChain %9 %109 
                                                      OpStore %158 %157 
                                Uniform f32* %159 = OpAccessChain %21 %36 %45 %89 
                                         f32 %160 = OpLoad %159 
                                Private f32* %162 = OpAccessChain %9 %161 
                                         f32 %163 = OpLoad %162 
                                         f32 %164 = OpFMul %160 %163 
                                Private f32* %165 = OpAccessChain %9 %109 
                                         f32 %166 = OpLoad %165 
                                         f32 %167 = OpFAdd %164 %166 
                                Private f32* %168 = OpAccessChain %9 %109 
                                                      OpStore %168 %167 
                                Private f32* %170 = OpAccessChain %9 %109 
                                         f32 %171 = OpLoad %170 
                                         f32 %172 = OpFNegate %171 
                                 Output f32* %173 = OpAccessChain vs_TEXCOORD3 %89 
                                                      OpStore %173 %172 
                                Private f32* %174 = OpAccessChain %49 %76 
                                         f32 %175 = OpLoad %174 
                                Uniform f32* %176 = OpAccessChain %21 %28 %109 
                                         f32 %177 = OpLoad %176 
                                         f32 %178 = OpFMul %175 %177 
                                Private f32* %179 = OpAccessChain %9 %109 
                                                      OpStore %179 %178 
                                Private f32* %180 = OpAccessChain %9 %109 
                                         f32 %181 = OpLoad %180 
                                         f32 %183 = OpFMul %181 %182 
                                Private f32* %184 = OpAccessChain %9 %161 
                                                      OpStore %184 %183 
                                       f32_4 %185 = OpLoad %49 
                                       f32_2 %186 = OpVectorShuffle %185 %185 0 3 
                                       f32_2 %188 = OpFMul %186 %187 
                                       f32_4 %189 = OpLoad %9 
                                       f32_4 %190 = OpVectorShuffle %189 %188 4 1 5 3 
                                                      OpStore %9 %190 
                                Private f32* %191 = OpAccessChain %49 %161 
                                         f32 %192 = OpLoad %191 
                                 Output f32* %193 = OpAccessChain vs_TEXCOORD3 %161 
                                                      OpStore %193 %192 
                                       f32_4 %194 = OpLoad %9 
                                       f32_2 %195 = OpVectorShuffle %194 %194 2 2 
                                       f32_4 %196 = OpLoad %9 
                                       f32_2 %197 = OpVectorShuffle %196 %196 0 3 
                                       f32_2 %198 = OpFAdd %195 %197 
                                       f32_4 %199 = OpLoad vs_TEXCOORD3 
                                       f32_4 %200 = OpVectorShuffle %199 %198 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %200 
                                 Output f32* %201 = OpAccessChain %80 %28 %76 
                                         f32 %202 = OpLoad %201 
                                         f32 %203 = OpFNegate %202 
                                 Output f32* %204 = OpAccessChain %80 %28 %76 
                                                      OpStore %204 %203 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 79
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %55 %70 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpMemberDecorate %29 1 RelaxedPrecision 
                                             OpMemberDecorate %29 1 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %49 RelaxedPrecision 
                                             OpDecorate %50 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 55 
                                             OpDecorate %66 RelaxedPrecision 
                                             OpDecorate %67 RelaxedPrecision 
                                             OpDecorate %70 RelaxedPrecision 
                                             OpDecorate %70 Location 70 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 %24 
                                     %30 = OpTypePointer Uniform %29 
     Uniform struct {f32_4; f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 1 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                 i32 %46 = OpConstant 0 
                                     %52 = OpTypePointer Private %6 
                        Private f32* %53 = OpVariable Private 
                                     %54 = OpTypePointer Input %6 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                 f32 %58 = OpConstant 3.674022E-40 
                                 f32 %59 = OpConstant 3.674022E-40 
                                     %69 = OpTypePointer Output %24 
                       Output f32_4* %70 = OpVariable Output 
                                     %74 = OpTypeInt 32 0 
                                 u32 %75 = OpConstant 3 
                                     %76 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                      Uniform f32_4* %47 = OpAccessChain %31 %46 
                               f32_4 %48 = OpLoad %47 
                               f32_3 %49 = OpVectorShuffle %48 %48 0 1 2 
                               f32_3 %50 = OpFNegate %49 
                               f32_3 %51 = OpFAdd %45 %50 
                                             OpStore %39 %51 
                                 f32 %56 = OpLoad vs_TEXCOORD0 
                                             OpStore %53 %56 
                                 f32 %57 = OpLoad %53 
                                 f32 %60 = OpExtInst %1 43 %57 %58 %59 
                                             OpStore %53 %60 
                                 f32 %61 = OpLoad %53 
                               f32_3 %62 = OpCompositeConstruct %61 %61 %61 
                               f32_3 %63 = OpLoad %39 
                               f32_3 %64 = OpFMul %62 %63 
                      Uniform f32_4* %65 = OpAccessChain %31 %46 
                               f32_4 %66 = OpLoad %65 
                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
                               f32_3 %68 = OpFAdd %64 %67 
                                             OpStore %39 %68 
                               f32_3 %71 = OpLoad %39 
                               f32_4 %72 = OpLoad %70 
                               f32_4 %73 = OpVectorShuffle %72 %71 4 5 6 3 
                                             OpStore %70 %73 
                         Output f32* %77 = OpAccessChain %70 %75 
                                             OpStore %77 %59 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp float vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat5 = u_xlat1.z * unity_FogParams.x;
    u_xlat5 = u_xlat5 * (-u_xlat5);
    vs_TEXCOORD0 = exp2(u_xlat5);
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat1.w;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp float vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DstBlend==1);
#else
    u_xlatb0 = _DstBlend==1;
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 206
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %118 %123 %125 %169 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpMemberDecorate %19 5 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpMemberDecorate %78 0 BuiltIn 78 
                                                      OpMemberDecorate %78 1 BuiltIn 78 
                                                      OpMemberDecorate %78 2 BuiltIn 78 
                                                      OpDecorate %78 Block 
                                                      OpDecorate %84 Location 84 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %85 Location 85 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 118 
                                                      OpDecorate vs_TEXCOORD1 Location 123 
                                                      OpDecorate %125 Location 125 
                                                      OpDecorate vs_TEXCOORD3 Location 169 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 %7 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4;}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 1 
                                              %24 = OpTypePointer Uniform %7 
                                          i32 %28 = OpConstant 0 
                                          i32 %36 = OpConstant 2 
                                          i32 %45 = OpConstant 3 
                               Private f32_4* %49 = OpVariable Private 
                                          u32 %76 = OpConstant 1 
                                              %77 = OpTypeArray %6 %76 
                                              %78 = OpTypeStruct %7 %6 %77 
                                              %79 = OpTypePointer Output %78 
         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
                                              %82 = OpTypePointer Output %7 
                                Output f32_4* %84 = OpVariable Output 
                                 Input f32_4* %85 = OpVariable Input 
                                              %87 = OpTypePointer Private %6 
                                 Private f32* %88 = OpVariable Private 
                                          u32 %89 = OpConstant 2 
                                              %92 = OpTypePointer Uniform %6 
                                          f32 %98 = OpConstant 3.674022E-40 
                                         f32 %105 = OpConstant 3.674022E-40 
                                         i32 %108 = OpConstant 4 
                                         u32 %109 = OpConstant 0 
                                             %117 = OpTypePointer Output %6 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                                             %121 = OpTypeVector %6 2 
                                             %122 = OpTypePointer Output %121 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                             %124 = OpTypePointer Input %121 
                                Input f32_2* %125 = OpVariable Input 
                                         i32 %127 = OpConstant 5 
                                Private f32* %136 = OpVariable Private 
                                         u32 %161 = OpConstant 3 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                         f32 %182 = OpConstant 3.674022E-40 
                                       f32_2 %187 = OpConstantComposite %182 %182 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
                                        f32_4 %26 = OpLoad %25 
                                        f32_4 %27 = OpFMul %13 %26 
                                                      OpStore %9 %27 
                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
                                        f32_4 %30 = OpLoad %29 
                                        f32_4 %31 = OpLoad %11 
                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
                                        f32_4 %33 = OpFMul %30 %32 
                                        f32_4 %34 = OpLoad %9 
                                        f32_4 %35 = OpFAdd %33 %34 
                                                      OpStore %9 %35 
                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
                                        f32_4 %38 = OpLoad %37 
                                        f32_4 %39 = OpLoad %11 
                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
                                        f32_4 %41 = OpFMul %38 %40 
                                        f32_4 %42 = OpLoad %9 
                                        f32_4 %43 = OpFAdd %41 %42 
                                                      OpStore %9 %43 
                                        f32_4 %44 = OpLoad %9 
                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
                                        f32_4 %47 = OpLoad %46 
                                        f32_4 %48 = OpFAdd %44 %47 
                                                      OpStore %9 %48 
                                        f32_4 %50 = OpLoad %9 
                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
                                        f32_4 %53 = OpLoad %52 
                                        f32_4 %54 = OpFMul %51 %53 
                                                      OpStore %49 %54 
                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
                                        f32_4 %56 = OpLoad %55 
                                        f32_4 %57 = OpLoad %9 
                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
                                        f32_4 %59 = OpFMul %56 %58 
                                        f32_4 %60 = OpLoad %49 
                                        f32_4 %61 = OpFAdd %59 %60 
                                                      OpStore %49 %61 
                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
                                        f32_4 %63 = OpLoad %62 
                                        f32_4 %64 = OpLoad %9 
                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
                                        f32_4 %66 = OpFMul %63 %65 
                                        f32_4 %67 = OpLoad %49 
                                        f32_4 %68 = OpFAdd %66 %67 
                                                      OpStore %49 %68 
                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpLoad %9 
                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
                                        f32_4 %73 = OpFMul %70 %72 
                                        f32_4 %74 = OpLoad %49 
                                        f32_4 %75 = OpFAdd %73 %74 
                                                      OpStore %49 %75 
                                        f32_4 %81 = OpLoad %49 
                                Output f32_4* %83 = OpAccessChain %80 %28 
                                                      OpStore %83 %81 
                                        f32_4 %86 = OpLoad %85 
                                                      OpStore %84 %86 
                                 Private f32* %90 = OpAccessChain %49 %89 
                                          f32 %91 = OpLoad %90 
                                 Uniform f32* %93 = OpAccessChain %21 %28 %76 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFDiv %91 %94 
                                                      OpStore %88 %95 
                                          f32 %96 = OpLoad %88 
                                          f32 %97 = OpFNegate %96 
                                          f32 %99 = OpFAdd %97 %98 
                                                      OpStore %88 %99 
                                         f32 %100 = OpLoad %88 
                                Uniform f32* %101 = OpAccessChain %21 %28 %89 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                                      OpStore %88 %103 
                                         f32 %104 = OpLoad %88 
                                         f32 %106 = OpExtInst %1 40 %104 %105 
                                                      OpStore %88 %106 
                                         f32 %107 = OpLoad %88 
                                Uniform f32* %110 = OpAccessChain %21 %108 %109 
                                         f32 %111 = OpLoad %110 
                                         f32 %112 = OpFMul %107 %111 
                                                      OpStore %88 %112 
                                         f32 %113 = OpLoad %88 
                                         f32 %114 = OpLoad %88 
                                         f32 %115 = OpFNegate %114 
                                         f32 %116 = OpFMul %113 %115 
                                                      OpStore %88 %116 
                                         f32 %119 = OpLoad %88 
                                         f32 %120 = OpExtInst %1 29 %119 
                                                      OpStore vs_TEXCOORD0 %120 
                                       f32_2 %126 = OpLoad %125 
                              Uniform f32_4* %128 = OpAccessChain %21 %127 
                                       f32_4 %129 = OpLoad %128 
                                       f32_2 %130 = OpVectorShuffle %129 %129 0 1 
                                       f32_2 %131 = OpFMul %126 %130 
                              Uniform f32_4* %132 = OpAccessChain %21 %127 
                                       f32_4 %133 = OpLoad %132 
                                       f32_2 %134 = OpVectorShuffle %133 %133 2 3 
                                       f32_2 %135 = OpFAdd %131 %134 
                                                      OpStore vs_TEXCOORD1 %135 
                                Private f32* %137 = OpAccessChain %9 %76 
                                         f32 %138 = OpLoad %137 
                                Uniform f32* %139 = OpAccessChain %21 %36 %23 %89 
                                         f32 %140 = OpLoad %139 
                                         f32 %141 = OpFMul %138 %140 
                                                      OpStore %136 %141 
                                Uniform f32* %142 = OpAccessChain %21 %36 %28 %89 
                                         f32 %143 = OpLoad %142 
                                Private f32* %144 = OpAccessChain %9 %109 
                                         f32 %145 = OpLoad %144 
                                         f32 %146 = OpFMul %143 %145 
                                         f32 %147 = OpLoad %136 
                                         f32 %148 = OpFAdd %146 %147 
                                Private f32* %149 = OpAccessChain %9 %109 
                                                      OpStore %149 %148 
                                Uniform f32* %150 = OpAccessChain %21 %36 %36 %89 
                                         f32 %151 = OpLoad %150 
                                Private f32* %152 = OpAccessChain %9 %89 
                                         f32 %153 = OpLoad %152 
                                         f32 %154 = OpFMul %151 %153 
                                Private f32* %155 = OpAccessChain %9 %109 
                                         f32 %156 = OpLoad %155 
                                         f32 %157 = OpFAdd %154 %156 
                                Private f32* %158 = OpAccessChain %9 %109 
                                                      OpStore %158 %157 
                                Uniform f32* %159 = OpAccessChain %21 %36 %45 %89 
                                         f32 %160 = OpLoad %159 
                                Private f32* %162 = OpAccessChain %9 %161 
                                         f32 %163 = OpLoad %162 
                                         f32 %164 = OpFMul %160 %163 
                                Private f32* %165 = OpAccessChain %9 %109 
                                         f32 %166 = OpLoad %165 
                                         f32 %167 = OpFAdd %164 %166 
                                Private f32* %168 = OpAccessChain %9 %109 
                                                      OpStore %168 %167 
                                Private f32* %170 = OpAccessChain %9 %109 
                                         f32 %171 = OpLoad %170 
                                         f32 %172 = OpFNegate %171 
                                 Output f32* %173 = OpAccessChain vs_TEXCOORD3 %89 
                                                      OpStore %173 %172 
                                Private f32* %174 = OpAccessChain %49 %76 
                                         f32 %175 = OpLoad %174 
                                Uniform f32* %176 = OpAccessChain %21 %28 %109 
                                         f32 %177 = OpLoad %176 
                                         f32 %178 = OpFMul %175 %177 
                                Private f32* %179 = OpAccessChain %9 %109 
                                                      OpStore %179 %178 
                                Private f32* %180 = OpAccessChain %9 %109 
                                         f32 %181 = OpLoad %180 
                                         f32 %183 = OpFMul %181 %182 
                                Private f32* %184 = OpAccessChain %9 %161 
                                                      OpStore %184 %183 
                                       f32_4 %185 = OpLoad %49 
                                       f32_2 %186 = OpVectorShuffle %185 %185 0 3 
                                       f32_2 %188 = OpFMul %186 %187 
                                       f32_4 %189 = OpLoad %9 
                                       f32_4 %190 = OpVectorShuffle %189 %188 4 1 5 3 
                                                      OpStore %9 %190 
                                Private f32* %191 = OpAccessChain %49 %161 
                                         f32 %192 = OpLoad %191 
                                 Output f32* %193 = OpAccessChain vs_TEXCOORD3 %161 
                                                      OpStore %193 %192 
                                       f32_4 %194 = OpLoad %9 
                                       f32_2 %195 = OpVectorShuffle %194 %194 2 2 
                                       f32_4 %196 = OpLoad %9 
                                       f32_2 %197 = OpVectorShuffle %196 %196 0 3 
                                       f32_2 %198 = OpFAdd %195 %197 
                                       f32_4 %199 = OpLoad vs_TEXCOORD3 
                                       f32_4 %200 = OpVectorShuffle %199 %198 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %200 
                                 Output f32* %201 = OpAccessChain %80 %28 %76 
                                         f32 %202 = OpLoad %201 
                                         f32 %203 = OpFNegate %202 
                                 Output f32* %204 = OpAccessChain %80 %28 %76 
                                                      OpStore %204 %203 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 110
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %35 %50 %66 %92 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpMemberDecorate %12 0 RelaxedPrecision 
                                             OpMemberDecorate %12 0 Offset 12 
                                             OpMemberDecorate %12 1 RelaxedPrecision 
                                             OpMemberDecorate %12 1 Offset 12 
                                             OpMemberDecorate %12 2 Offset 12 
                                             OpDecorate %12 Block 
                                             OpDecorate %14 DescriptorSet 14 
                                             OpDecorate %14 Binding 14 
                                             OpDecorate %22 RelaxedPrecision 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %25 DescriptorSet 25 
                                             OpDecorate %25 Binding 25 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %30 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 35 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %39 RelaxedPrecision 
                                             OpDecorate %42 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %50 Location 50 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %57 RelaxedPrecision 
                                             OpDecorate %58 RelaxedPrecision 
                                             OpDecorate %61 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 66 
                                             OpDecorate %83 RelaxedPrecision 
                                             OpDecorate %84 RelaxedPrecision 
                                             OpDecorate %92 RelaxedPrecision 
                                             OpDecorate %92 Location 92 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeBool 
                                      %7 = OpTypePointer Private %6 
                        Private bool* %8 = OpVariable Private 
                                      %9 = OpTypeFloat 32 
                                     %10 = OpTypeVector %9 4 
                                     %11 = OpTypeInt 32 1 
                                     %12 = OpTypeStruct %10 %10 %11 
                                     %13 = OpTypePointer Uniform %12 
Uniform struct {f32_4; f32_4; i32;}* %14 = OpVariable Uniform 
                                 i32 %15 = OpConstant 2 
                                     %16 = OpTypePointer Uniform %11 
                                 i32 %19 = OpConstant 1 
                                     %21 = OpTypePointer Private %10 
                      Private f32_4* %22 = OpVariable Private 
                                     %23 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
                                     %24 = OpTypePointer UniformConstant %23 
UniformConstant read_only Texture2D* %25 = OpVariable UniformConstant 
                                     %27 = OpTypeSampler 
                                     %28 = OpTypePointer UniformConstant %27 
            UniformConstant sampler* %29 = OpVariable UniformConstant 
                                     %31 = OpTypeSampledImage %23 
                                     %33 = OpTypeVector %9 2 
                                     %34 = OpTypePointer Input %33 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %38 = OpVariable Private 
                                     %40 = OpTypePointer Uniform %10 
                                     %44 = OpTypeVector %9 3 
                                     %45 = OpTypePointer Private %44 
                      Private f32_3* %46 = OpVariable Private 
                                     %49 = OpTypePointer Input %10 
                        Input f32_4* %50 = OpVariable Input 
                                 i32 %54 = OpConstant 0 
                      Private f32_4* %60 = OpVariable Private 
                      Private f32_3* %64 = OpVariable Private 
                                     %65 = OpTypePointer Input %9 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                     %68 = OpTypeInt 32 0 
                                 u32 %69 = OpConstant 0 
                                     %70 = OpTypePointer Private %9 
                                 f32 %74 = OpConstant 3.674022E-40 
                                 f32 %75 = OpConstant 3.674022E-40 
                                     %91 = OpTypePointer Output %10 
                       Output f32_4* %92 = OpVariable Output 
                                 u32 %93 = OpConstant 3 
                                     %96 = OpTypePointer Output %9 
                                     %99 = OpTypePointer Function %44 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                    Function f32_3* %100 = OpVariable Function 
                        Uniform i32* %17 = OpAccessChain %14 %15 
                                 i32 %18 = OpLoad %17 
                                bool %20 = OpIEqual %18 %19 
                                             OpStore %8 %20 
                 read_only Texture2D %26 = OpLoad %25 
                             sampler %30 = OpLoad %29 
          read_only Texture2DSampled %32 = OpSampledImage %26 %30 
                               f32_2 %36 = OpLoad vs_TEXCOORD1 
                               f32_4 %37 = OpImageSampleImplicitLod %32 %36 
                                             OpStore %22 %37 
                               f32_4 %39 = OpLoad %22 
                      Uniform f32_4* %41 = OpAccessChain %14 %19 
                               f32_4 %42 = OpLoad %41 
                               f32_4 %43 = OpFMul %39 %42 
                                             OpStore %38 %43 
                               f32_4 %47 = OpLoad %38 
                               f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                               f32_4 %51 = OpLoad %50 
                               f32_3 %52 = OpVectorShuffle %51 %51 0 1 2 
                               f32_3 %53 = OpFMul %48 %52 
                      Uniform f32_4* %55 = OpAccessChain %14 %54 
                               f32_4 %56 = OpLoad %55 
                               f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                               f32_3 %58 = OpFNegate %57 
                               f32_3 %59 = OpFAdd %53 %58 
                                             OpStore %46 %59 
                               f32_4 %61 = OpLoad %38 
                               f32_4 %62 = OpLoad %50 
                               f32_4 %63 = OpFMul %61 %62 
                                             OpStore %60 %63 
                                 f32 %67 = OpLoad vs_TEXCOORD0 
                        Private f32* %71 = OpAccessChain %64 %69 
                                             OpStore %71 %67 
                        Private f32* %72 = OpAccessChain %64 %69 
                                 f32 %73 = OpLoad %72 
                                 f32 %76 = OpExtInst %1 43 %73 %74 %75 
                        Private f32* %77 = OpAccessChain %64 %69 
                                             OpStore %77 %76 
                               f32_3 %78 = OpLoad %64 
                               f32_3 %79 = OpVectorShuffle %78 %78 0 0 0 
                               f32_3 %80 = OpLoad %46 
                               f32_3 %81 = OpFMul %79 %80 
                      Uniform f32_4* %82 = OpAccessChain %14 %54 
                               f32_4 %83 = OpLoad %82 
                               f32_3 %84 = OpVectorShuffle %83 %83 0 1 2 
                               f32_3 %85 = OpFAdd %81 %84 
                                             OpStore %46 %85 
                               f32_4 %86 = OpLoad %60 
                               f32_3 %87 = OpVectorShuffle %86 %86 0 1 2 
                               f32_3 %88 = OpLoad %64 
                               f32_3 %89 = OpVectorShuffle %88 %88 0 0 0 
                               f32_3 %90 = OpFMul %87 %89 
                                             OpStore %64 %90 
                        Private f32* %94 = OpAccessChain %60 %93 
                                 f32 %95 = OpLoad %94 
                         Output f32* %97 = OpAccessChain %92 %93 
                                             OpStore %97 %95 
                                bool %98 = OpLoad %8 
                                             OpSelectionMerge %102 None 
                                             OpBranchConditional %98 %101 %104 
                                    %101 = OpLabel 
                              f32_3 %103 = OpLoad %64 
                                             OpStore %100 %103 
                                             OpBranch %102 
                                    %104 = OpLabel 
                              f32_3 %105 = OpLoad %46 
                                             OpStore %100 %105 
                                             OpBranch %102 
                                    %102 = OpLabel 
                              f32_3 %106 = OpLoad %100 
                              f32_4 %107 = OpLoad %92 
                              f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
                                             OpStore %92 %108 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat12 = u_xlat0.z * unity_FogParams.x;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    vs_TEXCOORD0 = exp2(u_xlat12);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD0;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 448
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %233 %246 %249 %299 %353 %383 %423 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %155 ArrayStride 155 
                                                      OpDecorate %156 ArrayStride 156 
                                                      OpMemberDecorate %157 0 Offset 157 
                                                      OpMemberDecorate %157 1 Offset 157 
                                                      OpMemberDecorate %157 2 Offset 157 
                                                      OpMemberDecorate %157 3 Offset 157 
                                                      OpMemberDecorate %157 4 Offset 157 
                                                      OpMemberDecorate %157 5 Offset 157 
                                                      OpMemberDecorate %157 6 Offset 157 
                                                      OpDecorate %157 Block 
                                                      OpDecorate %159 DescriptorSet 159 
                                                      OpDecorate %159 Binding 159 
                                                      OpDecorate vs_TEXCOORD3 Location 233 
                                                      OpMemberDecorate %244 0 BuiltIn 244 
                                                      OpMemberDecorate %244 1 BuiltIn 244 
                                                      OpMemberDecorate %244 2 BuiltIn 244 
                                                      OpDecorate %244 Block 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %250 RelaxedPrecision 
                                                      OpDecorate %253 RelaxedPrecision 
                                                      OpDecorate %299 Location 299 
                                                      OpDecorate %353 Location 353 
                                                      OpDecorate vs_TEXCOORD1 Location 383 
                                                      OpDecorate vs_TEXCOORD0 Location 423 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                              Private f32_4* %134 = OpVariable Private 
                                         i32 %136 = OpConstant 13 
                                Private f32* %148 = OpVariable Private 
                                         u32 %154 = OpConstant 4 
                                             %155 = OpTypeArray %7 %154 
                                             %156 = OpTypeArray %7 %154 
                                             %157 = OpTypeStruct %7 %155 %156 %7 %7 %6 %7 
                                             %158 = OpTypePointer Uniform %157 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32_4;}* %159 = OpVariable Uniform 
                                             %160 = OpTypePointer Uniform %7 
                                             %165 = OpTypePointer Uniform %6 
                                             %232 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %237 = OpTypePointer Output %6 
                                             %243 = OpTypeArray %6 %89 
                                             %244 = OpTypeStruct %7 %6 %243 
                                             %245 = OpTypePointer Output %244 
        Output struct {f32_4; f32; f32[1];}* %246 = OpVariable Output 
                                Input f32_4* %249 = OpVariable Input 
                                         f32 %251 = OpConstant 3.674022E-40 
                                       f32_4 %252 = OpConstantComposite %251 %251 %251 %251 
                                       f32_4 %259 = OpConstantComposite %17 %17 %17 %17 
                                             %261 = OpTypeVector %18 3 
                                             %262 = OpTypePointer Private %261 
                              Private u32_3* %263 = OpVariable Private 
                                         u32 %267 = OpConstant 255 
                                             %269 = OpTypePointer Private %18 
                                         i32 %283 = OpConstant 16 
                                         u32 %289 = OpConstant 24 
                               Output f32_4* %299 = OpVariable Output 
                                         f32 %301 = OpConstant 3.674022E-40 
                                       f32_4 %302 = OpConstantComposite %301 %301 %301 %301 
                                             %328 = OpTypeVector %6 2 
                                             %329 = OpTypePointer Private %328 
                              Private f32_2* %330 = OpVariable Private 
                                             %352 = OpTypePointer Input %328 
                                Input f32_2* %353 = OpVariable Input 
                                             %363 = OpTypeBool 
                                             %364 = OpTypePointer Private %363 
                               Private bool* %365 = OpVariable Private 
                                         f32 %368 = OpConstant 3.674022E-40 
                                             %371 = OpTypePointer Function %328 
                                             %382 = OpTypePointer Output %328 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                Private f32* %394 = OpVariable Private 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                                         f32 %428 = OpConstant 3.674022E-40 
                                       f32_3 %429 = OpConstantComposite %428 %428 %428 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %372 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %135 = OpLoad %24 
                                Uniform u32* %137 = OpAccessChain %43 %31 %135 %31 %136 
                                         u32 %138 = OpLoad %137 
                                         f32 %139 = OpBitcast %138 
                                Private f32* %140 = OpAccessChain %134 %66 
                                                      OpStore %140 %139 
                                Private f32* %141 = OpAccessChain %134 %66 
                                         f32 %142 = OpLoad %141 
                                         f32 %143 = OpExtInst %1 8 %142 
                                Private f32* %144 = OpAccessChain %134 %66 
                                                      OpStore %144 %143 
                                Private f32* %145 = OpAccessChain %112 %89 
                                         f32 %146 = OpLoad %145 
                                Private f32* %147 = OpAccessChain %62 %19 
                                                      OpStore %147 %146 
                                       f32_4 %149 = OpLoad %62 
                                       f32_4 %150 = OpLoad %9 
                                         f32 %151 = OpDot %149 %150 
                                                      OpStore %148 %151 
                                         f32 %152 = OpLoad %148 
                                       f32_4 %153 = OpCompositeConstruct %152 %152 %152 %152 
                              Uniform f32_4* %161 = OpAccessChain %159 %45 %55 
                                       f32_4 %162 = OpLoad %161 
                                       f32_4 %163 = OpFMul %153 %162 
                                                      OpStore %62 %163 
                                         f32 %164 = OpLoad %148 
                                Uniform f32* %166 = OpAccessChain %159 %55 %55 %63 
                                         f32 %167 = OpLoad %166 
                                         f32 %168 = OpFMul %164 %167 
                                                      OpStore %148 %168 
                                Private f32* %169 = OpAccessChain %36 %89 
                                         f32 %170 = OpLoad %169 
                                Private f32* %171 = OpAccessChain %68 %66 
                                                      OpStore %171 %170 
                                Private f32* %172 = OpAccessChain %68 %63 
                                         f32 %173 = OpLoad %172 
                                Private f32* %174 = OpAccessChain %36 %89 
                                                      OpStore %174 %173 
                                Private f32* %175 = OpAccessChain %92 %66 
                                         f32 %176 = OpLoad %175 
                                Private f32* %177 = OpAccessChain %68 %63 
                                                      OpStore %177 %176 
                                Private f32* %178 = OpAccessChain %92 %63 
                                         f32 %179 = OpLoad %178 
                                Private f32* %180 = OpAccessChain %36 %63 
                                                      OpStore %180 %179 
                                Private f32* %181 = OpAccessChain %112 %66 
                                         f32 %182 = OpLoad %181 
                                Private f32* %183 = OpAccessChain %68 %19 
                                                      OpStore %183 %182 
                                       f32_4 %184 = OpLoad %68 
                                       f32_4 %185 = OpLoad %9 
                                         f32 %186 = OpDot %184 %185 
                                Private f32* %187 = OpAccessChain %92 %66 
                                                      OpStore %187 %186 
                              Uniform f32_4* %188 = OpAccessChain %159 %45 %31 
                                       f32_4 %189 = OpLoad %188 
                                       f32_3 %190 = OpLoad %92 
                                       f32_4 %191 = OpVectorShuffle %190 %190 0 0 0 0 
                                       f32_4 %192 = OpFMul %189 %191 
                                       f32_4 %193 = OpLoad %62 
                                       f32_4 %194 = OpFAdd %192 %193 
                                                      OpStore %62 %194 
                                Uniform f32* %195 = OpAccessChain %159 %55 %31 %63 
                                         f32 %196 = OpLoad %195 
                                Private f32* %197 = OpAccessChain %92 %66 
                                         f32 %198 = OpLoad %197 
                                         f32 %199 = OpFMul %196 %198 
                                         f32 %200 = OpLoad %148 
                                         f32 %201 = OpFAdd %199 %200 
                                Private f32* %202 = OpAccessChain %92 %66 
                                                      OpStore %202 %201 
                                Private f32* %203 = OpAccessChain %112 %63 
                                         f32 %204 = OpLoad %203 
                                Private f32* %205 = OpAccessChain %36 %19 
                                                      OpStore %205 %204 
                                       f32_4 %206 = OpLoad %36 
                                       f32_4 %207 = OpLoad %9 
                                         f32 %208 = OpDot %206 %207 
                                Private f32* %209 = OpAccessChain %9 %66 
                                                      OpStore %209 %208 
                              Uniform f32_4* %210 = OpAccessChain %159 %45 %45 
                                       f32_4 %211 = OpLoad %210 
                                       f32_4 %212 = OpLoad %9 
                                       f32_4 %213 = OpVectorShuffle %212 %212 0 0 0 0 
                                       f32_4 %214 = OpFMul %211 %213 
                                       f32_4 %215 = OpLoad %62 
                                       f32_4 %216 = OpFAdd %214 %215 
                                                      OpStore %36 %216 
                                Uniform f32* %217 = OpAccessChain %159 %55 %45 %63 
                                         f32 %218 = OpLoad %217 
                                Private f32* %219 = OpAccessChain %9 %66 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpFMul %218 %220 
                                Private f32* %222 = OpAccessChain %92 %66 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFAdd %221 %223 
                                Private f32* %225 = OpAccessChain %9 %66 
                                                      OpStore %225 %224 
                                Private f32* %226 = OpAccessChain %9 %66 
                                         f32 %227 = OpLoad %226 
                                Uniform f32* %228 = OpAccessChain %159 %55 %75 %63 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpFAdd %227 %229 
                                Private f32* %231 = OpAccessChain %9 %66 
                                                      OpStore %231 %230 
                                Private f32* %234 = OpAccessChain %9 %66 
                                         f32 %235 = OpLoad %234 
                                         f32 %236 = OpFNegate %235 
                                 Output f32* %238 = OpAccessChain vs_TEXCOORD3 %63 
                                                      OpStore %238 %236 
                                       f32_4 %239 = OpLoad %36 
                              Uniform f32_4* %240 = OpAccessChain %159 %45 %75 
                                       f32_4 %241 = OpLoad %240 
                                       f32_4 %242 = OpFAdd %239 %241 
                                                      OpStore %9 %242 
                                       f32_4 %247 = OpLoad %9 
                               Output f32_4* %248 = OpAccessChain %246 %31 
                                                      OpStore %248 %247 
                                       f32_4 %250 = OpLoad %249 
                                       f32_4 %253 = OpFAdd %250 %252 
                                                      OpStore %36 %253 
                                Uniform f32* %254 = OpAccessChain %159 %80 
                                         f32 %255 = OpLoad %254 
                                       f32_4 %256 = OpCompositeConstruct %255 %255 %255 %255 
                                       f32_4 %257 = OpLoad %36 
                                       f32_4 %258 = OpFMul %256 %257 
                                       f32_4 %260 = OpFAdd %258 %259 
                                                      OpStore %36 %260 
                                Private f32* %264 = OpAccessChain %112 %19 
                                         f32 %265 = OpLoad %264 
                                         u32 %266 = OpBitcast %265 
                                         u32 %268 = OpBitwiseAnd %266 %267 
                                Private u32* %270 = OpAccessChain %263 %66 
                                                      OpStore %270 %268 
                                Private u32* %271 = OpAccessChain %263 %66 
                                         u32 %272 = OpLoad %271 
                                         f32 %273 = OpConvertUToF %272 
                                Private f32* %274 = OpAccessChain %62 %66 
                                                      OpStore %274 %273 
                                Private f32* %275 = OpAccessChain %112 %19 
                                         f32 %276 = OpLoad %275 
                                         u32 %277 = OpBitcast %276 
                                         u32 %278 = OpBitFieldUExtract %277 %104 %104 
                                Private u32* %279 = OpAccessChain %263 %66 
                                                      OpStore %279 %278 
                                Private f32* %280 = OpAccessChain %112 %19 
                                         f32 %281 = OpLoad %280 
                                         u32 %282 = OpBitcast %281 
                                         u32 %284 = OpBitFieldUExtract %282 %283 %104 
                                Private u32* %285 = OpAccessChain %263 %89 
                                                      OpStore %285 %284 
                                Private f32* %286 = OpAccessChain %112 %19 
                                         f32 %287 = OpLoad %286 
                                         u32 %288 = OpBitcast %287 
                                         u32 %290 = OpShiftRightLogical %288 %289 
                                Private u32* %291 = OpAccessChain %263 %63 
                                                      OpStore %291 %290 
                                       u32_3 %292 = OpLoad %263 
                                       f32_3 %293 = OpConvertUToF %292 
                                       f32_4 %294 = OpLoad %62 
                                       f32_4 %295 = OpVectorShuffle %294 %293 0 4 5 6 
                                                      OpStore %62 %295 
                                       f32_4 %296 = OpLoad %36 
                                       f32_4 %297 = OpLoad %62 
                                       f32_4 %298 = OpFMul %296 %297 
                                                      OpStore %36 %298 
                                       f32_4 %300 = OpLoad %36 
                                       f32_4 %303 = OpFMul %300 %302 
                                                      OpStore %299 %303 
                                Private f32* %304 = OpAccessChain %134 %66 
                                         f32 %305 = OpLoad %304 
                                Uniform f32* %306 = OpAccessChain %159 %70 %89 
                                         f32 %307 = OpLoad %306 
                                         f32 %308 = OpFDiv %305 %307 
                                Private f32* %309 = OpAccessChain %92 %66 
                                                      OpStore %309 %308 
                                Private f32* %310 = OpAccessChain %92 %66 
                                         f32 %311 = OpLoad %310 
                                         f32 %312 = OpExtInst %1 8 %311 
                                Private f32* %313 = OpAccessChain %92 %66 
                                                      OpStore %313 %312 
                                Private f32* %314 = OpAccessChain %92 %66 
                                         f32 %315 = OpLoad %314 
                                         f32 %316 = OpFNegate %315 
                                Uniform f32* %317 = OpAccessChain %159 %70 %89 
                                         f32 %318 = OpLoad %317 
                                         f32 %319 = OpFMul %316 %318 
                                Private f32* %320 = OpAccessChain %134 %66 
                                         f32 %321 = OpLoad %320 
                                         f32 %322 = OpFAdd %319 %321 
                                Private f32* %323 = OpAccessChain %134 %66 
                                                      OpStore %323 %322 
                                Private f32* %324 = OpAccessChain %134 %66 
                                         f32 %325 = OpLoad %324 
                                         f32 %326 = OpExtInst %1 8 %325 
                                Private f32* %327 = OpAccessChain %134 %66 
                                                      OpStore %327 %326 
                                Private f32* %331 = OpAccessChain %134 %66 
                                         f32 %332 = OpLoad %331 
                                Uniform f32* %333 = OpAccessChain %159 %70 %63 
                                         f32 %334 = OpLoad %333 
                                         f32 %335 = OpFMul %332 %334 
                                Private f32* %336 = OpAccessChain %330 %66 
                                                      OpStore %336 %335 
                                Uniform f32* %337 = OpAccessChain %159 %70 %19 
                                         f32 %338 = OpLoad %337 
                                         f32 %339 = OpFNegate %338 
                                         f32 %340 = OpFAdd %339 %17 
                                Private f32* %341 = OpAccessChain %134 %66 
                                                      OpStore %341 %340 
                                Private f32* %342 = OpAccessChain %92 %66 
                                         f32 %343 = OpLoad %342 
                                         f32 %344 = OpFNegate %343 
                                Uniform f32* %345 = OpAccessChain %159 %70 %19 
                                         f32 %346 = OpLoad %345 
                                         f32 %347 = OpFMul %344 %346 
                                Private f32* %348 = OpAccessChain %134 %66 
                                         f32 %349 = OpLoad %348 
                                         f32 %350 = OpFAdd %347 %349 
                                Private f32* %351 = OpAccessChain %330 %89 
                                                      OpStore %351 %350 
                                       f32_2 %354 = OpLoad %353 
                              Uniform f32_4* %355 = OpAccessChain %159 %70 
                                       f32_4 %356 = OpLoad %355 
                                       f32_2 %357 = OpVectorShuffle %356 %356 2 3 
                                       f32_2 %358 = OpFMul %354 %357 
                                       f32_2 %359 = OpLoad %330 
                                       f32_2 %360 = OpFAdd %358 %359 
                                       f32_4 %361 = OpLoad %134 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 2 3 
                                                      OpStore %134 %362 
                                Uniform f32* %366 = OpAccessChain %159 %70 %66 
                                         f32 %367 = OpLoad %366 
                                        bool %369 = OpFOrdNotEqual %367 %368 
                                                      OpStore %365 %369 
                                        bool %370 = OpLoad %365 
                                                      OpSelectionMerge %374 None 
                                                      OpBranchConditional %370 %373 %377 
                                             %373 = OpLabel 
                                       f32_4 %375 = OpLoad %134 
                                       f32_2 %376 = OpVectorShuffle %375 %375 0 1 
                                                      OpStore %372 %376 
                                                      OpBranch %374 
                                             %377 = OpLabel 
                                       f32_2 %378 = OpLoad %353 
                                                      OpStore %372 %378 
                                                      OpBranch %374 
                                             %374 = OpLabel 
                                       f32_2 %379 = OpLoad %372 
                                       f32_4 %380 = OpLoad %134 
                                       f32_4 %381 = OpVectorShuffle %380 %379 4 5 2 3 
                                                      OpStore %134 %381 
                                       f32_4 %384 = OpLoad %134 
                                       f32_2 %385 = OpVectorShuffle %384 %384 0 1 
                              Uniform f32_4* %386 = OpAccessChain %159 %94 
                                       f32_4 %387 = OpLoad %386 
                                       f32_2 %388 = OpVectorShuffle %387 %387 0 1 
                                       f32_2 %389 = OpFMul %385 %388 
                              Uniform f32_4* %390 = OpAccessChain %159 %94 
                                       f32_4 %391 = OpLoad %390 
                                       f32_2 %392 = OpVectorShuffle %391 %391 2 3 
                                       f32_2 %393 = OpFAdd %389 %392 
                                                      OpStore vs_TEXCOORD1 %393 
                                Private f32* %395 = OpAccessChain %9 %63 
                                         f32 %396 = OpLoad %395 
                                Uniform f32* %397 = OpAccessChain %159 %31 %89 
                                         f32 %398 = OpLoad %397 
                                         f32 %399 = OpFDiv %396 %398 
                                                      OpStore %394 %399 
                                         f32 %400 = OpLoad %394 
                                         f32 %401 = OpFNegate %400 
                                         f32 %402 = OpFAdd %401 %17 
                                Private f32* %403 = OpAccessChain %9 %63 
                                                      OpStore %403 %402 
                                       f32_4 %404 = OpLoad %9 
                                       f32_2 %405 = OpVectorShuffle %404 %404 1 2 
                              Uniform f32_4* %406 = OpAccessChain %159 %31 
                                       f32_4 %407 = OpLoad %406 
                                       f32_2 %408 = OpVectorShuffle %407 %407 0 2 
                                       f32_2 %409 = OpFMul %405 %408 
                                       f32_4 %410 = OpLoad %9 
                                       f32_4 %411 = OpVectorShuffle %410 %409 0 4 5 3 
                                                      OpStore %9 %411 
                                Private f32* %412 = OpAccessChain %9 %63 
                                         f32 %413 = OpLoad %412 
                                         f32 %414 = OpExtInst %1 40 %413 %368 
                                                      OpStore %394 %414 
                                         f32 %415 = OpLoad %394 
                                Uniform f32* %416 = OpAccessChain %159 %75 %66 
                                         f32 %417 = OpLoad %416 
                                         f32 %418 = OpFMul %415 %417 
                                                      OpStore %394 %418 
                                         f32 %419 = OpLoad %394 
                                         f32 %420 = OpLoad %394 
                                         f32 %421 = OpFNegate %420 
                                         f32 %422 = OpFMul %419 %421 
                                                      OpStore %394 %422 
                                         f32 %424 = OpLoad %394 
                                         f32 %425 = OpExtInst %1 29 %424 
                                                      OpStore vs_TEXCOORD0 %425 
                                       f32_4 %426 = OpLoad %9 
                                       f32_3 %427 = OpVectorShuffle %426 %426 0 3 1 
                                       f32_3 %430 = OpFMul %427 %429 
                                       f32_4 %431 = OpLoad %134 
                                       f32_4 %432 = OpVectorShuffle %431 %430 4 1 5 6 
                                                      OpStore %134 %432 
                                Private f32* %433 = OpAccessChain %9 %19 
                                         f32 %434 = OpLoad %433 
                                 Output f32* %435 = OpAccessChain vs_TEXCOORD3 %19 
                                                      OpStore %435 %434 
                                       f32_4 %436 = OpLoad %134 
                                       f32_2 %437 = OpVectorShuffle %436 %436 2 2 
                                       f32_4 %438 = OpLoad %134 
                                       f32_2 %439 = OpVectorShuffle %438 %438 0 3 
                                       f32_2 %440 = OpFAdd %437 %439 
                                       f32_4 %441 = OpLoad vs_TEXCOORD3 
                                       f32_4 %442 = OpVectorShuffle %441 %440 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %442 
                                 Output f32* %443 = OpAccessChain %246 %31 %89 
                                         f32 %444 = OpLoad %443 
                                         f32 %445 = OpFNegate %444 
                                 Output f32* %446 = OpAccessChain %246 %31 %89 
                                                      OpStore %446 %445 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 79
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %42 %55 %70 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpDecorate %9 RelaxedPrecision 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 22 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpMemberDecorate %29 0 RelaxedPrecision 
                                             OpMemberDecorate %29 0 Offset 29 
                                             OpMemberDecorate %29 1 RelaxedPrecision 
                                             OpMemberDecorate %29 1 Offset 29 
                                             OpDecorate %29 Block 
                                             OpDecorate %31 DescriptorSet 31 
                                             OpDecorate %31 Binding 31 
                                             OpDecorate %36 RelaxedPrecision 
                                             OpDecorate %37 RelaxedPrecision 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %40 RelaxedPrecision 
                                             OpDecorate %42 Location 42 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %49 RelaxedPrecision 
                                             OpDecorate %50 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 55 
                                             OpDecorate %66 RelaxedPrecision 
                                             OpDecorate %67 RelaxedPrecision 
                                             OpDecorate %70 RelaxedPrecision 
                                             OpDecorate %70 Location 70 
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
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                                     %24 = OpTypeVector %6 4 
                      Private f32_3* %27 = OpVariable Private 
                                     %29 = OpTypeStruct %24 %24 
                                     %30 = OpTypePointer Uniform %29 
     Uniform struct {f32_4; f32_4;}* %31 = OpVariable Uniform 
                                     %32 = OpTypeInt 32 1 
                                 i32 %33 = OpConstant 1 
                                     %34 = OpTypePointer Uniform %24 
                      Private f32_3* %39 = OpVariable Private 
                                     %41 = OpTypePointer Input %24 
                        Input f32_4* %42 = OpVariable Input 
                                 i32 %46 = OpConstant 0 
                                     %52 = OpTypePointer Private %6 
                        Private f32* %53 = OpVariable Private 
                                     %54 = OpTypePointer Input %6 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                 f32 %58 = OpConstant 3.674022E-40 
                                 f32 %59 = OpConstant 3.674022E-40 
                                     %69 = OpTypePointer Output %24 
                       Output f32_4* %70 = OpVariable Output 
                                     %74 = OpTypeInt 32 0 
                                 u32 %75 = OpConstant 3 
                                     %76 = OpTypePointer Output %6 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD1 
                               f32_4 %25 = OpImageSampleImplicitLod %19 %23 
                               f32_3 %26 = OpVectorShuffle %25 %25 0 1 2 
                                             OpStore %9 %26 
                               f32_3 %28 = OpLoad %9 
                      Uniform f32_4* %35 = OpAccessChain %31 %33 
                               f32_4 %36 = OpLoad %35 
                               f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                               f32_3 %38 = OpFMul %28 %37 
                                             OpStore %27 %38 
                               f32_3 %40 = OpLoad %27 
                               f32_4 %43 = OpLoad %42 
                               f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                               f32_3 %45 = OpFMul %40 %44 
                      Uniform f32_4* %47 = OpAccessChain %31 %46 
                               f32_4 %48 = OpLoad %47 
                               f32_3 %49 = OpVectorShuffle %48 %48 0 1 2 
                               f32_3 %50 = OpFNegate %49 
                               f32_3 %51 = OpFAdd %45 %50 
                                             OpStore %39 %51 
                                 f32 %56 = OpLoad vs_TEXCOORD0 
                                             OpStore %53 %56 
                                 f32 %57 = OpLoad %53 
                                 f32 %60 = OpExtInst %1 43 %57 %58 %59 
                                             OpStore %53 %60 
                                 f32 %61 = OpLoad %53 
                               f32_3 %62 = OpCompositeConstruct %61 %61 %61 
                               f32_3 %63 = OpLoad %39 
                               f32_3 %64 = OpFMul %62 %63 
                      Uniform f32_4* %65 = OpAccessChain %31 %46 
                               f32_4 %66 = OpLoad %65 
                               f32_3 %67 = OpVectorShuffle %66 %66 0 1 2 
                               f32_3 %68 = OpFAdd %64 %67 
                                             OpStore %39 %68 
                               f32_3 %71 = OpLoad %39 
                               f32_4 %72 = OpLoad %70 
                               f32_4 %73 = OpVectorShuffle %72 %71 4 5 6 3 
                                             OpStore %70 %73 
                         Output f32* %77 = OpAccessChain %70 %75 
                                             OpStore %77 %59 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"#ifdef VERTEX
#version 310 es

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_ParticleUVShiftData;
uniform 	float unity_ParticleUseMeshColors;
uniform 	vec4 _MainTex_ST;
 struct unity_ParticleInstanceData_type {
	uint[14] value;
};

layout(std430, binding = 0) readonly buffer unity_ParticleInstanceData {
	unity_ParticleInstanceData_type unity_ParticleInstanceData_buf[];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
layout(location = 0) out highp vec4 vs_COLOR0;
layout(location = 1) out highp float vs_TEXCOORD0;
layout(location = 2) out highp vec2 vs_TEXCOORD1;
layout(location = 3) out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat7;
uvec3 u_xlatu7;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz;
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat2.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(0 >> 2) + 1]));
    u_xlat3.x = u_xlat2.z;
    u_xlat4.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(12 >> 2) + 2]));
    u_xlat3.y = u_xlat4.x;
    u_xlat7.xyz = vec3(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(24 >> 2) + 2]));
    u_xlat3.z = u_xlat7.y;
    u_xlat5 = vec4(uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 0]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 1]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 2]), uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(36 >> 2) + 3]));
    u_xlat1.x = uintBitsToFloat(unity_ParticleInstanceData_buf[u_xlati1].value[(52 >> 2) + 0]);
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat3.w = u_xlat5.y;
    u_xlat13 = dot(u_xlat3, u_xlat0);
    u_xlat3 = vec4(u_xlat13) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat13 = u_xlat13 * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = u_xlat2.y;
    u_xlat2.y = u_xlat4.z;
    u_xlat4.z = u_xlat7.x;
    u_xlat2.z = u_xlat7.z;
    u_xlat4.w = u_xlat5.x;
    u_xlat7.x = dot(u_xlat4, u_xlat0);
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat7.xxxx + u_xlat3;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat7.x + u_xlat13;
    u_xlat2.w = u_xlat5.z;
    u_xlat0.x = dot(u_xlat2, u_xlat0);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    u_xlat0 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat2 = in_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(unity_ParticleUseMeshColors) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlatu7.x = floatBitsToUint(u_xlat5.w) & 255u;
    u_xlat3.x = float(u_xlatu7.x);
    u_xlatu7.x = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(8), int(8));
    u_xlatu7.y = bitfieldExtract(floatBitsToUint(u_xlat5.w), int(16), int(8));
    u_xlatu7.z = floatBitsToUint(u_xlat5.w) >> 24u;
    u_xlat3.yzw = vec3(u_xlatu7.xyz);
    u_xlat2 = u_xlat2 * u_xlat3;
    vs_COLOR0 = u_xlat2 * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886);
    u_xlat7.x = u_xlat1.x / unity_ParticleUVShiftData.y;
    u_xlat7.x = floor(u_xlat7.x);
    u_xlat1.x = (-u_xlat7.x) * unity_ParticleUVShiftData.y + u_xlat1.x;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat8.x = u_xlat1.x * unity_ParticleUVShiftData.z;
    u_xlat1.x = (-unity_ParticleUVShiftData.w) + 1.0;
    u_xlat8.y = (-u_xlat7.x) * unity_ParticleUVShiftData.w + u_xlat1.x;
    u_xlat1.xy = in_TEXCOORD0.xy * unity_ParticleUVShiftData.zw + u_xlat8.xy;
    u_xlatb13 = unity_ParticleUVShiftData.x!=0.0;
    u_xlat1.xy = (bool(u_xlatb13)) ? u_xlat1.xy : in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat12 = u_xlat0.z * unity_FogParams.x;
    u_xlat12 = u_xlat12 * (-u_xlat12);
    vs_TEXCOORD0 = exp2(u_xlat12);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.w = u_xlat0.w;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 310 es

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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	int _DstBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
layout(location = 0) in highp vec4 vs_COLOR0;
layout(location = 1) in highp float vs_TEXCOORD0;
layout(location = 2) in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlatb0 = _DstBlend==1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * _Color;
    u_xlat3.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-unity_FogColor.xyz);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.x = vs_TEXCOORD0;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx;
    SV_Target0.w = u_xlat1.w;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : u_xlat3.xyz;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 448
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %26 %233 %246 %249 %299 %353 %383 %423 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %26 BuiltIn WorkgroupId 
                                                      OpMemberDecorate %28 0 Offset 28 
                                                      OpMemberDecorate %28 1 Offset 28 
                                                      OpDecorate %28 Block 
                                                      OpDecorate %30 DescriptorSet 30 
                                                      OpDecorate %30 Binding 30 
                                                      OpDecorate %38 ArrayStride 38 
                                                      OpMemberDecorate %39 0 Offset 39 
                                                      OpDecorate %40 ArrayStride 40 
                                                      OpMemberDecorate %41 0 NonWritable 
                                                      OpMemberDecorate %41 0 Offset 41 
                                                      OpDecorate %41 BufferBlock 
                                                      OpDecorate %43 DescriptorSet 43 
                                                      OpDecorate %43 Binding 43 
                                                      OpDecorate %155 ArrayStride 155 
                                                      OpDecorate %156 ArrayStride 156 
                                                      OpMemberDecorate %157 0 Offset 157 
                                                      OpMemberDecorate %157 1 Offset 157 
                                                      OpMemberDecorate %157 2 Offset 157 
                                                      OpMemberDecorate %157 3 Offset 157 
                                                      OpMemberDecorate %157 4 Offset 157 
                                                      OpMemberDecorate %157 5 Offset 157 
                                                      OpMemberDecorate %157 6 Offset 157 
                                                      OpDecorate %157 Block 
                                                      OpDecorate %159 DescriptorSet 159 
                                                      OpDecorate %159 Binding 159 
                                                      OpDecorate vs_TEXCOORD3 Location 233 
                                                      OpMemberDecorate %244 0 BuiltIn 244 
                                                      OpMemberDecorate %244 1 BuiltIn 244 
                                                      OpMemberDecorate %244 2 BuiltIn 244 
                                                      OpDecorate %244 Block 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %250 RelaxedPrecision 
                                                      OpDecorate %253 RelaxedPrecision 
                                                      OpDecorate %299 Location 299 
                                                      OpDecorate %353 Location 353 
                                                      OpDecorate vs_TEXCOORD1 Location 383 
                                                      OpDecorate vs_TEXCOORD0 Location 423 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %12 = OpTypeVector %6 3 
                                          f32 %17 = OpConstant 3.674022E-40 
                                              %18 = OpTypeInt 32 0 
                                          u32 %19 = OpConstant 3 
                                              %20 = OpTypePointer Private %6 
                                              %22 = OpTypeInt 32 1 
                                              %23 = OpTypePointer Private %22 
                                 Private i32* %24 = OpVariable Private 
                                              %25 = OpTypePointer Input %22 
                                   Input i32* %26 = OpVariable Input 
                                              %28 = OpTypeStruct %22 %22 
                                              %29 = OpTypePointer Uniform %28 
                  Uniform struct {i32; i32;}* %30 = OpVariable Uniform 
                                          i32 %31 = OpConstant 0 
                                              %32 = OpTypePointer Uniform %22 
                               Private f32_4* %36 = OpVariable Private 
                                          u32 %37 = OpConstant 14 
                                              %38 = OpTypeArray %18 %37 
                                              %39 = OpTypeStruct %38 
                                              %40 = OpTypeRuntimeArray %39 
                                              %41 = OpTypeStruct %40 
                                              %42 = OpTypePointer Uniform %41 
                          Uniform struct {;}* %43 = OpVariable Uniform 
                                          i32 %45 = OpConstant 2 
                                              %46 = OpTypePointer Uniform %18 
                                          i32 %55 = OpConstant 1 
                               Private f32_4* %62 = OpVariable Private 
                                          u32 %63 = OpConstant 2 
                                          u32 %66 = OpConstant 0 
                               Private f32_4* %68 = OpVariable Private 
                                          i32 %70 = OpConstant 4 
                                          i32 %75 = OpConstant 3 
                                          i32 %80 = OpConstant 5 
                                          u32 %89 = OpConstant 1 
                                              %91 = OpTypePointer Private %12 
                               Private f32_3* %92 = OpVariable Private 
                                          i32 %94 = OpConstant 6 
                                          i32 %99 = OpConstant 7 
                                         i32 %104 = OpConstant 8 
                              Private f32_4* %112 = OpVariable Private 
                                         i32 %114 = OpConstant 9 
                                         i32 %119 = OpConstant 10 
                                         i32 %124 = OpConstant 11 
                                         i32 %129 = OpConstant 12 
                              Private f32_4* %134 = OpVariable Private 
                                         i32 %136 = OpConstant 13 
                                Private f32* %148 = OpVariable Private 
                                         u32 %154 = OpConstant 4 
                                             %155 = OpTypeArray %7 %154 
                                             %156 = OpTypeArray %7 %154 
                                             %157 = OpTypeStruct %7 %155 %156 %7 %7 %6 %7 
                                             %158 = OpTypePointer Uniform %157 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4; f32_4; f32; f32_4;}* %159 = OpVariable Uniform 
                                             %160 = OpTypePointer Uniform %7 
                                             %165 = OpTypePointer Uniform %6 
                                             %232 = OpTypePointer Output %7 
                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
                                             %237 = OpTypePointer Output %6 
                                             %243 = OpTypeArray %6 %89 
                                             %244 = OpTypeStruct %7 %6 %243 
                                             %245 = OpTypePointer Output %244 
        Output struct {f32_4; f32; f32[1];}* %246 = OpVariable Output 
                                Input f32_4* %249 = OpVariable Input 
                                         f32 %251 = OpConstant 3.674022E-40 
                                       f32_4 %252 = OpConstantComposite %251 %251 %251 %251 
                                       f32_4 %259 = OpConstantComposite %17 %17 %17 %17 
                                             %261 = OpTypeVector %18 3 
                                             %262 = OpTypePointer Private %261 
                              Private u32_3* %263 = OpVariable Private 
                                         u32 %267 = OpConstant 255 
                                             %269 = OpTypePointer Private %18 
                                         i32 %283 = OpConstant 16 
                                         u32 %289 = OpConstant 24 
                               Output f32_4* %299 = OpVariable Output 
                                         f32 %301 = OpConstant 3.674022E-40 
                                       f32_4 %302 = OpConstantComposite %301 %301 %301 %301 
                                             %328 = OpTypeVector %6 2 
                                             %329 = OpTypePointer Private %328 
                              Private f32_2* %330 = OpVariable Private 
                                             %352 = OpTypePointer Input %328 
                                Input f32_2* %353 = OpVariable Input 
                                             %363 = OpTypeBool 
                                             %364 = OpTypePointer Private %363 
                               Private bool* %365 = OpVariable Private 
                                         f32 %368 = OpConstant 3.674022E-40 
                                             %371 = OpTypePointer Function %328 
                                             %382 = OpTypePointer Output %328 
                       Output f32_2* vs_TEXCOORD1 = OpVariable Output 
                                Private f32* %394 = OpVariable Private 
                         Output f32* vs_TEXCOORD0 = OpVariable Output 
                                         f32 %428 = OpConstant 3.674022E-40 
                                       f32_3 %429 = OpConstantComposite %428 %428 %428 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_2* %372 = OpVariable Function 
                                        f32_4 %13 = OpLoad %11 
                                        f32_3 %14 = OpVectorShuffle %13 %13 0 1 2 
                                        f32_4 %15 = OpLoad %9 
                                        f32_4 %16 = OpVectorShuffle %15 %14 4 5 6 3 
                                                      OpStore %9 %16 
                                 Private f32* %21 = OpAccessChain %9 %19 
                                                      OpStore %21 %17 
                                          i32 %27 = OpLoad %26 
                                 Uniform i32* %33 = OpAccessChain %30 %31 
                                          i32 %34 = OpLoad %33 
                                          i32 %35 = OpIAdd %27 %34 
                                                      OpStore %24 %35 
                                          i32 %44 = OpLoad %24 
                                 Uniform u32* %47 = OpAccessChain %43 %31 %44 %31 %45 
                                          u32 %48 = OpLoad %47 
                                          f32 %49 = OpBitcast %48 
                                          i32 %50 = OpLoad %24 
                                 Uniform u32* %51 = OpAccessChain %43 %31 %50 %31 %31 
                                          u32 %52 = OpLoad %51 
                                          f32 %53 = OpBitcast %52 
                                          i32 %54 = OpLoad %24 
                                 Uniform u32* %56 = OpAccessChain %43 %31 %54 %31 %55 
                                          u32 %57 = OpLoad %56 
                                          f32 %58 = OpBitcast %57 
                                        f32_3 %59 = OpCompositeConstruct %49 %53 %58 
                                        f32_4 %60 = OpLoad %36 
                                        f32_4 %61 = OpVectorShuffle %60 %59 4 5 6 3 
                                                      OpStore %36 %61 
                                 Private f32* %64 = OpAccessChain %36 %63 
                                          f32 %65 = OpLoad %64 
                                 Private f32* %67 = OpAccessChain %62 %66 
                                                      OpStore %67 %65 
                                          i32 %69 = OpLoad %24 
                                 Uniform u32* %71 = OpAccessChain %43 %31 %69 %31 %70 
                                          u32 %72 = OpLoad %71 
                                          f32 %73 = OpBitcast %72 
                                          i32 %74 = OpLoad %24 
                                 Uniform u32* %76 = OpAccessChain %43 %31 %74 %31 %75 
                                          u32 %77 = OpLoad %76 
                                          f32 %78 = OpBitcast %77 
                                          i32 %79 = OpLoad %24 
                                 Uniform u32* %81 = OpAccessChain %43 %31 %79 %31 %80 
                                          u32 %82 = OpLoad %81 
                                          f32 %83 = OpBitcast %82 
                                        f32_3 %84 = OpCompositeConstruct %73 %78 %83 
                                        f32_4 %85 = OpLoad %68 
                                        f32_4 %86 = OpVectorShuffle %85 %84 4 5 6 3 
                                                      OpStore %68 %86 
                                 Private f32* %87 = OpAccessChain %68 %66 
                                          f32 %88 = OpLoad %87 
                                 Private f32* %90 = OpAccessChain %62 %89 
                                                      OpStore %90 %88 
                                          i32 %93 = OpLoad %24 
                                 Uniform u32* %95 = OpAccessChain %43 %31 %93 %31 %94 
                                          u32 %96 = OpLoad %95 
                                          f32 %97 = OpBitcast %96 
                                          i32 %98 = OpLoad %24 
                                Uniform u32* %100 = OpAccessChain %43 %31 %98 %31 %99 
                                         u32 %101 = OpLoad %100 
                                         f32 %102 = OpBitcast %101 
                                         i32 %103 = OpLoad %24 
                                Uniform u32* %105 = OpAccessChain %43 %31 %103 %31 %104 
                                         u32 %106 = OpLoad %105 
                                         f32 %107 = OpBitcast %106 
                                       f32_3 %108 = OpCompositeConstruct %97 %102 %107 
                                                      OpStore %92 %108 
                                Private f32* %109 = OpAccessChain %92 %89 
                                         f32 %110 = OpLoad %109 
                                Private f32* %111 = OpAccessChain %62 %63 
                                                      OpStore %111 %110 
                                         i32 %113 = OpLoad %24 
                                Uniform u32* %115 = OpAccessChain %43 %31 %113 %31 %114 
                                         u32 %116 = OpLoad %115 
                                         f32 %117 = OpBitcast %116 
                                         i32 %118 = OpLoad %24 
                                Uniform u32* %120 = OpAccessChain %43 %31 %118 %31 %119 
                                         u32 %121 = OpLoad %120 
                                         f32 %122 = OpBitcast %121 
                                         i32 %123 = OpLoad %24 
                                Uniform u32* %125 = OpAccessChain %43 %31 %123 %31 %124 
                                         u32 %126 = OpLoad %125 
                                         f32 %127 = OpBitcast %126 
                                         i32 %128 = OpLoad %24 
                                Uniform u32* %130 = OpAccessChain %43 %31 %128 %31 %129 
                                         u32 %131 = OpLoad %130 
                                         f32 %132 = OpBitcast %131 
                                       f32_4 %133 = OpCompositeConstruct %117 %122 %127 %132 
                                                      OpStore %112 %133 
                                         i32 %135 = OpLoad %24 
                                Uniform u32* %137 = OpAccessChain %43 %31 %135 %31 %136 
                                         u32 %138 = OpLoad %137 
                                         f32 %139 = OpBitcast %138 
                                Private f32* %140 = OpAccessChain %134 %66 
                                                      OpStore %140 %139 
                                Private f32* %141 = OpAccessChain %134 %66 
                                         f32 %142 = OpLoad %141 
                                         f32 %143 = OpExtInst %1 8 %142 
                                Private f32* %144 = OpAccessChain %134 %66 
                                                      OpStore %144 %143 
                                Private f32* %145 = OpAccessChain %112 %89 
                                         f32 %146 = OpLoad %145 
                                Private f32* %147 = OpAccessChain %62 %19 
                                                      OpStore %147 %146 
                                       f32_4 %149 = OpLoad %62 
                                       f32_4 %150 = OpLoad %9 
                                         f32 %151 = OpDot %149 %150 
                                                      OpStore %148 %151 
                                         f32 %152 = OpLoad %148 
                                       f32_4 %153 = OpCompositeConstruct %152 %152 %152 %152 
                              Uniform f32_4* %161 = OpAccessChain %159 %45 %55 
                                       f32_4 %162 = OpLoad %161 
                                       f32_4 %163 = OpFMul %153 %162 
                                                      OpStore %62 %163 
                                         f32 %164 = OpLoad %148 
                                Uniform f32* %166 = OpAccessChain %159 %55 %55 %63 
                                         f32 %167 = OpLoad %166 
                                         f32 %168 = OpFMul %164 %167 
                                                      OpStore %148 %168 
                                Private f32* %169 = OpAccessChain %36 %89 
                                         f32 %170 = OpLoad %169 
                                Private f32* %171 = OpAccessChain %68 %66 
                                                      OpStore %171 %170 
                                Private f32* %172 = OpAccessChain %68 %63 
                                         f32 %173 = OpLoad %172 
                                Private f32* %174 = OpAccessChain %36 %89 
                                                      OpStore %174 %173 
                                Private f32* %175 = OpAccessChain %92 %66 
                                         f32 %176 = OpLoad %175 
                                Private f32* %177 = OpAccessChain %68 %63 
                                                      OpStore %177 %176 
                                Private f32* %178 = OpAccessChain %92 %63 
                                         f32 %179 = OpLoad %178 
                                Private f32* %180 = OpAccessChain %36 %63 
                                                      OpStore %180 %179 
                                Private f32* %181 = OpAccessChain %112 %66 
                                         f32 %182 = OpLoad %181 
                                Private f32* %183 = OpAccessChain %68 %19 
                                                      OpStore %183 %182 
                                       f32_4 %184 = OpLoad %68 
                                       f32_4 %185 = OpLoad %9 
                                         f32 %186 = OpDot %184 %185 
                                Private f32* %187 = OpAccessChain %92 %66 
                                                      OpStore %187 %186 
                              Uniform f32_4* %188 = OpAccessChain %159 %45 %31 
                                       f32_4 %189 = OpLoad %188 
                                       f32_3 %190 = OpLoad %92 
                                       f32_4 %191 = OpVectorShuffle %190 %190 0 0 0 0 
                                       f32_4 %192 = OpFMul %189 %191 
                                       f32_4 %193 = OpLoad %62 
                                       f32_4 %194 = OpFAdd %192 %193 
                                                      OpStore %62 %194 
                                Uniform f32* %195 = OpAccessChain %159 %55 %31 %63 
                                         f32 %196 = OpLoad %195 
                                Private f32* %197 = OpAccessChain %92 %66 
                                         f32 %198 = OpLoad %197 
                                         f32 %199 = OpFMul %196 %198 
                                         f32 %200 = OpLoad %148 
                                         f32 %201 = OpFAdd %199 %200 
                                Private f32* %202 = OpAccessChain %92 %66 
                                                      OpStore %202 %201 
                                Private f32* %203 = OpAccessChain %112 %63 
                                         f32 %204 = OpLoad %203 
                                Private f32* %205 = OpAccessChain %36 %19 
                                                      OpStore %205 %204 
                                       f32_4 %206 = OpLoad %36 
                                       f32_4 %207 = OpLoad %9 
                                         f32 %208 = OpDot %206 %207 
                                Private f32* %209 = OpAccessChain %9 %66 
                                                      OpStore %209 %208 
                              Uniform f32_4* %210 = OpAccessChain %159 %45 %45 
                                       f32_4 %211 = OpLoad %210 
                                       f32_4 %212 = OpLoad %9 
                                       f32_4 %213 = OpVectorShuffle %212 %212 0 0 0 0 
                                       f32_4 %214 = OpFMul %211 %213 
                                       f32_4 %215 = OpLoad %62 
                                       f32_4 %216 = OpFAdd %214 %215 
                                                      OpStore %36 %216 
                                Uniform f32* %217 = OpAccessChain %159 %55 %45 %63 
                                         f32 %218 = OpLoad %217 
                                Private f32* %219 = OpAccessChain %9 %66 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpFMul %218 %220 
                                Private f32* %222 = OpAccessChain %92 %66 
                                         f32 %223 = OpLoad %222 
                                         f32 %224 = OpFAdd %221 %223 
                                Private f32* %225 = OpAccessChain %9 %66 
                                                      OpStore %225 %224 
                                Private f32* %226 = OpAccessChain %9 %66 
                                         f32 %227 = OpLoad %226 
                                Uniform f32* %228 = OpAccessChain %159 %55 %75 %63 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpFAdd %227 %229 
                                Private f32* %231 = OpAccessChain %9 %66 
                                                      OpStore %231 %230 
                                Private f32* %234 = OpAccessChain %9 %66 
                                         f32 %235 = OpLoad %234 
                                         f32 %236 = OpFNegate %235 
                                 Output f32* %238 = OpAccessChain vs_TEXCOORD3 %63 
                                                      OpStore %238 %236 
                                       f32_4 %239 = OpLoad %36 
                              Uniform f32_4* %240 = OpAccessChain %159 %45 %75 
                                       f32_4 %241 = OpLoad %240 
                                       f32_4 %242 = OpFAdd %239 %241 
                                                      OpStore %9 %242 
                                       f32_4 %247 = OpLoad %9 
                               Output f32_4* %248 = OpAccessChain %246 %31 
                                                      OpStore %248 %247 
                                       f32_4 %250 = OpLoad %249 
                                       f32_4 %253 = OpFAdd %250 %252 
                                                      OpStore %36 %253 
                                Uniform f32* %254 = OpAccessChain %159 %80 
                                         f32 %255 = OpLoad %254 
                                       f32_4 %256 = OpCompositeConstruct %255 %255 %255 %255 
                                       f32_4 %257 = OpLoad %36 
                                       f32_4 %258 = OpFMul %256 %257 
                                       f32_4 %260 = OpFAdd %258 %259 
                                                      OpStore %36 %260 
                                Private f32* %264 = OpAccessChain %112 %19 
                                         f32 %265 = OpLoad %264 
                                         u32 %266 = OpBitcast %265 
                                         u32 %268 = OpBitwiseAnd %266 %267 
                                Private u32* %270 = OpAccessChain %263 %66 
                                                      OpStore %270 %268 
                                Private u32* %271 = OpAccessChain %263 %66 
                                         u32 %272 = OpLoad %271 
                                         f32 %273 = OpConvertUToF %272 
                                Private f32* %274 = OpAccessChain %62 %66 
                                                      OpStore %274 %273 
                                Private f32* %275 = OpAccessChain %112 %19 
                                         f32 %276 = OpLoad %275 
                                         u32 %277 = OpBitcast %276 
                                         u32 %278 = OpBitFieldUExtract %277 %104 %104 
                                Private u32* %279 = OpAccessChain %263 %66 
                                                      OpStore %279 %278 
                                Private f32* %280 = OpAccessChain %112 %19 
                                         f32 %281 = OpLoad %280 
                                         u32 %282 = OpBitcast %281 
                                         u32 %284 = OpBitFieldUExtract %282 %283 %104 
                                Private u32* %285 = OpAccessChain %263 %89 
                                                      OpStore %285 %284 
                                Private f32* %286 = OpAccessChain %112 %19 
                                         f32 %287 = OpLoad %286 
                                         u32 %288 = OpBitcast %287 
                                         u32 %290 = OpShiftRightLogical %288 %289 
                                Private u32* %291 = OpAccessChain %263 %63 
                                                      OpStore %291 %290 
                                       u32_3 %292 = OpLoad %263 
                                       f32_3 %293 = OpConvertUToF %292 
                                       f32_4 %294 = OpLoad %62 
                                       f32_4 %295 = OpVectorShuffle %294 %293 0 4 5 6 
                                                      OpStore %62 %295 
                                       f32_4 %296 = OpLoad %36 
                                       f32_4 %297 = OpLoad %62 
                                       f32_4 %298 = OpFMul %296 %297 
                                                      OpStore %36 %298 
                                       f32_4 %300 = OpLoad %36 
                                       f32_4 %303 = OpFMul %300 %302 
                                                      OpStore %299 %303 
                                Private f32* %304 = OpAccessChain %134 %66 
                                         f32 %305 = OpLoad %304 
                                Uniform f32* %306 = OpAccessChain %159 %70 %89 
                                         f32 %307 = OpLoad %306 
                                         f32 %308 = OpFDiv %305 %307 
                                Private f32* %309 = OpAccessChain %92 %66 
                                                      OpStore %309 %308 
                                Private f32* %310 = OpAccessChain %92 %66 
                                         f32 %311 = OpLoad %310 
                                         f32 %312 = OpExtInst %1 8 %311 
                                Private f32* %313 = OpAccessChain %92 %66 
                                                      OpStore %313 %312 
                                Private f32* %314 = OpAccessChain %92 %66 
                                         f32 %315 = OpLoad %314 
                                         f32 %316 = OpFNegate %315 
                                Uniform f32* %317 = OpAccessChain %159 %70 %89 
                                         f32 %318 = OpLoad %317 
                                         f32 %319 = OpFMul %316 %318 
                                Private f32* %320 = OpAccessChain %134 %66 
                                         f32 %321 = OpLoad %320 
                                         f32 %322 = OpFAdd %319 %321 
                                Private f32* %323 = OpAccessChain %134 %66 
                                                      OpStore %323 %322 
                                Private f32* %324 = OpAccessChain %134 %66 
                                         f32 %325 = OpLoad %324 
                                         f32 %326 = OpExtInst %1 8 %325 
                                Private f32* %327 = OpAccessChain %134 %66 
                                                      OpStore %327 %326 
                                Private f32* %331 = OpAccessChain %134 %66 
                                         f32 %332 = OpLoad %331 
                                Uniform f32* %333 = OpAccessChain %159 %70 %63 
                                         f32 %334 = OpLoad %333 
                                         f32 %335 = OpFMul %332 %334 
                                Private f32* %336 = OpAccessChain %330 %66 
                                                      OpStore %336 %335 
                                Uniform f32* %337 = OpAccessChain %159 %70 %19 
                                         f32 %338 = OpLoad %337 
                                         f32 %339 = OpFNegate %338 
                                         f32 %340 = OpFAdd %339 %17 
                                Private f32* %341 = OpAccessChain %134 %66 
                                                      OpStore %341 %340 
                                Private f32* %342 = OpAccessChain %92 %66 
                                         f32 %343 = OpLoad %342 
                                         f32 %344 = OpFNegate %343 
                                Uniform f32* %345 = OpAccessChain %159 %70 %19 
                                         f32 %346 = OpLoad %345 
                                         f32 %347 = OpFMul %344 %346 
                                Private f32* %348 = OpAccessChain %134 %66 
                                         f32 %349 = OpLoad %348 
                                         f32 %350 = OpFAdd %347 %349 
                                Private f32* %351 = OpAccessChain %330 %89 
                                                      OpStore %351 %350 
                                       f32_2 %354 = OpLoad %353 
                              Uniform f32_4* %355 = OpAccessChain %159 %70 
                                       f32_4 %356 = OpLoad %355 
                                       f32_2 %357 = OpVectorShuffle %356 %356 2 3 
                                       f32_2 %358 = OpFMul %354 %357 
                                       f32_2 %359 = OpLoad %330 
                                       f32_2 %360 = OpFAdd %358 %359 
                                       f32_4 %361 = OpLoad %134 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 2 3 
                                                      OpStore %134 %362 
                                Uniform f32* %366 = OpAccessChain %159 %70 %66 
                                         f32 %367 = OpLoad %366 
                                        bool %369 = OpFOrdNotEqual %367 %368 
                                                      OpStore %365 %369 
                                        bool %370 = OpLoad %365 
                                                      OpSelectionMerge %374 None 
                                                      OpBranchConditional %370 %373 %377 
                                             %373 = OpLabel 
                                       f32_4 %375 = OpLoad %134 
                                       f32_2 %376 = OpVectorShuffle %375 %375 0 1 
                                                      OpStore %372 %376 
                                                      OpBranch %374 
                                             %377 = OpLabel 
                                       f32_2 %378 = OpLoad %353 
                                                      OpStore %372 %378 
                                                      OpBranch %374 
                                             %374 = OpLabel 
                                       f32_2 %379 = OpLoad %372 
                                       f32_4 %380 = OpLoad %134 
                                       f32_4 %381 = OpVectorShuffle %380 %379 4 5 2 3 
                                                      OpStore %134 %381 
                                       f32_4 %384 = OpLoad %134 
                                       f32_2 %385 = OpVectorShuffle %384 %384 0 1 
                              Uniform f32_4* %386 = OpAccessChain %159 %94 
                                       f32_4 %387 = OpLoad %386 
                                       f32_2 %388 = OpVectorShuffle %387 %387 0 1 
                                       f32_2 %389 = OpFMul %385 %388 
                              Uniform f32_4* %390 = OpAccessChain %159 %94 
                                       f32_4 %391 = OpLoad %390 
                                       f32_2 %392 = OpVectorShuffle %391 %391 2 3 
                                       f32_2 %393 = OpFAdd %389 %392 
                                                      OpStore vs_TEXCOORD1 %393 
                                Private f32* %395 = OpAccessChain %9 %63 
                                         f32 %396 = OpLoad %395 
                                Uniform f32* %397 = OpAccessChain %159 %31 %89 
                                         f32 %398 = OpLoad %397 
                                         f32 %399 = OpFDiv %396 %398 
                                                      OpStore %394 %399 
                                         f32 %400 = OpLoad %394 
                                         f32 %401 = OpFNegate %400 
                                         f32 %402 = OpFAdd %401 %17 
                                Private f32* %403 = OpAccessChain %9 %63 
                                                      OpStore %403 %402 
                                       f32_4 %404 = OpLoad %9 
                                       f32_2 %405 = OpVectorShuffle %404 %404 1 2 
                              Uniform f32_4* %406 = OpAccessChain %159 %31 
                                       f32_4 %407 = OpLoad %406 
                                       f32_2 %408 = OpVectorShuffle %407 %407 0 2 
                                       f32_2 %409 = OpFMul %405 %408 
                                       f32_4 %410 = OpLoad %9 
                                       f32_4 %411 = OpVectorShuffle %410 %409 0 4 5 3 
                                                      OpStore %9 %411 
                                Private f32* %412 = OpAccessChain %9 %63 
                                         f32 %413 = OpLoad %412 
                                         f32 %414 = OpExtInst %1 40 %413 %368 
                                                      OpStore %394 %414 
                                         f32 %415 = OpLoad %394 
                                Uniform f32* %416 = OpAccessChain %159 %75 %66 
                                         f32 %417 = OpLoad %416 
                                         f32 %418 = OpFMul %415 %417 
                                                      OpStore %394 %418 
                                         f32 %419 = OpLoad %394 
                                         f32 %420 = OpLoad %394 
                                         f32 %421 = OpFNegate %420 
                                         f32 %422 = OpFMul %419 %421 
                                                      OpStore %394 %422 
                                         f32 %424 = OpLoad %394 
                                         f32 %425 = OpExtInst %1 29 %424 
                                                      OpStore vs_TEXCOORD0 %425 
                                       f32_4 %426 = OpLoad %9 
                                       f32_3 %427 = OpVectorShuffle %426 %426 0 3 1 
                                       f32_3 %430 = OpFMul %427 %429 
                                       f32_4 %431 = OpLoad %134 
                                       f32_4 %432 = OpVectorShuffle %431 %430 4 1 5 6 
                                                      OpStore %134 %432 
                                Private f32* %433 = OpAccessChain %9 %19 
                                         f32 %434 = OpLoad %433 
                                 Output f32* %435 = OpAccessChain vs_TEXCOORD3 %19 
                                                      OpStore %435 %434 
                                       f32_4 %436 = OpLoad %134 
                                       f32_2 %437 = OpVectorShuffle %436 %436 2 2 
                                       f32_4 %438 = OpLoad %134 
                                       f32_2 %439 = OpVectorShuffle %438 %438 0 3 
                                       f32_2 %440 = OpFAdd %437 %439 
                                       f32_4 %441 = OpLoad vs_TEXCOORD3 
                                       f32_4 %442 = OpVectorShuffle %441 %440 4 5 2 3 
                                                      OpStore vs_TEXCOORD3 %442 
                                 Output f32* %443 = OpAccessChain %246 %31 %89 
                                         f32 %444 = OpLoad %443 
                                         f32 %445 = OpFNegate %444 
                                 Output f32* %446 = OpAccessChain %246 %31 %89 
                                                      OpStore %446 %445 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 110
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %35 %50 %66 %92 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpMemberDecorate %12 0 RelaxedPrecision 
                                             OpMemberDecorate %12 0 Offset 12 
                                             OpMemberDecorate %12 1 RelaxedPrecision 
                                             OpMemberDecorate %12 1 Offset 12 
                                             OpMemberDecorate %12 2 Offset 12 
                                             OpDecorate %12 Block 
                                             OpDecorate %14 DescriptorSet 14 
                                             OpDecorate %14 Binding 14 
                                             OpDecorate %22 RelaxedPrecision 
                                             OpDecorate %25 RelaxedPrecision 
                                             OpDecorate %25 DescriptorSet 25 
                                             OpDecorate %25 Binding 25 
                                             OpDecorate %26 RelaxedPrecision 
                                             OpDecorate %29 RelaxedPrecision 
                                             OpDecorate %29 DescriptorSet 29 
                                             OpDecorate %29 Binding 29 
                                             OpDecorate %30 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 35 
                                             OpDecorate %38 RelaxedPrecision 
                                             OpDecorate %39 RelaxedPrecision 
                                             OpDecorate %42 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %47 RelaxedPrecision 
                                             OpDecorate %48 RelaxedPrecision 
                                             OpDecorate %50 Location 50 
                                             OpDecorate %56 RelaxedPrecision 
                                             OpDecorate %57 RelaxedPrecision 
                                             OpDecorate %58 RelaxedPrecision 
                                             OpDecorate %61 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 66 
                                             OpDecorate %83 RelaxedPrecision 
                                             OpDecorate %84 RelaxedPrecision 
                                             OpDecorate %92 RelaxedPrecision 
                                             OpDecorate %92 Location 92 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeBool 
                                      %7 = OpTypePointer Private %6 
                        Private bool* %8 = OpVariable Private 
                                      %9 = OpTypeFloat 32 
                                     %10 = OpTypeVector %9 4 
                                     %11 = OpTypeInt 32 1 
                                     %12 = OpTypeStruct %10 %10 %11 
                                     %13 = OpTypePointer Uniform %12 
Uniform struct {f32_4; f32_4; i32;}* %14 = OpVariable Uniform 
                                 i32 %15 = OpConstant 2 
                                     %16 = OpTypePointer Uniform %11 
                                 i32 %19 = OpConstant 1 
                                     %21 = OpTypePointer Private %10 
                      Private f32_4* %22 = OpVariable Private 
                                     %23 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
                                     %24 = OpTypePointer UniformConstant %23 
UniformConstant read_only Texture2D* %25 = OpVariable UniformConstant 
                                     %27 = OpTypeSampler 
                                     %28 = OpTypePointer UniformConstant %27 
            UniformConstant sampler* %29 = OpVariable UniformConstant 
                                     %31 = OpTypeSampledImage %23 
                                     %33 = OpTypeVector %9 2 
                                     %34 = OpTypePointer Input %33 
               Input f32_2* vs_TEXCOORD1 = OpVariable Input 
                      Private f32_4* %38 = OpVariable Private 
                                     %40 = OpTypePointer Uniform %10 
                                     %44 = OpTypeVector %9 3 
                                     %45 = OpTypePointer Private %44 
                      Private f32_3* %46 = OpVariable Private 
                                     %49 = OpTypePointer Input %10 
                        Input f32_4* %50 = OpVariable Input 
                                 i32 %54 = OpConstant 0 
                      Private f32_4* %60 = OpVariable Private 
                      Private f32_3* %64 = OpVariable Private 
                                     %65 = OpTypePointer Input %9 
                 Input f32* vs_TEXCOORD0 = OpVariable Input 
                                     %68 = OpTypeInt 32 0 
                                 u32 %69 = OpConstant 0 
                                     %70 = OpTypePointer Private %9 
                                 f32 %74 = OpConstant 3.674022E-40 
                                 f32 %75 = OpConstant 3.674022E-40 
                                     %91 = OpTypePointer Output %10 
                       Output f32_4* %92 = OpVariable Output 
                                 u32 %93 = OpConstant 3 
                                     %96 = OpTypePointer Output %9 
                                     %99 = OpTypePointer Function %44 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                    Function f32_3* %100 = OpVariable Function 
                        Uniform i32* %17 = OpAccessChain %14 %15 
                                 i32 %18 = OpLoad %17 
                                bool %20 = OpIEqual %18 %19 
                                             OpStore %8 %20 
                 read_only Texture2D %26 = OpLoad %25 
                             sampler %30 = OpLoad %29 
          read_only Texture2DSampled %32 = OpSampledImage %26 %30 
                               f32_2 %36 = OpLoad vs_TEXCOORD1 
                               f32_4 %37 = OpImageSampleImplicitLod %32 %36 
                                             OpStore %22 %37 
                               f32_4 %39 = OpLoad %22 
                      Uniform f32_4* %41 = OpAccessChain %14 %19 
                               f32_4 %42 = OpLoad %41 
                               f32_4 %43 = OpFMul %39 %42 
                                             OpStore %38 %43 
                               f32_4 %47 = OpLoad %38 
                               f32_3 %48 = OpVectorShuffle %47 %47 0 1 2 
                               f32_4 %51 = OpLoad %50 
                               f32_3 %52 = OpVectorShuffle %51 %51 0 1 2 
                               f32_3 %53 = OpFMul %48 %52 
                      Uniform f32_4* %55 = OpAccessChain %14 %54 
                               f32_4 %56 = OpLoad %55 
                               f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                               f32_3 %58 = OpFNegate %57 
                               f32_3 %59 = OpFAdd %53 %58 
                                             OpStore %46 %59 
                               f32_4 %61 = OpLoad %38 
                               f32_4 %62 = OpLoad %50 
                               f32_4 %63 = OpFMul %61 %62 
                                             OpStore %60 %63 
                                 f32 %67 = OpLoad vs_TEXCOORD0 
                        Private f32* %71 = OpAccessChain %64 %69 
                                             OpStore %71 %67 
                        Private f32* %72 = OpAccessChain %64 %69 
                                 f32 %73 = OpLoad %72 
                                 f32 %76 = OpExtInst %1 43 %73 %74 %75 
                        Private f32* %77 = OpAccessChain %64 %69 
                                             OpStore %77 %76 
                               f32_3 %78 = OpLoad %64 
                               f32_3 %79 = OpVectorShuffle %78 %78 0 0 0 
                               f32_3 %80 = OpLoad %46 
                               f32_3 %81 = OpFMul %79 %80 
                      Uniform f32_4* %82 = OpAccessChain %14 %54 
                               f32_4 %83 = OpLoad %82 
                               f32_3 %84 = OpVectorShuffle %83 %83 0 1 2 
                               f32_3 %85 = OpFAdd %81 %84 
                                             OpStore %46 %85 
                               f32_4 %86 = OpLoad %60 
                               f32_3 %87 = OpVectorShuffle %86 %86 0 1 2 
                               f32_3 %88 = OpLoad %64 
                               f32_3 %89 = OpVectorShuffle %88 %88 0 0 0 
                               f32_3 %90 = OpFMul %87 %89 
                                             OpStore %64 %90 
                        Private f32* %94 = OpAccessChain %60 %93 
                                 f32 %95 = OpLoad %94 
                         Output f32* %97 = OpAccessChain %92 %93 
                                             OpStore %97 %95 
                                bool %98 = OpLoad %8 
                                             OpSelectionMerge %102 None 
                                             OpBranchConditional %98 %101 %104 
                                    %101 = OpLabel 
                              f32_3 %103 = OpLoad %64 
                                             OpStore %100 %103 
                                             OpBranch %102 
                                    %104 = OpLabel 
                              f32_3 %105 = OpLoad %46 
                                             OpStore %100 %105 
                                             OpBranch %102 
                                    %102 = OpLabel 
                              f32_3 %106 = OpLoad %100 
                              f32_4 %107 = OpLoad %92 
                              f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
                                             OpStore %92 %108 
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
SubProgram "gles3 " {
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "vulkan " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_EXP2" "PROCEDURAL_INSTANCING_ON" "SOFTPARTICLES_ON" }
Local Keywords { "_ALPHABLEND_ON" }
""
}
}
}
}
Fallback "VertexLit"
CustomEditor "StandardParticlesShaderGUI"
}