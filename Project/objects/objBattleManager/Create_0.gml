/// @description Insert description here
// You can write your code in this editor

//Units
player_x = 350;
enemy_x = 960;

unitList = ds_list_create();

//Items
inventory = ds_map_create();

//UI
subMenuIdx = 0;
subMenuCount = 0;
selectedItem = noone;
subMenuItems = noone;

turn = 1;
turnColor = make_color_rgb(128, 128, 221);