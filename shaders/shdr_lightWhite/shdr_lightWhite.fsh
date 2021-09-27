//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vScreenPos;


uniform vec4 u_fLightPositionRadius;        // x=lightx, y=lighty, z=light radius, w=unused

void main()
{
    // Work out vector from room location to the light
    vec2 vect = vec2( v_vScreenPos.x-u_fLightPositionRadius.x, v_vScreenPos.y-u_fLightPositionRadius.y );

    // work out the length of this vector
    float dist = sqrt(vect.x*vect.x + vect.y*vect.y);

    // if in range use the shadow texture, if not it's black.
    if( dist< u_fLightPositionRadius.z ){
        gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    }else{
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
	
	gl_FragColor.a *= 0.5;
}