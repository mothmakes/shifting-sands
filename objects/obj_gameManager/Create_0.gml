#region Create Managers

#endregion

#region Views

show_debug_overlay(true);

view_enabled = true;
view_visible[0] = true;
view_visible[1] = true; // Timeshift bubble view

base_w = 640;
base_h = 360;
var max_w = display_get_width();
show_debug_message(max_w);
var max_h = display_get_height();
var aspect = display_get_width() / display_get_height();
if (max_w < max_h)
    {
    // portait
     var VIEW_WIDTH = min(base_w, max_w);
    var VIEW_HEIGHT = VIEW_WIDTH / aspect;
    }
else
    {
    // landscape
    var VIEW_HEIGHT = min(base_h, max_h);
    var VIEW_WIDTH = VIEW_HEIGHT * aspect;
    }
view_wport[0] = max_w;
view_hport[0] = max_h;
//view_wport[1] = max_w;
//view_hport[1] = max_h;
surface_resize(application_surface, view_wport[0], view_hport[0]);

depth = 0;

#endregion

#region Shader Setup

application_surface_draw_enable(false);

dark = false;

shader_day_night = shdr_dayAndNight;

shader_bloom_lum = shdr_bloom_filter_luminance;

shader_bloom_blur = shdr_bloom_blur_hardcoded;
u_blur_vector = shader_get_uniform(shader_bloom_blur,"blur_vector");
u_texel_size = shader_get_uniform(shader_bloom_blur,"texel_size");

shader_bloom_blend = shdr_bloom_blend;
//u_bloom_intensity = shader_get_uniform(shader_bloom_blend,"bloom_intensity");
u_bloom_texture = shader_get_sampler_index(shader_bloom_blend,"bloom_texture");
u_bloom_darken = shader_get_uniform(shader_bloom_blend,"bloom_darken");

darkness = 0.7; // 1.0 is less dark

surf_ping = -1;
surf_pong = -1;
surf_time = -1;

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

texel_w = 1 / gui_w;
texel_h = 1 / gui_h;

app_w = gui_w / 3;
app_h = gui_h / 3;

u_col = shader_get_uniform(shdr_dayAndNight, "col");
u_con_sat_brt = shader_get_uniform(shdr_dayAndNight, "con_sat_brt");

color_mix_night = a(030/255,	120/255,	225/255);
con_sat_brt_mix_night = a(0.60,	1.00,  -0.20,	0.80,	0.65);

#endregion

#region Load level data

var _file = file_text_open_read(room_get_name(room)+".json");
if(_file == -1) {
	show_error("Room not identified!", true);
}

var _json = "";
while !file_text_eof(_file) {
	_json += file_text_read_string(_file);
	file_text_readln(_file);
}

var _loadData = json_parse(_json);

show_debug_message(_loadData);

#endregion

#region Variables
global.PRESENT = 0;
global.PAST = 1;
global.WORLD_SPEED = 1;
global.GRAVITY = 0.34;
global.PAUSED = false;
global.VIEW_HEIGHT = VIEW_HEIGHT;
global.VIEW_WIDTH = VIEW_WIDTH;

global.CENTRE_PLAYER_X = sprite_get_xoffset(spr_player)
global.CENTRE_PLAYER_Y = sprite_get_yoffset(spr_player)

var _alignCentre = ALIGN_CENTRE;

scr_constants();

// Establishes the regions where the two timestreams are located, decides by room name.
// Will likely be updated to use parameters passed to gameManager on loading room.
presentRect = _loadData.presentRect;
pastRect = _loadData.pastRect;
cameraLocks = _loadData.cameraLocks;
cameraLocksEnabled = false;
currentCameraLock = 0;

#endregion

#region Create objects

screen_shake = instance_create_layer(0,0,"GUI",obj_screenshake);
screen_flash = instance_create_layer(0,0,"GUI",obj_screenflash);
screen_fade = instance_create_layer(0,0,"GUI",obj_screenfade);

doors = [];
logicAreas = [];

var _logicAreas = _loadData.logicAreas;
for(var i=0;i<array_length(_logicAreas);i++) {
	var _logicArea = _logicAreas[i];
	var _region = _logicArea.region;
	logicAreas[i] = instance_create_layer(_region[0,0],_region[0,1],"Instances",obj_logicArea);
	with(logicAreas[i]) {
		region = _region;
		var _inputs = _logicArea.inputs;
		var _outputs = _logicArea.outputs;
		
		testData = ds_map_create();
		testData[? "inputs"] = _inputs;
		testData[? "outputs"] = _outputs;
		
		// Create the input and output gates with nodes
		
		var _inGates = _logicArea.inGates;
		var _outGate = _logicArea.outGate;
		
		for(var j=0;j<array_length(_inGates);j++) {
			inGates[j] = instance_create_layer(region[0][0]+_inGates[j].relx,region[0][1]+_inGates[j].rely,"Instances",obj_gate);
			with(inGates[j]) {
				gateType = gateTypes.IN;
				sprite_index = spr_inGate;
				outputNodes = createNodes(x,y,id,true,1,_alignCentre);
			}
		}
		outGate = instance_create_layer(region[0][0]+_outGate.relx,region[0][1]+_outGate.rely,"Instances",obj_gate);
		with(outGate) {
			gateType = gateTypes.OUT;
			sprite_index = spr_outGate;
			inputNodes = createNodes(x,y,id,false,1,_alignCentre);
		}
	}
}

var _doors = _loadData.doors;
for(var i=0;i<array_length(_doors);i++) {
	var _door = _doors[i];
	doors[i] = instance_create_layer(_door[0],_door[1],"Instances_Fore",obj_door);
	doors[i].image_index = _door[2];
	array_push(logicAreas[_door[3]].connectedDevices,doors[i]);
}

global.cameraCurrent = instance_create_layer(0,0,"Managers",obj_camera);
global.cameraVariant = instance_create_layer(0,0,"Managers",obj_cameraVariant);
view_camera[0] = global.cameraCurrent.camera;//camera_create_view(0, 0, 640, 360, 0, noone, -1, -1, -1, -1);
view_camera[1] = global.cameraVariant.camera;//camera_create_view(0, 0, 640, 360, 0, noone, -1, -1, -1, -1);

// Create player object
var _playerStart = _loadData.playerStart;
player = instance_create_layer(_playerStart[0],_playerStart[1],"Player",obj_player);

#endregion

#region GUI setup
window_set_cursor(cr_none);
cursor_sprite = spr_cursor_normal;

function setCameraLockRegion(_constraintStart, _constraintEnd, _variant, _shared) {
	if(_variant || _shared) {
		global.cameraVariant.constraintStart = _constraintStart;
		global.cameraVariant.constraintEnd = _constraintEnd;
	}
	if(!_variant || _shared) {
		global.cameraCurrent.constraintStart = _constraintStart;
		global.cameraCurrent.constraintEnd = _constraintEnd;
	}
}

function setCameraLockIndex(_index) {
	currentCameraLock = _index;
	var _region = cameraLocks[_index];
	var _constraintStart = _region[0];
	var _constraintEnd = _region[1];
	var _variant = _region[2];
	var _shared = _region[3];
	setCameraLockRegion(_constraintStart, _constraintEnd, _variant, _shared);
}

function enableCameraLocks(_enable) {
	cameraLocksEnabled = _enable;
	if(_enable) {
		setCameraLockIndex(currentCameraLock);
	} else {
		setCameraLockRegion([0,0],[room_width,room_height],false,true);
	}
}

enableCameraLocks(true);

#endregion