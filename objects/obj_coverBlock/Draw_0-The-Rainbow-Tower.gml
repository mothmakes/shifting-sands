/// @desc
var _left = bbox_left;
var _top = bbox_top;
var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[1]);

if(view_current != 0) exit;

if(!surface_exists(cSurf)) {
	cSurf = surface_create(sprite_width,sprite_height);
	blend_texture = surface_get_texture(cSurf);
}
surface_set_target(cSurf);
	draw_clear_alpha(c_blue,0);
	draw_surface_part_ext(application_surface,(_left-_camX),(_top-_camY),sprite_width,sprite_height,0,0,1,1,c_white,1);
surface_reset_target();

draw_surface(cSurf,x,y);

shader_set(shader);
	shader_set_uniform_f(u_blend,blend);
	
	texture_set_stage(u_blend_texture,blend_texture);
	
	//draw_self();
shader_reset();