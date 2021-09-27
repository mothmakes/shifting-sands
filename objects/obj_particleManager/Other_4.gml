/// @desc
global.pSystem = part_system_create_layer("Instances",true);
global.pEmitter1 = part_emitter_create(global.pSystem);
global.pEmitter2 = part_emitter_create(global.pSystem);
global.pTypeAmbient1 = part_type_create();
global.pTypeScarf = part_type_create();

#region pTypeAmbient1 Setup Functions

part_type_shape(global.pTypeAmbient1, pt_shape_flare);
part_type_size(global.pTypeAmbient1, 0.045,0.045,0,0);
part_type_speed(global.pTypeAmbient1,0.03,0.06,0,0);
part_type_direction(global.pTypeAmbient1,0,360,0,0);
part_type_color1(global.pTypeAmbient1,$bd6a62)
part_type_alpha3(global.pTypeAmbient1,0,1,0)
part_type_life(global.pTypeAmbient1,100,150);

#endregion

#region pTypeScarf

part_type_shape(global.pTypeScarf, pt_shape_pixel);
//part_type_size(global.pTypeScarf, 0.045,0.045,0,0);
part_type_speed(global.pTypeScarf,0.03,0.06,0,0);
part_type_direction(global.pTypeScarf,0,360,0,0);
part_type_color1(global.pTypeScarf,$92e8c0);
part_type_alpha3(global.pTypeScarf,0,1,0);
part_type_blend(global.pTypeScarf,true);
part_type_life(global.pTypeScarf,100,150);

#endregion

#region pEmitter1 Setup Functions

part_emitter_region(global.pSystem,global.pEmitter1,48,192,48,176,ps_shape_rectangle,ps_distr_linear);
part_emitter_stream(global.pSystem, global.pEmitter1, global.pTypeAmbient1, -6);

#endregion

#region pEmitter2

part_emitter_stream(global.pSystem, global.pEmitter2, global.pTypeScarf, -6);

#endregion