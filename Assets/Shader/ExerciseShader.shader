Shader "Custom/ExerciseShader"
{
	Properties
	{
		[NoScaleOffset] _MainTex ("Splat Map", 2D) = "white" {}
		_Texture1 ("Texture 1 Red 1", 2D) = "white" {}
		_Texture2 ("Texture 2 Green 1", 2D) = "white" {}
		_Texture3 ("Texture 3 Blue 1", 2D) = "white" {}
		_Texture4 ("Texture 4 Black 1", 2D) = "white" {}
		_Texture5 ("Texture 5 Red 2", 2D) = "white" {}
		_Texture6 ("Texture 6 Green 2", 2D) = "white" {}
		_Texture7 ("Texture 7 Blue 2", 2D) = "white" {}
		_Texture8 ("Texture 8 Black 2", 2D) = "white" {}
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
	}

	SubShader 
	{
		Pass 
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#pragma shader_feature duplication

			#include "UnityCG.cginc"

			sampler2D _MainTex;

			Texture2D    _DetailTex1, _DetailTex2,_DetailTex3, _DetailTex4, _DetailTex5,_DetailTex6, _DetailTex7, _DetailTex8;
			float4       _DetailTex1_ST, _DetailTex2_ST,_DetailTex3_ST, _DetailTex4_ST,_DetailTex5_ST, _DetailTex6_ST, _DetailTex7_ST, _DetailTex8_ST;
			SamplerState sampler_DetailTex1;

			float4 _MainTex_ST;
			float4 _Offset;
			float _Degrees;

			sampler2D _Texture1, _Texture2, _Texture3, _Texture4, _Texture5, _Texture6, _Texture7, _Texture8;

			struct appdata
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2g 
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvSplat : TEXCOORD1;	
				float2 uvDetail : TEXCOORD2;
			};

			struct g2f
            {
                float4 worldPos : SV_POSITION;
                float2 uv : TEXCOORD0;
				float2 uvSplat : TEXCOORD1;
				float2 uvDetail : TEXCOORD2;
            };

			v2g vert (appdata v) 
			{
				v2g i;				
				i.position = UnityObjectToClipPos(v.position);
				i.position = v.position;
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);	
				
				i.uvDetail = TRANSFORM_TEX(v.uv, _DetailTex1);

				i.uvSplat = v.uv;
				return i;
			}

			float4 frag (v2g i) : SV_TARGET 
			{
				float4 splat = tex2D(_MainTex, i.uvSplat);
			
				return	
						tex2D(_Texture1, i.uv) * splat.r * _DetailTex1.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture2, i.uv) * splat.g * _DetailTex2.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture3, i.uv) * splat.b * _DetailTex3.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture4, i.uv) * (1 - splat.r - splat.g - splat.b) * _DetailTex4.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture5, i.uv) * splat.r * _DetailTex5.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture6, i.uv) * splat.g * _DetailTex6.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture7, i.uv) * splat.b * _DetailTex7.Sample(sampler_DetailTex1, i.uv) +
						tex2D(_Texture8, i.uv) * (1 - splat.r - splat.g - splat.b) * _DetailTex8.Sample(sampler_DetailTex1, i.uv);
			}
			
			
			float4 RotateAroundYInDegrees (float4 vertex, float degrees)
			{
				float alpha = degrees * UNITY_PI / 180.0;
				float sina, cosa;
				sincos(alpha, sina, cosa);
				float2x2 m = float2x2(cosa, -sina, sina, cosa);
				return float4(mul(m, vertex.xz), vertex.yw).xzyw;
			}
			
			[maxvertexcount(12)]
            void geom(triangle v2g input[3], inout TriangleStream<g2f> tristream) 
			{				
                g2f o;
			
				input[0].position = RotateAroundYInDegrees(input[0].position, _Degrees);
				o.worldPos = UnityObjectToClipPos (input[0].position);
                o.uv = input[0].uv;
				o.uvSplat = input[0].uvSplat;
				o.uvDetail = input[0].uvDetail;	
                tristream.Append(o);
			
				input[1].position = RotateAroundYInDegrees(input[1].position, _Degrees);
				o.worldPos = UnityObjectToClipPos (input[1].position);
                o.uv = input[1].uv;
				o.uvSplat = input[1].uvSplat;
				o.uvDetail = input[1].uvDetail;
                tristream.Append(o);
			
				input[2].position = RotateAroundYInDegrees(input[2].position, _Degrees);
				o.worldPos = UnityObjectToClipPos (input[2].position);
                o.uv = input[2].uv;
				o.uvSplat = input[2].uvSplat;
				o.uvDetail = input[2].uvDetail;
                tristream.Append(o);	

                tristream.RestartStrip();
				
				#ifdef duplication
				input[0].position = RotateAroundYInDegrees(input[0].position, _Degrees);
                o.worldPos = UnityObjectToClipPos(input[0].position + _Offset);
                o.uv = input[0].uv;
				o.uvSplat = input[0].uvSplat;
				o.uvDetail = input[0].uvDetail;
                tristream.Append(o);
			
				input[1].position = RotateAroundYInDegrees(input[1].position, _Degrees);
                o.worldPos = UnityObjectToClipPos(input[1].position + _Offset);
                o.uv = input[1].uv;
				o.uvSplat = input[1].uvSplat;
				o.uvDetail = input[1].uvDetail;
                tristream.Append(o);
			
				input[2].position = RotateAroundYInDegrees(input[2].position, _Degrees);
                o.worldPos = UnityObjectToClipPos(input[2].position + _Offset);
                o.uv = input[2].uv;
				o.uvSplat = input[2].uvSplat;
				o.uvDetail = input[2].uvDetail;
                tristream.Append(o);
			
                tristream.RestartStrip();
			
				input[0].position = RotateAroundYInDegrees(input[0].position, _Degrees);
                o.worldPos = UnityObjectToClipPos(input[0].position - _Offset);
                o.uv = input[0].uv;
				o.uvSplat = input[0].uvSplat;
				o.uvDetail = input[0].uvDetail;
                tristream.Append(o);
			
				input[1].position = RotateAroundYInDegrees(input[1].position, _Degrees);
                o.worldPos = UnityObjectToClipPos(input[1].position - _Offset);
                o.uv = input[1].uv;
				o.uvSplat = input[1].uvSplat;
				o.uvDetail = input[1].uvDetail;
                tristream.Append(o);
			
				input[2].position = RotateAroundYInDegrees(input[2].position, _Degrees);
                o.worldPos = UnityObjectToClipPos(input[2].position - _Offset);
                o.uv = input[2].uv;
				o.uvSplat = input[2].uvSplat;
				o.uvDetail = input[2].uvDetail;
                tristream.Append(o);
				#endif		
            }
			ENDCG
		}
	}
}
