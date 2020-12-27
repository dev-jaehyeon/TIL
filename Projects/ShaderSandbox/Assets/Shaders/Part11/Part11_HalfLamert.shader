Shader "Custom/Part11_HalfLamert"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        _Adder("Adder", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf basic noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;
        float _Adder;

        struct Input
        {
            float2 uv_MainTex;
        };


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(nor);
            o.Alpha = c.a;
        }

        float4 Lightingbasic(SurfaceOutput s, float3 lightDir, float atten)
        {
            float dotted = dot(lightDir, s.Normal);
            float halfed = dotted * 0.5 + 0.5;
            /*0.5 + 0.5는 -1~1의 값을 부드럽게 0~1로 끌어올려준다*/
            //return dotted *0.5 + 0.5;
            return pow(halfed, 3);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
