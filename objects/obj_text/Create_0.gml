text = "";
colour = c_white;
font = font_alagard;
align = fa_center;
proximity = false;
proximityHoriz = false;
proximityVert = false;
proximityDist = TILE_SIZE;
proximityTriggered = false;
fadeOut = false;
fadeHoriz = false;
fadeVert = false;
fadeDist = proximityDist;
fadeTriggered = false;
opacity = 0;
fadeAmt = 0.03;
object = obj_player;
instance = object.id;
destructable = true;

function activate() {
	proximity = true;
	proximityTriggered = true;
}