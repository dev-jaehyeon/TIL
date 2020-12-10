Shader "Custom/Part06_UV"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _UVx("UV.x에 더해질 부동소수점", float) = 0
        _UVy("UV.y에 더해질 부동소수점", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        #pragma target 3.0

        sampler2D _MainTex;
        float _UVx;
        float _UVy;

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x + _UVx, IN.uv_MainTex.y + _UVy));
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
