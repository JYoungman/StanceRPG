///UpdateParty(battleManager, party)
// Update the player party at the end of a battle
function UpdateParty(battleManager, party){
	
	//Health and stances
	var unitCount = ds_list_size(battleManager.unitList);
	var playerUnitCount = ds_list_size(party.units)
	
	for(var i = 0; i < unitCount; i++)
	{
		var curUnit = ds_list_find_value(battleManager.unitList, i);
		if(curUnit.player == true)
		{
			for(var j = 0; j < playerUnitCount; j++)
			{
				if(curUnit.object_index == ds_list_find_value(party.units, j))
				{
					ds_list_set(party.healthPools, j, max(1, curUnit.hp));
					ds_list_set(party.stances, j, curUnit.stance);
					break;
				}
			}
		}
	}
	
	//Inventory
	party.inventory = battleManager.inventory;
}