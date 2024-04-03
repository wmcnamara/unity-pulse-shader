Shader "Custom/PulseShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
		_Waves("Waves", Float) = 1.0
        _Speed("Speed", Float) = 0.2
    }
   SubShader 
	{
		Tags { "RenderType" = "Transparent" }

		pass
		{
			// Vertex & Fragment shader
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			// access shader property in Cg
			fixed4 _Color;
		    uniform float pulseRadius;
			uniform float3 pulseStartingPosition;
			uniform float pulseSize;
			uniform fixed4 pulseColor;
			uniform int isPulsing;
			uniform int enableWaveEffect;
			float _Speed;
            float _Waves;

			// vertex input
			struct vertexIn
			{
				float4 vertex   : POSITION;
				float4 texcoord : TEXCOORD0;
			};
		
			// vertex output
			struct vertexOut 
			{
				float4 posClip : SV_POSITION;
				float4 posWorld : POSITIONT;
				float4 uv  : TEXCOORD0;
			};
			
			bool isInPulseRange(float3 worldPos)
			{
				if (isPulsing) 
				{
					float distToStartingPos = distance(worldPos, pulseStartingPosition);

					return distToStartingPos < pulseRadius && distToStartingPos > pulseRadius - pulseSize;
				}

				return false;
			}

			vertexOut vert (vertexIn v)
			{
				vertexOut o;

				o.uv  = float4(v.texcoord.xy, 0, 0);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
		
				if (isInPulseRange(o.posWorld) && enableWaveEffect) 
				{
					v.vertex.y += cos(o.uv.x * _Waves + _Time.y) * _Speed;
					v.vertex.y += sin(o.uv.y * _Waves / 2.0 + _Time.y) * _Speed;
				}

				o.posClip = UnityObjectToClipPos(v.vertex);

				return o; 
			}
		
			half4 frag (vertexOut i) : COLOR
			{
				// Shader Parameters
				half4 color = _Color;	

				if (isInPulseRange(i.posWorld)) 
				{
					color = color * pulseColor;
				}

				return color;
			}

			ENDCG
		}
	}
    FallBack "Diffuse"
}
