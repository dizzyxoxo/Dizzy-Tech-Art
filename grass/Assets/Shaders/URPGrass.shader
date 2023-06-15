Shader "Unlit/URPGrass"
{
    Properties
    {
        [MainTexture] _BaseMap("Grass Texture", 2D) = "white" {}
        _Height ("Height", float) = 1.0
        _Base ("Base", float) = 1.0
        _Tint ("Tint", Color) = (1, 0, 0, 1)
        _RootColor ("Root Color", Color) =  (1, 0, 0, 1)
        _LightPower ("Light Power", float) = 0.05  
        _TPower ("Translucency Power", float) = 0.02
        _AlphaCutoff("Alpha Cutoff", float) = 0.1
        _ShadowPower("Shadow Power", float) = 0.1

        _WindDistortionMap("Wind Distortion Map", 2D) = "white" {}
        _WindFrequency("Wind Frequency", Vector) = (0.05, 0.05, 0, 0)
        _WindStrength("Wind Strength", Float) = 1

        _MinHeight("Minimum Height", float) = 0
        _MaxHeight("Maximum Height", float) = 1
    } 
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }
        LOD 100


        Pass
        {
            Name "Geometry Pass"
            Tags {"LightMode"="DepthOnly"}
            
            ZWrite On
            ColorMask 0
            Cull Off

            HLSLPROGRAM

            #pragma prefer_hlslcc gles
            //#pragma exclude_renderers d3d11_9x
            #pragma target 2.0

            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH
            #pragma shader_feature _ALPHATEST_ON
            #pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma multi_compile_instancing
            
            #pragma require geometry

            #pragma geometry LitPassGeom
            #pragma vertex LitPassVertex
            #pragma fragment DepthPassFragment
            #pragma hull hull
            #pragma domain domain
            #define SHADOW

            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\ShaderLibrary\Core.hlsl"
            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\ShaderLibrary\Lighting.hlsl"
            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\ShaderLibrary\Shadows.hlsl"
            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\Shaders\LitInput.hlsl"
            #include "Grasspass.hlsl"

            half4 DepthPassFragment (Varyings input) : SV_TARGET{
            return 0;
            }
            ENDHLSL

        }
        Pass
        {
            Name "Geometry Pass"
            Tags {"LightMode"="UniversalForward"}

            ZWrite On
            Cull Off

            HLSLPROGRAM

            #pragma prefer_hlslcc gles
            //#pragma exclude_renderers d3d11_9x
            #pragma target 4.0

            #pragma shader_feature _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature _ALPHATEST_ON
            #pragma shader_feature _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _SPECULAR_SETUP
            #pragma shader_feature _RECIEVE_SHADOWS_ON

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile _ _MIXED_LIGHTNING_SUBTRACTIVE
            #pragma multi_compile _ _DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ _LIGHTMAP_ON

            #pragma multi_compile_fog
            #pragma require geometry

            #pragma geometry LitPassGeom
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment


            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\ShaderLibrary\Core.hlsl"
            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\ShaderLibrary\Lighting.hlsl"
            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\ShaderLibrary\Shadows.hlsl"
            #include "X:\unity projects\grass\Library\PackageCache\com.unity.render-pipelines.universal@12.1.8\Shaders\LitInput.hlsl"
            #include "Grasspass.hlsl"

            ENDHLSL
        
            
        }
    }
}
