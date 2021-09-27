/// @desc

x = obj_player.x;
y = obj_player.y;

image_xscale = obj_player.image_xscale;
image_index = obj_player.image_index;
image_speed = obj_player.image_speed;

part_emitter_region(global.pSystem,global.pEmitter2,x-(32*image_xscale),x-(16*image_xscale),y-32,y-16,ps_shape_ellipse,ps_distr_gaussian);