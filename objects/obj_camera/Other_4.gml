/// @desc

if(x<(relxZero-constraintStart[0])) {
	x = relxZero-constraintStart[0];
} else if(x>(constraintEnd[0]-relxZero)) {
	x = constraintEnd[0]-relxZero;
}

if(y<(relyZero-constraintStart[1])) {
	y = relyZero-constraintStart[1];
} else if(y>(constraintEnd[1]-relyZero)) {
	y = constraintEnd[1]-relyZero;
}

xTo = x;
yTo = y;