// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_idle(){
	if(state_new) {
		if(printState) sdm(state_name);
		hsp = 0;
		vsp = 0;
		image_speed = 0.3;
		animStart = IDLE_START;
		animEnd = IDLE_END;
		dbJumping = false;
	}
	
	///Check for no ground.
	if(!place_meeting(x,y+1,obj_collide))
	{
	    state_switch("Fall");
	}
	
	if(key_left xor key_right) {
		face = (key_right ? 1 : -1);
		var collider = instance_position(((face > 0) ? bbox_right : bbox_left)+face,bbox_bottom,obj_collide);
		var vertDist = (instance_exists(collider) ? bbox_bottom - collider.y : noone);
		//if(instance_exists(collider))sdm(object_get_name(collider.object_index))
		//sdm(vertDist)
		if(instance_exists(collider) && object_is_ancestor(collider.object_index,obj_ramp)) {
			state_switch("Run");
		} else if(vertDist < STEP_DISTANCE && vertDist >= 0 && !place_meeting(x+face,collider.y-bboxOffset-1,obj_collide)) {
			state_switch("Run");
		} else if ((key_left && !place_meeting(x-1,y,obj_collide)) ||  (key_right && !place_meeting(x+1,y,obj_collide))){
			state_switch("Run");
		}
	}

	if(key_jump) {
		state_switch("Jump");
	}

	
}