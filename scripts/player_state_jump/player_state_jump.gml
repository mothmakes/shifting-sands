// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_jump(){
	if(state_new) {
		if(printState && !dbJumping && !wallJumping) sdm(state_name);
		image_speed = 0;
		jumps -= 1;
		//Adds initial jump speed
		if(!dbJumping) vsp = -jumpsp;
		//animStart = IDLE_START;
		//animEnd = IDLE_END;
	}
	
	image_index = getPlayerAirFrame(jumpsp,termsp,vsp);
	
	if(wallJumping && (state_timer == (room_speed * maxWallJumpTime))) {
		wallJumping = false;
	}
	
	if(dbJumping && (state_timer == (room_speed * dbjumpDelay))) {
		vsp = -(jumpsp+dbjumpBoost);
	}
	
	if(vsp < termsp) {
		vsp += grv;
	}
	
	if(vsp >= 0 && (state_timer > (room_speed * dbjumpDelay))) {
		state_switch("Fall");
	}
	
	if(key_left xor key_right) {
		face = (key_right ? 1 : -1);
		if(wallJumping && state_timer >= (room_speed * minWallJumpTime)) {
			wallJumping = false;
		}
	}
	
	image_xscale = face;
	
	if(wallJumping) {
		hsp *= hres;
	} else {
		hsp = (key_right-key_left) * walksp;
	} 
	
	hsp_final = hsp + hsp_decimal;
	hsp_decimal = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
	hsp_final -= hsp_decimal;
	
	if(place_meeting(x+hsp_final,y,obj_collide)) {
		var collider = instance_nearest(x+hsp_final,y,obj_collide);
		var vertDist = bbox_bottom - collider.y;
		var toY = y;
		var inc = sign(hsp_final);
		if(vertDist < STEP_DISTANCE && vertDist >= 0 && !place_meeting(x+hsp_final,collider.y-bboxOffset-1,obj_collide)) {
			while(place_meeting(x+inc,toY,obj_collide)) toY--;
		} else {
			while (!place_meeting(x+inc,y,obj_collide)) x+= inc;
			
			hsp_final = 0;
			hsp = 0;
		}
	    
		y = toY;
	}
	
	x+=hsp_final;
	
	// Adjusts jump speed based on whether the key is being held
	if(!key_jump_held) {
		vsp = max(vsp, -(jumpsp+(dbJumping ? dbjumpBoost : 0)) * jumpDynamicRatio);
	}
	
	vsp_final = vsp + vsp_decimal;
	vsp_decimal = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
	vsp_final -= vsp_decimal;
	
	if (place_meeting(x,y+vsp_final,obj_collide)) {
	    var inc = sign(vsp_final);
	    while (!place_meeting(x,y+inc,obj_collide)) y+= inc;
		vsp_final = 0;
		vsp = 0;
	}
	y+=vsp_final;
	
	if(key_jump && jumps != 0) {
		state_switch("Double Jump");
	}
}