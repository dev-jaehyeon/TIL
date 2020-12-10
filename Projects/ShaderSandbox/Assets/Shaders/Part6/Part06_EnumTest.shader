Shader "Custom/Part06_EnumTest"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo()", 2D) = "white"{}
        [Enum(RGBA)] _RGBA("RGBA", float) = 0
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

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        UNITY_INSTANCING_BUFFER_START(Props)

        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 rgbed = tex2D(_MainTex2, IN.uv_MainTex2);
            fixed4 output = tex2D(_MainTex, IN.uv_MainTex);
            if (_RGBA == 0)
            {
                output = output * rgbed.r;
            }
            else if (_RGBA == 1)
            {
                output = output * rgbed.g;
            }
            else if (_RGBA == 2)
            {
                output = output * rgbed.b;
            }
            else
            {
                output = output * rgbed.a;
            }
            o.Albedo = output.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
