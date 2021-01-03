Shader "Custom/Part13_CustomRim"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        _SpecPower("Specular Power", Range(1,200)) = 1
        _SpecColor("Specular Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Custom noambient

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;

        struct Input
        {
            float2 uv_MainTex;
        };

        float _SpecPower;
        //fixed4 _SpecColor;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Normal = UnpackNormal(nor);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        float4 LightingCustom(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            fixed4 lighten;

            //Diffuse
            fixed3 diffused;
            float satured = saturate(dot(s.Normal, lightDir));
            diffused = satured * _LightColor0.rgb * atten * s.Albedo;

            //Specular
            fixed3 speculed;
            float3 halfed = normalize(lightDir + viewDir);
            float specSatured = saturate(dot(s.Normal, halfed));
            float specPowered = pow(specSatured, _SpecPower);
            speculed = specPowered;

            //Rim
            float rimSatured = 1- saturate(dot(viewDir, s.Normal));
            float poweredRim = pow(rimSatured, _SpecPower);
            fixed4 coloredRim = _SpecColor * poweredRim;

            lighten.rgb = diffused + coloredRim;
            lighten.a = s.Alpha;


            return lighten;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
