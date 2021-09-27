//Updates the checkpoint of the player if the player is in it
function updateCheckpoint() {
	if(place_meeting(x,y,obj_checkpoint)) {
		var _checkpoint = instance_nearest(x,y,obj_checkpoint); // OPTIMIZE
		checkpoint = _checkpoint;
		var _x = x;
		var _y = y;
		with(checkpoint) {
			playerX = _x;
			playerY = _y;
		}
	}
}

if(global.PAUSED) {
	exit;
}

#region Get timestream location (it's variant: present or past)

variant = getObjectVariantByPos(x,y,obj_gameManager.pastRect,obj_gameManager.presentRect);

#endregion

#region Water Update
if(place_meeting(x,y,obj_water)) {
	if(!inWater) {
		var _water = instance_nearest(x,y,obj_water);
		var _xoffset = x-_water.bbox_left;
		var _spring = clamp(ceil((_xoffset/_water.sprite_width)*_water.springCount),0,_water.springCount)
		_water.springsVelocity[_spring] = -16 * (vsp/termsp);
		inWater = true;
	}
} else if (inWater) {
	inWater = false;
	var _water = instance_nearest(x,y,obj_water);
	var _xoffset = x-_water.bbox_left;
	var _spring = clamp(ceil((_xoffset/_water.sprite_width)*_water.springCount),0,_water.springCount);
	_water.springsVelocity[_spring] = -4 * (vsp/termsp);
}
#endregion

#region Checkpoint Check

updateCheckpoint();

#endregion

#region Pressure Plate Check
var collider = instance_place(x,y+1,obj_pressureSensor);

if(collider != noone && collider.activated == false) {
	with(collider) activate();
}
#endregion

#region Keyboard Input Checks

// TODO: Optimize lazy ops
key_right = keyboard_check(ord("D")) && !disableInput;
key_left = keyboard_check(ord("A")) && !disableInput;
key_dash = keyboard_check(vk_lshift) && !disableInput;
key_up = keyboard_check(ord("W")) && !disableInput;
key_down = keyboard_check(ord("S")) && !disableInput;
key_jump = keyboard_check_pressed(vk_space) && !disableInput;
key_jump_held = keyboard_check(vk_space) && !disableInput;

//DON'T FORGET: ENABLE OR DISABLE QENABLE IN ROOM CREATION CODE

key_q = keyboard_check_pressed(ord("Q")) && !disableInput && qEnable;
key_e = keyboard_check(ord("E")) && !disableInput && eEnable;

if keyboard_check(vk_escape) {
	game_end();
}

#endregion

//Execute script for the state
state_execute();

#region Animation Keying
if(state_name != "Jump" && state_name != "Fall" && state_name != "Wall Slide") {
	if(state_new && state_name != "Stand") {
		image_index = animStart;
	} else if (image_index > animEnd || image_index < animStart) {
		if(state_name == "Stagger" || state_name == "Stand") {
			image_index = animEnd;
		} else {
			image_index = animStart + 1;
		}
	}
}
#endregion

#region Time shifts

// Tests for timeshift, checking which time the player is in and therefore what way to swap.

if (key_q && !disableInput) {
	variant = getObjectVariantByPos(x,y,pastRect,presentRect);
	y += power(-1,variant)*rectHeight;
	
	if(place_meeting(x,y,obj_collide)) {
		alarm[3] = room_speed * deathDelay;
		disableInput = true;
	}
	
	// If in present, add rectHeight (-1^0 * rectHeight). If in past, minus rectHeight (-1^1 * rectHeight)
	// Jump camera to this position
	
	camera_swap_timestream(view_camera[0],view_camera[1],camC,camV);
	
	variant = getObjectVariantByPos(x,y,pastRect,presentRect);
}

// Reset world speed incase no longer shifting.
global.WORLD_SPEED = 1;

// Handles bubble timeshifting - the size of the bubble, and when to shift
if (key_e && !disableInput) {
	// Computes bubble if time since last shift is greater than the cooldown
	if current_time - timeOfLastShift > timeshiftCooldown {
		// If bubble size is larger than threshold, trigger timeshift
		if viewRadius > BUBBLE_SIZE_LIMIT {
			variant = getObjectVariantByPos(x,y,pastRect,presentRect)
			y += power(-1,variant)*rectHeight; // If in present, add rectHeight (-1^0 * rectHeight). If in past, minus rectHeight (-1^1 * rectHeight)
			viewRadius = 0;
			edgeRadius = 0;
			timeOfLastShift = current_time;
			
			camera_swap_timestream(view_camera[0],view_camera[1],camC,camV);
			
			variant = getObjectVariantByPos(x,y,pastRect,presentRect)
		
			// Trigger screenflash
			screenflash(0,1,0.05);
		} else {
			global.WORLD_SPEED = 1;
			viewRadius = lerp(viewRadius,2*halfViewWidth,BUBBLE_EXPANSION_SPEED);
			edgeRadius = lerp(edgeRadius,2*halfViewWidth,BUBBLE_EXPANSION_SPEED*1.05);
		}
	}
} else {
	viewRadius = lerp(viewRadius,0,BUBBLE_DISSIPATION_SPEED);
	edgeRadius = lerp(edgeRadius,0,BUBBLE_DISSIPATION_SPEED);
}

#endregion

#region Old Code
/*

#region Movement and collisions

if(key_left xor key_right) {
	face = (key_right ? 1 : -1);
	if(minWallJumpTimeElapsed) {
		didWallJump = false;
	}
}

if(didWallJump) {
	hsp *= hres;
} else {
	hsp = (key_right-key_left) * walksp;
}

if(vsp < termsp) {
	if(onWall && vsp > 0) {
		vsp = wallslidesp;
		jumps = jumpsMax;
	} else {
		vsp += grv;
	}
}

if(key_jump && jumps > 0 && minWallJumpTimeElapsed && !dbJumping) {
	jumps -= 1;
	
	if(jumps <= jumpsMax - 2 && !onWall) {
		alarm[2] = room_speed * dbjumpDelay;
		dbJumping = true;
		show_debug_message("Double Jumping!")
	} else {
		vsp = -(jumpsp + (jumps<jumpsMax-1 ? dbjumpBoost : 0)); // Sets vsp to jumpsd, and adds jump boost if double jump
		didJump = true;
		didWallJump = false;
		show_debug_message("Jump!")
		if(onWall) show_debug_message("Against wall!")
		if(onWall && !onGround) {
			show_debug_message("Wall jump!")
			hsp = face * -1 * walljumphsp;
			didWallJump = true;
			minWallJumpTimeElapsed = false;
			alarm[0] = room_speed * minWallJumpTime;
			alarm[1] = room_speed * maxWallJumpTime;
			onWall = false;
		}
	}
}

if(didJump && vsp < 0 && !key_jump_held) {
	vsp = max(vsp, -(jumpsp + (jumps<jumpsMax-1 ? dbjumpBoost : 0)) * jumpDynamicRatio); 
}

hsp_final = hsp + hsp_decimal;
hsp_decimal = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
hsp_final -= hsp_decimal;
 
vsp_final = vsp + vsp_decimal;
vsp_decimal = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
vsp_final -= vsp_decimal;
 
if (place_meeting(x+(onWall && !(key_left xor key_right) ? face : hsp_final),y,obj_collide)) {
	var collider = instance_nearest(x+(onWall && !(key_left xor key_right) ? face : hsp_final),y,obj_collide);
	var vertDist = bbox_bottom - collider.y;
	var toY = y;
	sdm(vertDist);
	if(vertDist < 8 && vertDist > 0 && !place_meeting(x+(onWall && !(key_left xor key_right) ? face : hsp_final),collider.y-bboxOffset-2,obj_collide)) toY = collider.y-bboxOffset-2;
    var inc = sign(hsp_final);
    while (!(onWall && !(key_left xor key_right)) && !place_meeting(x+inc,y,obj_collide)) x+= inc;
	y = toY;
    hsp_final = 0;
    hsp = 0;
	if (collider.object_index == obj_wallFlat) {
		onWall = true;
	} else {
		onWall = false;
	}
} else {
	if(onWall) {
		onWall = false;
	}
}
x+=hsp_final;
 
if (place_meeting(x,y+vsp_final,obj_collide)) {
    var inc = sign(vsp_final);
    while (!place_meeting(x,y+inc,obj_collide)) y+= inc;
	if(vsp_final < 0) {
		onWall = false;
	}
	if(vsp_final > 0) {
		jumps = jumpsMax;
		onGround = true;
		if(hsp_final != 0) {
			idling = false;
			if(!running) {
				running = true;
				image_index = RUN_START;
			} else if(image_index < RUN_START or image_index > RUN_END) {
				image_index = RUN_START+1;
			}
			image_speed = 1;
			image_xscale = key_right - key_left;
			//instance_activate_object(scarf);
			//show_debug_message(image_xscale);
		} else {
			running = false;
			if (!idling) {
				idling = true;
				image_index = IDLE_START;
			} else if (image_index > IDLE_END) image_index = IDLE_START + 1;
			image_speed = 0.3;
			//instance_deactivate_object(scarf);
		}
		didJump = false;
	}
    vsp_final = 0;
    vsp = 0;
	didWallJump = false;
} else {
	if(vsp_final != 0) {
		onGround = false;
		if(!didJump && !dbJumping) {
			jumps = jumpsMax - 1;
		}
	}
}
y+=vsp_final;
//show_debug_message(jumps)

#endregion
*/

#endregion