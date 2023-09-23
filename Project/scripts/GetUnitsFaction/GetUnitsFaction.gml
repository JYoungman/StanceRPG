///GetUnitsFaction(unitList, isPlayer, excludeDown)
function GetUnitsFaction(unitList, isPlayer, excludeDown){
	filteredUnits = ds_list_create();
	var unitCount = ds_list_size(unitList);
	
	for(var i = 0; i < unitCount; i++)
	{
		var unit = ds_list_find_value(unitList, i);
		if(unit.player == isPlayer)
		{
			if(excludeDown == true and unit.hp == 0)
			{
				//
			}
			else
			{
				ds_list_add(filteredUnits, unit);
			}
		}
	}
	
	return filteredUnits;
}