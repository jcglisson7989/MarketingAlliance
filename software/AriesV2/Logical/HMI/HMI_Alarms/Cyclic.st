
PROGRAM _CYCLIC
	brsmemcpy(ADR(AppAlarms.AlarmImage[0]), 	ADR(gAlarms), 					SIZEOF(Machine_Alarms_typ));
	
	brsmemcpy(ADR(gAcknowledge), 				ADR(AppAlarms.AlarmImage[0]), 	SIZEOF(Machine_Alarms_typ));

//	tmp_alarm_counter := 0;
//	
//	FOR ii_alarms := 0 TO MAX_IDX_ALARMS BY 1 DO
//		IF gMachine.HMI.AlarmControls.Dispense.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//		
//		IF gMachine.HMI.AlarmControls.Inspect.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//		
//		IF gMachine.HMI.AlarmControls.Sensor.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//		
//		IF gMachine.HMI.AlarmControls.Safety.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//		
//		IF gMachine.HMI.AlarmControls.RecCfg.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//		
//		IF gMachine.HMI.AlarmControls.Hardware.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//		
//		IF gMachine.HMI.AlarmControls.Motor.AlarmImage[ii_alarms] THEN
//			tmp_alarm_counter := tmp_alarm_counter + 1;
//		END_IF;
//	END_FOR;
	
	
	IF gAlarmResetRequested THEN
		brsmemset(ADR(gAlarms), 0, 		SIZEOF(Machine_Alarms_typ));

		gAlarmResetRequested := FALSE;
	END_IF;
//
//	IF Alarm_Control.ActiveAlarms = 0 AND Alarm_Control.PendingAlarms = 0 AND tmp_alarm_counter = 0 THEN
//		gAlarmState := 0;
//	ELSIF Alarm_Control.ActiveAlarms = 0 AND Alarm_Control.PendingAlarms = 0 AND tmp_alarm_counter > 0 THEN
//		gAlarmState := 1;
//	ELSIF Alarm_Control.ActiveAlarms = 0 AND Alarm_Control.PendingAlarms > 0 THEN
//		gAlarmState := 2;
//	ELSE
//		gAlarmState := 3;
//	END_IF;
	
	AppAlarms_FBK();
//	
//	gMachine.HMI.Dashboard.Application_Errors_Active := tmp_alarm_counter;
//	gMachine.HMI.Dashboard.System_Alarms_Active := Alarm_Control.ActiveAlarms;
//	gMachine.HMI.Dashboard.System_Alarms_Pending := Alarm_Control.PendingAlarms;
END_PROGRAM
