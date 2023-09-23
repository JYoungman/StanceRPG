//Abilities
var abilitiesFile = file_text_open_read("abilities.json");
var unitFile = file_text_open_read("units.json");
var jsonStr = "";

while (!file_text_eof(abilitiesFile))
{
	jsonStr += file_text_readln(abilitiesFile);
}
file_text_close(abilitiesFile);

global.abilities = json_parse(jsonStr);

jsonStr = "";
while (!file_text_eof(unitFile))
{
	jsonStr += file_text_readln(unitFile);
}
file_text_close(unitFile);
global.units = json_parse(jsonStr);

//Player party
global.playerParty = instance_create_depth(0, 0, 0, objParty);
//GeneratePlayerParty(global.playerParty);

//Initial enemy party
global.enemyParty = instance_create_depth(0, 0, 0, objParty);
GenerateEnemyParty(global.enemyParty, 0);