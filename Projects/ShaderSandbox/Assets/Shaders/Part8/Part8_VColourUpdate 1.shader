Shader "Custom/Part8_VColourUpdate"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _VertexR("V1", 2D) = "white"{}
        _VertexG("V1", 2D) = "white"{}
        _VertexB("V1", 2D) = "white"{}
        _MainNormal("Normal", 2D) = "white" {}
        _Metallic("Metallic", Range(0, 1)) = 0
        _Smoothness("Smoothness", Range(0, 1)) = 0.5
        [Enum(RGBA)] _RGBA ("어디가 빛날 것인지", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard noambient

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _VertexR;
        sampler2D _VertexG;
        sampler2D _VertexB;

        sampler2D _MainNormal;

        float _Metallic;
        float _Smoothness;

        float _RGBA;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_VertexR;
            float2 uv_VertexG;
            float2 uv_VertexB;
            //버텍스 컬러를 가져오는 정해진..이름?
            float4 color:COLOR;

            float2 uv_MainNormal;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {  
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 v1 = tex2D(_VertexR, IN.uv_VertexR);
            fixed4 v2 = tex2D(_VertexG, IN.uv_VertexG);
            fixed4 v3 = tex2D(_VertexB, IN.uv_VertexB);

            //c.rgb = c.rgb - (IN.color.r + IN.color.g + IN.color.b);
            c.rgb = c.rgb * (1 - (IN.color.r + IN.color.g + IN.color.b));

            v1.rgb = v1.rgb * IN.color.r;
            v2.rgb = v2.rgb * IN.color.g;
            v3.rgb = v3.rgb * IN.color.b;
            o.Albedo = c + v1 + v2 + v3;
            o.Alpha = c.a;
            fixed4 normal = tex2D(_MainNormal, IN.uv_MainNormal);
            o.Normal = UnpackNormal(normal);
            o.Metallic = _Metallic;
            
            switch (_RGBA)
            {
                case 0:
                o.Smoothness = IN.color.r * _Smoothness;
                break;
            }


            //o.Smoothness = _Smoothness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
