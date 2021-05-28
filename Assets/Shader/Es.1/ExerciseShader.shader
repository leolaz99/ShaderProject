Shader "Custom/ExerciseShader"
{
	Properties
	{
		[NoScaleOffset] _MainTex ("Splat Map", 2D) = "white" {}
		_Texture1 ("Texture 1", 2D) = "white" {}
		_Texture2 ("Texture 2", 2D) = "white" {}
		_Texture3 ("Texture 3", 2D) = "white" {}
		_Texture4 ("Texture 4", 2D) = "white" {}
		_Texture5 ("Texture 5", 2D) = "white" {}
		_Texture6 ("Texture 6", 2D) = "white" {}
		_Texture7 ("Texture 7", 2D) = "white" {}
		_Texture8 ("Texture 8", 2D) = "white" {}
		_Offset ("Offset", Vector) = (10,0,0,0)
		_Degrees ("Degrees", Float) = 25
		[Toggle(duplication)] _ToggleDuplication ("Toggle Duplication", Float) = 1

		_DetailTex1 ("Detail Texture 1", 2D) = "gray" {}
		_DetailTex2 ("Detail Texture 2", 2D) = "gray" {} 
		_DetailTex3 ("Detail Texture 3", 2D) = "gray" {} 
		_DetailTex4 ("Detail Texture 4", 2D) = "gray" {}
		_DetailTex5 ("Detail Texture 5", 2D) = "gray" {}
		_DetailTex6 ("Detail Texture 6", 2D) = "gray" {} 
		_DetailTex7 ("Detail Texture 7", 2D) = "gray" {} 
		_DetailTex8 ("Detail Texture 8", 2D) = "gray" {} 

		_Smoothness("Smoothness", Range(0, 1)) = 0.5
        [Gamma] _Metallic("Metallic", Range(0, 1)) = 0

		_NormalMap1("Normal 1", 2D) = "bump" {}
		_BumpScale1("Bump Scale 1", Float) = 1
		_DetailNormalMap1("Detail Normal 1", 2D) = "bump" {}
		_DetailBumpScale1("Detail Bump Scale 1", Float) = 1

		_NormalMap2("Normal 2", 2D) = "bump" {}
		_BumpScale2("Bump Scale 2", Float) = 1
		_DetailNormalMap2("Detail Normal 2", 2D) = "bump" {}
		_DetailBumpScale2("Detail Bump Scale 2", Float) = 1

		_NormalMap3("Normal 3", 2D) = "bump" {}
		_BumpScale3("Bump Scale 3", Float) = 1
		_DetailNormalMap3("Detail Normal 3", 2D) = "bump" {}
		_DetailBumpScale3("Detail Bump Scale 3", Float) = 1

		_NormalMap4("Normals 4", 2D) = "bump" {}
		_BumpScale4("Bump Scale 4", Float) = 1
		_DetailNormalMap4("Detail Normal 4", 2D) = "bump" {}
		_DetailBumpScale4("Detail Bump Scale 4", Float) = 1

		_NormalMap15("Normals 5", 2D) = "bump" {}
		_BumpScale5("Bump Scale 5", Float) = 1
		_DetailNormalMap5("Detail Normals 5", 2D) = "bump" {}
		_DetailBumpScale5("Detail Bump Scale 5", Float) = 1

		_NormalMap6("Normals 6", 2D) = "bump" {}
		_BumpScale6("Bump Scale 6", Float) = 1
		_DetailNormalMap6("Detail Normals 6", 2D) = "bump" {}
		_DetailBumpScale6("Detail Bump Scale 6", Float) = 1

		_NormalMap7("Normals 7", 2D) = "bump" {}
		_BumpScale7("Bump Scale 7", Float) = 1
		_DetailNormalMap7("Detail Normals 7", 2D) = "bump" {}
		_DetailBumpScale7("Detail Bump Scale 7", Float) = 1

		_NormalMap8("Normals 8", 2D) = "bump" {}
		_BumpScale8("Bump Scale 8", Float) = 1
		_DetailNormalMap8("Detail Normals 8", 2D) = "bump" {}
		_DetailBumpScale8("Detail Bump Scale 8", Float) = 1
	}

	SubShader 
	{
		Pass 
		{		
			Tags 
			{
				"LightMode" = "ForwardBase"
			}

			CGPROGRAM

			#pragma require geometry
			#pragma target 3.0

			#pragma multi_compile _ VERTEXLIGHT_ON

			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#pragma shader_feature duplication

			#define FORWARD_BASE_PASS
			
			#include "UnityCG.cginc"
			#include "Light.cginc"
			
			ENDCG
		}


		Pass 
		{
			Tags 
			{
				"LightMode" = "ForwardAdd"
			}

			Blend One One
			ZWrite Off

			CGPROGRAM

			#pragma require geometry
			#pragma target 3.0

			#pragma multi_compile_fwdadd

			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#pragma shader_feature duplication

			#include "UnityCG.cginc"
			#include "Light.cginc"
			

			ENDCG
		}
	}
}
