/// @desc Save Event

// Make save array
var _saveData = array_create(0);

// For each instance, create a struct and add it to the array
// Replace with any saveable objects
with(obj_saveable) {
	var _saveEntity = 
	{
		obj : object_get_name(object_index),
		y : y,
		x : x,
	}
	array_push(_saveData, _saveEntity);
}

// Turn data into JSON string and save it via a buffer
var _string = json_stringify(_saveData);
var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer,"savedgame.save");
buffer_delete(_buffer);

show_debug_message("Game saved! " + _string);