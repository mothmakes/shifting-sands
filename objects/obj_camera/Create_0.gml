isVariant = false;
rectHeight = obj_gameManager.pastRect[1,1]-obj_gameManager.presentRect[1,1];

camera = camera_create_view(0, 0, floor(global.VIEW_WIDTH), floor(global.VIEW_HEIGHT), 0, noone, -1, -1, -1, -1);

halfViewWidth = floor(global.VIEW_WIDTH)/2;
halfViewHeight = floor(global.VIEW_HEIGHT)/2;

xOffset = halfViewWidth;
relxZero = xOffset;
relxRoomEnd = room_width - relxZero;

yOffset = halfViewHeight;
relyZero = yOffset;
relyRoomEnd = room_height - relyZero;

constraintStart = [0,0];
constraintEnd = [room_width,room_height];

follow = obj_player;

xTo = x;
yTo = y;

changeX = 0;
changeY = 0;

initDecelRatio = 0.04;
decelerateRatio = initDecelRatio;