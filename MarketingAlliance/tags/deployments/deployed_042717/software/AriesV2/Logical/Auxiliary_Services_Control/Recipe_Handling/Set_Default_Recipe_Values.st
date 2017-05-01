FUNCTION Set_Default_Recipe_Values
	
	pRec.FeedVelocity := 2;

	pRec.Crease.CreaseDistance_mm[0] := 1;
	pRec.Crease.CreaseDistance_mm[1] := 2;
	pRec.Crease.CreaseDistance_mm[2] := 3;
	pRec.Crease.CreaseDistance_mm[3] := 4;
	pRec.Crease.CreaseDistance_mm[4] := 5;
	pRec.Crease.CreaseDistance_mm[5] := 6;
	pRec.Crease.CreaseDistance_mm[6] := 7;
	pRec.Crease.CreaseDistance_mm[7] := 8;
	pRec.Crease.CreaseDistance_mm[8] := 9;
	pRec.Crease.CreaseDistance_mm[9] := 10;
	pRec.Crease.CreaseWidth_mm := 4;
	pRec.Crease.CreaseCount := 5;
	pRec.Crease.ShaftSensorEdge := 0;
	pRec.Crease.CreaserDirection := 0;
	pRec.Crease.CreaserMotorIdxLag_S := 0.1;
	
	Set_Default_Recipe_Values := 0;
END_FUNCTION