///GeneratePlayerParty(partyManager, unitList)
function GeneratePlayerParty(partyManager, unitList){
	
	for(var i = 0; i < ds_list_size(unitList); i++)
	{
		var curUnit = ds_list_find_value(unitList, i);
		ds_list_add(partyManager.units, string(variable_instance_get(curUnit, "name")));
	}
	
	//Temporarily create units to track persistent stats
	var unitCount = ds_list_size(partyManager.units);
	for(var i = 0; i < unitCount; i++)
	{
		var curUnit = CreateUnit(ds_list_find_value(partyManager.units, i), 0, 0, 0);
		ds_list_add(partyManager.healthPools, curUnit.maxHP);
		ds_list_add(partyManager.stances, curUnit.stance);
		
		instance_destroy(curUnit);
	}
	
	//Inventory
	ds_map_add(partyManager.inventory, enmItems.healthPotion01, 3);
	ds_map_add(partyManager.inventory, enmItems.staminaPotion01, 3);
	ds_map_add(partyManager.inventory, enmItems.resPotion01, 2);
}