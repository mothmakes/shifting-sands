/// @desc Times start of double jump

vsp = -(jumpsp + (jumps<jumpsMax-1 ? dbjumpBoost : 0)); // Sets vsp to jumpsd, and adds jump boost if double jump
didJump = true;
didWallJump = false;
onWall = false;
dbJumping = false;
show_debug_message("Done db!")
