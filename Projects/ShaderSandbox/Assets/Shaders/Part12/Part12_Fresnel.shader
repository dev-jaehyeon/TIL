Shader "Custom/Part12_Fresnel"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white" {}
        _RimColor("Rim Color", Color) = (1,1,1,1)
        _RimPower("Rim Power", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;
        fixed4 _RimColor;
        fixed _RimPower;


        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
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
            o.Albedo = c.rgb;

            //노말을 언팩해서 집어넣고 림라이트를 쓰면 더 선명한 림라이트를 얻을 수 있다. 대신 연산이 빡셀듯?
            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Normal = UnpackNormal(nor);
            float rimmed = dot(o.Normal, IN.viewDir);

            o.Emission = pow(saturate(1-rimmed), 3) * _RimPower * _RimColor;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
