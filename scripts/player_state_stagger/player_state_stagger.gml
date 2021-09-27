// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_stagger(){
	if(state_new) {
		if(printState) sdm(state_name);
		disableInput = true;
		image_speed = 0.8;
		animStart = STAGGER_START;
		animEnd = STAGGER_END;
		screenshake(room_speed*0.1,1.2,0.03);
	}
	
	if(state_timer > (staggertime * room_speed)) {
		state_switch("Stand");
	}
}