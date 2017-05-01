
ACTION Action_Init_Infeed_Axis: 
	//Initialize the axis control FBK
	AxisControl.MpLink := ADR(FeedAxis_MpLink); //Pointer to the MAPP Axis Configuration
	AxisControl.Enable := TRUE; //Enables FBK "AxisControl" to hold/retain control of the axis object
	AxisControl.Parameters := ADR(AxisPar); //Pointer to the movement parameters
	AxisControl.Axis := ADR(Axis1); //Pointer to the ACP10 object which is mapped to the drive
	AxisControl(); //Call FBK once during INIT section to ensure it initializes without the cyclic task class time restraints!
	
	Alarm_Feed_UI.MpLink := ADR(FeedAxis_MpLink);
	Alarm_Feed_UI.Enable := TRUE;
	Alarm_Feed_UI.Mode := mpALARM_BASIC_UI_MODE_ALL;
	
	Alarm_Feed_UI.UISetup.ImageSize := 20;
	Alarm_Feed_UI.UISetup.AlarmImage := ADR(Alarm_Feed.AlarmImage);
	Alarm_Feed_UI.UISetup.AcknowledgeImage := ADR(Alarm_Feed.AcknowledgeImage);
	Alarm_Feed_UI.UISetup.AddInfoStringSize := 100;
	Alarm_Feed_UI.UISetup.AddInfo := ADR(Alarm_Feed.AddInfo);
	
	Alarm_Feed;
	Alarm_Feed_UI();
END_ACTION
