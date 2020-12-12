﻿Shader "Custom/Part06_Fire"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        //투명하게 만드는 태그
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        LOD 200

        //alpha:fade가 추가 됨
        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y -_Time.y));
            d.rgb = d.rgb + 1;
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex + d.r);
            //uv에서 y축이 계속 움직임
            o.Emission = c.rgb * d.rgb;
            o.Alpha = c.a * d.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
