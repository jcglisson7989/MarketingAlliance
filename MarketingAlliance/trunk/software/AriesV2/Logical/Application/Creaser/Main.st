
PROGRAM _INIT
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	//Set alarm values based on IO points->
	gAlarms.SM1_Disabled := IO.iSM1Disabled;
	gAlarms.Unsafe_Machine_State := NOT IO.iSafeMachineState;
	
	IF (NOT IO.iSafeMachineState) AND (MachineState <> MACHINE_STATE_ERROR) THEN
		MachineState := MACHINE_STATE_ERROR;
	END_IF;
	
	CASE MachineState OF
		MACHINE_STATE_INIT:
			IO.oCreaserCCWRotation := FALSE;
			IO.oCreaserCWRotation := FALSE;
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
		
		MACHINE_STATE_IDLE:
			IO.oCreaserCCWRotation := FALSE;
			IO.oCreaserCWRotation := FALSE;
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
		
		MACHINE_STATE_RUNNING:
			
		
		MACHINE_STATE_ERROR:
			IO.oCreaserCCWRotation := FALSE;
			IO.oCreaserCWRotation := FALSE;
			IO.oBoardFeedingLight := FALSE;
//			IO.oUIIndicatorLight := FBK_Pulse_Indicator;
		
	END_CASE;
	
	
	
	 IO_LastCycle := IO;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

