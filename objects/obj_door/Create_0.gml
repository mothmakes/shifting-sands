// Which logic area is it linked to?
logicArea = noone;


// Does it start closed or open?
image_index = 0;
active = false;

image_speed = 0;

function toggle() {
	if(active) {
		deactivate();
	} else {
		activate();
	}
}
function activateExtra() {
	
}

function deactivateExtra() {
	
}

function activate() {
	image_speed = 1;
	sprite = spr_door;
	active = true;
	activateExtra();
}

function deactivate() {
	image_speed = 1;
	sprite = spr_door_reverse;
	active = false;
	deactivateExtra();
}