// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateUnit(unitName, x, y, depth){
	for(var i = 0; i < array_length(global.units); i++)
	{
		if(variable_instance_get(global.units[i], "name") == unitName)
		{
			var newUnit = instance_create_depth(x, y, depth, objUnit);
			newUnit.maxHP = real(variable_instance_get(global.units[i], "maxHP"));
			newUnit.hp = newUnit.maxHP;
			
			newUnit.maxStamina = real(variable_instance_get(global.units[i], "maxStamina"));
			newUnit.stamina = newUnit.maxStamina;
			newUnit.staminaGain = real(variable_instance_get(global.units[i], "staminaGain"));
			
			newUnit.pow = real(variable_instance_get(global.units[i], "pow"));
			newUnit.def = real(variable_instance_get(global.units[i], "def"));
			newUnit.spd = real(variable_instance_get(global.units[i], "spd"));
			newUnit.lck = real(variable_instance_get(global.units[i], "lck"));
			
			newUnit.critStartRound = real(variable_instance_get(global.units[i], "critStartRound"));
			newUnit.critRoundPeriod = real(variable_instance_get(global.units[i], "critRoundPeriod"));
			newUnit.critMultiplier = real(variable_instance_get(global.units[i], "critMultiplier"));
			newUnit.nextCritRound = newUnit.critStartRound;
		
			newUnit.displayName = unitName;
			show_debug_message(variable_instance_get(global.units[i], "sprite"));
			newUnit.sprite_index = asset_get_index(variable_instance_get(global.units[i], "sprite"));
			
			newUnit.player = real(variable_instance_get(global.units[i], "player"));
			newUnit.stance = real(variable_instance_get(global.units[i], "defaultStance"));
			
			NumToAIFuncs(newUnit, real(variable_instance_get(global.units[i], "targetSelectionFunction")), real(variable_instance_get(global.units[i], "abilitySelectFunction")) )
			
			var abilityString = variable_instance_get(global.units[i], "abilities");
			var strStart = 1;
			for(var strCount = 1; strCount < string_length(abilityString)+1; strCount++)
			{
				if(string_char_at(abilityString, strCount) == ";")
				{
					var abilityStr = string_copy(abilityString, strStart, strCount-strStart);
					ds_list_add(newUnit.abilities, GetAbility(abilityStr));
					
					strStart = strCount+1;
				}
				else if(strCount == string_length(abilityString))
				{
					var lastAbility = string_copy(abilityString, strStart, string_length(abilityString)+1);
					
					ds_list_add(newUnit.abilities, GetAbility(lastAbility));				
				}
			}
			
			return newUnit;
		}	 
	}
}