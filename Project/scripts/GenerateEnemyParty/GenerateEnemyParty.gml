///GenerateEnemyParty(partyManager, partyConfiguration)
function GenerateEnemyParty(partyManager, partyConfiguration){
	switch(partyConfiguration)
	{
		case 0:
		{
			/*
			ds_list_add(partyManager.units, "Cranberry");
			ds_list_add(partyManager.units, "Strawberry");
			ds_list_add(partyManager.units, "Cherry");
			*/
			
			ds_list_add(partyManager.units, "Gator");
			ds_list_add(partyManager.units, "Shark");
			ds_list_add(partyManager.units, "Seahorse");
			
			break;
		}
		case 1:
		{
			ds_list_add(partyManager.units, "Avenger");
			ds_list_add(partyManager.units, "Bully");	
			
			break;
		}
	}
}