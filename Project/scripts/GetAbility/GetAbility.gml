// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetAbility(abilityName){
	for(var i = 0; i < array_length(global.abilities); i++)
	{
		if(variable_instance_get(global.abilities[i], "name") == abilityName)
		{
			var abilityStruct = {};
			variable_struct_set(abilityStruct, "name", abilityName);
			variable_struct_set(abilityStruct, "stance", real(variable_instance_get(global.abilities[i], "stance")));
			variable_struct_set(abilityStruct, "cost", real(variable_instance_get(global.abilities[i], "cost")));
			variable_struct_set(abilityStruct, "targetAllies", real(variable_instance_get(global.abilities[i], "targetAllies")));
			variable_struct_set(abilityStruct, "targetAll", real(variable_instance_get(global.abilities[i], "targetAll")));
			variable_struct_set(abilityStruct, "powModifier", real(variable_instance_get(global.abilities[i], "powModifier")));
			variable_struct_set(abilityStruct, "effect", real(variable_instance_get(global.abilities[i], "effect")));
			variable_struct_set(abilityStruct, "effectDuration", real(variable_instance_get(global.abilities[i], "effectDuration")));
			variable_struct_set(abilityStruct, "effectPowModifier", real(variable_instance_get(global.abilities[i], "effectPowModifier")));
			variable_struct_set(abilityStruct, "description", string(variable_instance_get(global.abilities[i], "description")));
			
			return abilityStruct;
		}	 
	}
}