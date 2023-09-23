///InitializeBattle(battleManager, playerParty, enemyParty)
function InitializeBattle(battleManager, playerParty, enemyParty){

	var playerCount = ds_list_size(playerParty.units);
	var enemyCount = ds_list_size(enemyParty.units);

	//Unit management
	for(var i = 0; i < playerCount; i++)
	{
		var curUnit = CreateUnit(ds_list_find_value(playerParty.units, i), battleManager.player_x, 150+(150*i), 0);
		ds_list_add(battleManager.unitList, curUnit);
		curUnit.hp = ds_list_find_value(playerParty.healthPools, i);
		curUnit.stance = ds_list_find_value(playerParty.stances, i);
	}
	
	for(i = 0; i < enemyCount; i++)
	{
		//var curUnit = instance_create_depth(battleManager.enemy_x, 150+(150*i), 1, ds_list_find_value(enemyParty.units, i))
		var curUnit = CreateUnit(ds_list_find_value(enemyParty.units, i), battleManager.enemy_x, 150+(150*i), 0);
		ds_list_add(battleManager.unitList, curUnit);
		curUnit.nextAbility = curUnit.abilitySelectionFunction(curUnit);
	}
	
	//Inventory
	battleManager.inventory = playerParty.inventory;
	
	//Initialize turn
	battleManager.unitList = DetermineTurnOrder(battleManager.unitList);
	battleManager.activeUnit = ds_list_find_value(battleManager.unitList, 0);
	battleManager.activeUnit.critRoundCounter = 1;
	battleManager.playerTurn = battleManager.activeUnit.player;
	battleManager.turnIdx = 0;

	battleManager.uiState = enmBattleUIState.neutral;
	if(battleManager.playerTurn == true)
	{
		battleManager.uiState = enmBattleUIState.playerTurn;
	}
	else
	{
		battleManager.uiState = enmBattleUIState.enemyTurn;
	}
	
	//Allow battle to begin
	battleManager.turnAvailable = true;

}