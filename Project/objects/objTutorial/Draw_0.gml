/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white);
draw_set_font(fntBattleDisplay);
draw_set_halign(fa_left);

draw_text(x-120, y, "Welcome to the stance system demo. Hopefully this inspires some ideas!");
draw_text(x-120, y+30, "The gray and yellow boxes show crit timing. If the boxes are all yellow, you'll crit.");
draw_text(x-120, y+60, "Using an ability will shift that unit into the stance that it does damage with.");
draw_text(x-120, y+90, "Units cannot be hurt by attacks from the stance they're in; they'll just whiff.");
draw_text(x-120, y+120, "You'll take more damage if your stamina falls to or below zero.");
draw_text(x-120, y+150, "Ability options are pretty sparse at the moment; this is just to validate the concept.");
draw_text(x-120, y+180, "Go, fight, win!.");

draw_set_halign(fa_center);
draw_text(x+400, y+250, "Press A Button or J Key to start the demo.");
draw_text(x+400, y+280, "Controls:");
draw_set_halign(fa_left);
draw_text(x+200, y+320, "Abilities/Confirm: A Button/J Key");
draw_text(x+200, y+350, "Items:                 X Button/U Key");
draw_text(x+200, y+380, "Back:                  B Button/K Key");
draw_text(x+200, y+410, "Shift Stance:       LB and RB/Y and I Keys");
draw_text(x+200, y+440, "Reset Demo:      Back Button/P Key");