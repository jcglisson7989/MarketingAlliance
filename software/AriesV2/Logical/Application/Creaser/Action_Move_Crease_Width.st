
ACTION Action_Move_Crease_Width: 
	AxisControl.MoveVelocity := FALSE;
	AxisControl.MoveAbsolute := FALSE;
	AxisControl.MoveAdditive := FALSE;
	AxisControl.Stop := FALSE;
	AxisControl();
	
	AxisPar.Acceleration := gRecCfg.active.Cfg.Creaser.FeedAxisAccel;
	AxisPar.Deceleration := gRecCfg.active.Cfg.Creaser.FeedAxisDecel;
	AxisPar.Distance := 	gRecCfg.active.Rec.Crease.CreaseWidth_mm;
	AxisPar.Velocity := gRecCfg.active.Rec.FeedVelocity;
	
	AxisControl.MoveAdditive := TRUE;
	AxisControl();
END_ACTION
