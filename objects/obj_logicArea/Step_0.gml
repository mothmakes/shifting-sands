if(global.PAUSED) {
	exit;
}

#region Control Cursor Sprite

if(inRectangle(region[0],region[1],[mouse_x,mouse_y])) {
	// TODO: Base mouse offset off of current offset
	var _gateHeight = sprite_get_bbox_bottom(spr_orGate) - sprite_get_bbox_top(spr_orGate);
	var _gateWidth = sprite_get_bbox_right(spr_orGate) - sprite_get_bbox_left(spr_orGate);
	
	cursor_sprite = spr_cursor_logic;
	cursorLeft = false;
	
	// (PICKUP)
	if(mouse_check_button_pressed(mb_left)) {
		// Gets the id of the gate under the mouse
		iid = instance_position(mouse_x,mouse_y,obj_gate);
		
		if(iid != noone) {
			mouseClicks += 1;
			alarm[0] = room_speed * 1;
			
			mouseOffsetX = mouse_x-iid.x;
			mouseOffsetY = mouse_y-iid.y;
			
			if(mouseClicks == 2) {
				deleteGate(iid);
			}
		}
		iidNode = instance_position(mouse_x,mouse_y,obj_node);
	}
	
	// (DRAG)
	if(mouse_check_button(mb_left)) {
		// If there is a gate under the mouse
		if(instance_exists(iid) && iid != noone && iid.gateType != gateTypes.IN && iid.gateType != gateTypes.OUT && iidNode == noone) {
			// Set it's position equal to the mouse value, offset (DRAG)
			var _proposedRectangle = [mouse_x-mouseOffsetX-nodeSprSize,mouse_y-mouseOffsetY-nodeSprSize,mouse_x-mouseOffsetX+_gateWidth+nodeSprSize,mouse_y-mouseOffsetY+_gateHeight+nodeSprSize]
			if(rectangle_in_rectangle(_proposedRectangle[0],_proposedRectangle[1],_proposedRectangle[2],_proposedRectangle[3],region[0][0],region[0][1],region[1][0],region[1][1])==1) {
				iid.x = mouse_x-mouseOffsetX;
				iid.y = mouse_y-mouseOffsetY;
				moveNodes(iid.x,iid.y,iid,false,iid.inputNodes);
				moveNodes(iid.x+(iid.bbox_right-iid.bbox_left),iid.y,iid,true,iid.outputNodes);
				
				
			} else {
				// Deselects gate if mouse exits area.
				//iid = noone;
			}
		} else if (iidNode != noone) {
			drawCoords = [[iidNode.x,iidNode.y],[mouse_x,mouse_y]];
			drawConnector = true;
		}
	}
	
	// (DROP)
	if(mouse_check_button_released(mb_left)) {
		drawConnector = false;
		mouseOffsetX = 1;
		mouseOffsetY = 1;
		iidNodeToConnect = instance_position(mouse_x,mouse_y,obj_node);
		if(iidNode != noone) {
			if(iidNodeToConnect != noone && iidNodeToConnect != iidNode) {
				if(iidNodeToConnect.gateID != iidNode.gateID) {
					if(iidNodeToConnect.isOutput xor iidNode.isOutput) {
						array_push(iidNodeToConnect.connectedNodes,iidNode);
						array_push(iidNode.connectedNodes,iidNodeToConnect);
					}
				}
			}
		}
	}
	
	// (CREATE GATES WITHIN REGION)
	if(mouse_check_button_pressed(mb_right)) {
		var _proposedRectangle = [mouse_x-nodeSprSize,mouse_y-nodeSprSize,mouse_x+_gateWidth+nodeSprSize,mouse_y+_gateHeight+nodeSprSize]
		switch(rectangle_in_rectangle(_proposedRectangle[0],_proposedRectangle[1],_proposedRectangle[2],_proposedRectangle[3],region[0][0],region[0][1],region[1][0],region[1][1])) {
			case 0:
				createX = region[0][0] + nodeSprSize;
				createY = region[0][1] + nodeSprSize;
				break;
			case 1:
				createX = mouse_x;
				createY = mouse_y;
				break;
			case 2:
				if(_proposedRectangle[0]<region[0][0]) {
					if(_proposedRectangle[1]<region[0][1]) {
						createY = region[0][1] + nodeSprSize;
					} else if (_proposedRectangle[3]>region[1][1]) {
						createY = region[1][1] - _gateHeight - nodeSprSize;
					} else {
						createY = mouse_y;
					}
					createX = region[0][0] + nodeSprSize;
				} else if(_proposedRectangle[2]>region[1][0]) {
					if(_proposedRectangle[1]<region[0][1]) {
						createY = region[0][1] + nodeSprSize;
					} else if (_proposedRectangle[3]>region[1][1]) {
						createY = region[1][1] - _gateHeight - nodeSprSize;
					} else {
						createY = mouse_y;
					}
					createX = region[1][0] - _gateWidth - nodeSprSize;
				} else if(_proposedRectangle[1]<region[0][1]) {
					createX = mouse_x;
					createY = region[0][1] + nodeSprSize;
				} else if(_proposedRectangle[3]>region[1][1]) {
					createX = mouse_x;
					createY = region[1][1] - _gateHeight - nodeSprSize;
				}
		}
		radialMenu = instance_create_layer(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),"GUI",obj_radialGateMenu);
		radialMenu.logicArea = id;
	}
} else if (cursorLeft == false) {
	cursor_sprite = spr_cursor_normal;
	drawConnector = false;
	cursorLeft = true;
}

if(keyboard_check_pressed(ord("R"))) {
	// Get inputs array
	var _inputs = testData[? "inputs"];
	var _outputs = testData[? "outputs"];
	var _correct = true;
	
	// Perform test on each row of truth table
	for(var i=0;i<array_length(_inputs);i++) {
		var _row = _inputs[i];
		
		// Initialise inputs with correct test data
		for(var j=0;j<array_length(_row);j++) {
			inGates[j].storedValue = _row[j];	
		}
		
		// Compute based on inputs and compare outputs
		var _result = compute(outGate);
		show_debug_message("Result of test: " + string(_result));
		
		_correct = _correct and (_result == _outputs[i]);
	}
	show_debug_message("Is correct: " + string(_correct));
	
	if(_correct) {
		for(var i=0;i<array_length(connectedDevices);i++) {
			with(connectedDevices[i]) activate();
		}
	} else {
		for(var i=0;i<array_length(connectedDevices);i++) {
			with(connectedDevices[i]) deactivate();
		}
	}
}

#endregion