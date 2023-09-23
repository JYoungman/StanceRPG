/// SortActiveEnemies(unitList)
function SortActiveEnemies(unitList){
	
	var unitCount = ds_list_size(unitList) - 1;
	var unsorted = true;

	while(unsorted == true)
	{
		unsorted = false;
		for(var i = 0; i < unitCount; i++)
		{
			if(ds_list_find_value(unitList, i).y > ds_list_find_value(unitList, i+1).y)
			{
				unsorted = true;
				var tmp = ds_list_find_value(unitList, i);
				ds_list_set(unitList, i, ds_list_find_value(unitList, i+1));
				ds_list_set(unitList, i+1, tmp);
			}
		}
	}

	return unitList;
}