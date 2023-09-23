// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NumToAIFuncs(unit, targeting, ability){
	switch(targeting)
	{
		case 0:
		{
			unit.targetSelectionFunction = noone;
			break;
		}
		
		case 1:
		{
			unit.targetSelectionFunction = TargetSelectRandom;
			break;
		}
		
		case 2:
		{
			unit.targetSelectionFunction = TargetLowestHP;
			break;
		}
		
		case 3:
		{
			unit.targetSelectionFunction = TargetLastStruckBy;
			break;
		}
	}
	
	switch(ability)
	{
		case 0:
		{
			unit.abilitySelectionFunction = noone;
			break;
		}
		
		case 1:
		{
			unit.abilitySelectionFunction = AbilitySelectRandom;
			break;
		}
		
		case 2:
		{
			unit.abilitySelectionFunction = AbilitySelectAlternateStance;
			break;
		}
	}
}