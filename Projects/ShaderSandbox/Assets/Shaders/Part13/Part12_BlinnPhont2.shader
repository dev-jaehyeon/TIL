Shader "Custom/Part12_BlinnPhont2"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        _SpecularRange("Specular Range", Range(1,200)) = 1
        _SpecularColor("Specular Color", Color) = (1,1,1,1)
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            #pragma surface surf test

            #pragma target 3.0

            sampler2D _MainTex;
            sampler2D _Normal;
            fixed _SpecularRange;
            fixed4 _SpecularColor;

            struct Input
            {
                float2 uv_MainTex;
            };


            UNITY_INSTANCING_BUFFER_START(Props)
            UNITY_INSTANCING_BUFFER_END(Props)

            void surf(Input IN, inout SurfaceOutput o)
            {
                fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
                fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
                o.Albedo = c.rgb;
                o.Normal = UnpackNormal(nor);
                o.Alpha = c.a;
            }

            float4 Lightingtest(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
            {
                float4 lighten;
                //Diffuse
                float3 diffused;
                float satured = saturate(dot(s.Normal, lightDir));
                diffused = satured * s.Albedo * _LightColor0.rgb * atten;

                //Specular
                float3 speculared;
                float3 halfed = normalize(lightDir + viewDir);
                float spec = saturate(dot(halfed, s.Normal));
                spec = pow(spec, _SpecularRange);
                speculared = _SpecularColor * spec;

                lighten.rgb = diffused.rgb + speculared;
                lighten.a = s.Alpha;
                return lighten;
            }
            ENDCG
        }
            FallBack "Diffuse"
}
