Shader "Custom/Part12_Practice"
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
        #pragma surface surf custom noambient

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
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Normal = UnpackNormal(nor);
            o.Alpha = c.a;
        }

        float4 Lightingcustom(SurfaceOutput s, float3 lightDir, float atten)
        {
            fixed4 albedo;
            albedo.rgb = s.Albedo * atten * saturate(dot(lightDir, s.Normal));
            albedo.a = s.Alpha;

            float dotted = dot(s.Normal, lightDir);
            s.Emission = 1 - dotted;

            return albedo;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
