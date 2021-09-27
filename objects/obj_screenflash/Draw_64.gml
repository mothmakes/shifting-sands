if(flash) {
	flash_time -= 1; 
	
	if (flash_time <= 0) 
	{ 
	    flash_alpha -= flash_fade; 

	    if (flash_alpha <= 0) 
	    { 
	        flash = false; 
	    } 
	} 

	draw_set_color(c_white);
	draw_set_alpha(flash_alpha);//screenFlashAlpha);
	draw_rectangle(0,0,gui_w,gui_h,false);
	draw_set_alpha(1);
}