/// @description Insert description here
// You can write your code in this editor

event_inherited();

function activate() {
	image_speed = 1;
	activated = true;
	alarm[0] = room_speed * random(0.7);
}
image_speed = 0;
activated = false;

sprite = spr_limestoneStepLarge;