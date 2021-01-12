Shader "Custom/Part16_Depth"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert noambient noshadow 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _CameraDepthTexture;

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float4 screenPos;
        };


        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            
            float2 sPos = float2(IN.screenPos.x, IN.screenPos.y);
            float4 Depth = tex2D(_CameraDepthTexture, IN.uv_MainTex);

            o.Albedo = Depth.r;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack off
}
