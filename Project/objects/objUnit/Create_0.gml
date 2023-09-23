/// @description Insert description here
// You can write your code in this editor
hp = 20;
maxHP = 20;
stamina = 8;
maxStamina = 8;

pow = 6;
def = 2;
spd = 3;
lck = 2;

powMultiplier = 1.0;
defMultiplier = 1.0;
spdMultiplier = 1.0;
critPowMultiplier = 1.0;

critStartRound = 2;
critRoundPeriod = 3;
nextCritRound = critStartRound;
critRoundCounter = 0;
critMultiplier = 2.0;

staminaGain = 1;

stance = enmStance.alpha;

color = c_white;
displayName = "Unit";
player = true;

abilities = ds_list_create();
statusEffects = ds_map_create();

abilitySelectionFunction = noone;
targetSelectionFunction = noone;
nextAbility = noone;

lastStruckBy = noone;