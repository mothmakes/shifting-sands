// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_wall_slide(){
	if(state_new) {
		if(printState) sdm(state_name);
		image_speed = 0;
		animStart = WALLSLIDE_START;
		animEnd = WALLSLIDE_END;
		jumps = jumpsMax;
	}
	image_index = animEnd;
	
	vsp = wallslidesp;
	
	vsp_final = vsp + vsp_decimal;
	vsp_decimal = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
	vsp_final -= vsp_decimal;
	
	if(place_meeting(x,y,obj_deathpoint)) {
		state_switch("Dead");
	}
	
	if(place_meeting(x,y+vsp_final,obj_collide)) {
		state_switch("Idle");
		exit;
	}
	
	y+= vsp_final;
	
	if(key_left xor key_right) {
		face = (key_right ? 1 : -1);
	}
	
	image_xscale = -face;
	
	if(key_jump) {
		state_switch("Wall Jump");	
	}
	
	if(!place_meeting(x+face,y,obj_collide)) {
		state_switch("Fall");
	}
	
	
}