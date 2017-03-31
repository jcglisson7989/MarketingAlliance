
PROGRAM _INIT
	
	//Valve names for alarm groups-
	ValveFBK[0].Name := 'Valve 1';
	ValveFBK[1].Name := 'Valve 2';
	
END_PROGRAM

PROGRAM _CYCLIC
	FOR ii_valves :=0 TO MAX_IDX_VALVES BY 1 DO
		
		IF gRecCfg.active.Cfg.Dispense[ii_valves].Disable = 1 THEN
			gRecCfg.active.Rec.Dispense[ii_valves].Enable := FALSE;
		END_IF;
		
		ValveFBK[ii_valves].pCounterValveNotRdy := ADR(gStatistics.Debug.Valve_Not_Rdy[ii_valves].Count);
		ValveFBK[ii_valves].pCyclesCounter := ADR(gStatistics.Debug.Disp_Cycle_Count[ii_valves].Count);
		ValveFBK[ii_valves].iVBlockFractionalPosition := Position.Target_Fractional_Position_Pct;
		ValveFBK[ii_valves].iX2XNettime := ControlIO.iX2XNettime;
		ValveFBK[ii_valves].Recipe := ADR(gRecCfg.active.Rec.Dispense[ii_valves]);
		ValveFBK[ii_valves].Config := ADR(gRecCfg.active.Cfg.Dispense[ii_valves]);
		ValveFBK[ii_valves].IO := ADR(ValveIO[ii_valves]);
		ValveFBK[ii_valves].Alarms := ADR(gAlarms.Sureshot3500[ii_valves]);
		ValveFBK[ii_valves]();
		
		IF gStatistics.Debug.Valve_Not_Rdy[ii_valves].Count > Debug_Stats_LastCycle.Valve_Not_Rdy[ii_valves].Count THEN
			gStatistics.Debug.Valve_Not_Rdy[ii_valves].Latch_Position := Position;
		END_IF;
		
	END_FOR;
	
	Debug_Stats_LastCycle := gStatistics.Debug;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

//Notes-
//-Four valves were included such that they could be substituted.  Can be disabled if functionality is undesirable.