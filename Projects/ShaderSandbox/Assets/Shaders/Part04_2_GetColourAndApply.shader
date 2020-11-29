Shader "Custom/Part04_2_GetColourAndApply"
{
    Properties
    {
        _Red ("Red", Range(0, 1)) = 0.5
        _Green("Green", Range(0, 1)) = 0.5
        _Blue("Blue", Range(0,1)) = 0.5
        _Brightness("Brightness", Range(-1,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        fixed _Red;
        fixed _Green;
        fixed _Blue;
        fixed _Brightness;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed3 c = fixed3(_Red, _Green, _Blue);
            o.Albedo = c.rgb + _Brightness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
