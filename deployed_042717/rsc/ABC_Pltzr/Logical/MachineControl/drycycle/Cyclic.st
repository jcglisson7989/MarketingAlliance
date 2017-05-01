
PROGRAM _CYCLIC
	(* Insert code here *)	
	elevatorTimer();

	IF ((dryCycleState <> 0) AND (NOT gCtrl.main.noFaults)) THEN
		dryCycleState := 0;
	END_IF;	
	
	
	CASE dryCycleState OF
		0 : IF gCtrl.main.testBit1 THEN//wait here
				gCtrl.main.testBit1 := 0;
				dryCycleState := 1;
				elevatorTimer.IN := 0;
				elevatorTimer.PT := REAL_TO_UDINT(gPallete.palCfg.palSettings.timers.dlyTableLayerRdyToElevMove * 1000);			
			END_IF;	
		1: //wait a delay before start moving elevator
			elevatorTimer.IN := 1;
			IF elevatorTimer.Q THEN
				dryCycleState := 20;
				gCtrl.elevator.hmiBtnElevatorFwd := 1;//move elevator
				elevatorTimer.IN := 0;
				elevatorTimer.PT := REAL_TO_UDINT(gConfigApp.options.tmDryCycleElevatorUp * 1000) * gCtrlAnimation.currentLayer + REAL_TO_UDINT(gConfigApp.options.tmDryCycleLayerZeroOffset * 1000);			
			END_IF;	
		
		20://box pusher is done
			elevatorTimer.IN := 1;
			IF elevatorTimer.Q THEN
				elevatorTimer.IN := 0;
				gCtrl.elevator.hmiBtnElevatorFwd := 0;
				gCtrl.transfertable.hmiBtnTableFwd := 1;
				dryCycleState := 30;
			END_IF;	
		30:
			IF gCtrl.transfertable.isTableAtPallete THEN
				gCtrl.squaring.hmiBtnSidePlatesExtRet := 1;
				gCtrl.retainerbar.hmiBtnRetainterBarFwd := 1;
				
				elevatorTimer.IN := 1;
				elevatorTimer.PT := T#3s;			
	
				dryCycleState := 35;
			END_IF;	
		35:
			IF elevatorTimer.Q THEN
				gCtrl.transfertable.hmiBtnTableRev := 1;
				dryCycleState := 40;				
			END_IF;
		
		40://
			IF gCtrl.transfertable.isTableAtGrouping THEN
				gCtrl.squaring.hmiBtnSidePlatesExtRet := 0;
				gCtrl.retainerbar.hmiBtnRetainterBarRev := 1;
				gCtrl.elevator.hmiBtnElevatorToGrouping := 1;
				dryCycleState := 50;
			END_IF;	
		50://wait for elevator to come back home
			IF gCtrl.elevator.elevatorIsAtHome THEN
				dryCycleState := 0;
				gCtrl.main.testBit3 := 1;
			END_IF;	
		60://dry cycle is done
			
		ELSE
			
	END_CASE;	
	
END_PROGRAM
