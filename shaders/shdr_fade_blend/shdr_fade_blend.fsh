//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float blend;
uniform sampler2D blend_texture;

void main()
{
	vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 blend_col = texture2D(blend_texture, v_vTexcoord);
	
    gl_FragColor = vec4(mix(blend_col.rgb,base_col.rgb,blend),1.0);
}
