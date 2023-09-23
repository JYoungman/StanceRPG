///DetermineOrder(unitPool)
function DetermineTurnOrder(unitPool) {
	
	var unitCount = ds_list_size(unitPool) - 1;
	var unsorted = true;

	while(unsorted == true)
	{
		unsorted = false;
		for(var i = 0; i < unitCount; i++)
		{
			if(IsUnitFaster(ds_list_find_value(unitPool, i), ds_list_find_value(unitPool, i+1)) == false)
			{
				unsorted = true;
				var tmp = ds_list_find_value(unitPool, i);
				ds_list_set(unitPool, i, ds_list_find_value(unitPool, i+1));
				ds_list_set(unitPool, i+1, tmp);
			}
		}
	}

	return unitPool;
}
