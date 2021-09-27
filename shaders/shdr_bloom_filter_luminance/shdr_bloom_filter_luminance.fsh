varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float lum = dot(base_col.rgb, vec3(0.229,0.587,0.114));
	//Threshold and Range
	float weight = smoothstep(0.25, 0.25 + 0.1,lum);
	base_col.rgb = mix(vec3(0.0),base_col.rgb,weight);
    gl_FragColor = base_col;
}
