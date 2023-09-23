/// @description Insert description here
draw_set_color(c_white);
draw_set_font(fntBattleDisplay);

//Labels
draw_text(100, 100, "Use A/J to Select Three (3) Unique Units.");
draw_text(800, 100, "Selected Units:");
draw_text(800, 520, "Press X/U to start");
draw_set_color(c_white);

//Unit pool
for(var i = 0; i < ds_list_size(availableUnits); i++)
{
	var curUnit = ds_list_find_value(availableUnits, i);
	draw_set_font(fntBattleDisplay);
	draw_text(100, 150+(i*64),string(variable_instance_get(curUnit, "name")));
	draw_set_font(fntBattleDisplaySmall);
	draw_text(100, 175+(i*64),string(variable_instance_get(curUnit, "description")));
}

//Party
draw_set_color(c_orange);
draw_set_font(fntBattleDisplay);
for(var j = 0; j < ds_list_size(selectedParty); j++)
{
	var curUnit = ds_list_find_value(selectedParty, j);
	draw_text(800, 150+(j*64),string(variable_instance_get(curUnit, "name")));
}

//Indicator
if(selectionPool == true)
{
	draw_sprite_ext(selectionIcon, image_index, 64, 163+(selectionIdx*64), -1.0, 1.0, 1.0, c_orange, 1.0);
}
else
{
	draw_sprite_ext(selectionIcon, image_index, 764, 163+(selectionIdx*64), -1.0, 1.0, 1.0, c_orange, 1.0);
}