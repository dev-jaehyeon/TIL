Shader "Custom/Part11_Fianl"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf halfLambert noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);

            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(nor);
            o.Alpha = c.a;
        }

        float4 LightinghalfLambert(SurfaceOutput s, float3 lightDir, float atten)
        {
            float dotted = dot(lightDir, s.Normal);
            float satured = saturate(dotted);
            //여기가 빛의 감쇠, 텍스쳐, 빛의 색상, 내적된 값을 곱해서 만든 최종 float4
            float4 final;
            final.rgb = dotted * s.Albedo * _LightColor0.rgb * atten;
            final.a = s.Alpha;
            return final;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
