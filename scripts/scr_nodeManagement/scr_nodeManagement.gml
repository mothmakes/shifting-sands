// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createNodes(_gateX,_gateY,_gateID,_isOutput,_number){
	nodes = [];
	for(var i=0;i<_number;i++) {
		var _nodeSprite;
		var _align;
		if(_isOutput) {
			_gateX += (_gateID.bbox_right-_gateID.bbox_left);
			_nodeSprite = spr_inputNode;
			_align = alignOuts;
		} else {
			_nodeSprite = spr_inputNode;
			_align = alignIns;
		}
		nodes[i] = instance_create_layer(_gateX,_gateY+spaceNodes(_gateID.sprite_index,_number,i,_align),"Instances",obj_node);
		nodes[i].gateID = _gateID;
		nodes[i].sprite_index = _nodeSprite;
		//nodes[i].depth = -100;
		nodes[i].isOutput = _isOutput;
	}
	
	return nodes;
}

function moveNodes(_newX,_newY,_gateID,_areOutputs,_nodes) {
	var _align;
	if(_areOutputs) {
		_align = _gateID.alignOuts;
	} else {
		_align = _gateID.alignIns;
	}
	for(var i=0;i<array_length(_nodes);i++) {
		_nodes[i].x = _newX;
		_nodes[i].y = _newY+spaceNodes(_gateID.sprite_index,array_length(_nodes),i,_align);
	}
}

function spaceNodes(_gateSprite,_totalNodes,_nodeIndex,_alignment) {
	var _gateHeight = sprite_get_bbox_bottom(_gateSprite) - sprite_get_bbox_top(_gateSprite);
	
	return (_nodeIndex + (_alignment>0)) * (_gateHeight / (_totalNodes + _alignment))
}

function deleteNodes(_gate) {
	for(var i=0;i<array_length(_gate.inputNodes);i++) {
		var _node = _gate.inputNodes[i];
		for(var j=0;j<array_length(_node.connectedNodes);j++) {
			array_delete_val(_node.connectedNodes[j].connectedNodes,_node);
		}
		instance_destroy(_gate.inputNodes[i]);
	}
	for(var i=0;i<array_length(_gate.outputNodes);i++) {
		var _node = _gate.outputNodes[i];
		for(var j=0;j<array_length(_node.connectedNodes);j++) {
			array_delete_val(_node.connectedNodes[j].connectedNodes,_node);
		}
		instance_destroy(_gate.outputNodes[i]);
	}
}