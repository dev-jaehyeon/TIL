Shader "Custom/Part11_BasicCL"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        [MaterialToggle] _IsSatured("is Saturated", float) = 0
        _Adder("Adder", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf testa noambient

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;

        float _IsSatured;
        float _Adder;

        struct Input
        {
            float2 uv_MainTex;
        };


        UNITY_INSTANCING_BUFFER_START(Props)

        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(nor);
            o.Alpha = c.a;
        }

        float4 Lightingtesta(SurfaceOutput s, float3 lightDir, float atten)
        {
            float dotted = dot(s.Normal, lightDir);
            float satured = saturate(dotted);
            if (_IsSatured == 1)
                return satured + _Adder;
            else if (_IsSatured == 0)
                return dotted + _Adder;
            else
                return 0;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
