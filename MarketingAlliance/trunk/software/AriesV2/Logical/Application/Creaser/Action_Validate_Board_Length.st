
ACTION Action_Validate_Board_Length: 
	
	length_calculated_total := 0;
	flagBoardLengthCfgErr := FALSE;
	
	FOR ii_crease_count := 0 TO gRecCfg.active.Rec.Crease.CreaseCount - 1 BY 1 DO
		
		length_calculated_total := length_calculated_total + gRecCfg.active.Rec.Crease.CreaseDistance_mm[ii_crease_count] + gRecCfg.active.Rec.Crease.CreaseWidth_mm;
		
	END_FOR;
	
	IF length_calculated_total > (gRecCfg.active.Rec.Crease.TotalBoardLength + gRecCfg.active.Cfg.Creaser.BoardLengthTolerance) THEN
		gAlarms.Board_Length_GT_Confgd_Amount := TRUE;
		flagBoardLengthCfgErr := TRUE;
	ELSIF length_calculated_total < (gRecCfg.active.Rec.Crease.TotalBoardLength - gRecCfg.active.Cfg.Creaser.BoardLengthTolerance) THEN
		gAlarms.Board_Length_LT_Confgd_Amount := TRUE;
		flagBoardLengthCfgErr := TRUE;
	END_IF;
		
END_ACTION

