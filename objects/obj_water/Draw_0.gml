if(view_current != 0) exit;

var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[0]);

if(!surface_exists(wSurf)) {
	wSurf = surface_create(sprite_width,fullHeight);
}

surface_set_target(wSurf);
	draw_clear_alpha(c_blue,0);
	draw_surface_part_ext(application_surface,(left-_camX)*appScale,(top-_camY)*appScale,scaledW,scaledH,0,transparencyBufferHeight,appScaleRatio,appScaleRatio,c_white,1);
	gpu_set_colorwriteenable(true,true,true,false);
	draw_set_alpha(0.5);
	draw_set_color($f4bb41);
	draw_rectangle(0,transparencyBufferHeight,sprite_width,fullHeight,false);
	draw_set_color($f4eb42);
	draw_line(0,transparencyBufferHeight+1,sprite_width,transparencyBufferHeight+1);
	
	draw_set_color(c_white);
	draw_line(0,transparencyBufferHeight,sprite_width,transparencyBufferHeight);
	draw_set_alpha(1);
	gpu_set_colorwriteenable(true,true,true,true);
surface_reset_target();

if(!surface_exists(resizeSurf)) {
	resizeSurf = surface_create(sprite_width,fullHeight);
}
surface_set_target(resizeSurf);
	draw_clear_alpha(c_white,0);
	shader_set(shader);
		shader_set_uniform_f(u_texelH_Wave,texel_h);
		shader_set_uniform_f(u_texelW_Wave,texel_w);
		shader_set_uniform_f(u_springCount,springCount);
		shader_set_uniform_f_array(u_springs,springs);
		shader_set_uniform_f(u_time,get_timer()*0.0000025);
		draw_surface(wSurf,0,0);
	shader_reset();
surface_reset_target();

draw_surface(resizeSurf,left,topBuffered);

for(var xx = 0; xx<image_xscale;xx++) {
	for(var yy = 0; yy<image_yscale;yy++) {
		var _xToCheck =  x+(xx*TILE_SIZE);
		var _yToCheck = y+(yy*TILE_SIZE);
		
		var _tileindex = tilemap_get_at_pixel(tilemap,_xToCheck,_yToCheck);
		if(_tileindex != 0) {
			draw_tile(tileset,_tileindex,0,floor(_xToCheck/TILE_SIZE)*TILE_SIZE,floor(_yToCheck/TILE_SIZE)*TILE_SIZE);
		}
	}
}