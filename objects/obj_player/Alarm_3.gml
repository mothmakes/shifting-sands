/// @desc Delays respawn/death
disableInput = false;
x = checkpoint.playerX;
y = checkpoint.playerY;
if(!place_meeting(x,y,obj_collide)) while (!place_meeting(x,y+1,obj_collide)) y+= 1;

if(variant != checkpoint.variant) {
	camera_swap_timestream(view_camera[0],view_camera[1],camC,camV);
}