
PROGRAM _INIT
	VelCalc_DT_Element.Enable := 1;
	VelCalc_DT_Element.Gain := 1;
	VelCalc_DT_Element.TimeConstant := DEFINE_TN_VELCALC;
	VelCalc_DT_Element();
	
	gState := STATE_INIT;
END_PROGRAM

PROGRAM _CYCLIC

	//Action for testing the PiP sensor->
	Action_Test_PiP_Trigger;
		
//	ControlIO.Inspection.oInspectionGood := ValveIO[0].oDispTrigger;
	//	ControlIO.Inspection.oInspectionValid := ValveIO[1].oDispTrigger;
	
	//Have to check for the following...
	IF gRecCfg.active.Cfg.Control.N_Encoder_Bits_SingleTurn = 0 OR gRecCfg.active.Rec.Control.N_Targets_On_Dial = 0 THEN
		gAlarms.Control.Invalid_Par := TRUE;
		RETURN; //...Otherwise machine will go into service mode due to integer div. 0 error
	END_IF;
	
	//Handle commands from HMI (Home pos., reset stats)
	Action_HMI_Commands_Handler;
	//Calc current pos/vel of the dial for triggering purposes-
	Action_Dial_Position_Velocity_Calc;
	
	IF gState <> STATE_ERROR AND (NOT (StatusIO.iProcessStopRelay[0] AND StatusIO.iProcessStopRelay[1])) THEN
		gState := STATE_ERROR;
	END_IF;
	
	//Manage PiP target sensor debounce to prevent "dirty edge" switching->
	ControlIO.PiP_Sensor_Debounce.pConfigVals := ADR(gRecCfg.active.Cfg.Control.Debounce_PiP);
	ControlIO.PiP_Sensor_Debounce(input := ControlIO.iTargetPiP);
		
	//On target index, reset "TargetInfoArray" index for the target that has just moved in front of the PiP sensor (all values to 0)
	IF Position.Current_Target <> Position_LastCycle.Current_Target THEN
		brsmemset(ADR(TargetInfoArray[Position.Current_Target]), 0, SIZEOF(Target_typ));
	END_IF;
	
	//On + edge of SW debounced PiP sensor, enter info. into array-
	IF ControlIO.PiP_Sensor_Debounce.Signal_Debounced = 1 AND ControlIO_LastCycle.PiP_Sensor_Debounce.Signal_Debounced = 0 THEN
		IF TargetInfoArray[Position.Current_Target].VBlock_Occupied THEN //Handler for diagnostics purposes when there are 2 + edges on the same target
			gStatistics.Count_PiP_Twice_Single_Targ.Count := gStatistics.Count_PiP_Twice_Single_Targ.Count + 1;
			gStatistics.Count_PiP_Twice_Single_Targ.Latch_Position := Position;
		ELSE
			gStatistics.VBlock_Fraction_Pos_Last_Edge := Position.Target_Fractional_Position_Pct;
			TargetInfoArray[Position.Current_Target].VBlock_Occupied := TRUE;
			gStatistics.Total_Num_Targets := gStatistics.Total_Num_Targets + 1;
			bgTimerStart(Timer_Pulse_Target_Present, Tms(gRecCfg.active.Cfg.Control.Target_Present_Pulse_Time_S));
		END_IF;
	END_IF;
	
	ControlIO.oTargetPresent := NOT bgTimerIsTimeOut(Timer_Pulse_Target_Present);
	
	Flag_Cure_Error_Exists := FALSE;
	
	IF gRecCfg.active.Rec.Control.Enable_Cure[0] = 1 AND NOT CureIO.iUVCuringChannelOK[0] THEN
		Flag_Cure_Error_Exists := TRUE;
	END_IF;
	
	IF gRecCfg.active.Rec.Control.Enable_Cure[1] = 1 AND NOT CureIO.iUVCuringChannelOK[1] THEN
		Flag_Cure_Error_Exists := TRUE;
	END_IF;

	//Flag for valve error, reset on every cycle->
	Flag_Valve_Error_Exists := FALSE;
	
	FOR ii_valves := 0 TO MAX_IDX_VALVES BY 1 DO
		//Set values of current target index in front of each dispense unit
		Control.Dispense[ii_valves].Current_Target_At_Dispense_Unit := ((Position.Current_Target) + (gRecCfg.active.Rec.Control.N_Targets_On_Dial - gRecCfg.active.Rec.Dispense[ii_valves].Target_Offset)) MOD (gRecCfg.active.Rec.Control.N_Targets_On_Dial);
		Control.Dispense[ii_valves].Target_Fractional_Position_Pct := Position.Target_Fractional_Position_Pct;
		
		IF ValveFBK[ii_valves].oState = DISPENSE_STATE_ERROR THEN
			Flag_Valve_Error_Exists := TRUE;
		END_IF;
		
		gStatistics.Dispense_Discrepancy := UDINT_TO_DINT(gStatistics.Debug.Disp_Trigger_Count[ii_valves].Count - gStatistics.Debug.Disp_Cycle_Count[ii_valves].Count);
	END_FOR;
	
	CASE gState OF
		STATE_INIT:
			ColorBar := COLOR_NONE;
			StatusIO.oSystemNeedsAttention := FALSE;
			StatusIO.oRunningReady := FALSE;
			
			CureIO.oUVCureChannel[0] := FALSE;
			CureIO.oUVCureChannel[1] := FALSE;
		
			gState := STATE_IDLE;
		STATE_IDLE:
			ColorBar := COLOR_GREEN_FLASH;
			StatusIO.oSystemNeedsAttention := FALSE;
			StatusIO.oRunningReady := TRUE;
			
			CureIO.oUVCureChannel[0] := gRecCfg.active.Rec.Control.Enable_Cure[0] = 1;
			CureIO.oUVCureChannel[1] := gRecCfg.active.Rec.Control.Enable_Cure[1] = 1;
		
			IF Flag_Valve_Error_Exists OR Flag_Cure_Error_Exists THEN
				gState := STATE_ERROR;
			ELSIF ControlIO.iRunCmd THEN
				gState := STATE_RUNNING;
			END_IF;
		
		STATE_RUNNING:
			ColorBar := COLOR_GREEN;
			Action_Dispense_TriggerFinger;
			StatusIO.oSystemNeedsAttention := FALSE;
			StatusIO.oRunningReady := TRUE;
			
			CureIO.oUVCureChannel[0] := gRecCfg.active.Rec.Control.Enable_Cure[0] = 1;
			CureIO.oUVCureChannel[1] := gRecCfg.active.Rec.Control.Enable_Cure[1] = 1;
			
			Action_Manage_Update_Total_Runtime;
		
			IF NOT ControlIO.iRunCmd THEN
				gState := STATE_IDLE;
			ELSIF Flag_Valve_Error_Exists OR Flag_Cure_Error_Exists THEN
				gState := STATE_ERROR;
			END_IF;
		
		STATE_ERROR:
			ColorBar := COLOR_RED;
			StatusIO.oSystemNeedsAttention := TRUE;
			StatusIO.oRunningReady := FALSE;
			
			CureIO.oUVCureChannel[0] := FALSE;
			CureIO.oUVCureChannel[1] := FALSE;
			
			IF StatusIO.iProcessStopRelay[0] AND StatusIO.iProcessStopRelay[1] AND (StatusIO.iClearError AND NOT StatusIO_LastCycle.iClearError) (*AND (NOT Flag_Valve_Error_Exists)*) AND (NOT Flag_Cure_Error_Exists) THEN
				FOR ii_valves := 0 TO MAX_IDX_VALVES BY 1 DO
					ValveFBK[ii_valves].iReset := TRUE;
				END_FOR;
				
				gState := STATE_IDLE;
			END_IF;
		
	END_CASE;	
	
	bgTimerCyclic(Timer_Pulse_Target_Present);
	
	Action_Set_Colorbar_IO;
	
	Position_LastCycle := Position;
	Position_SHL_LastCycle := Position_SHL;
	
	CureIO_LastCycle := CureIO;
	StatusIO_LastCycle := StatusIO;
	ControlIO_LastCycle := ControlIO;
END_PROGRAM

PROGRAM _EXIT

END_PROGRAM

