// FUNCTION: Returns if coordinate toCheck is between coord start and coord dest (a rectanglular region)
function inRectangle(_start,_dest,_toCheck){
	if _toCheck[0] >= _start[0] and _toCheck[0] < _dest[0] {
		if _toCheck[1] >= _start[1] and _toCheck[1] < _dest[1] {
			return true;
		}
	}
	
	return false;
}

function circularDistribute(_objectArray, _radius) {
	var _fraction = 360/array_length(_objectArray);
	for(var i=0;i<array_length(_objectArray);i++) {
		_objectArray[i].x += lengthdir_x(_radius,_fraction*i);
		_objectArray[i].y += lengthdir_y(_radius,_fraction*i);
	}
}