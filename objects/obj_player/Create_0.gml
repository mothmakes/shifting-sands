#region Init Graphical Variables
bboxOffset = bbox_bottom-y;
flooredW = floor(global.VIEW_WIDTH);
flooredH = floor(global.VIEW_HEIGHT);

halfViewWidth = flooredW/2;
halfViewHeight = flooredH/2;

camC = global.cameraCurrent;
camV = global.cameraVariant;

pastRect = obj_gameManager.pastRect;
presentRect = obj_gameManager.presentRect;

rectHeight = pastRect[1][1] - presentRect[1][1];

viewSurf = -1;
clipSurf = -1;
viewRadius = 0;
edgeRadius = 0;

BUBBLE_DISSIPATION_SPEED = 0.3;
BUBBLE_EXPANSION_SPEED = 0.02;
BUBBLE_SIZE_LIMIT = 1.3*halfViewWidth;

animStart = IDLE_START;
animEnd = IDLE_END;
#endregion

#region Related Objects
scarf = instance_create_depth(x,y,depth,obj_scarf);
variant = getObjectVariantByPos(x,y,pastRect,presentRect)
checkpoint = noone;
#endregion

#region Speed and Time
timeOfLastShift = current_time;
timeshiftCooldown = 500;

hsp = 0; // Horizontal movement speed
hsp_decimal = 0;
hsp_final = 0;

vsp = 0; // Vertical movement speed
vsp_decimal = 0;
vsp_final = 0;

fallStart = y;
#endregion

#region Player Properties
grvRatio = 1; // The proportion of gravity the player experiences relative to the global value - this immitates air resistance
grv = grvRatio * global.GRAVITY; // The actual gravity the player experiences
hres = 0.8; // Horizontal air resistance
walksp = 1.9; // Walk speed
jumpsp = 5.8; // Jump speed
walljumphsp = 5; // Wall jump horizontal boost speed
wallslidesp = 1;
termsp = 6; // Terminal velocity
jumpsMax = 2; // Maximum amount of jumps
jumps = jumpsMax; // Current number of jumps
jumpDynamicRatio = 0.35; // Ratio that the jump is decreased by for each step not held
dbjumpBoost = 0.5; // Extra jump height given for a double jump
dbjumpDelay = 0.1;
minWallJumpTime = 0.1;
maxWallJumpTime = 0.8;
deathDelay = 0.3;
face = 1;
staggerSpeedThresh = 6;
staggerDistThresh = TILE_SIZE * 6;
staggertime = 0.3;
standtime = 0.2;
#endregion

#region Booleans
printState = true;
minWallJumpTimeElapsed = true;
onWall = false;
inWater = false;
didJump = false;
wallJumping = false;
dbJumping = false;
disableInput = false;
qEnable = true;
eEnable = true;
#endregion

//Setup the state machine
state_machine_init();

//Define the states
state_create("Idle",player_state_idle);
state_create("Fall",player_state_fall);
state_create("Run",player_state_run);
state_create("Jump",player_state_jump);
state_create("Double Jump",player_state_db_jump);
state_create("Wall Slide",player_state_wall_slide);
state_create("Wall Jump",player_state_wall_jump);
state_create("Dead",player_state_dead);
state_create("Stagger",player_state_stagger);
state_create("Stand",player_state_stand);

//Set the default state
state_init("Idle");