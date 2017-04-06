
ACTION Action_Start_Feeder: 
	AxisPar.Velocity := gRecCfg.active.Rec.FeedVelocity;
	AxisPar.Acceleration := gRecCfg.active.Cfg.Creaser.FeedAxisAccel;
	AxisPar.Deceleration := gRecCfg.active.Cfg.Creaser.FeedAxisDecel;
	
	AxisControl.MoveVelocity := TRUE;
	AxisControl.MoveAbsolute := FALSE;
	AxisControl.MoveAdditive := FALSE;
	AxisControl.Stop := FALSE;
	AxisControl();
END_ACTION
