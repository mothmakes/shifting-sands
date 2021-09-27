if(view_current != 0) exit;
draw_set_font(font);
draw_set_halign(align)
draw_set_colour(colour);

if(proximity && !proximityTriggered) {
	if(proximityHoriz && x_distance_to_instance(x,instance,true) <= proximityDist) {
		proximityTriggered = true;
	} else if(proximityVert && y_distance_to_instance(y,instance,true) <= proximityDist) {
		proximityTriggered = true;
	} else if (!proximityHoriz && !proximityVert && distance_to_object(object) <= proximityDist) {
		proximityTriggered = true;
	}
}

if(proximityTriggered) {
	opacity = lerp(opacity,1,fadeAmt);
}

if(fadeOut) {
	if(destructable && fadeTriggered && !proximityTriggered && opacity <= 0.01) {
		instance_destroy()
	} else if(fadeHoriz && x_distance_to_instance(x,instance,true) >= fadeDist) {
		opacity = lerp(opacity,0,fadeAmt);
		if(proximityTriggered) {
			fadeTriggered = true;
			proximityTriggered = false;
		}
	} else if(fadeVert && y_distance_to_instance(y,instance,true) >= fadeDist) {
		opacity = lerp(opacity,0,fadeAmt);
		if(proximityTriggered) {
			fadeTriggered = true;
			proximityTriggered = false;
		}
	} else if (!fadeHoriz && !fadeVert && distance_to_object(object) >= fadeDist) {
		opacity = lerp(opacity,0,fadeAmt);
		if(proximityTriggered) {
			fadeTriggered = true;
			proximityTriggered = false;
		}
	} else {
		fadeTriggered = false;
	}
}

if(proximity || fadeOut) {
	draw_set_alpha(opacity)
}

draw_text(x,y,text);

draw_set_alpha(1);