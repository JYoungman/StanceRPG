/// @description Insert description here

// -------------------- Draw frames --------------------
draw_set_alpha(0.2);
DrawBox(0, 570, 1280, 150, c_black);
DrawBox(0, 0, 200, 570, c_black);
DrawBox(1280, 0, -200, 570, c_black);
draw_set_alpha(1.0);

// -------------------- Draw timeline --------------------
draw_set_font(fntBattleDisplay);
draw_set_halign(fa_right);
draw_text_color(x+1235, y+25, "Round: "+string(turn), c_white, c_white, c_white, c_white, 1.0);
DrawBox(x+1145, y+62, 70, 75, turnColor);

var unitCount = ds_list_size(unitList);
var timelineStartY = y+100;
var curTimelineIcon = 0;

draw_set_font(fntBattleDisplaySmall);
draw_set_halign(fa_center);
draw_set_color(c_white);

for(var i = turnIdx; i < unitCount; i++)
{
	var curSprite = ds_list_find_value(unitList, i);
	if(curSprite.hp > 0)
	{
		if(curSprite.player == true)
		{
			draw_sprite_ext(curSprite.sprite_index, curSprite.image_index, x+1180, timelineStartY+(80*curTimelineIcon), 0.5, 0.5, 0, curSprite.color, 1.0);
		}
		else
		{
			draw_sprite_ext(curSprite.sprite_index, curSprite.image_index, x+1180, timelineStartY+(80*curTimelineIcon), -0.5, 0.5, 0, curSprite.color, 1.0);
		}
		draw_text(x+1180, timelineStartY+16+(80*curTimelineIcon), curSprite.displayName);
		curTimelineIcon++;
	}
}

draw_set_font(fntBattleDisplay);

// -------------------- Unit vitals --------------------
for(i = 0; i < unitCount; i++)
{
	var curUnit = ds_list_find_value(unitList, i);
	var curHPcolor = c_white;
	var curSPcolor = c_white;
	
	if((curUnit.maxHP * .2) > curUnit.hp)
	{
		if(curUnit.hp == 0)
		{
			curHPcolor = c_red;
		}
		else
		{
			curHPcolor = c_yellow;
		}
	}
	
	if((curUnit.maxStamina * .2) > curUnit.stamina)
	{
		if(curUnit.stamina < 1)
		{
			curSPcolor = c_red;
		}
		else
		{
			curSPcolor = c_yellow;
		}
	}
	
	draw_set_halign(fa_left);
	
	//Display stats
	if(curUnit.player)
	{
		draw_text_color(x+30, curUnit.y-36, string(curUnit.displayName), c_white, c_white, c_white, c_white, 1.0);
		draw_text_color(x+30, curUnit.y-12, "HP: "+string(curUnit.hp)+"/"+string(curUnit.maxHP), curHPcolor, curHPcolor, curHPcolor, curHPcolor, 1.0);
		draw_text_color(x+30, curUnit.y+12, "SP: "+string(curUnit.stamina)+"/"+string(curUnit.maxStamina), curSPcolor, curSPcolor, curSPcolor, curSPcolor, 1.0);
		draw_text_color(x+30, curUnit.y+36, StanceToString(curUnit.stance), GetStanceColor(curUnit.stance), GetStanceColor(curUnit.stance), GetStanceColor(curUnit.stance), GetStanceColor(curUnit.stance), 1.0);
	}
	else
	{
		draw_text_color(curUnit.x-230, curUnit.y-36, string(curUnit.displayName), c_white, c_white, c_white, c_white, 1.0);
		draw_text_color(curUnit.x-230, curUnit.y-12, "HP: "+string(curUnit.hp)+"/"+string(curUnit.maxHP), c_white, c_white, c_white, c_white, 1.0);
		draw_text_color(curUnit.x-230, curUnit.y+12, "SP: "+string(curUnit.stamina)+"/"+string(curUnit.maxStamina), c_white, c_white, c_white, c_white, 1.0);
		
		draw_text_color(curUnit.x-230, curUnit.y+36, StanceToString(curUnit.stance), GetStanceColor(curUnit.stance), GetStanceColor(curUnit.stance), GetStanceColor(curUnit.stance), GetStanceColor(curUnit.stance), 1.0);
		draw_sprite_ext(selectionIcon, image_index, curUnit.x-195, curUnit.y+50, -0.5, 0.5, 1.0, c_white, 1.0);
		if(curUnit.nextAbility == noone)
		{
			draw_text_color(curUnit.x-180, curUnit.y+36, "?", c_white, c_white, c_white, c_white, 1.0);
		}
		else
		{
			draw_text_color(curUnit.x-180, curUnit.y+36, StanceToString(curUnit.nextAbility.stance), GetStanceColor(curUnit.nextAbility.stance), GetStanceColor(curUnit.nextAbility.stance), GetStanceColor(curUnit.nextAbility.stance), GetStanceColor(curUnit.nextAbility.stance), 1.0);
		}
	}
	
	//Crit meter
	if(curUnit.player)
	{
		for(var j = 0; j < curUnit.nextCritRound; j++)
		{
			var blockColor = c_gray;
			if(j < curUnit.critRoundCounter)
			{
				blockColor = c_yellow;
			}
			DrawBox(x+72+(12*j), curUnit.y+46, 10, 10, blockColor);
		}
	}
	
	//Status effects
	if(ds_map_size(curUnit.statusEffects) > 0)
	{
		baseIcons = GetBaseSprites(curUnit.statusEffects);
		maskIcons = GetMaskSprites(curUnit.statusEffects);
		var icons = ds_list_size(baseIcons);
		var offset = 48;
		if (curUnit.player)
		{
			offset = -48;
		}
		
		for(var k = 0; k < icons; k++)
		{
			draw_sprite(ds_list_find_value(baseIcons, k), image_index, curUnit.x+offset, curUnit.y-48+(k*24));
			draw_sprite(ds_list_find_value(maskIcons, k), image_index, curUnit.x+offset, curUnit.y-48+(k*24));
		}
		
		ds_list_destroy(baseIcons);
		ds_list_destroy(maskIcons);
	}
}

switch(uiState)
{
	//Draw turn options if it is the turn of a player unit
	case enmBattleUIState.playerTurn:
	{
		draw_sprite_ext(selectionIcon, image_index, activeUnit.x + 80, activeUnit.y, 1.0, 1.0, 1.0, c_orange, 1.0);
	
		draw_set_halign(fa_left);
		if(activeUnit.stamina > 0)
		{
			draw_sprite_ext(buttonA, image_index, x+490, y+665, 0.75, 0.75, 1.0, c_white, 1.0);
			draw_text_color(x+510, y+650, "/J - Abilities", c_white, c_white, c_white, c_white, 1.0);
		}
		else
		{
			draw_sprite_ext(buttonA, image_index, x+490, y+665, 0.75, 0.75, 1.0, c_ltgray, 1.0);
			draw_text_color(x+510, y+650, "/J - Abilities", c_ltgray, c_ltgray, c_ltgray, c_ltgray, 1.0);
		}
		draw_sprite_ext(buttonX, image_index, x+490, y+635, 0.75, 0.75, 1.0, c_white, 1.0);
		draw_text_color(x+510, y+620, "/U - Items", c_white, c_white, c_white, c_white, 1.0);
		
		draw_sprite_ext(buttonB, image_index, x+680, y+650, 0.75, 0.75, 1.0, c_white, 1.0);
		draw_text_color(x+700, y+635, "/K - Skip", c_white, c_white, c_white, c_white, 1.0);
	
		var lStance;
		var rStance;
		var lColor;
		var rColor;
	
		if(activeUnit.stance = enmStance.alpha)
		{
			lStance = "B";
			rStance = "G";
			lColor = GetStanceColor(enmStance.beta);
			rColor = GetStanceColor(enmStance.gamma);
		}
		else if(activeUnit.stance = enmStance.beta)
		{
			lStance = "A";
			rStance = "G";
			lColor = GetStanceColor(enmStance.alpha);
			rColor = GetStanceColor(enmStance.gamma);
		}
		else if(activeUnit.stance = enmStance.gamma)
		{
			lStance = "A";
			rStance = "B";
			lColor = GetStanceColor(enmStance.alpha);
			rColor = GetStanceColor(enmStance.beta);
		}
		draw_sprite_ext(buttonLB, image_index, x+530, y+603, 0.8, 0.8, 1.0, lColor, 1.0);
		draw_text_color(x+550, y+590, "/Y - "+lStance, lColor, lColor, lColor, lColor, 1.0);
		
		draw_sprite_ext(buttonRB, image_index, x+680, y+603, 0.8, 0.8, 1.0, rColor, 1.0);
		draw_text_color(x+700, y+590, "/I - "+rStance, rColor, rColor, rColor, rColor, 1.0);
		
		break;
	}
	
	//Use one of the unit's abilities
	case enmBattleUIState.chooseAbility:
	{
		if(subMenuIdx < 4)
		{
			draw_sprite_ext(selectionIcon, image_index, x+230, y+602+(24*subMenuIdx), -0.8, 0.8, 1.0, c_orange, 1.0);
		}
		else
		{
			draw_sprite_ext(selectionIcon, image_index, x+730, y+602+(24*(subMenuIdx-4)), -0.8, 0.8, 1.0, c_orange, 1.0);
		}
		for(var i = 0; i < subMenuCount; i++)
		{
			var curAbility = ds_list_find_value(activeUnit.abilities, i);
			draw_set_color(c_white);
			if(i < 4)
			{
				draw_text_color(x+250, y+590+(24*i), curAbility.name+" ("+StanceToString(curAbility.stance)+")", GetStanceColor(curAbility.stance), GetStanceColor(curAbility.stance), GetStanceColor(curAbility.stance), GetStanceColor(curAbility.stance), 1.0);
				draw_text(x+500, y+590+(24*i), "Cost: "+string(GetSPcost(activeUnit, curAbility)));
			}
			else
			{
				draw_text_color(x+750, y+590+(24*(i-4)), curAbility.name+" ("+StanceToString(curAbility.stance)+")", GetStanceColor(curAbility.stance), GetStanceColor(curAbility.stance), GetStanceColor(curAbility.stance), GetStanceColor(curAbility.stance), 1.0);
				draw_text(x+1000, y+590+(24*(i-4)), "Cost: "+string(GetSPcost(activeUnit, curAbility)));
			}
		}
		
		break;
	}
	
	//Select from the party's items
	case enmBattleUIState.chooseItem:
	{
		draw_sprite_ext(selectionIcon, image_index, x+230, y+602+(24*subMenuIdx), -0.8, 0.8, 1.0, c_orange, 1.0);
		
		//Item list
		var item = ds_map_find_first(inventory);
		var itemCount = ds_map_find_value(inventory, item);
		for(var i = 0; i < subMenuCount; i++)
		{
			if(itemCount > 0)
			{
				draw_set_color(c_white);
			}
			else
			{
				draw_set_color(c_ltgray);
			}
			switch(item)
			{
				case enmItems.healthPotion01:
				{
					draw_text(x+250, y+590+(24*i), "Health Potion");
					break;
				}
				case enmItems.staminaPotion01:
				{
					draw_text(x+250, y+590+(24*i), "Stamina Potion");
					break;
				}
				case enmItems.resPotion01:
				{
					draw_text(x+250, y+590+(24*i), "Revival Potion");
					break;
				}
			}
			draw_text(x+500, y+590+(24*i), itemCount);
			item = ds_map_find_next(inventory, item);
			itemCount = ds_map_find_value(inventory, item);
		}
		break;
	}
	
	//Target an item or ability
	case enmBattleUIState.chooseTargets:
	{
		draw_set_color(c_orange);
		//Highlight all members of targeted faction
		if(selectedItem.targetAll)
		{
			if(selectedItem.targetAllies)
			{
				var units = ds_list_size(unitList);
				for(var i = 0; i < units; i++)
				{
					var unit = ds_list_find_value(unitList, i);
					if(unit.player == true)
					{
						draw_sprite_ext(selectionIcon, image_index, unit.x+60, unit.y, -1.0, 1.0, 1.0, c_orange, 1.0);
					}
				}
			}
			else
			{
				var units = ds_list_size(unitList);
				for(var i = 0; i < units; i++)
				{
					var unit = ds_list_find_value(unitList, i);
					if(unit.player == false)
					{
						draw_sprite_ext(selectionIcon, image_index, unit.x+80, unit.y, 1.0, 1.0, 1.0, c_orange, 1.0);
					}
				}
			}
		}
		//Highlight individual unit to target
		else
		{
			var target = ds_list_find_value(subMenuItems, subMenuIdx);
			draw_sprite_ext(selectionIcon, image_index, target.x+80, target.y, 1.0, 1.0, 1.0, c_orange, 1.0);
		}
		
		//Display info about the selected ability
		draw_set_color(c_white);
		draw_text(x+250, y+600, selectedItem.description);
		
		break;
	}
	
	case enmBattleUIState.chooseTargetsItem:
	{
		draw_set_color(c_orange);
		
		//Highlight individual unit to target
		var target = ds_list_find_value(subMenuItems, subMenuIdx);
		draw_sprite_ext(selectionIcon, image_index, target.x+80, target.y, 1.0, 1.0, 1.0, c_orange, 1.0);
		
		break;
	}
	
	//Player victory
	case enmBattleUIState.playerWin:
	{
		draw_set_halign(fa_left);
		draw_set_colour(c_white);
		
		draw_text(x+300, y+600, "You Win! I always believed in you.");
		draw_text(x+300, y+630, "Press A Button or J Key.");
		break;
	}
	
	//Enemy victory
	case enmBattleUIState.enemyWin:
	{
		draw_set_halign(fa_left);
		draw_set_colour(c_white);
		
		draw_text(x+300, y+600, "You Lose! Don't worry, I haven't done a balance pass.");
		break;
	}
}