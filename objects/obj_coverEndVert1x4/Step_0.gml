if(linked != noone) {
	fade = linked.fade;
}

if(fade) {
	if(image_alpha <= 0) {
		instance_destroy();
	}
	image_alpha -= 0.035;
}