battleManager = instance_create_depth(0, 0, 0, objBattleManager);
ds_list_clear(global.enemyParty.units);
GenerateEnemyParty(global.enemyParty, 1);

InitializeBattle(battleManager, global.playerParty, global.enemyParty);