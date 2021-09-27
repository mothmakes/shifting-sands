/// @desc

//IMPORTANT: MAKE SURE TO UPDATE ALL NECESSARY PARTS WHEN CHANGING A LIGHTS POSITION: MAKE FUNCTION

for(var i=0;i<instance_number(obj_light);i++) {
	var _light = instance_find(obj_light,i);
	lights[i][0] = _light.x * surf_scale; //Light x
	lights[i][1] = _light.y * surf_scale; // Light y
	lights[i][2] = _light.variant; //Light variant
	lights[i][3] = _light.scale; //Light Scale
	lights[i][4] = _light.sprite; //Light Sprite
	lights[i][5] = sprite_get_width(lights[i][4]) * lights[i][3] * surf_scale; //Light Width Adjusted
	lights[i][6] = sprite_get_height(lights[i][4]) * lights[i][3] * surf_scale; //Light Height Adjusted
	lights[i][7] = lights[i][0] - (lights[i][5] * surf_scale); //Light X Offset Adjusted
	lights[i][8] = lights[i][1] - (lights[i][6] * surf_scale); //Light Y Offset Adjusted
	lights[i][9] = _light.id;
}