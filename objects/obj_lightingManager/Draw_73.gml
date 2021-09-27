////draw_set_color(c_red);

////for(var i=0;i<numCorners;i++) {
////	var _x = cornersX[| i];
////	var _y = cornersY[| i];
////	var _dir = directions[| i];
	
////	var _p0 = array_get(edges[| i],0);
////	var _p1 = array_get(edges[| i],1);
	
////	//show_debug_message(_p0);
////	//show_debug_message(_p1);
	
////	if(_dir == edgeDirs.UP || _dir == edgeDirs.FUP) draw_line_width(_x,_y,_x,_y-16,3);
////	if(_dir == edgeDirs.DOWN || _dir == edgeDirs.FDOWN) draw_line_width(_x,_y,_x,_y+16,3);
	
////	if(_dir == edgeDirs.LEFT || _dir == edgeDirs.FLEFT) draw_line_width(_x,_y,_x-16,_y,3);
////	if(_dir == edgeDirs.RIGHT || _dir == edgeDirs.FRIGHT) draw_line_width(_x,_y,_x+16,_y,3);
	
////	draw_circle(_x,_y,5,false);
////	draw_line_width(_p0[0],_p0[1],_p1[0],_p1[1],5);
	
////}

//// TODO: MAKE SURFACE OPTIMIZED, FIT TO VIEW!!! - DONE
//// POINT CHECK FOR PLAYER! - DONE

//if(view_current != 0) exit;

//if( !surface_exists(surf) ){
//    surf = surface_create(surf_w,surf_h);
//}

//surface_set_target(surf);
//draw_clear_alpha(c_black,1);

//var _surf_x = global.cameraCurrent.x-surf_xOffset;
//var _surf_y = global.cameraCurrent.y-surf_yOffset;
//var _playerX = obj_player.x;
//var _playerY = obj_player.y;

//var _lxs = lxs;
//var _lys = lys;

//var _lEdges = lEdges;

//for(var i=0;i<array_length(_lxs);i++) {
//	var _distToPlayer = point_distance(_lxs[i],_lys[i],_playerX,_playerY);
//	if(_distToPlayer > outOfViewDist || _distToPlayer > rectHeight) continue;
//	gpu_set_colorwriteenable(false,false,false,true); // All drawing only affects alpha
//	if(i > 0) draw_rectangle(0,0,surf_w,surf_h,false);
//	gpu_set_blendmode(bm_subtract);
//	vertex_delete_buffer(vBuffer);
//	vBuffer = vertex_create_buffer();
	
//	vertex_begin(vBuffer,vFormat);

//	for(var j=0;j<array_length(_lEdges[i]);j++) {
//		var _edge = _lEdges[i,j];
//		var _Ax = _edge[0,0]-_surf_x;
//		var _Ay = _edge[0,1]-_surf_y;
//		var _Bx = _edge[1,0]-_surf_x;
//		var _By = _edge[1,1]-_surf_y;
	
//		if(SignTest(_Ax,_Ay,_Bx,_By,_lxs[i]-_surf_x,_lys[i]-_surf_y) > 0) {
//			ProjectShadow(vBuffer, _Ax,_Ay,_Bx,_By,_lxs[i]-_surf_x,_lys[i]-_surf_y);
//		}
//	}

//	vertex_end(vBuffer);
//	vertex_submit(vBuffer,pr_trianglelist,-1);
	
//	if(i==0) {
//		for(var iWall = 0;iWall<instance_number(obj_collide);iWall++) {
//			var _wall = instance_find(obj_collide,iWall);
//			draw_rectangle(_wall.bbox_left-_surf_x,_wall.bbox_top-_surf_y,_wall.bbox_right-_surf_x,_wall.bbox_bottom-_surf_y,false);
//		}
//	}

//	gpu_set_colorwriteenable(true,true,true,true);
//	gpu_set_blendmode_ext(bm_dest_alpha,bm_one);
//	//gpu_set_blendmode(bm_add);

//	draw_sprite_stretched(spr_light_orange,0,_lxs[i]-256-_surf_x,_lys[i]-256-_surf_y,512,512)

//	gpu_set_colorwriteenable(false,false,false,true)
//	gpu_set_blendmode(bm_add);
//	draw_set_colour(c_black);
//	draw_rectangle(0,0,surf_w,surf_h,false);
//	gpu_set_blendmode(bm_subtract);
//	draw_set_alpha(0.7);
//	draw_rectangle(0,0,surf_w,surf_h,false);
//	draw_set_alpha(1);

//	gpu_set_blendmode(bm_normal);
//	gpu_set_colorwriteenable(true,true,true,true);
//}

//surface_reset_target();

//Local variables setup
if(view_current != 0) exit;
var _u_pos2 = u_pos2;
var _vb = vb;
var _vx = vx;
var _vy = vy;
var _vxScaled = _vx  * surf_scale;
var _vyScaled = _vy * surf_scale;
var _playerVar = obj_player.variant;

//Shadow surface setup
if (!surface_exists(shad_surf)){
	shad_surf = surface_create(surf_w_scaled,surf_h_scaled);
}

surface_set_target(shad_surf);
draw_clear_alpha(c_black,1);
for(var i=0;i<array_length(lights);i++) {
	if(i>0) {
		if(lights[i][2] != _playerVar || lights[i][0] > 640) continue;
	}
	//Draw the shadows (AKA light blockers)
	//gpu_set_blendmode_ext_sepalpha(bm_zero,bm_one,bm_one,bm_zero);
	gpu_set_colorwriteenable(0,0,0,1);
	if(i > 0) draw_rectangle(0,0,surf_w_scaled,surf_h_scaled,false);
	gpu_set_blendmode(bm_subtract);
	shader_set(shd_shadow);
	shader_set_uniform_f(_u_pos2,lights[i][0],lights[i][1]);
	vertex_submit(_vb,pr_trianglelist,-1);
	shader_reset();
	gpu_set_colorwriteenable(true,true,true,true);
	
	////Draw the Light - for meanings of the lights array stuff, see the room start event
	gpu_set_blendmode_ext(bm_dest_alpha,bm_one);
	draw_sprite_stretched(lights[i][4],0,lights[i][7]-_vxScaled,lights[i][8]-_vyScaled,lights[i][5],lights[i][6])
	
	gpu_set_colorwriteenable(false,false,false,true)
	gpu_set_blendmode(bm_add);
	
	draw_set_colour(c_black);
	draw_rectangle(0,0,surf_w_scaled,surf_h_scaled,false);
	gpu_set_blendmode(bm_subtract);
	draw_set_alpha(0.7);
	draw_rectangle(0,0,surf_w_scaled,surf_h_scaled,false);
	draw_set_alpha(1);

	gpu_set_blendmode(bm_normal);
	gpu_set_colorwriteenable(true,true,true,true);
	
}

surface_reset_target();

if(!surface_exists(surf_ping)) {
	surf_ping = surface_create(surf_w_scaled,surf_h_scaled);
}

if(!surface_exists(surf_pong)) {
	surf_pong = surface_create(surf_w_scaled,surf_h_scaled);
}

gpu_set_texfilter(true);
gpu_set_blendenable(false)

//1st pass: downscale
//shad_surf -> surf_ping
surface_set_target(surf_ping);
	draw_surface_stretched(shad_surf,0,0,surf_w_scaled,surf_h_scaled)
surface_reset_target();

//2nd pass: Blur horizontally
// surf_ping -> surf_pong
shader_set(blur_shader);
	//shader_set_uniform_f(u_blur_steps, blur_steps);
	//shader_set_uniform_f(u_sigma, sigma);
	shader_set_uniform_f(u_blur_vector, 1, 0);
	shader_set_uniform_f(u_texel_size, texel_w_scaled, texel_h_scaled);
	
	surface_set_target(surf_pong);
		draw_surface(surf_ping,0,0);
	surface_reset_target();
	
//3rd pass: Blur vertical
// surf_pong -> surf_ping
	shader_set_uniform_f(u_blur_vector, 0, 1);
	
	surface_set_target(surf_ping);
		draw_surface(surf_pong,0,0);
	surface_reset_target();
shader_reset();

//4th pass: Upscale
gpu_set_blendenable(true)
draw_surface_stretched(surf_ping,_vx,_vy,surf_w,surf_h);

gpu_set_texfilter(false);

//draw_surface(shad_surf,vx,vy)
