
PROGRAM _INIT
	(* Insert code here *)
	AlarmX_Control.MpLink := ADR(MpLink_AlarmControl);
	AlarmX_Control.Enable := TRUE;
	
	AlarmX_ListUI.MpLink := ADR(MpLink_AlarmControl);
	AlarmX_ListUI.Enable := TRUE;
	AlarmX_ListUI.UISetup.AlarmListSize := 5;
	AlarmX_ListUI.UISetup.AlarmListScrollWindow := 5;
	AlarmX_ListUI.UIConnect := ADR(AlarmX_ListUIConnect);
	
	AlarmX_History.MpLink := ADR(MpLink_AlarmHistory);
	AlarmX_History.Enable := TRUE;
	AlarmX_History.DeviceName := ADR('Alarm');
	AlarmX_History.Language := ADR('en');
	
	AlarmX_HistoryUI.MpLink := ADR(MpLink_AlarmHistory);
	AlarmX_HistoryUI.Enable := TRUE;
	AlarmX_HistoryUI.UISetup.AlarmListSize := 5;
	AlarmX_HistoryUI.UISetup.AlarmListScrollWindow := 5;
	AlarmX_HistoryUI.UIConnect := ADR(AlarmX_History_UIConnect);
	
//	AlarmX_ListUIConnect.AlarmList.Timestamp[0]

END_PROGRAM

PROGRAM _CYCLIC
	
	IF set THEN
		set := FALSE;
		MpAlarmXSet(MpLink_AlarmControl, 'exampleAlarm');
	END_IF;
	
	IF reset THEN
		reset := FALSE;
		MpAlarmXReset(MpLink_AlarmControl, 'exampleAlarm');
	END_IF;
	
	IF ack THEN
		ack := FALSE;
		MpAlarmXAcknowledge(MpLink_AlarmControl, 'exampleAlarm');
	END_IF;
	
	loc.ExampleAlarm.active := MpAlarmXCheckState(MpLink_AlarmControl, 'exampleAlarm', mpALARMX_STATE_NONE);
	loc.ExampleReaction.active := MpAlarmXCheckReaction(MpLink_AlarmControl, 'exampleReaction');
	
	AlarmX_Control();
	AlarmX_ListUI();
	AlarmX_ListUIConnect;
	
	AlarmX_History();
	AlarmX_HistoryUI();
	AlarmX_History_UIConnect;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

