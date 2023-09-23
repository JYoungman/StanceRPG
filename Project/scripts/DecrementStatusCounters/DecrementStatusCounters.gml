// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DecrementStatusCounters(statusList){

	var statusCount = ds_map_size(statusList);
	var status = ds_map_find_first(statusList);
	
	//Decrement turn counters
	for(var i = 0; i < statusCount; i++)
	{
		ds_map_set(statusList, status, ds_map_find_value(statusList, status) - 1);
		status = ds_map_find_next(statusList, status);
	}
	
	//Removed complete statuses
	for(var j = 0; j < statusCount; j++)
	{
		if(ds_map_find_value(statusList, status) == 0)
		{
			var removedStatus = status;
			status = ds_map_find_next(statusList, status);
			ds_map_delete(statusList, removedStatus);
			
			//Update stat modifiers as necessary
			switch(status)
			{
				case enmAbilityEffect.powUp:
				{
					AdjustPowMultiplier(unit, -0.5);
					break;
				}
				case enmAbilityEffect.powDown:
				{
					AdjustPowMultiplier(unit, 0.5);
					break;
				}
				case enmAbilityEffect.defUp:
				{
					AdjustDefMultiplier(unit, -0.5);
					break;
				}
				case enmAbilityEffect.defDown:
				{
					AdjustDefMultiplier(unit, 0.5);
					break;
				}
				case enmAbilityEffect.spdUp:
				{
					AdjustSpdMultiplier(unit, -0.5);
					break;
				}
				case enmAbilityEffect.spdDown:
				{
					AdjustSpdMultiplier(unit, 0.5);
					break;
				}
				case enmAbilityEffect.critPowerUp:
				{
					AdjustCrtPowMultiplier(unit, -0.5);
					break;
				}
			}
		}
		else
		{
			status = ds_map_find_next(statusList, status);
		}
	}
}