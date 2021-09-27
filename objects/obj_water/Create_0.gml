/// @desc
image_alpha = 0.5;
transparencyBufferHeight = 16;
wSurf = noone;
resizeSurf = noone;
shader = shdr_wave;
springCount = ceil(sprite_width/WATER_DIVISION);
springs[springCount] = 0;
springsVelocity[springCount] = 0;
springDeltaL[springCount] = 0;
springDeltaR[springCount] = 0;
k = 0.035;
d = 0.045;
spread = 0.18;

u_texelH_Wave = shader_get_uniform(shader,"texelH");
u_texelW_Wave = shader_get_uniform(shader,"texelW");
u_springCount = shader_get_uniform(shader,"springCount");
u_springs = shader_get_uniform(shader,"springs");
u_time = shader_get_uniform(shader,"time");

left = bbox_left;
top = bbox_top;
topBuffered = top - transparencyBufferHeight;
fullHeight = sprite_height+transparencyBufferHeight;

appScale = view_hport[0] / obj_gameManager.base_h;
appScaleRatio = 1/appScale;
scaledW = sprite_width * appScale;
scaledH = sprite_height * appScale;

texel_w = 1/sprite_width;//texture_get_texel_width(surface_get_texture(wSurf));
texel_h = 1/fullHeight;//texture_get_texel_height(surface_get_texture(wSurf));

tilemap = layer_tilemap_get_id(layer_get_id("Foreground_Tiles"));
tileset = tilemap_get_tileset(tilemap);