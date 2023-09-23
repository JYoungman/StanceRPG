///TargetLowestHP(activeUnit, ability, unitPool)
function TargetLowestHP(activeUnit, ability, unitPool){
	
	var isPlayer = !ability.targetAllies;
	var units = GetUnitsFaction(unitPool, isPlayer, true);
	
	if(ability.targetAll)
	{
		return units;
	}
	else
	{	
		target = ds_list_create();
		var lowestHPidx = 0;
		var lowestHP = 1000000;	//This should get replaced at some point
		
		for(var i = 0; i < ds_list_size(units); i++)
		{
			var curUnit = ds_list_find_value(units, i);
			if(curUnit.hp < lowestHP)
			{
				//Store health and index of unit with lowest health
				if(i > 0)
				{
					if(curUnit.hp < lowestHP)
					{
						lowestHP = curUnit.hp;
						lowestHPidx = i;
					}
					//Break ties using luck
					else if(curUnit.hp == lowestHP)
					{
						var lowestUnit = ds_list_find_value(units, lowestHPidx);
						if(lowestUnit.lck > curUnit.lck)
						{
							lowestHP = curUnit.hp;
							lowestHPidx = i;
						}
					}			
				}
				//First iteration of the loop
				else
				{
					lowestHP = curUnit.hp;
					lowestHPidx = i;
				}
			}
		}
		ds_list_add(target, ds_list_find_value(units, lowestHPidx));

		return target;
	}
}