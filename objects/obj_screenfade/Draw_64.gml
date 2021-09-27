if(fade) {
	fade_time -= 1; 
	
	if (fade_time <= 0) 
	{ 
	    fade_alpha += fade_speed * power(-1,fade_in); 

	    if (fade_alpha <= 0) 
	    { 
	        fade = false;
	    } 
	} 

	draw_set_color(c_black);
	draw_set_alpha(fade_alpha);//screenFlashAlpha);
	draw_rectangle(0,0,gui_w,gui_h,false);
	draw_set_alpha(1);
}