// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ApplyStatusEffect(unit, status, duration){
	
	//Add duration to extant status effect
	var curStatus = ds_map_find_first(unit.statusEffects);
	var statusCount = ds_map_size(unit.statusEffects);
	
	for(var i = 0; i < statusCount; i++)
	{
		if(curStatus == status)
		{
			var statusDuration = ds_map_find_value(unit.statusEffects, curStatus) + duration;
			ds_map_set(unit.statusEffects, curStatus, statusDuration);
			
			return;
		}
	}
	
	//Apply new status effect
	ds_map_add(unit.statusEffects, status, duration);
	
	//Update stat modifiers as necessary
	switch(status)
	{
		case enmAbilityEffect.powUp:
		{
			AdjustPowMultiplier(unit, 0.5);
			break;
		}
		case enmAbilityEffect.powDown:
		{
			AdjustPowMultiplier(unit, -0.5);
			break;
		}
		case enmAbilityEffect.defUp:
		{
			AdjustDefMultiplier(unit, 0.5);
			break;
		}
		case enmAbilityEffect.defDown:
		{
			AdjustDefMultiplier(unit, -0.5);
			break;
		}
		case enmAbilityEffect.spdUp:
		{
			AdjustSpdMultiplier(unit, 0.5);
			break;
		}
		case enmAbilityEffect.spdDown:
		{
			AdjustSpdMultiplier(unit, -0.5);
			break;
		}
		case enmAbilityEffect.critPowerUp:
		{
			AdjustCrtPowMultiplier(unit, 0.5);
			break;
		}
	}
}