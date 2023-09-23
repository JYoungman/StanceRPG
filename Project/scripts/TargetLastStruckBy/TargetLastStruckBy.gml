/// TargetLastStruckBy(activeUnit, ability, unitPool)
function TargetLastStruckBy(activeUnit, ability, unitPool){
	
	var isPlayer = !ability.targetAllies;
	var units = GetUnitsFaction(unitPool, isPlayer, true);
	
	if(ability.targetAll)
	{
		return units;
	}
	else
	{
		if(activeUnit.lastStruckBy != noone and activeUnit.lastStruckBy.hp > 0)
		{
			target = ds_list_create();
			ds_list_add(target, activeUnit.lastStruckBy);
			return target;
		}
		else
		{
			return TargetSelectRandom(activeUnit, ability, unitPool);
		}
	}
}