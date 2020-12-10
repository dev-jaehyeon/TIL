Shader "Custom/Part06_UVControl"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("UVContol Texture", 2D) = "white"{}
        [Enum(RGBA)] _RGBA("RGBA", float) = 0
        _uvx("UV에서 x에 더해짐", float) = 0
        _uvy("UV에서 y에 더해짐", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        float _RGBA;

        float _uvx;
        float _uvy;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 uv = tex2D(_MainTex2, float2(IN.uv_MainTex.x + _Time.y, IN.uv_MainTex.y + _Time.y));
            float2 couv;
            if (_RGBA == 0)//red
            {
                couv = float2(IN.uv_MainTex.x + uv.r, IN.uv_MainTex.y);
            }
            else if (_RGBA == 1) //green
            {
                couv = float2(IN.uv_MainTex.x + uv.g, IN.uv_MainTex.y);
            }
            else if (_RGBA == 2) //green
            {
                couv = float2(IN.uv_MainTex.x + uv.b, IN.uv_MainTex.y);
            }
            else if (_RGBA == 3) //green
            {
                couv = float2(IN.uv_MainTex.x + uv.a, IN.uv_MainTex.y);
            }

            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, float2(couv.x + _uvx, couv.y+_uvy));
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
