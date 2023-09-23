///GetNextUnitIdx(curIdx, unitList)

function GetNextUnitIdx(curIdx, unitList){
	var listSize = ds_list_size(unitList);
	
	for(var i = curIdx+1; i < listSize; i++)
	{
		var curUnit = ds_list_find_value(unitList, i);
		if(curUnit.hp > 0)
		{
			return i;
		}
	}
	return listSize;

}