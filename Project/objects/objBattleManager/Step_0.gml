/// Determine what action will happen this turn

if(playerTurn == true)
{
	if(turnAvailable == true)
	{
		//A Button
		if(gamepad_button_check_released(0, gp_face1) or keyboard_check_released(ord("J")))
		{
			switch(uiState)
			{
				//Bring up ability menu
				case enmBattleUIState.playerTurn:
				{
					if(activeUnit.stamina > 0)
					{
						subMenuCount = ds_list_size(activeUnit.abilities);
						uiState = enmBattleUIState.chooseAbility;
					}
					
					break;
				}
				//Select ability to use
				case enmBattleUIState.chooseAbility:
				{
					selectedItem = ds_list_find_value(activeUnit.abilities, subMenuIdx);
					subMenuIdx = 0;
					subMenuCount = 0;
			
					if(selectedItem.targetAll == false)
					{
						subMenuItems = GetUnitsFaction(unitList, selectedItem.targetAllies, true);
						subMenuItems = SortActiveEnemies(subMenuItems);
						subMenuCount = ds_list_size(subMenuItems);
					}			
			
					uiState = enmBattleUIState.chooseTargets;
					break;
				}
				//Select item to use
				case enmBattleUIState.chooseItem:
				{
					if(ds_map_find_value(inventory, subMenuIdx) > 0)
					{
						var item = ds_map_find_first(inventory);
						var entryCount = 0;
						while(entryCount < subMenuIdx)
						{
							item = ds_map_find_next(inventory, item);
							entryCount++;
						}
					
						selectedItem = item;
						subMenuIdx = 0;
						subMenuCount = 0;
					
						subMenuItems = GetUnitsFaction(unitList, true, false);
						subMenuCount = ds_list_size(subMenuItems);
					
						uiState = enmBattleUIState.chooseTargetsItem;
					}
					break;
				}
				//Select target(s) for ability
				case enmBattleUIState.chooseTargets:
				{
					turnAvailable = false;
					if(selectedItem.targetAll == true)
					{
						UseAbility(activeUnit, GetUnitsFaction(unitList, selectedItem.targetAllies, true), selectedItem);
						alarm[0] = 1;
					}
					else
					{
						targets = ds_list_create();
						var tempUnit = ds_list_find_value(subMenuItems, subMenuIdx);
						ds_list_add(targets, tempUnit);
				
						UseAbility(activeUnit, targets, selectedItem);
						alarm[0] = 1;
					}
					break;
				}
				//Select target for item
				case enmBattleUIState.chooseTargetsItem:
				{
					turnAvailable = false;

					var curItemCount = ds_map_find_value(inventory, selectedItem)-1;
					ds_map_set(inventory, selectedItem, curItemCount);
				
					UseItem(selectedItem, ds_list_find_value(subMenuItems, subMenuIdx));
					alarm[0] = 1;
					
					break;
				}
			}
		}
		//X Button
		else if(gamepad_button_check_released(0, gp_face3) or keyboard_check_released(ord("U")))
		{
			//Bring up player's inventory
			if(uiState == enmBattleUIState.playerTurn)
			{
				subMenuCount = ds_map_size(inventory);
				subMenuIdx = 0;
				uiState = enmBattleUIState.chooseItem;
			}
		}
		//B Button
		else if(gamepad_button_check_released(0, gp_face2) or keyboard_check_released(ord("K")))
		{
			//Back out of ability/item selection/aim menu
			if(uiState == enmBattleUIState.chooseAbility or uiState == enmBattleUIState.chooseItem or uiState == enmBattleUIState.chooseTargets or uiState == enmBattleUIState.chooseTargetsItem)
			{
				subMenuCount = 0;
				subMenuIdx = 0;
				selectedItem = noone;
			
				uiState = enmBattleUIState.playerTurn
			}
			//Skip turn
			else if(uiState == enmBattleUIState.playerTurn)
			{
				alarm[0] = 1;
			}
		}
		//Shift stance left
		else if(gamepad_button_check_released(0, gp_shoulderl) or keyboard_check_released(ord("Y")))
		{
			if(uiState == enmBattleUIState.playerTurn)
			{
				turnAvailable = false;
				switch(activeUnit.stance)
				{
					case enmStance.alpha:
					{
						ChangeStance(activeUnit, enmStance.beta);
						break;
					}
					case enmStance.beta:
					{
						ChangeStance(activeUnit, enmStance.alpha);
						break;
					}
					case enmStance.gamma:
					{
						ChangeStance(activeUnit, enmStance.alpha);
						break;
					}
				}
				alarm[0] = 1;
			}
		}
		//Shift stance right
		else if(gamepad_button_check_released(0, gp_shoulderr) or keyboard_check_released(ord("I")))
		{
			if(uiState == enmBattleUIState.playerTurn)
			{
				turnAvailable = false;
				switch(activeUnit.stance)
				{
					case enmStance.alpha:
					{
						ChangeStance(activeUnit, enmStance.gamma);
						break;
					}
					case enmStance.beta:
					{
						ChangeStance(activeUnit, enmStance.gamma);
						break;
					}
					case enmStance.gamma:
					{
						ChangeStance(activeUnit, enmStance.beta);
						break;
					}
				}
				alarm[0] = 1;
			}
		}
		//Scroll down selection
		else if(gamepad_button_check_released(0, gp_padd) or keyboard_check_released(ord("S")))
		{
			if(uiState == enmBattleUIState.chooseAbility or uiState == enmBattleUIState.chooseTargets or uiState == enmBattleUIState.chooseItem or uiState == enmBattleUIState.chooseTargetsItem)
			{
				if(subMenuIdx == subMenuCount - 1)
				{
					subMenuIdx = 0;
				}
				else
				{
					subMenuIdx++;
				}
			}
		}
		//Scroll up selection
		else if(gamepad_button_check_released(0, gp_padu) or keyboard_check_released(ord("W")))
		{
			if(uiState == enmBattleUIState.chooseAbility or uiState == enmBattleUIState.chooseTargets or uiState == enmBattleUIState.chooseItem or uiState == enmBattleUIState.chooseTargetsItem)
			{
				if(subMenuIdx == 0)
				{
					subMenuIdx = subMenuCount-1;
				}
				else
				{
					subMenuIdx--;
				}
			}
		}
	}
}
//Have the enemy perform their action
else
{
	if(turnAvailable == true)
	{
		if(activeUnit.stamina > 0)
		{
			turnAvailable = false;
			var targetList = script_execute(activeUnit.targetSelectionFunction, activeUnit, activeUnit.nextAbility, unitList);
	
			UseAbility(activeUnit, targetList, activeUnit.nextAbility);
			activeUnit.nextAbility = script_execute(activeUnit.abilitySelectionFunction, activeUnit);
			
			alarm[0] = 1 * room_speed;
		}
		else
		{
			alarm[0] = 1;
		}

	}
}

//Reset fight option
if(gamepad_button_check_released(0, gp_select) or keyboard_check_released(ord("P")))
{
	room_goto(infoRoom);
}

//Victory condition
if (uiState == enmBattleUIState.playerWin)
{
	if(gamepad_button_check_released(0, gp_face1) or keyboard_check_released(ord("J")))
	{
		room_goto_next();
	}
}

//Defeat condition
if (uiState == enmBattleUIState.enemyWin)
{
	if(gamepad_button_check_released(0, gp_face1) or keyboard_check_released(ord("J")))
	{
		room_goto(infoRoom);
	}
}