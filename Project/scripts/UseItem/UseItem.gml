///Use Item(item, target)

function UseItem(item, target){
	var impact = 0;
	var floaterColor = c_black;
	switch(item)
	{
		case enmItems.healthPotion01:
		{
			if(target.hp > 0)
			{
				impact = min(80, target.maxHP-target.hp);
				target.hp += impact;
				floaterColor = c_green;
			}
			break;
		}
		case enmItems.staminaPotion01:
		{
			if(target.hp > 0)
			{
				impact = min(30, target.maxStamina-target.stamina);
				target.stamina += impact;
				floaterColor = c_yellow;
			}
			break;
		}
		case enmItems.resPotion01:
		{
			if(target.hp == 0)
			{
				impact = floor(target.maxHP * 0.4);
				target.hp += impact;
				floaterColor = c_green;
			}
			break;
		}
	}
	//Display health/stamina gain
	if(impact != 0)
	{
		var floater = instance_create_depth(target.x, target.y, target.depth-1, objDamageFloater);
		floater.value = impact;
		floater.color = floaterColor;
	}
}