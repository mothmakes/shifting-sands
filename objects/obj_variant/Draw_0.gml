#region Draw correct part of sprite - depending on present or past

// Draws first half if present, second half if past (starts from 0*32 or 1*32 depending)
draw_sprite_part(sprite_index,image_index,variant*sprite_width/2,0,sprite_width/2,sprite_height,x,y);

#endregion