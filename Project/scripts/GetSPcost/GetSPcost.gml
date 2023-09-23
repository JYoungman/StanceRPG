// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetSPcost(unit, ability){
	var costModifier = 1.0;
	var statusList = unit.statusEffects;
	
	//Check for ability cost modifying status effects
	var statusCount = ds_map_size(statusList);
	var status = ds_map_find_first(statusList);
	
	//Decrement turn counters
	for(var i = 0; i < statusCount; i++)
	{
		if(status == enmAbilityEffect.spTaxA and ability.stance == enmStance.alpha)
		{
			costModifier = 1.5;
			break;
		}
		else if(status == enmAbilityEffect.spTaxB and ability.stance == enmStance.beta)
		{
			costModifier = 1.5;
			break;
		}
		else if(status == enmAbilityEffect.spTaxG and ability.stance == enmStance.gamma)
		{
			costModifier = 1.5;
			break;
		}
		
		status = ds_map_find_next(statusList, status);
	}
	
	return floor(ability.cost * costModifier);

}