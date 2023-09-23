///UseAbility(activeUnit, targetList, ability)
function UseAbility(activeUnit, targetList, ability){

	//Casting effects
	activeUnit.stance = ability.stance;
	//activeUnit.stamina -= ability.cost;
	activeUnit.stamina -= GetSPcost(activeUnit, ability);
	
	//Tracking variable(s)
	var activePow = activeUnit.pow * activeUnit.powMultiplier;
	
	//Damage dealing
	var targetCount = ds_list_size(targetList);
	for(var i = 0; i < targetCount; i++)
	{
		var target = ds_list_find_value(targetList, i);
		var targetDef = target.def * target.defMultiplier;
		
		if(ability.stance != target.stance)
		{
			var floaterColor = c_white;
			
			//Power up attack if it's a crit turn
			var critPower = 1.0;
			if(activeUnit.player == true and activeUnit.critRoundCounter == activeUnit.nextCritRound)
			{
				critPower = activeUnit.critMultiplier * activeUnit.critPowMultiplier;
				activeUnit.critRoundCounter = 0;
				
			}
			if(critPower > 1.0)
			{
				floaterColor = c_yellow;
			}
			
			//Variability in damage output based on unit luck stats
			var effectPower = round(random_range(activePow, activePow + activeUnit.lck) * ability.powModifier * critPower);
			var defPower = round(random_range(targetDef, targetDef + (target.lck/2)));
			
			//Penalty for running out of stamina
			if(target.stamina < 1)
			{
				defPower = round(defPower/2);
				floaterColor = c_red;
			}
			
			//Deal damage
			var dmg = max(0, effectPower - defPower);
			target.hp = max(0, (target.hp - dmg));
			target.lastStruckBy = activeUnit;
			
			//Display damage dealt
			if(ability.powModifier > 0)
			{
				var floater = instance_create_depth(target.x, target.y, target.depth-1, objDamageFloater);
				floater.value = dmg;
				floater.color = floaterColor;
			}
			
			//Special abilities
			if(ability.effect != enmAbilityEffect.none)
			{
				if(ability.effectDuration == 0)
				{
					var abilityPow = round(random_range(activePow, activePow + activeUnit.lck) * ability.effectPowModifier * critPower);
				
					switch(ability.effect)
					{
						//Stamina
						case enmAbilityEffect.spBurn:
						{
							target.stamina = max(0, (target.stamina - abilityPow));
						
							var stamFloater = instance_create_depth(target.x+10, target.y-5, target.depth-1, objDamageFloater);
							stamFloater.value = abilityPow;
							stamFloater.color = c_olive;
						
							break;
						}
						case enmAbilityEffect.spBurnEx:
						{
							target.stamina -= abilityPow;
						
							var stamFloater = instance_create_depth(target.x+10, target.y-5, target.depth-1, objDamageFloater);
							stamFloater.value = abilityPow;
							stamFloater.color = c_olive;

							break;
						}
						case enmAbilityEffect.spSteal:
						{
							var stolenStamina = min(target.stamina, abilityPow);
							target.stamina = max(0, (target.stamina - abilityPow));
							activeUnit.stamina = min(activeUnit.maxStamina, activeUnit.stamina + stolenStamina);
						
							var stamFloater = instance_create_depth(target.x+10, target.y-5, target.depth-1, objDamageFloater);
							stamFloater.value = abilityPow;
							stamFloater.color = c_olive;
						
							var stamGainFloater = instance_create_depth(activeUnit.x+10, activeUnit.y-5, activeUnit.depth-1, objDamageFloater);
							stamGainFloater.value = stolenStamina;
							stamGainFloater.color = c_orange;
						
							break;
						}
						case enmAbilityEffect.spStealEx:
						{
							target.stamina -= abilityPow;
							activeUnit.stamina = min(activeUnit.maxStamina, activeUnit.stamina + abilityPow);
						
							var stamFloater = instance_create_depth(target.x+10, target.y-5, target.depth-1, objDamageFloater);
							stamFloater.value = abilityPow;
							stamFloater.color = c_olive;
						
							var stamGainFloater = instance_create_depth(activeUnit.x+10, activeUnit.y-5, activeUnit.depth-1, objDamageFloater);
							stamGainFloater.value = abilityPow;
							stamGainFloater.color = c_orange;
						
							break;
						}
					
						//Stance
						case enmAbilityEffect.forceStanceA:
						{
							target.stance = enmStance.alpha;
							break;
						}
					
						case enmAbilityEffect.forceStanceB:
						{
							target.stance = enmStance.beta;
							break;
						}
					
						case enmAbilityEffect.forceStanceG:
						{
							target.stance = enmStance.gamma;
							break;
						}
					
						case enmAbilityEffect.randomizeStance:
						{
							var newStance = enmStance.alpha;
							switch(target.stance)
							{
								case enmStance.alpha:
								{
									if(irandom(1) == 0)
									{
										newStance = enmStance.beta;
									}
									else
									{
										newStance = enmStance.gamma;
									}
									break;
								}
								case enmStance.beta:
								{
									if(irandom(1) == 0)
									{
										newStance = enmStance.alpha;
									}
									else
									{
										newStance = enmStance.gamma;
									}
									break;
								}
								case enmStance.gamma:
								{
									if(irandom(1) == 0)
									{
										newStance = enmStance.beta;
									}
									else
									{
										newStance = enmStance.alpha;
									}
									break;
								}
							}
						
							target.stance = newStance;
							break;
						}
					
						//DOT
					
						//Crit
						case enmAbilityEffect.critInc:
						{
							if(target.critRoundCounter != target.nextCritRound)
							{
								target.critRoundCounter += 1;
							}
							break;
						}
					
						case enmAbilityEffect.critDec:
						{
							if(target.critRoundCounter != 0)
							{
								target.critRoundCounter -= 1;
							}
							break;
						}
					
						case enmAbilityEffect.critFill:
						{
							target.critRoundCounter = target.nextCritRound;
							break;
						}
					
						case enmAbilityEffect.critEmpty:
						{
							target.critRoundCounter = 0;
							break;
						}
					
						//Stats
					
						//Other
					}
				}
				else
				{
					ApplyStatusEffect(target, ability.effect, ability.effectDuration);
				}
			}
			
		}
		else
		{
			if(ability.powModifier > 0)
			{
				instance_create_depth(target.x, target.y, target.depth-1, objDamageFloater);
			}
		}
	}
}