// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function a(){
	var arr;
	for(var i=0;i<argument_count;i++) {
		arr[i] = argument[i];
	}
	return arr;
}

function sdm(_string) {
	show_debug_message(_string);	
}

function array_delete_val(_array,_val) {
	for(var i=0;array_length(_array);i++) {
		if(_array[i] == _val) {
			array_delete(_array,i,1);	
		}
	}
}

/// smoothstep(a,b,x)
//
//  Returns 0 when (x < a), 1 when (x >= b), a smooth transition
//  from 0 to 1 otherwise, or (-1) on error (a == b).
//
//      a           upper bound, real
//      b           lower bound, real
//      x           value, real
//
/// GMLscripts.com/license
function smoothstep(_a,_b,_x) {
    var p;
    if (_x < _a) return 0;
    if (_x >= _b) return 1;
    if (_a == _b) return -1;
    p = (_x - _a) / (_b - _a);
    return (p * p * (3 - 2 * p));
}

function step(_a,_b,_x) {
    var p;
    if (_x < _a) return 0;
    if (_x >= _b) return 1;
    if (_a == _b) return -1;
    p = (_x - _a) / (_b - _a);
    return p;
}

/// smoothmap(a,b,x,start,end)
// Returns a value within the space provided by start and end, that is smoothly interpolated between the upper
// and lower bounds. Maps a value in the bounds to a value in the space.
//
// a			upper bound, real
// b			lower bound, real
// x			value, real
// start	space start, real
// end	space end, real
function smoothmap(_upper,_lower,_x,_spaceStart,_spaceEnd) {
	var _spaceSize = abs(_spaceEnd - _spaceStart);
	var _scaledValue = smoothstep(_upper,_lower,_x) * _spaceSize;
	return _scaledValue + _spaceStart;
}

function map(_upper,_lower,_x,_spaceStart,_spaceEnd) {
	var _spaceSize = abs(_spaceEnd - _spaceStart);
	var _scaledValue = step(_upper,_lower,_x) * _spaceSize;
	return _scaledValue + _spaceStart;
}

/// @function with_tagged(tag, lambda)
/// @param tag The tag or array of tags to operate on
/// @param lambda An inline function to be run
/// Applies the lambda function provided to every instance with a given tag
function with_tagged(tag, lambda) {
	var tagged = tag_get_asset_ids(tag, asset_object);
	for (var i = 0; i < array_length(tagged); i++) {
		with (tagged[i]) {
			var boundMethod = method(self, lambda);
			boundMethod();
		}
	}
}
	
function x_distance_to_instance(_x,_inst,_useMask) {
	if(!_useMask) {
		return abs(_x - _inst.x);
	} else {
		return min(abs(_x - _inst.bbox_left),abs(_x - _inst.bbox_right));
	}
}

function y_distance_to_instance(_y,_inst,_useMask) {
	if(!_useMask) {
		return abs(_y - _inst.y);
	} else {
		return min(abs(_y - _inst.bbox_top),abs(_y - _inst.bbox_bottom));
	}
}