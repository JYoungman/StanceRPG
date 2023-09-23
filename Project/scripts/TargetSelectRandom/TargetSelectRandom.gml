/// TargetSelectRandom(activeUnit, ability, unitPool)
function TargetSelectRandom(activeUnit, ability, unitPool){
	
	var isPlayer = !ability.targetAllies;
	var units = GetUnitsFaction(unitPool, isPlayer, true);
	
	if(ability.targetAll)
	{
		return units;
	}
	else
	{	
		target = ds_list_create();

		if(ds_list_size(units) > 1)
		{
			var randIdx = irandom(ds_list_size(units)-1);
			ds_list_add(target, ds_list_find_value(units, randIdx));
		}
		else
		{
			ds_list_add(target, ds_list_find_value(units, 0));
		}
		return target;
	}
}