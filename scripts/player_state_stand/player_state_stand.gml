// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_stand(){
	if(state_new) {
		if(printState) sdm(state_name);
		disableInput = true;
		image_speed = 0.8;
		animStart = STAND_START;
		animEnd = STAND_END;
	}
	if(state_timer > (standtime * room_speed)) {
		disableInput = false;
		state_switch("Idle");
	}
}