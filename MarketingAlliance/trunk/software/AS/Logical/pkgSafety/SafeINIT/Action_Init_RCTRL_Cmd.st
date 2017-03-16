
ACTION Action_Init_RCTRL_Cmd: 
	brsmemset(ADR(gSafety.o.Command_Allowed), 0, SIZEOF(paiSL_Operations_typ));
	brsmemset(ADR(gSafety.o.Command_Being_Executed), 0, SIZEOF(paiSL_Operations_typ));
	
	gSafety.prv.FBK.DownloadApplication.Execute := FALSE;
	gSafety.prv.FBK.UDID_High.enable := FALSE;
	gSafety.prv.FBK.UDID_Low.enable := FALSE;
	
	gSafety.o.RCTRL.SafeOSState := SAFEOS_UPDATING_STATUS;
	gSafety.prv.Data.RemoteControlCmd.Password := gSafety.i.Password_for_command;
	gSafety.prv.Data.RemoteControlCmd.NewPassword := '';
	gSafety.prv.Command_Number := gSafety.prv.Command_Number + 1;
	gSafety.prv.Data.RemoteControlCmd.Number := gSafety.prv.Command_Number;
	gSafety.prv.Data.RemoteControlCmd.Command := safeCMD_ENTER;
	gSafety.prv.FBK.RemoteControl.Execute := TRUE;
	
	bgTimerStart(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd, Tms(DEFINE_TIME_MAX_RCTRL_CMD)); 
END_ACTION
