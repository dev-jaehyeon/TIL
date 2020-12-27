Shader "Custom/Part12_Confused"
{
    Properties
    {
        _RimColor("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        _RimPower("RimPower", float) = 1
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque"}
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert noambient

            #pragma target 3.0

            sampler2D _MainTex;
            sampler2D _Normal;

            struct Input
            {
                float2 uv_MainTex;
                float3 viewDir;
            };

            fixed4 _RimColor;
            fixed _RimPower;

            UNITY_INSTANCING_BUFFER_START(Props)
            UNITY_INSTANCING_BUFFER_END(Props)

            void surf(Input IN, inout SurfaceOutput o)
            {
                fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
                fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
                o.Albedo = 0;
                o.Normal = UnpackNormal(nor);

                float rimmed = dot(o.Normal, IN.viewDir) * _RimPower;
                o.Emission = rimmed;
            }
            ENDCG
        }
            FallBack "Diffuse"
}
