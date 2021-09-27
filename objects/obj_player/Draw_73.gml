if !surface_exists(viewSurf){
	if(view_current == 1) {
		viewSurf = surface_create(flooredW, flooredH);
		view_surface_id[1] = viewSurf;
	}
}

if(view_current == 0) {
	if !surface_exists(clipSurf) {
		clipSurf = surface_create(view_wport[0], view_hport[0]);
	}
	
	if (surface_exists(viewSurf)) {
		draw_set_color(c_white);
		draw_circle(x,y,edgeRadius,false);
		
		var xviewOffset = x-camera_get_view_x(view_camera[0]);
		var yviewOffset = y-camera_get_view_y(view_camera[0]);
		
		surface_set_target(clipSurf);
			gpu_set_blendenable(false); // All alpha shown as fully opaque
			gpu_set_colorwriteenable(false,false,false,true); // All drawing only affects alpha
			draw_set_alpha(0); // All drawing fully transparent
			draw_rectangle(0,0,flooredW, flooredH,false); // Draws rectangle to fill view
		
			draw_set_alpha(1); // All drawing fully opaque
			draw_circle(xviewOffset,yviewOffset,viewRadius,false); // Draws circle in centre of screen
			gpu_set_blendenable(true); // All alpha shown properly
			gpu_set_colorwriteenable(true,true,true,true); // All drawing affects all channels
		
			#region Additional effects to improve timeshift bubble put here
		
			#endregion
		
			gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha); // Sets the blending modes to blend the circle and viewport
        
			// Essentially, the pixels where the circle and view overlap are shown by the blending mode
			// The rectangle is fully invisible
		
			gpu_set_alphatestenable(true); // Possibly redundant - keeping in for cases of special effects or errors
		
			// Draws viewport surface to the clipSurf
	        draw_surface_stretched(viewSurf, 0, 0, flooredW, flooredH);
			draw_sprite_ext(sprite_index,image_index,xviewOffset,yviewOffset,image_xscale,image_yscale,0,image_blend,image_alpha);
			gpu_set_alphatestenable(false);
		
			// Returns pixel blending to normal and stops drawing to surface
	        gpu_set_blendmode(bm_normal);
			
		surface_reset_target();
		
		draw_surface(clipSurf,camC.x-camC.xOffset,camC.y-camC.yOffset);
		
		//surface_set_target(viewSurf);
		//	draw_clear_alpha(c_white,0);
		//surface_reset_target();
	}
}