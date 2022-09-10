Shader "Unlit/TextureUV"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
    }
    SubShader
    {


        Pass
        {
            CGPROGRAM
            #pragma vertex vertexShader
            #pragma fragment fragmentShader

            #include "UnityCG.cginc" 

            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float4 _Color;

            struct vertexInput //VertexInput
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct vertexOutput //VertexOutput
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            vertexOutput vertexShader(vertexInput i){
                vertexOutput o;
                o.position = UnityObjectToClipPos(i.vertex);
                //o.uv = i.uv;
                o.uv = (i.uv * _MainTex_ST.xy + _MainTex_ST.zw);
                return o;
            }

            fixed4 fragmentShader(vertexOutput o) : SV_TARGET{
                fixed4 col = tex2D(_MainTex, o.uv) * _Color;
                return col;
            }


            ENDCG
        }
    }
}
