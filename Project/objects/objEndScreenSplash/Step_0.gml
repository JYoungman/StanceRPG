/// @description Insert description here
// You can write your code in this editor
if(gamepad_button_check_released(0, gp_face1) or keyboard_check_released(ord("J")))
{
	room_goto(infoRoom);
}