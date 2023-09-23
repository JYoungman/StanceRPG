/// @description Insert description here
//Party management
if(gamepad_button_check_released(0, gp_face1) or keyboard_check_released(ord("J")))
{
	if(selectionPool == true)
	{
		if(allowRedundant == false)
		{
			var unitFound = false;
			var selectedUnit = ds_list_find_value(availableUnits, selectionIdx);
			
			for(var i = 0; i < ds_list_size(selectedParty); i++)
			{
				var curUnit = ds_list_find_value(selectedParty, i);
				if(curUnit == selectedUnit)
				{
					unitFound = true;
					break;
				}
			}
			
			if(unitFound == false)
			{
				selectedUnitIdx = selectionIdx;
				selectionIdx = 0;
				selectionPool = false;
			}
		}
		else
		{
			selectedUnitIdx = selectionIdx;
			selectionIdx = 0;
			selectionPool = false;
		}
	}
	else
	{
		ds_list_set(selectedParty, selectionIdx, ds_list_find_value(availableUnits, selectedUnitIdx));
		selectedUnitIdx = -1;
		selectionPool = true;
	}
}
//Scrolling
else if(gamepad_button_check_released(0, gp_padd) or keyboard_check_released(ord("S")))
{
	var idxCap = 2;
	if(selectionPool == true)
	{
		idxCap = ds_list_size(availableUnits) - 1;
	}
	
	if(selectionIdx == idxCap)
	{
		selectionIdx = 0;
	}
	else
	{
		selectionIdx++;
	}

}
else if(gamepad_button_check_released(0, gp_padu) or keyboard_check_released(ord("W")))
{
	var idxCap = 2;
	if(selectionPool == true)
	{
		idxCap = ds_list_size(availableUnits) - 1;
	}
	
	if(selectionIdx == 0)
	{
		selectionIdx = idxCap;
	}
	else
	{
		selectionIdx--;
	}
}

//Begin combat
else if(gamepad_button_check_released(0, gp_face3) or keyboard_check_released(ord("U")))
{
	GeneratePlayerParty(global.playerParty, selectedParty);
	room_goto_next();
}