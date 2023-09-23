/// @description Insert description here
//Generate player units
availableUnits = ds_list_create();
selectedParty = ds_list_create();
selectionIdx = 0;
selectionPool = true;
selectedUnitIdx = -1;

allowRedundant = false;

for(var i = 0; i < array_length(global.units); i++)
{
	if(real(variable_instance_get(global.units[i], "player")) == 1)
	{
		ds_list_add(availableUnits, global.units[i]);
		if(ds_list_size(selectedParty) < 3)
		{
			ds_list_add(selectedParty, global.units[i]);
		}
	}
}