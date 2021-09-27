/// @description Insert description here
// You can write your code in this editor

key_right = keyboard_check(ord("a"))

anchor_y = obj_player.y-16;
anchor_x = obj_player.x-(power(-1,key_right)*24);
var disty = anchor_y - y;
var distx = anchor_x - x;

//phy_position_y = lerp(phy_position_y,anchor_y,buoyancy_ratio);

physics_apply_force(x,y,0,5*clamp(disty/16,-1,1));
physics_apply_force(x,y,5*clamp(distx/24,-1,1),0);