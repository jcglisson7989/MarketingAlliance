

PROGRAM _INIT

	AppAlarms_FBK.MpLink := ADR(Alarm_MpLink);
	AppAlarms_FBK.Enable := TRUE;
	AppAlarms_FBK();
	 
END_PROGRAM