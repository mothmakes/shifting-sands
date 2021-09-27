/*-----------------------------------------------------------------------------
Day and Night Shader: Tint, Contrast, Brightness, Saturation and Pop Lights
Vertex Shader: Pass-through
-------------------------------------------------------------------------------
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
Post Processing shader
Changes Tint, Contrast, Brightness, Saturation of the image.
Pops bright colours to simulate moon light reflection.

_______________________________________________________________________________
UNIFORMS:
-------------------------------------------------------------------------------
uniform vec3 col;
	Tint Colour
	real, usually 0-1, can exceed the range though
	
uniform float con_sat_brt[5];
	contrast		con_sat_brt[0]	1: no change
	saturation		con_sat_brt[1]	1: no change
	brightness		con_sat_brt[2]	0: no change
	pop_strength	con_sat_brt[3]	0: no change, 0-3 works best
	pop_threshold	con_sat_brt[4]	luminance above this threshold get brightned by pop_strength

	
_______________________________________________________________________________
EXAMPLE:
-------------------------------------------------------------------------------

In seperate example files.

*/


attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
