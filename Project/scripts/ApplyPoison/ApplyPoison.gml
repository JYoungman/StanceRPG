// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ApplyPoison(unit){
	
	var damage = -1;
	
	var statusList = unit.statusEffects;
	var status = ds_map_find_first(statusList);
	var statusCount = ds_map_size(statusList);
	
	for(var i = 0; i < statusCount; i++)
	{
		//Calculate damage from all eligible poison effects
		if(status == enmAbilityEffect.poisonA)
		{
			if(unit.stance != enmStance.alpha)
			{
				damage = max(damage, 0);
				//damage += min(1, (unit.maxHP * 0.1) * ((10 - unit.lck) * 0.1));
				damage += max(1, (unit.maxHP * 0.1) * ((100 - unit.lck) * 0.1));
			}
		}
		if(status == enmAbilityEffect.poisonB)
		{
			if(unit.stance != enmStance.beta)
			{
				damage = max(damage, 0);
				damage += max(1, (unit.maxHP * 0.1) * ((100 - unit.lck) * 0.1));
			}
		}
		if(status == enmAbilityEffect.poisonG)
		{
			if(unit.stance != enmStance.gamma)
			{
				damage = max(damage, 0);
				damage += max(1, (unit.maxHP * 0.1) * ((100 - unit.lck) * 0.1));
			}
		}
		
		//Advance loop
		status = ds_map_find_next(statusList, status);
	}
	
	//Deal and display damage
	if(damage > -1)
	{
		var impact = min(unit.hp, floor(damage));
		unit.hp -= impact;
		
		var floater = instance_create_depth(unit.x, unit.y, unit.depth-1, objDamageFloater);
		floater.value = impact;
		floater.color = make_color_rgb(182, 51, 247);
	}
}