// What happens when option is picked

var _closestDistance = 100000000;
var _closest = noone;
for(var i=0;i<array_length(options);i++) {
	var _distance = point_distance(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),options[i].x,options[i].y)
	if(_distance < _closestDistance) {
		_closestDistance = _distance;
		_closest = options[i];
	}
}

if(_closest != closestOption) {
	_closest.size = 4;
	for(var i=0;i<array_length(options);i++) {
		if(options[i] != _closest) {
			options[i].size = 2;
		}
	}
	closestOption = _closest;
}
	
if(mouse_check_button_pressed(mb_left)) {
	selectedType = _closest.gateType;
	with(logicArea) {
		gate = instance_create_layer(createX,createY,"Instances_Fore",obj_gate);
		gate.logicArea = id;
		with(gate) {
			gateType = logicArea.radialMenu.selectedType;
			var _numInputs;
			alignOuts = ALIGN_CENTRE;
			switch(gateType) {
				case gateTypes.OR:
					sprite_index = spr_orGate;
					alignIns = ALIGN_JUSTIFY;
					_numInputs = 2;
					break;
				case gateTypes.AND:
					sprite_index = spr_andGate;
					alignIns = ALIGN_JUSTIFY;
					_numInputs = 2;
					break;
				case gateTypes.NOT:
					sprite_index = spr_notGate;
					alignIns = ALIGN_CENTRE;
					_numInputs = 1;
					break;
			}
			
			inputNodes = createNodes(x,y,id,false,_numInputs);
			outputNodes = createNodes(x,y,id,true,1);
		}
	}
	for(var i=0;i<array_length(options);i++) {
		instance_destroy(options[i]);
	}
	instance_destroy(id);
	global.PAUSED = false;
}

// Cover any exit cases
if(keyboard_check_pressed(vk_escape) or keyboard_check_pressed(ord("E")) or keyboard_check_pressed(ord("Q")) or mouse_check_button_pressed(mb_right)) {
	for(var i=0;i<array_length(options);i++) {
		instance_destroy(options[i]);
	}
	instance_destroy(id);
	global.PAUSED = false;
}