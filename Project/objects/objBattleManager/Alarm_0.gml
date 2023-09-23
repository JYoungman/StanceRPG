/// @description Advance to next unit's turn

//Reset UI
subMenuIdx = 0;
subMenuCount = 0;
selectedItem = noone;
if(subMenuItems != noone)
{
	ds_list_destroy(subMenuItems);
	subMenuItems = noone;
}

//Persistent status updates
ApplyPoison(activeUnit);

DecrementStatusCounters(activeUnit.statusEffects);

//Check for victory conditions
if(HasWon(unitList, true))
{
	uiState = enmBattleUIState.playerWin;
	UpdateParty(self, global.playerParty);
	return;
}
if(HasWon(unitList, false))
{
	uiState = enmBattleUIState.enemyWin;
	return;
}

//Update turn counter
turnIdx = GetNextUnitIdx(turnIdx, unitList);

//Advance to next unit
if(turnIdx < ds_list_size(unitList))
{
	activeUnit = ds_list_find_value(unitList, turnIdx);
}
else
{
	turn++;
	
	unitList = DetermineTurnOrder(unitList);
	turnIdx = GetNextUnitIdx(-1, unitList);
	activeUnit = ds_list_find_value(unitList, turnIdx);
}

activeUnit.stamina = min(activeUnit.maxStamina, activeUnit.stamina + activeUnit.staminaGain);
activeUnit.critRoundCounter++;
if(activeUnit.critRoundCounter > activeUnit.nextCritRound)
{
	activeUnit.nextCritRound = activeUnit.critRoundPeriod;
	activeUnit.critRoundCounter = 1;
}

playerTurn = activeUnit.player;

if(playerTurn == true)
{
	uiState = enmBattleUIState.playerTurn;
}
else
{
	uiState = enmBattleUIState.enemyTurn;	
}

turnAvailable = true;