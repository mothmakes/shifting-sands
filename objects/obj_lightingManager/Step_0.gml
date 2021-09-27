//Construct the vertex buffer with every wall
//Instead of using the four edges as the walls, we use the diagonals instead (Optimization)
vertex_begin(vb,vf);

//Create object deactivation system
with_tagged("opaque", function() {
	var _vb = obj_lightingManager.vb;
	Quad(_vb,x_scaled,y_scaled,x_scaled+sprite_width_scaled,y_scaled+sprite_height_scaled); //Negative Slope Diagonal Wall
	Quad(_vb,x_scaled+sprite_width_scaled,y_scaled,x_scaled,y_scaled+sprite_height_scaled); //Positive Slope Diagonal Wall
});
vertex_end(vb);


//view movement controls

