
ACTION Action_Start_Feeder: 
	AxisControl.MoveVelocity := FALSE;
	AxisControl.MoveAbsolute := FALSE;
	AxisControl.MoveAdditive := FALSE;
	AxisControl.Stop := FALSE;
	AxisControl();
	
	AxisPar.Velocity := gRecCfg.active.Cfg.Creaser.PreInsertSpeed;
	AxisPar.Acceleration := gRecCfg.active.Cfg.Creaser.FeedAxisAccel;
	AxisPar.Deceleration := gRecCfg.active.Cfg.Creaser.FeedAxisDecel;
	
	AxisControl.MoveVelocity := TRUE;
	AxisControl();
END_ACTION
