///IsUnitFaster(unitA, unitB)
function IsUnitFaster(unitA, unitB) {
	var spdA = unitA.spd * unitA.spdMultiplier;
	var spdB = unitB.spd * unitB.spdMultiplier;

	if(spdA > spdB)
	{
		return true;
	}
	else if(spdA == spdB)
	{
		if(unitA.lck > unitB.lck)
		{
			return true;
		}
		else if(unitA.lck < unitB.lck)
		{
			return false;
		}
		else
		{
			return irandom(1);
		}
	}

	return false;


}
