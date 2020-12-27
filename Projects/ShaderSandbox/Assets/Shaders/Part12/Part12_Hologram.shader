Shader "Custom/Part12_Hologram"
{
    Properties
    {
        _RimColor ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal("Normal", 2D) = "white"{}
        _RimPower("RimPower", float) = 1
        [MaterialToggle] _isEmission("isEmission", float) = 0
        _ViewDirAdder("viewDirAdder", Vector) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert noambient alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normal;
        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        fixed4 _RimColor;
        fixed _RimPower;
        float _isEmission;

        fixed3 _ViewDirAdder;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //o.Albedo = c.rgb;

            fixed4 nor = tex2D(_Normal, IN.uv_MainTex);
            o.Normal = UnpackNormal(nor);

            float rimmed = pow(1 - dot(o.Normal, IN.viewDir + _ViewDirAdder.xyz), 3) * _RimPower;
            //오 Emission에 넣는거 말고 그냥 저렇게 더해놔도 꽤 쓸만하다.
            //근데 Emission에 넣는게 더 림라이트같고 단순히 더한 것은 뭔가 부족하다.
            //if (_isEmission == 0)
            //{
            //    //o.Albedo = c.rgb + pow(1 - rimmed, 3) * _RimColor * _RimPower;
            //}
            //else
            //    o.Emission = rimmed

            o.Alpha = abs(rimmed * sin((_Time.y* 0.5 + 0.5)*4));
            o.Emission = _RimColor;
            //에미션에 컬러를 넣어줘야 컬러가 살아난다니..
        }
        ENDCG
    }
    FallBack "Diffuse"
}
