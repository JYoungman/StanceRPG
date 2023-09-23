/// @description Insert description here
// You can write your code in this editor
if(hp > 0)
{
	if(player == true)
	{
		draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0, color, 1.0);
	}
	else
	{
		draw_sprite_ext(sprite_index, image_index, x, y, -1.0, 1.0, 0, color, 1.0);
	}
	
	//Shield
	var orientation = 1.0;
	var offset = 30;
	if(player == false)
	{
		orientation = -1.0;
		offset = -30;
	}
	
	draw_sprite_ext(auraShield, 0, x+offset, y, orientation*0.35, 0.35, 0, GetStanceColor(stance), 0.6);
}
else
{
	draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 180, color, 1.0);
}