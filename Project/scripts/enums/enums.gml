function enums() {
	enum enmStance
	{
		alpha,
		beta,
		gamma
	}

	enum enmBattleUIState
	{
		playerTurn,
		chooseAbility,
		chooseItem,
		chooseTargets,
		chooseTargetsItem,
		enemyTurn,
		playerWin,
		enemyWin,
		neutral
	}
	
	enum enmItems
	{
		healthPotion01,
		staminaPotion01,
		resPotion01
	}
	
	enum enmAbilityEffect
	{
		none = 0,
		
		//Stamina 1-8
		spBurn,	
		spBurnEx,	//Ex: Does not cap at zero
		spSteal,		
		spStealEx,
		spCap,
		spTaxA,
		spTaxB,
		spTaxG,
		
		//Stance 9-12
		forceStanceA,
		forceStanceB,
		forceStanceG,
		randomizeStance,
		
		//DOT 13-15
		poisonA,
		poisonB,
		poisonG,
		
		//Crit 16-20
		critInc,
		critDec,
		critFill,
		critEmpty,
		critPowerUp,
		
		//Stats 21-26
		powUp,
		defUp,
		spdUp,
		powDown,
		defDown,
		spdDown,
		
		//Other 27-29
		lockA,
		lockB,
		lockG
		
	}
	
	enum enmTargetSelect
	{
		none = 0,
		
		random,
		lowestHP,
		lastStruckBy
	}
	
	enum enmAbilitySelect
	{
		none = 0,
		
		random,
		alternateStance
	}
	
}
