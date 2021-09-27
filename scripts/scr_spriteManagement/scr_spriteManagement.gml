// FUNCTION: Returns whether object is in the past or present based on it's position.
function getObjectVariantByPos(_x,_y,_pastRect,_presentRect) {
	if inRectangle(_pastRect[0],_pastRect[1],[_x,_y]) { // If in region designated as the past, it's past.
		return global.PAST;
	} else if inRectangle(_presentRect[0],_presentRect[1],[_x,_y]) { // If in region designated as the present, it's present.
		return global.PRESENT;
	} else { // Else, throw an error
		show_error("Error! Variant object not in the timestream!", true);
	}
}

function getMappedImageIndex(_upper,_lower,_value,_start,_end) {
	var _smoothMap = map(_upper,_lower,_value,_start,_end)
	return round(_smoothMap);
}

function getPlayerAirFrame(_jumpsp,_termsp,_vsp) {
	return getMappedImageIndex(-_jumpsp,_termsp,_vsp,JUMP_START,JUMP_END);
}