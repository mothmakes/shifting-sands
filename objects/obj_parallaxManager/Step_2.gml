/// @desc

var _cx = global.cameraCurrent.changeX;

var _b = ds_map_find_first(bg_map);
repeat(ds_map_size(bg_map)) {
	layer_x(_b, layer_get_x(_b) + bg_map[? _b] * _cx);
	_b = ds_map_find_next(bg_map, _b);
}
	