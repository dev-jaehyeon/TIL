Shader "Custom/Part14_2Pass"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        _VertexMultier("Vertex Multier", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        cull front

        CGPROGRAM
        #pragma surface surf NoLight vertex:vert noambient

        #pragma target 3.0

        fixed _VertexMultier;
        
        void vert(inout appdata_full v)
        {
            v.vertex.xyz = v.vertex.xyz + v.normal.xyz * _VertexMultier;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
        }

        float4 LightingNoLight(SurfaceOutput s, float3 viewDir, float atten)
        {
            return 0;
        }
        ENDCG

        cull back
        CGPROGRAM
        #pragma surface surf Lambert noambient

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Normal = UnpackNormal(nor);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
