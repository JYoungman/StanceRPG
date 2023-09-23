// AbilitySelectAlternateStance(unit)
function AbilitySelectAlternateStance(unit){
	var abilityCount = ds_list_size(unit.abilities);
	for(var i = 0; i < abilityCount; i++)
	{
		var curAbility = ds_list_find_value(unit.abilities, i);
		if(curAbility.stance != unit.stance)
		{
			return curAbility;
		}
	}
}