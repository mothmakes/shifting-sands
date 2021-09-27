if(keyboard_check_pressed(vk_control)) {
	dark = !dark;
}

if(keyboard_check_pressed(vk_enter)) {
	with(obj_door) toggle();	
}