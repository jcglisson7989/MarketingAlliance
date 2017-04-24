
ACTION Action_Move_Photoeye_Offset:
	
		
	AxisControl.MoveAbsolute := FALSE;
	AxisControl.MoveAdditive := FALSE;
	AxisControl.MoveVelocity := FALSE;
	AxisControl.Stop := FALSE;
	AxisControl();
	
	//	AxisPar.Direction := mpAXIS_DIR_EXCEED_PERIOD;
	
	Current_Crease_Section_Length := gRecCfg.active.Cfg.Creaser.PhotoEyeOffset;
	
	AxisPar.Acceleration := gRecCfg.active.Cfg.Creaser.FeedAxisAccel;
	AxisPar.Deceleration := gRecCfg.active.Cfg.Creaser.FeedAxisDecel;
	AxisPar.Distance := gRecCfg.active.Cfg.Creaser.PhotoEyeOffset;
	AxisPar.Velocity := gRecCfg.active.Rec.FeedVelocity;
	
	AxisControl.MoveAdditive := TRUE;
	AxisControl();

END_ACTION
