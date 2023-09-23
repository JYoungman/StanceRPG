// AbilitySelectRandom(unit)
function AbilitySelectRandom(unit){
	var abilityCount = ds_list_size(unit.abilities);
	return ds_list_find_value(unit.abilities, irandom(abilityCount-1));
}