var nearest = instance_nearest(bbox_right,bbox_bottom,obj_limestoneSubStep);
if(nearest != noone && nearest.activated == false && distance_to_object(nearest) < 6) {
	with(nearest) activate();
}