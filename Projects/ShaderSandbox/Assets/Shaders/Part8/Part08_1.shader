Shader "Custom/Part08_1"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _NormalBump("Normal", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalBump;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //노말맵을 sampler2D에서 fixed4로 바꾼다음
            fixed4 n = tex2D(_NormalBump, IN.uv_MainTex);
            //float3 UnpackNoraml(fixed4 normal) 로 넣어준다.
            //o.Normal = float3(n.x*2, n.y*2, n.z);로 강도 조절 가능 
            o.Normal = UnpackNormal(n);
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
