Shader "Custom/Practice1"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NoiserTex("Noiser", 2D) = "white" {}
        _Adder("Multiplier", float) = 0
        _Lerper("Lerper", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NoiserTex;
        fixed _Adder;
        fixed _Lerper;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NoiserTex;
        };


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) - 1 + _Adder;
            fixed4 d = tex2D(_NoiserTex, IN.uv_NoiserTex);
            fixed4 lerped = lerp(c, d, _Lerper);
            o.Albedo = lerped.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
