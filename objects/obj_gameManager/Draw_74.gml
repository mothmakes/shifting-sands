/// @description AppSurf Shaders

// Night and Day Shader
// arguments:	  R    G    B   con  sat  brt   popS  popT

//shader_set(shdr_dayAndNight);
//shader_set_uniform_f_array(u_col, color_mix_night);
//shader_set_uniform_f_array(u_con_sat_brt, con_sat_brt_mix_night);
//draw_surface(application_surface,0,0);
//shader_reset();

// Bloom Shader
if(!surface_exists(surf_ping)) {
	surf_ping = surface_create(app_w,app_h);
	bloom_texture = surface_get_texture(surf_ping);
}

if(!surface_exists(surf_pong)) {
	surf_pong = surface_create(app_w,app_h);
}

if(!surface_exists(surf_time)) {
	surf_time = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
}

//1st pass: Draw brights to ping surface
// AppSurf -> surf_ping
shader_set(shader_bloom_lum);
	//shader_set_uniform_f(u_bloom_threshold,bloom_threshold);
	//shader_set_uniform_f(u_bloom_range,bloom_range);
	
	surface_set_target(surf_ping);
		draw_surface_stretched(application_surface,0,0,app_w,app_h);
	surface_reset_target();
	
//2nd pass: Blur horizontally
// surf_ping -> surf_pong
gpu_set_texfilter(true);
shader_set(shader_bloom_blur);
	//shader_set_uniform_f(u_blur_steps, blur_steps);
	//shader_set_uniform_f(u_sigma, sigma);
	shader_set_uniform_f(u_blur_vector, 1, 0);
	shader_set_uniform_f(u_texel_size, texel_w, texel_h);
	
	surface_set_target(surf_pong);
		draw_surface(surf_ping,0,0);
	surface_reset_target();
	
//3rd pass: Blur vertical
// surf_pong -> surf_ping
	shader_set_uniform_f(u_blur_vector, 0, 1);
	
	surface_set_target(surf_ping);
		draw_surface(surf_pong,0,0);
	surface_reset_target();
	
gpu_set_texfilter(false);

shader_reset();

//4th pass: Performing Night and Day shaders
// AppSurf -> AppSurf

if(dark) {
	shader_set(shader_day_night);
	shader_set_uniform_f_array(u_col, color_mix_night);
	shader_set_uniform_f_array(u_con_sat_brt, con_sat_brt_mix_night);
}

surface_set_target(surf_time);
	draw_surface(application_surface,0,0);
surface_reset_target();

//5th pass: Blending the surfaces
// AppSurf + surf_ping -> Screen
shader_set(shader_bloom_blend);
	//shader_set_uniform_f(u_bloom_intensity, bloom_intensity);
	shader_set_uniform_f(u_bloom_darken, darkness);
	//shader_set_uniform_f(u_bloom_saturation, bloom_saturation);
	texture_set_stage(u_bloom_texture,bloom_texture);
	
	gpu_set_texfilter_ext(u_bloom_texture, true);
	
	draw_surface(surf_time,0,0);
shader_reset();
gpu_set_texfilter_ext(u_bloom_texture, false);