Shader "Custom/Part12_HoloFinal"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white"{}
        _RimColor ("Color", Color) = (1,1,1,1)
        _Normal ("Normal", 2D) = "white" {}
        _RimPower("RimPower", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldPos;
        };

        fixed4 _RimColor;
        fixed _RimPower;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Albedo = 0;
            o.Normal = UnpackNormal(nor);

            float rimmed = pow(1- saturate(dot(o.Normal, IN.viewDir)),3) * _RimPower;
            //o.Emission = _RimColor;
            //o.Alpha = rimmed;
            //frac은 소숫점만 반환해주는 함수
            float fractaled = pow(frac(IN.worldPos.y * 3 + _Time.y), 30);
            o.Emission = _RimColor;
            o.Alpha = fractaled + rimmed;
        }
        ENDCG
    }
    FallBack "Diffuse"
}