
PROGRAM _INIT
//	Init_Logbook.Enable := TRUE;
//	Init_Logbook.Name := 'usr_safe';
//	Init_Logbook();
	
	gSafety.o.State := SAFE_PROGRAM_INIT;
	
	gSafety.prv.FBK.RemoteControl.SafeLOGICID := DEFINE_SAFELOGIC_ID;
	gSafety.prv.FBK.RemoteControl.pCommandData := ADR(gSafety.prv.Data.RemoteControlCmd);
	gSafety.prv.Data.RemoteControlCmd.Version := DEFINE_VERSION;
	
	gSafety.prv.FBK.DownloadApplication.SafeLOGICID := DEFINE_SAFELOGIC_ID;
	gSafety.prv.FBK.DownloadApplication.pCommandData := ADR(gSafety.prv.Data.DownloadAppCmd);
	gSafety.prv.Data.DownloadAppCmd.Version := DEFINE_VERSION;

	gSafety.prv.Command_Number := 0;
	
	Action_Reset_FBK;
END_PROGRAM

PROGRAM _CYCLIC
	gSafetyPermInfo;
	
	IF gSafety.i.Reset THEN
		gSafety.i.Reset := FALSE;
		gSafety.o.State := SAFE_PROGRAM_INIT;
	END_IF;
	
	IF EDGEPOS(gSafety.o.State = SAFE_PROGRAM_WAIT_COMMAND) THEN
		bgTimerStart(gSafety.prv.Timer.Timer_Rescan, Tms(DEFINE_TIME_SCANNING_RETRY));
	END_IF;
	
	IF EDGEPOS(gSafety.o.State = SAFE_PROGRAM_ERROR) THEN
		bgTimerStart(gSafety.prv.Timer.Timer_Error_Retry, Tms(DEFINE_TIME_ERROR_AUTORESET));
	END_IF;
	
	IF EDGENEG(gSafety.o.State = SAFE_PROGRAM_WAIT_COMMAND) THEN
		brsmemset(ADR(gSafety.i.Command), 0, SIZEOF(paiSL_Operations_typ));
	END_IF;
	
	IF EDGEPOS(gSafety.o.State = SAFE_PROGRAM_PRINT_STATUS_WAIT) THEN
		bgTimerStart(gSafety.prv.Timer.Timer_Print_HMI_Status, Tms(DEFINE_TIME_PRINT_HMI_STATUS));
	END_IF;
	
	//	IF gSafety.o.State <> gSafety.o.State_Old THEN
	//		Data_Log_Control.Trigger := TRUE;
	//	END_IF;
	
	CASE gSafety.o.State OF
		SAFE_PROGRAM_INIT:
			brsmemset(ADR(gSafety.o.Command_Allowed), 0, SIZEOF(paiSL_Operations_typ));
			Action_Reset_FBK;
			gSafety.o.Status_Print := 'Initializing SL Comm Setup, Please Wait';
			gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
			
		SAFE_PROGRAM_READ_STATUS:
			gSafety.prv.Data.RemoteControlCmd.Command := safeCMD_STATUS;
			gSafety.prv.Data.RemoteControlCmd.Data := 0; //Just read the status, data is 0 here per help file
			
			gSafety.o.Status_Print := 'Reading SafeLogic PLC Status, Please Wait';
			
			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.RCTRL.Status := UINT_TO_DINT(gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.Status);
				gSafety.o.RCTRL.State := UINT_TO_DINT(gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.State);
				
				CASE gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.SafeOSState OF
					16#00:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_INVALID_OR_BOOT;
					16#0F:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_ON_OR_ERROR;
					//requestMessageToLog(ADR('SafeOS State: On or Error'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					16#33:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_LOADING;
					//requestMessageToLog(ADR('SafeOS State: Loading'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					16#55:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_STOP_SAFE;
					//requestMessageToLog(ADR('SafeOS State: Stop [Safe]'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					16#66:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_RUN_SAFE;
					gSafetyPermInfo.Run_State := 1;
					//requestMessageToLog(ADR('SafeOS State: Run [SAFE]'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
//					perm_Sys_Commissioned := TRUE;
					16#99:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_HALT_DEBUG;
					//requestMessageToLog(ADR('SafeOS State: Halt [Debug]'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					16#AA:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_STOP_DEBUG;
					//requestMessageToLog(ADR('SafeOS State: Stop [Debug]'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					16#CC:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_RUN_DEBUG;
					//requestMessageToLog(ADR('SafeOS State: Run [Debug]'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					16#F0:
					gSafety.o.RCTRL.SafeOSState := SAFEOS_NO_EXECUTION;
					//requestMessageToLog(ADR('SafeOS State: No Execution'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				END_CASE;
				
				gSafety.o.Command_Allowed.Ack_All_UDID := (gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.NumberOfUDIDMismatches > 0);
				gSafety.o.Command_Allowed.Ack_Firmware := (gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.NumberOfDifferentFirmware > 0);
				gSafety.o.Command_Allowed.Ack_Safekey_Exchange := (gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.SafeKEYChanged > 0);
				gSafety.o.Command_Allowed.Test_LED := TRUE;
				gSafety.o.Command_Allowed.Sys_Scan := TRUE;
				gSafety.o.Command_Allowed.Alter_SK_Password := TRUE;
				gSafety.o.Command_Allowed.Format_SK := TRUE;
				gSafety.o.Command_Allowed.Reset := TRUE;
				gSafety.o.Command_Allowed.Clear_Data := TRUE;
				gSafety.o.Command_Allowed.Download_Application := TRUE;
				
				gSafety.o.RCTRL.FailSafe := (gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.FailSafe = 16#55);
					
				gSafety.o.State := SAFE_PROGRAM_WAIT_COMMAND;
			ELSIF gSafety.prv.FBK.RemoteControl.Error AND gSafety.prv.FBK.RemoteControl.StatusID <> 36105 AND gSafety.prv.FBK.RemoteControl.StatusID <> 65535 THEN
				gSafety.o.Status_Print := 'Unable to read status';
				//requestMessageToLog(ADR('Error, RCTRL, attempting to read status'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF gSafety.prv.FBK.RemoteControl.Error AND gSafety.prv.FBK.RemoteControl.StatusID = 36105 THEN
				gSafety.o.Status_Print := 'Comm Err (Rebooting?)';
				bgTimerStart(gSafety.prv.Timer.Timer_Print_HMI_Status, Tms(DEFINE_TIME_PRINT_HMI_STATUS));
				gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout reading status (PLC &| SLX Reboot may be required)';
				//requestMessageToLog(ADR('Status read timeout'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_WAIT_COMMAND:
			Action_Reset_FBK;
			gSafety.o.Status_Print := 'Waiting on User Input Command';

			IF gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.Scanning = 1 AND bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Rescan) AND (gSafety.o.RCTRL.SafeOSState <> SAFEOS_RUN_SAFE) THEN
				gSafety.o.Status_Print := 'Updating SLX status information, please wait';
				gSafety.o.RCTRL.SafeOSState := SAFEOS_UPDATING_STATUS;
				gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
			ELSIF gSafety.i.Command.Ack_All_UDID THEN
				Action_Init_RCTRL_Cmd;

				CASE gSafety.prv.FBK.RemoteControl.SafeLOGICStatus.NumberOfUDIDMismatches OF
					0:
						gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_1_UDID_ACKN;
					1:
						gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_1_UDID_ACKN;
					2:
						gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_2_UDID_ACKN;
					3:
						gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_3_UDID_ACKN;
					4:
						gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_4_UDID_ACKN;
					ELSE
						gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_N_UDID_ACKN;
				END_CASE;
				
				//requestMessageToLog(ADR('Acknowledging modules'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_CONFIRM_MODULES;
			ELSIF gSafety.i.Command.Ack_Firmware THEN
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_FW_ACKN;
				//requestMessageToLog(ADR('Confirming Firmware'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_CONFIRM_FW;
			ELSIF gSafety.i.Command.Ack_Safekey_Exchange THEN
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_SK_XCHG;
				//requestMessageToLog(ADR('Confirming SK Xchg'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_CONFIRM_SK_XCHG;
			ELSIF gSafety.i.Command.Test_LED THEN
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_TEST;
				//requestMessageToLog(ADR('Testing LEDs'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_LED_TEST;
			ELSIF gSafety.i.Command.Sys_Scan THEN
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_SCAN;
				//requestMessageToLog(ADR('Scanning system...'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_SCAN;
			ELSIF gSafety.i.Command.Alter_SK_Password THEN
//				perm_Sys_Commissioned := FALSE;
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_SK_PW;
				gSafety.prv.Data.RemoteControlCmd.NewPassword := gSafety.i.Password_New;
				//requestMessageToLog(ADR('Altering SK password'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_SET_PASSWORD;
			ELSIF gSafety.i.Command.Format_SK THEN
				//				perm_Sys_Commissioned := FALSE;
				brsmemset(ADR(gSafetyPermInfo), 0, SIZEOF(paiSL_Perm_Info_typ));
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_SK_FORMAT;
				//requestMessageToLog(ADR('Formatting SafeKey'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_FORMAT_SAFEKEY;
			ELSIF gSafety.i.Command.Reset THEN
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_RESET;
				//requestMessageToLog(ADR('Resetting...'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_RESET;
			ELSIF gSafety.i.Command.Clear_Data THEN
				Action_Init_RCTRL_Cmd;
				gSafety.prv.Data.RemoteControlCmd.Data := safeCMD_CLEAR_DATA;
				//requestMessageToLog(ADR('Clearing Data'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_CLEAR_DATA;
			ELSIF gSafety.i.Command.Download_Application THEN
				gSafety.o.RCTRL.SafeOSState := SAFEOS_UPDATING_STATUS;
				brsmemset(ADR(gSafety.o.Command_Allowed), 0, SIZEOF(paiSL_Operations_typ));
				brsmemset(ADR(gSafety.o.Command_Being_Executed), 0, SIZEOF(paiSL_Operations_typ));
				gSafety.prv.FBK.DownloadApplication.Execute := FALSE;
				gSafety.prv.FBK.RemoteControl.Execute := FALSE;
				
				gSafety.prv.Data.Read_UDID_Low.Value := 0;
				gSafety.prv.Data.Read_UDID_Low.Valid := FALSE;
				
				gSafety.prv.Data.Read_UDID_High.Value := 0;
				gSafety.prv.Data.Read_UDID_High.Valid := FALSE;

				gSafety.prv.Data.DownloadAppCmd.Password := gSafety.i.Password_for_command;

				gSafety.prv.Data.DownloadAppCmd.ApplicationID := DEFINE_SAFETY_APP_ID;//TODO: optional functionality not implemented to load .swt file from declared file dev.
				
				gSafety.prv.FBK.UDID_Low.enable := TRUE;
				gSafety.prv.FBK.UDID_Low.pDeviceName := ADR(DEFINE_SAFELOGIC_ADDRESS);
				gSafety.prv.FBK.UDID_Low.pChannelName := ADR('UDID_low');
				gSafety.prv.FBK.UDID_High.enable := TRUE;
				gSafety.prv.FBK.UDID_High.pDeviceName := ADR(DEFINE_SAFELOGIC_ADDRESS);
				gSafety.prv.FBK.UDID_High.pChannelName := ADR('UDID_high');
				
				//requestMessageToLog(ADR('Reading UDIDs'), Init_Logbook.pLog, arlogLEVEL_INFO,0,0,0);
				bgTimerStart(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd, Tms(DEFINE_TIME_MAX_RCTRL_CMD));
				gSafety.o.State := SAFE_PROGRAM_READ_UDID;
			END_IF;
		
		SAFE_PROGRAM_READ_UDID:
			gSafety.o.Status_Print := 'Reading Module UDIDs, please wait';
			
			IF gSafety.prv.FBK.UDID_Low.status = 0 AND NOT gSafety.prv.Data.Read_UDID_Low.Valid THEN
				gSafety.prv.FBK.UDID_Low.enable := FALSE;
				gSafety.prv.Data.Read_UDID_Low.Value := gSafety.prv.FBK.UDID_Low.value;
				gSafety.prv.Data.Read_UDID_Low.Valid := TRUE;
			END_IF;
			
			IF gSafety.prv.FBK.UDID_High.status = 0 AND NOT gSafety.prv.Data.Read_UDID_High.Valid THEN
				gSafety.prv.FBK.UDID_High.enable := FALSE;
				gSafety.prv.Data.Read_UDID_High.Value := gSafety.prv.FBK.UDID_High.value;
				gSafety.prv.Data.Read_UDID_High.Valid := TRUE;
			END_IF;

			IF gSafety.prv.Data.Read_UDID_Low.Valid AND gSafety.prv.Data.Read_UDID_High.Valid THEN
				gSafety.prv.Data.DownloadAppCmd.UDID_Low := gSafety.prv.Data.Read_UDID_Low.Value;
				gSafety.prv.Data.DownloadAppCmd.UDID_High := UDINT_TO_UINT(gSafety.prv.Data.Read_UDID_High.Value);
			
				gSafety.prv.FBK.DownloadApplication.Execute := TRUE;
				
				gSafety.prv.Data.DownloadAppCmd.Unlock := 0;
				
				//requestMessageToLog(ADR('UDID Read successful'), Init_Logbook.pLog, arlogLEVEL_INFO,0,0,0);
				bgTimerStart(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd, Tms(DEFINE_TIME_MAX_RCTRL_CMD));
				gSafety.o.State := SAFE_PROGRAM_DOWNLOAD_APP;
			ELSIF gSafety.prv.FBK.UDID_Low.status <> 0 AND gSafety.prv.FBK.UDID_Low.status <> 65535 AND gSafety.prv.FBK.UDID_Low.status <> 65534 AND gSafety.prv.FBK.UDID_High.status <> 0 AND gSafety.prv.FBK.UDID_High.status <> 65535 AND gSafety.prv.FBK.UDID_High.status <> 65534 THEN
				
				//requestMessageToLog(ADR('UDID Read Error-High'), Init_Logbook.pLog, arlogLEVEL_WARNING,UINT_TO_UDINT(gSafety.prv.FBK.UDID_High.status),0,0);
				//requestMessageToLog(ADR('UDID Read Error-Low'), Init_Logbook.pLog, arlogLEVEL_WARNING,UINT_TO_UDINT(gSafety.prv.FBK.UDID_Low.status),0,0);
					
				gSafety.o.Status_Print := 'Err reading UDIDs';
					
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) AND NOT (gSafety.prv.Data.Read_UDID_Low.Valid AND gSafety.prv.Data.Read_UDID_High.Valid) THEN
				gSafety.o.Status_Print := 'Timeout reading UDIDs';
				//requestMessageToLog(ADR('Timeout during UDID Read'), Init_Logbook.pLog, arlogLEVEL_WARNING,0,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
			
		SAFE_PROGRAM_DOWNLOAD_APP:
			gSafety.o.Status_Print := 'Downloading Application from PLC to SafeLogic Controller';
			
			IF gSafety.prv.FBK.DownloadApplication.UnlockRequired THEN
				gSafety.prv.Data.DownloadAppCmd.Unlock := 1;
			END_IF;
			
			IF gSafety.prv.FBK.DownloadApplication.Done AND NOT gSafety.prv.FBK.DownloadApplication.Error THEN
				IF gSafety.prv.FBK.DownloadApplication.Error THEN
					//requestMessageToLog(ADR('Error Downloading Application (Did you set the password?)'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.DownloadApplication.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Downloaded Application (PLC Power Cycle Required)'), Init_Logbook.pLog, arlogLEVEL_INFO,0,0,0);
					gSafety.o.Status_Print := 'Successfully downloaded application';
					gSafetyPermInfo.Application_Downloaded := 1;
//					perm_Sys_Commissioned := FALSE;
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.DownloadApplication.Error AND NOT gSafety.prv.FBK.DownloadApplication.StatusID = 65535 THEN
				gSafety.o.Status_Print := 'Error Downloading Application from PLC to SafeLogic Controller';
				//requestMessageToLog(ADR('Error Downloading Application'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.DownloadApplication.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout Downloading Program, try again';
				//requestMessageToLog(ADR('Timeout during prog download'), Init_Logbook.pLog, arlogLEVEL_WARNING,0,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_SET_PASSWORD:
			gSafety.o.Status_Print := 'Setting new SLX password';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error Altering SLX Password'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Changed Password'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
//					perm_Sys_Commissioned := FALSE;
					gSafety.o.Status_Print := 'Successfully Changed SLX Password';
					gSafetyPermInfo.Password_Set := 1;
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error Altering SLX Password';
				//requestMessageToLog(ADR('Error Altering SLX Password'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout changing password';
				//requestMessageToLog(ADR('Timeout during password change'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
			
		SAFE_PROGRAM_FORMAT_SAFEKEY:
			gSafety.o.Status_Print := 'Formatting Safekey Then Rebooting...';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error Formatting Safekey1'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Formatted Safekey (Reset required)'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
//					perm_Sys_Commissioned := FALSE;
					gSafety.o.Status_Print := 'Successfully Formatted Safekey';
					gSafetyPermInfo.Safekey_Formatted := 1;
					bgTimerStart(gSafety.prv.Timer.Timer_Print_HMI_Status, Tms(DEFINE_TIME_PRINT_HMI_STATUS));
					SYSreset(1,1);
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error AND gSafety.prv.FBK.RemoteControl.StatusID <> 65535 THEN
				gSafety.o.Status_Print := 'Possible error Formatting Safekey (New password?  Powercycle PLC & SLX?)';
				gSafetyPermInfo.Safekey_Formatted := 1;
				//requestMessageToLog(ADR('Error Formatting Safekey2'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout formatting SK';
				//requestMessageToLog(ADR('Timeout during SK Format'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_CONFIRM_SK_XCHG:
			gSafety.o.Status_Print := 'Confirming Safekey exchange';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during confirming SK XCHG'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Acknowledged SK XCHG'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully Acknowledged SK XCHG';
					gSafetyPermInfo.SKey_Exchanged := 1;
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error during confirming SK XCHG';
				//requestMessageToLog(ADR('Error during confirming SK XCHG'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout confirming SK exchange';
				//requestMessageToLog(ADR('Timeout during SK XCHG confirmation'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_CONFIRM_FW:
			gSafety.o.Status_Print := 'Confirming FW mismatch';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during Firmware ACK'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Ackd FW'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully acknowledged firmware change';
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error Confirming FW mismatch';
				//requestMessageToLog(ADR('Error during Firmware ACK'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout acknowledging firmware mismatch';
				//requestMessageToLog(ADR('Timeout during FW ACK'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_SCAN:
			gSafety.o.Status_Print := 'Performing System Scan';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during performing system scan'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Scanned system'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully Scanned System';
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error Performing System Scan';
				//requestMessageToLog(ADR('Error during performing system scan'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout during network scan';
				//requestMessageToLog(ADR('Timeout during system scan'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_LED_TEST:
			gSafety.o.Status_Print := 'Testing LEDs';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during LED test'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('LED Test Concluded'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully carried out LED test procedure';
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error Testing LEDs';
				//requestMessageToLog(ADR('Error during LED test'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout during LED test';
				//requestMessageToLog(ADR('Timeout during LED Test'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_CLEAR_DATA:
			gSafety.o.Status_Print := 'Clearing Reloaded Data';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during clear data'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Cleared SLX Data'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully cleared SLX data';
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error Clearing Reloaded Data';
				//requestMessageToLog(ADR('Error during clear data'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout clearing SLX data';
				//requestMessageToLog(ADR('Timeout during clear SLX data'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_CONFIRM_MODULES:
			gSafety.o.Status_Print := 'Confirming Module UDID mismatch';

			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during UDID mismatch confirmation'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Ackd UDID mismatch'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully completed UDID mismatch acknowledgement';
					gSafetyPermInfo.ACK_UDID_Firmware := 1;
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Error Confirming Module UDID mismatch';
				//requestMessageToLog(ADR('Error during UDID mismatch confirmation'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout during UDID mismatch acknowledgment';
				//requestMessageToLog(ADR('Timeout during UDID mismatch ACK'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;
		
		SAFE_PROGRAM_RESET:
			gSafety.o.Status_Print := 'Resetting Data';
			
			IF gSafety.prv.FBK.RemoteControl.Done AND NOT gSafety.prv.FBK.RemoteControl.Error THEN
				IF gSafety.prv.FBK.RemoteControl.Error THEN
					//requestMessageToLog(ADR('Error during data reset'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
					gSafety.o.State := SAFE_PROGRAM_ERROR;
				ELSE
					//requestMessageToLog(ADR('Reset SLX data'), Init_Logbook.pLog, arlogLEVEL_INFO,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
					gSafety.o.Status_Print := 'Successfully reset SLX data';
					gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
				END_IF;
			ELSIF gSafety.prv.FBK.RemoteControl.Error THEN
				gSafety.o.Status_Print := 'Data Reset Error';
				//requestMessageToLog(ADR('Error during data reset'), Init_Logbook.pLog, arlogLEVEL_WARNING,gSafety.prv.FBK.RemoteControl.StatusID,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			ELSIF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd) THEN
				gSafety.o.Status_Print := 'Timeout resetting SLX';
				//requestMessageToLog(ADR('Timeout during SLX data reset'), Init_Logbook.pLog, arlogLEVEL_WARNING,DEFINE_OFFSET_ERR_START + gSafety.prv.Command_Number,0,0);
				gSafety.o.State := SAFE_PROGRAM_ERROR;
			END_IF;

		SAFE_PROGRAM_ERROR:
			Action_Reset_FBK;
			brsmemset(ADR(gSafety.i.Command), 0, SIZEOF(paiSL_Operations_typ));
			brsmemset(ADR(gSafety.o.Command_Being_Executed), 0, SIZEOF(paiSL_Operations_typ));
			
			IF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Error_Retry) THEN
				gSafety.o.Status_Print := 'Returning...';
				
				bgTimerStart(gSafety.prv.Timer.Timer_Print_HMI_Status, Tms(DEFINE_TIME_PRINT_HMI_STATUS));
				gSafety.o.State := SAFE_PROGRAM_PRINT_STATUS_WAIT;
			END_IF;
			
		SAFE_PROGRAM_PRINT_STATUS_WAIT:
			Action_Reset_FBK;

			brsmemset(ADR(gSafety.o.Command_Being_Executed), 0, SIZEOF(paiSL_Operations_typ));
			
			IF bgTimerIsTimeOut(gSafety.prv.Timer.Timer_Print_HMI_Status) THEN
				
				gSafety.prv.Command_Number := gSafety.prv.Command_Number + 1;
				gSafety.prv.Data.RemoteControlCmd.Number := gSafety.prv.Command_Number;
				
				bgTimerStart(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd, Tms(DEFINE_TIME_MAX_RCTRL_CMD));
				gSafety.prv.FBK.RemoteControl.Execute := TRUE;
				gSafety.o.State := SAFE_PROGRAM_READ_STATUS;
			END_IF;
	END_CASE;
	
	gSafety.prv.FBK.RemoteControl();
	gSafety.prv.FBK.DownloadApplication();
	gSafety.prv.FBK.UDID_Low();
	gSafety.prv.FBK.UDID_High();
	
	bgTimerCyclic(gSafety.prv.Timer.Timer_Print_HMI_Status);
	bgTimerCyclic(gSafety.prv.Timer.Timer_Max_RCTRL_Cmd);
	bgTimerCyclic(gSafety.prv.Timer.Timer_Error_Retry);
	bgTimerCyclic(gSafety.prv.Timer.Timer_Rescan);
	
	gSafety.o.State_Old := gSafety.o.State;
END_PROGRAM
