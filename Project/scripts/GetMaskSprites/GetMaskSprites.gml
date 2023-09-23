// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetMaskSprites(statusList){
	maskSprites = ds_list_create();
	
	var status = ds_map_find_first(statusList);
	var statusCount = ds_map_size(statusList);
	
	for(var i = 0; i < statusCount; i++)
	{
		if(ds_map_find_value(statusList, status) > 0)
		{
			//Find the appropriate sprite and add it to the list
			if(status == enmAbilityEffect.poisonA or status == enmAbilityEffect.spTaxA)
			{
				ds_list_add(maskSprites, alphaMask);
			}
			else if(status == enmAbilityEffect.poisonB or status == enmAbilityEffect.spTaxB)
			{
				ds_list_add(maskSprites, betaMask);
			}
			else if(status == enmAbilityEffect.poisonG or status == enmAbilityEffect.spTaxG)
			{
				ds_list_add(maskSprites, gammaMask);
			}
			else if(status == enmAbilityEffect.powUp
			or status == enmAbilityEffect.defUp
			or status == enmAbilityEffect.spdUp)
			{
				ds_list_add(maskSprites, buffMask);
			}
			else if(status == enmAbilityEffect.powDown
			or status == enmAbilityEffect.defDown
			or status == enmAbilityEffect.spdDown)
			{
				ds_list_add(maskSprites, debuffMask);
			}
		}
		
		status = ds_map_find_next(statusList, status);
	}
	
	return maskSprites;
}