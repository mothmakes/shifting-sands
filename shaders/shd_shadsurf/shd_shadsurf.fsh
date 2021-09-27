varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main(){
	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = vec4(vec3(v_vColour.a * frag.rgb + 1.-v_vColour.a),1.); //change the scale of the light intensity then translate it to have max rgb value at pure white
}
