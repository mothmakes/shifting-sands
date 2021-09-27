// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_run(){
	if(state_new) {
		if(printState) sdm(state_name);
		image_speed = 1
		animStart = RUN_START;
		animEnd = RUN_END;
	}
	
	if(key_left xor key_right) {
		face = (key_right ? 1 : -1);
	}
	
	image_xscale = face;
	
	hsp = (key_right-key_left) * walksp;
	
	hsp_final = hsp + hsp_decimal;
	hsp_decimal = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
	hsp_final -= hsp_decimal;
	
	if(!place_meeting(x,y+1,obj_collide)) {
		if(place_meeting(x,y+STEP_DISTANCE,obj_collide)) {
			//while (!place_meeting(x,y+1,obj_collide)) y+= 1;
			y++;
		} else if (place_meeting(x,y+(2*STEP_DISTANCE),obj_ramp)) {
			while (!place_meeting(x,y+1,obj_collide)) y+= 1;
			//y++;
		} else {
			state_switch("Fall");
		}
	}
	
	if(place_meeting(x+hsp_final,y,obj_collide)) {
		var collider = instance_position(((face > 0) ? bbox_right : bbox_left)+hsp_final,bbox_bottom,obj_collide);
		var vertDist =  (instance_exists(collider) ? bbox_bottom - collider.y : noone);
		var toY = y;
		var inc = sign(hsp_final);
		if((instance_exists(collider) && object_is_ancestor(collider.object_index,obj_ramp)) || vertDist < STEP_DISTANCE && vertDist >= 0 && !place_meeting(x+hsp_final,collider.y-bboxOffset-1,obj_collide)) {
			while(place_meeting(x+hsp_final,toY,obj_collide)) toY--;
		} else {
			while (!place_meeting(x+inc,y,obj_collide)) x+= inc;
			
			hsp_final = 0;
			hsp = 0;
		}
	    
		y = toY;
	}
	
	x+=hsp_final;
	
	if(key_jump)
	{
		state_switch("Jump");
	}
	
	//Switch back to idling if not moving
	if(hsp_final == 0) {
		state_switch("Idle");	
	}
}