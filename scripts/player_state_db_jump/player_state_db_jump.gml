// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_db_jump(){
	if(printState) sdm(state_name);
	dbJumping = true;
	state_switch("Jump");
}