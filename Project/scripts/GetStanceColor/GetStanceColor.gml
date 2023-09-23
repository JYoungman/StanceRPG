// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetStanceColor(stance){
	switch(stance)
	{
		case enmStance.alpha:
		{
			return make_color_rgb(170,0,0);
			break;
		}
		case enmStance.beta:
		{
			return make_color_rgb(0,0,170);
			break;
		}
		case enmStance.gamma:
		{
			return make_color_rgb(239,99,255);
			break;
		}
	}
}