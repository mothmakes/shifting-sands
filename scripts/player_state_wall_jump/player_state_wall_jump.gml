// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_wall_jump(){
	if(printState) sdm(state_name);
	wallJumping = true;
	hsp = face * -1 * walljumphsp;
	state_switch("Jump");
}