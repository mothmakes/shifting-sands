// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_dead(){
	if(state_new) {
		if(printState) sdm(state_name);
		image_speed = 0.3
		animStart = IDLE_START;
		animEnd = IDLE_END;
		dbJumping = false;
		wallJumping = false;
	}
	disableInput = true;
	if(state_timer > room_speed * deathDelay) {
		disableInput = false;
		x = checkpoint.playerX;
		y = checkpoint.playerY;
		if(!place_meeting(x,y,obj_collide)) while (!place_meeting(x,y+1,obj_collide)) y+= 1;

		if(variant != checkpoint.variant) {
			camera_swap_timestream(view_camera[0],view_camera[1],camC,camV);
		}
		state_switch("Idle");
	}
}