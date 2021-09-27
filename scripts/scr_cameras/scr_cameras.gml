// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function camera_swap_timestream(_camera,_cameraVariant,_cameraObj,_cameraVariantObj){
	
	_cameraObj.yTo = obj_player.y;
	if(_cameraObj.yTo<_cameraVariantObj.relyZero) {
		_cameraObj.yTo = _cameraVariantObj.relyZero;
	}
	_cameraObj.y += (power(-1,obj_player.variant)*rectHeight);
	
	camera_set_view_pos(_camera,_cameraObj.x-_cameraObj.xOffset,_cameraObj.y-_cameraObj.yOffset);

	_cameraVariantObj.yTo = obj_player.y - (power(-1,obj_player.variant)*rectHeight);
	if(_cameraVariantObj.yTo<_cameraObj.relyZero) {
		_cameraVariantObj.yTo = _cameraObj.relyZero;
	}
	_cameraVariantObj.y -= (power(-1,obj_player.variant)*rectHeight);
	
	camera_set_view_pos(_cameraVariant,_cameraVariantObj.x-_cameraVariantObj.xOffset,_cameraVariantObj.y-_cameraVariantObj.yOffset);
}