///// @desc

//collideableArray = [];
//cornersX = ds_list_create();
//cornersY = ds_list_create();
//directions = ds_list_create();
//numCorners = 0;

//rectHeight = obj_gameManager.pastRect[1,1]-obj_gameManager.presentRect[1,1];

//halfViewWidth = floor(global.VIEW_WIDTH)/2;
//halfViewHeight = floor(global.VIEW_HEIGHT)/2;

//surf_scale = 0.5;

//surf_w = view_wport[0];
//surf_h = view_hport[0];

//surf_w_scaled = round(surf_w*surf_scale);
//surf_h_scaled = round(surf_h*surf_scale);

//surf_xOffset = (halfViewWidth+global.CENTRE_PLAYER_X);
//surf_yOffset = (halfViewHeight+global.CENTRE_PLAYER_Y);

//surf = noone;
//surf_dscaleH = noone;
//surf_dscaleV = noone;

////Blur shader stuff

//blur_shader = shdr_blur_hardcoded;
//u_texel_size = shader_get_uniform(blur_shader,"texel_size");
//u_blur_vector = shader_get_uniform(blur_shader,"blur_vector");

//texel_w = 1 / surf_w;
//texel_h = 1 / surf_h;

//texel_w_scaled = texel_w/surf_scale;
//texel_h_scaled = texel_h/surf_scale;

//sigma = 0.5;
//blur_steps = 16;
//blur_opacity = 0.45;

//// TODO: Watch out for view_wport only being accessed at start of room!!!!! May be problems with window resize later!
//outOfViewDist = 300;//(sqrt(power(view_wport[0],2)+power(view_hport[0],2))/2);

//// For every collideable wall:
//// - For each tile between top and bottom bbox
//// - - For each tile between left and right bbox
//// - - - Create a obj_tiledCollide
//total = 0;

//var i = 0;
//while(instance_find(obj_collide,i)!=noone) {
//	var _collide = instance_find(obj_collide,i);
	
//	//show_debug_message(_collide.bbox_left % 32)
//	//show_debug_message(floor(_collide.bbox_right+1) % 32)
	
//	for(var yy=floor(_collide.bbox_top);yy<floor(_collide.bbox_bottom);yy+=TILE_SIZE) {
//		for(var xx=floor(_collide.bbox_left);xx<floor(_collide.bbox_right);xx+=TILE_SIZE) {
//			//show_debug_message(xx % 32);
//			//show_debug_message(yy % 32);
//			collideableArray[total] = instance_create_layer(xx,yy,"Managers",obj_tiledCollide);
//			total++;
//		}
//	}
	
//	i++;
//}

//show_debug_message(collideableArray);
//show_debug_message(array_length(collideableArray));
//show_debug_message("Total: " + string(total));

//#region Find corners of collidable objects

//// For every object:
//// - Check to see which sides have instances adjacent to them
//// - Determine what corners the object has that are not just adjacent corners (so edges)
//// - Also check for folds

//for(var i=0;i<array_length(collideableArray);i++) {
//	var _obj = collideableArray[i];
	
//	with(_obj) {
//		var _adjTop = place_meeting(x,y-1,obj_tiledCollide);
//		var _adjBot = place_meeting(x,y+1,obj_tiledCollide);
	
//		var _adjLeft = place_meeting(x-1,y,obj_tiledCollide);
//		var _adjRight = place_meeting(x+1,y,obj_tiledCollide);
//	}
	
//	// Top right
//	if(!_adjTop && !_adjRight || (_adjTop && _adjRight && !position_meeting(_obj.bbox_right+5,_obj.bbox_top-5,obj_tiledCollide))) {
//		ds_list_add(cornersX,floor(_obj.bbox_right+1));
//		ds_list_add(cornersY,_obj.bbox_top);
//		numCorners++;
		
//		if(!_adjTop && !_adjRight) {
//			ds_list_add(directions,edgeDirs.DOWN);
//		} else {
//			ds_list_add(directions,edgeDirs.FRIGHT);	
//		}
//	}
	
//	// Top left
//	if(!_adjTop && !_adjLeft || (_adjTop && _adjLeft && !position_meeting(_obj.bbox_left-5,_obj.bbox_top-5,obj_tiledCollide))) {
//		ds_list_add(cornersX,_obj.bbox_left);
//		ds_list_add(cornersY,_obj.bbox_top);
//		numCorners++;
		
//		if(!_adjTop && !_adjLeft) {
//			ds_list_add(directions,edgeDirs.RIGHT);
//		} else {
//			ds_list_add(directions,edgeDirs.FUP);	
//		}
//	}
	
//	// Bottom right
//	if(!_adjBot && !_adjRight || (_adjBot && _adjRight && !position_meeting(_obj.bbox_right+5,_obj.bbox_bottom+5,obj_tiledCollide))) {
//		ds_list_add(cornersX,floor(_obj.bbox_right+1));
//		ds_list_add(cornersY,floor(_obj.bbox_bottom+1));
//		numCorners++;
		
//		if(!_adjBot && !_adjRight) {
//			ds_list_add(directions,edgeDirs.LEFT);
//		} else {
//			ds_list_add(directions,edgeDirs.FDOWN);	
//		}
//	}
	
//	// Bottom left
//	if(!_adjBot && !_adjLeft || (_adjBot && _adjLeft && !position_meeting(_obj.bbox_left-5,_obj.bbox_bottom+5,obj_tiledCollide))) {
//		ds_list_add(cornersX,_obj.bbox_left);
//		ds_list_add(cornersY,floor(_obj.bbox_bottom+1));
//		numCorners++;
		
//		if(!_adjBot && !_adjLeft) {
//			ds_list_add(directions,edgeDirs.UP);
//		} else {
//			ds_list_add(directions,edgeDirs.FLEFT);
//		}
//	}
//}

//// For every corner
//// - Get a list of all the corners whose Y is the same, and whose direction comes before the current corners direction
//// - Get closest corner in that list
//// - Add pair to edge list

//edges = ds_list_create();

//for(var i=0;i<ds_list_size(cornersX);i++) {
//	var _cornerX = cornersX[| i];
//	var _cornerY = cornersY[| i];
//	var _direction = directions[| i];
	
//	var _matches = [];
	
//	//show_debug_message([_cornerX,_cornerY]);
	
//	for(var j=0;j<ds_list_size(cornersX);j++) {
//		var _preReq = false;
		
//		if(cornersX[| j] == _cornerX) {
//			if((_direction == edgeDirs.UP || _direction == edgeDirs.FUP) && _cornerY > cornersY[| j] && (directions[| j] == edgeDirs.FLEFT || directions[| j] == edgeDirs.RIGHT)) _preReq = true;
			
//			if((_direction == edgeDirs.DOWN || _direction == edgeDirs.FDOWN) && _cornerY < cornersY[| j] && (directions[| j] == edgeDirs.LEFT || directions[| j] == edgeDirs.FRIGHT)) _preReq = true;
//		}
//		if(cornersY[| j] == _cornerY) {
//			//show_debug_message([cornersX[| j], cornersY[| j]]);
//			//show_debug_message(_direction);
//			if((_direction == edgeDirs.RIGHT || _direction == edgeDirs.FRIGHT) && _cornerX < cornersX[| j] && (directions[| j] == edgeDirs.FUP || directions[| j] == edgeDirs.DOWN)) _preReq = true;
			
//			if((_direction == edgeDirs.LEFT || _direction == edgeDirs.FLEFT) && _cornerX > cornersX[| j] && (directions[| j] == edgeDirs.UP || directions[| j] == edgeDirs.FDOWN)) _preReq = true;
//		}
		
//		if(_preReq) {// && (cornersX[| j] == _cornerX xor cornersY[| j] == _cornerY)) {
//			array_push(_matches,[cornersX[| j], cornersY[| j]]);
//			//show_debug_message([cornersX[| j], cornersY[| j]]);
//		}
//	}
	
//	var _closest = [];
//	var _closestDist = 1000000000;
	
//	for(var j=0;j<array_length(_matches);j++) {
//		var _match = _matches[j];
//		var _dist = point_distance(_cornerX,_cornerY,_match[0],_match[1])
//		if(_dist <= _closestDist && !array_equals(_match,[_cornerX,_cornerY])) {
//			_closest = _match;
//			_closestDist = _dist;
//		}
//	}
//	if(array_length(_matches) == 0) show_debug_message([_cornerX,_cornerY]);
	
//	ds_list_add(edges,[[_cornerX,_cornerY],_closest]);
	
//	//show_debug_message(_closest);
//	//show_debug_message(ds_list_size(_matches));
	
//	//show_error("hmm",true);
//}
//show_debug_message("Corners: " + string(ds_list_size(cornersX)));
//show_debug_message("Edges: " + string(ds_list_size(edges)));

//#endregion

//vertex_format_begin();
//vertex_format_add_position();
//vertex_format_add_color();
//vFormat = vertex_format_end();

//vBuffer = vertex_create_buffer();

//range = 256;

//lEdges = [[]];
//lxs = [];
//lys = [];
//lxs[0] = noone;
//lys[0] = noone;

//var tmp = [];
//for(var j=0;j<ds_list_size(edges);j++) {
//	var edge = edges[| j];
		
//	array_push(tmp,edge);
//}
//lEdges[0] = tmp;

//var i = 1;
//while(instance_find(obj_light,i)!=noone) {
//	var _inst = instance_find(obj_light,i);
//	lxs[i] = _inst.x;
//	lys[i] = _inst.y;
//	var tmp = [];
//	for(var j=0;j<ds_list_size(edges);j++) {
//		var edge = edges[| j];

//		if(point_distance(edge[0,0],edge[0,1],lxs[i],lys[i]) <= range || point_distance(edge[1,0],edge[1,1],lxs[i],lys[i]) <= range) {
//			array_push(tmp,edge);
//		}
//	}
//	lEdges[i] = tmp;
//	i++;
//}

//instance_destroy(obj_tiledCollide);



//// TODO:
//// Filter edges to get edges in radius for optimisation

//view coordinates
vx = 0;
vy = 0;

surf_scale = SURF_SCALE;

//lightSpriteScaled = sprite_ * surf_scale;

//Shader uniform variable setup
u_pos2 = shader_get_uniform(shd_shadow,"u_pos");

//Vertex format and buffer setup
vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer();

//shadow surface variable declaration
shad_surf = noone;

halfViewWidth = floor(global.VIEW_WIDTH)/2;
halfViewHeight = floor(global.VIEW_HEIGHT)/2;

surf_w = view_wport[0];
surf_h = view_hport[0];

surf_xOffset = (halfViewWidth+global.CENTRE_PLAYER_X);
surf_yOffset = (halfViewHeight+global.CENTRE_PLAYER_Y);


surf_w_scaled = round(surf_w*surf_scale);
surf_h_scaled = round(surf_h*surf_scale);

surf_ping = noone;
surf_pong = noone;

//Blur shader stuff

blur_shader = shdr_blur_hardcoded;
u_texel_size = shader_get_uniform(blur_shader,"texel_size");
u_blur_vector = shader_get_uniform(blur_shader,"blur_vector");

texel_w = 1 / surf_w;
texel_h = 1 / surf_h;

texel_w_scaled = texel_w/surf_scale;
texel_h_scaled = texel_h/surf_scale;