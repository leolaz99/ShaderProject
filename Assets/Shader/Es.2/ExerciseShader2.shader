Shader "Custom/ExerciseShader2"
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

		_Smoothness("Smoothness", Range(0, 1)) = 0.5
        [Gamma] _Metallic("Metallic", Range(0, 1)) = 0

		_NormalMap("Normal", 2D) = "bump" {}
		_BumpScale("Bump Scale", Float) = 1
		_DetailNormalMap("Detail Normal", 2D) = "bump" {}
		_DetailBumpScale("Detail Bump Scale", Float) = 1	
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
			#include "Light2.cginc"
			
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
			#include "Light2.cginc"
			

			ENDCG
		}
	}
}
