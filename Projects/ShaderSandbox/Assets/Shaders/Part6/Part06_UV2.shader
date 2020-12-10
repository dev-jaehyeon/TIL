Shader "Custom/Part06_UV2"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "white" {}
        //이게 있으면 float이 bool이 된다
        [MaterialToggle] _Boolean("Boolean", float) = 0
        //이게 있으면 C#스크립트에서 썼던 Enum을 가져다 쓸 수 있다
        [Enum(RGBA)] _BlendMode("Mode", float) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        bool _Boolean;
        float _BlendMode;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 d = tex2D(_MainTex2, IN.uv_MainTex2);
            //uv에서 뭔가 바뀜. 숫자가 더해짐
            float2 booledUV;
            if (_Boolean == true)
            {
                if(_BlendMode == 1)
                    booledUV = float2(IN.uv_MainTex.x + d.r, IN.uv_MainTex.y);
                else if(_BlendMode == 2)
                    booledUV = float2(IN.uv_MainTex.x + d.g, IN.uv_MainTex.y);
            }
            else
            {
                booledUV = IN.uv_MainTex;
            }
            fixed4 c = tex2D (_MainTex, booledUV);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
