Shader "Custom/Part7_VColour"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _VertexR("V1", 2D) = "white"{}
        _VertexG("V1", 2D) = "white"{}
        _VertexB("V1", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _VertexR;
        sampler2D _VertexG;
        sampler2D _VertexB;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_VertexR;
            float2 uv_VertexG;
            float2 uv_VertexB;
            //버텍스 컬러를 가져오는 정해진..이름?
            float4 color:COLOR;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
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
            //o.Emission = c + v1 + v2 + v3;//밑에랑 같이 둘다 됨
            o.Emission = c.rgb + v1.rgb + v2.rgb + v3.rgb;
            //o.Emission = (IN.color.r + IN.color.g + IN.color.b);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
