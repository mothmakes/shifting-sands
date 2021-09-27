if(xTo<=(relxZero+constraintStart[0])) {
	xTo = relxZero+constraintStart[0];
} else if(xTo>=(constraintEnd[0]-relxZero)) {
	xTo = constraintEnd[0]-relxZero;
}
changeX = (xTo - x)*decelerateRatio;
x += changeX;

if(follow.variant) {
	relyZero = yOffset + (isVariant ? 0 : rectHeight);
} else {
	relyZero = yOffset + (isVariant ? rectHeight : 0);
}

if(yTo<=(relyZero-constraintStart[1])) {
	yTo = relyZero-constraintStart[1];
} else if(yTo>=(constraintEnd[1]-relyZero)) {
	yTo = constraintEnd[1]-relyZero;
}
changeY = (yTo - y)*decelerateRatio;
y += changeY;

if(follow != noone) {
	xTo = follow.x;
	if(isVariant) {
		yTo = follow.y+(power(-1,follow.variant)*rectHeight);
	} else {
		yTo = follow.y;
	}
}

camera_set_view_pos(camera,x-xOffset+obj_screenshake.xval,y-yOffset+obj_screenshake.yval);