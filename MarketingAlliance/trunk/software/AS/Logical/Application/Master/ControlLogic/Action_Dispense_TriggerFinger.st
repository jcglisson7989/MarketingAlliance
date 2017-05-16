
ACTION Action_Dispense_TriggerFinger: 
	IF Position.Current_Target <> Position_LastCycle.Current_Target THEN
		FOR ii_valves := 0 TO MAX_IDX_VALVES BY 1 DO
			IF gRecCfg.active.Cfg.Dispense[ii_valves].Disable = 0 AND gRecCfg.active.Rec.Dispense[ii_valves].Enable = 1 THEN
				IF TargetInfoArray[Control.Dispense[ii_valves].Current_Target_At_Dispense_Unit].VBlock_Occupied AND NOT TargetInfoArray[Control.Dispense[ii_valves].Current_Target_At_Dispense_Unit].VBlock_Dispensed[ii_valves] THEN
					IF ValveFBK[ii_valves].iFlagDispenseOnFractionOffset THEN
						gStatistics.Debug.Disp_Flag_Twice[ii_valves].Count := gStatistics.Debug.Disp_Flag_Twice[ii_valves].Count + 1;
						gStatistics.Debug.Disp_Flag_Twice[ii_valves].Latch_Position := Position;
						
					ELSE
						ValveFBK[ii_valves].iFlagDispenseOnFractionOffset := TRUE;
						gStatistics.Debug.Disp_Trigger_Count[ii_valves].Count := gStatistics.Debug.Disp_Trigger_Count[ii_valves].Count + 1;
						TargetInfoArray[Control.Dispense[ii_valves].Current_Target_At_Dispense_Unit].VBlock_Dispensed[ii_valves] := TRUE;
					END_IF;
				END_IF;
			END_IF;
		END_FOR;
	END_IF;
END_ACTION
