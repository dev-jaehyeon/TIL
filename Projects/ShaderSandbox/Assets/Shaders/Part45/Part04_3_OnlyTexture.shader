Shader "Custom/Part04_3_OnlyTexture"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        //fullforwardshadows 가 있으면, 포워드 렌더링 상태일 때 모든 라이트에게서 그림자를 생성한다.
        //이 구문을 삭제하면 디렉셔널 라이트에게서만 그림자를 생성한다.
        #pragma surface surf Standard //fullforwardshadows

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //tex2D(Sampler, (float2)UV)는 텍스쳐로부터 컬러를 반환한다.
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
