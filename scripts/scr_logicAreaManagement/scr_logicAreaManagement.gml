// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function compute(_gate){
	var _state;
	switch(_gate.gateType) {
		case gateTypes.IN:
			return _gate.storedValue;
		case gateTypes.OR:
			_state = false;
			break;
		case gateTypes.AND:
			_state = true;
			break;
	}
	for(var i=0;i<array_length(_gate.inputNodes);i++) {
		if(array_length(_gate.inputNodes[i].connectedNodes) == 0) return false;
		var _parent = _gate.inputNodes[i].connectedNodes[0].gateID;
		switch(_gate.gateType) {
			case gateTypes.OR:
				_state = _state || compute(_parent);
				break;
			case gateTypes.AND:
				_state = _state && compute(_parent);
				break;
			case gateTypes.OUT:
				_state = compute(_parent);
				break;
			case gateTypes.NOT:
				return !compute(_parent);
				break;
		}
	}
	return _state;
}
	
function deleteGate(_gate){
	deleteNodes(iid);
	instance_destroy(iid);
	exit;
}