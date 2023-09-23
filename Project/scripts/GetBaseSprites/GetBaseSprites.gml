// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetBaseSprites(statusList){
	baseSprites = ds_list_create();
	
	var status = ds_map_find_first(statusList);
	var statusCount = ds_map_size(statusList);
	
	for(var i = 0; i < statusCount; i++)
	{
		if(ds_map_find_value(statusList, status) > 0)
		{
			//Find the appropriate sprite and add it to the list
			if(status == enmAbilityEffect.poisonA 
			or status == enmAbilityEffect.poisonB 
			or status == enmAbilityEffect.poisonG)
			{
				ds_list_add(baseSprites, poisonBase);
			}
			else if(status == enmAbilityEffect.spTaxA
			or status == enmAbilityEffect.spTaxB
			or status == enmAbilityEffect.spTaxG)
			{
				ds_list_add(baseSprites, spTaxBase);
			}
			else if(status == enmAbilityEffect.powDown
			or status == enmAbilityEffect.powUp)
			{
				ds_list_add(baseSprites, atkBase);
			}
			else if(status == enmAbilityEffect.defDown
			or status == enmAbilityEffect.defUp)
			{
				ds_list_add(baseSprites, defBase);
			}
			else if(status == enmAbilityEffect.spdDown
			or status == enmAbilityEffect.spdUp)
			{
				ds_list_add(baseSprites, spdBase);
			}
		}
		
		status = ds_map_find_next(statusList, status);
	}
	
	return baseSprites;
}