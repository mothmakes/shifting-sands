function ProjectShadow(_vBuffer, _Ax, _Ay, _Bx, _By, _Lx, _Ly) {
	
	// shadows are infinite - almost, just enough to go off screen
	var SHADOW_LENGTH = 20000;

	var Adx,Ady,Bdx,Bdy,len

	// get unit length to point 1
	Adx = _Ax-_Lx;      
	Ady = _Ay-_Ly;      
	len = SHADOW_LENGTH/sqrt( (Adx*Adx)+(Ady*Ady) );      // unit length scaler * Shadow length
	Adx = _Ax + Adx * len;
	Ady = _Ay + Ady * len;

	// get unit length to point 2
	Bdx = _Bx-_Lx;      
	Bdy = _By-_Ly;      
	len = SHADOW_LENGTH / sqrt( (Bdx*Bdx)+(Bdy*Bdy) );    // unit length scaler * Shadow length
	Bdx = _Bx + Bdx * len;
	Bdy = _By + Bdy * len;


	// now build a quad
	vertex_position(_vBuffer, _Ax,_Ay);
	vertex_argb(_vBuffer, $ff000000);
	vertex_position(_vBuffer, _Bx,_By);
	vertex_argb(_vBuffer, $ff000000);
	vertex_position(_vBuffer, Adx,Ady);
	vertex_argb(_vBuffer, $ff000000);

	vertex_position(_vBuffer, _Bx,_By);
	vertex_argb(_vBuffer, $ff000000);
	vertex_position(_vBuffer, Adx,Ady);
	vertex_argb(_vBuffer, $ff000000);
	vertex_position(_vBuffer, Bdx,Bdy);
	vertex_argb(_vBuffer, $ff000000);
}

function SignTest(_Ax,_Ay,_Bx,_By,_Lx,_Ly) {
	return ((_Bx - _Ax) * (_Ly - _Ay) - (_By - _Ay) * (_Lx - _Ax));
}
	
//Creates Quad with two triangles. Used to make the shadows. 
//Z coordinate is used as a flag to determine if the vertex will be repositioned in the shader
function Quad(_vb,_x1,_y1,_x2,_y2){
	
	//Upper triangle
	vertex_position_3d(_vb,_x1,_y1,0);
	vertex_position_3d(_vb,_x1,_y1,1); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,0);
	
	//Lower Triangle
	vertex_position_3d(_vb,_x1,_y1,1); //repositioned vertex
	vertex_position_3d(_vb,_x2,_y2,0);
	vertex_position_3d(_vb,_x2,_y2,1); //repositioned vertex
	
	//sdm(string(id) + ": (" + string(_x1) + ", " + string(_y1) + ") (" + string(_x2) + ", " + string(_y2) + ")")
}
	
function setLightX(_x,_id,_array) {
	for(var i=0;i<array_length(_array);i++) {
		if(_array[i][9] == _id) {
			_array[@ i][@ 0] = _x;
			_array[@ i][@ 7] = _array[i][0] - (_array[i][5] * SURF_SCALE);
			return;
		}
	}
	show_error("Error! Light does not seem to exist!", true);
}

function setLightY(_y,_id,_array) {
	for(var i=0;i<array_length(_array);i++) {
		if(_array[i][9] == _id) {
			_array[@ i][@ 1] = _y;
			_array[@ i][@ 8] = _array[i][1] - (_array[i][6] * SURF_SCALE);
			return;
		}
	}
	show_error("Error! Light does not seem to exist!", true);
}