// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_fall(){
	if(state_new) {
		if(printState) sdm(state_name);
		image_speed = 0
		//animStart = IDLE_START;
		//animEnd = IDLE_END;
		dbJumping = false;
		wallJumping = false;
		fallStart = y;
	}
	
	image_index = getPlayerAirFrame(jumpsp,termsp,vsp);
	
	if(vsp < termsp) {
		vsp += grv;
	}
	
	if(key_left xor key_right) {
		face = (key_right ? 1 : -1);
	}
	
	image_xscale = face;
	
	hsp = (key_right-key_left) * walksp;
	
	hsp_final = hsp + hsp_decimal;
	hsp_decimal = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
	hsp_final -= hsp_decimal;
	
	if(place_meeting(x,y,obj_deathpoint)) {
		state_switch("Dead");
	}
	
	if(place_meeting(x+hsp_final,y,obj_collide)) {
		var collider = instance_position(((face > 0) ? bbox_right : bbox_left)+hsp_final,bbox_bottom,obj_collide);
		var vertDist = (instance_exists(collider) ? bbox_bottom - collider.y : noone);
		var toY = y;
		//if(vertDist < 8 && vertDist > 0 && !place_meeting(x+hsp_final,collider.y-bboxOffset-2,obj_collide)) toY = collider.y-bboxOffset-2;
	    var inc = sign(hsp_final);
	    while (!place_meeting(x+inc,y,obj_collide)) x+= inc;
		y = toY;
	    hsp_final = 0;
	    hsp = 0;
		
		if(instance_exists(collider) && !object_is_ancestor(collider.object_index, obj_collideNoslide)) state_switch("Wall Slide");
	}
	
	x+=hsp_final;
	
	vsp_final = vsp + vsp_decimal;
	vsp_decimal = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
	vsp_final -= vsp_decimal;
	
	if (place_meeting(x,y+vsp_final,obj_collide)) {
	    var inc = sign(vsp_final);
	    while (!place_meeting(x,y+inc,obj_collide)) y+= inc;
		jumps = jumpsMax;
		vsp_final = 0;
		var vsptemp = vsp;
		vsp = 0;
		
		if(vsptemp >= staggerSpeedThresh && (y-fallStart) >= staggerDistThresh) {
			state_switch("Stagger");
		} else if(key_left xor key_right) {
			state_switch("Run");
		} else {
			state_switch("Idle");
		}
	}
	y+=vsp_final;
	
	if(key_jump && jumps != 0) {
		state_switch("Double Jump");
	}
}