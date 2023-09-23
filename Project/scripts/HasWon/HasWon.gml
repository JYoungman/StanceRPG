///HasWon(unitList, isPlayer)
function HasWon(unitList, isPlayer){
	var defeatedCount = 0;
	var enemyCount = 0;
	
	var unitCount = ds_list_size(unitList);
	
	for(var i = 0; i < unitCount; i++)
	{
		var curUnit = ds_list_find_value(unitList, i);
		if(curUnit.player != isPlayer)
		{
			enemyCount++;
			if(curUnit.hp == 0)
			{
				defeatedCount++;
			}
		}
	}
	
	if(defeatedCount == enemyCount)
	{
		return true;
	}
	else
	{
		return false;
	}
}