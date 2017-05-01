
PROGRAM _CYCLIC
	(* Insert code here *)	
	
	//===========================================================================================
	//Manipulate elevator speeds (lower speed when approaching home position)
	IF gCtrl.main.elevatorStopBlockActive THEN
		//When stop blocks are active make sure that the elevator only moves using a slow speed!!!
		gMachineVFD[1].vfdCtrl.iVelocitySetPoint := DINT_TO_INT(gPallete.palCfg.palSettings.vfd[1].velocitySlow_rpm);
		IF gMachineVFD[1].vfdCtrl.iVelocitySetPoint > 300 THEN
			gMachineVFD[1].vfdCtrl.iVelocitySetPoint := 300;
		END_IF;	
	ELSE	
		IF gCtrl.elevator.hmiBtnElevatorToGrouping AND (gCtrl.elevator.elevatorIsAboveNearHome OR gCtrl.elevator.elevatorIsBelowNearHome) THEN
			gMachineVFD[1].vfdCtrl.iVelocitySetPoint := DINT_TO_INT(gPallete.palCfg.palSettings.vfd[1].velocitySlow_rpm); 							
		ELSE
			gMachineVFD[1].vfdCtrl.iVelocitySetPoint := DINT_TO_INT(gPallete.palCfg.palSettings.vfd[1].velocity_rpm); 												
		END_IF;
		
		//Any Jog move ALWAYS uses SLOW SPEED
		//In auto mode (i.e. hmiBtnElevatorRev) reverse mode ALWAYS uses SLOW SPEED when approaching pallet top (i.e. table is NOT at grouping)
		IF (NOT gCtrl.transfertable.isTableAtGrouping AND gCtrl.elevator.hmiBtnElevatorRev) OR 
			( (gCtrl.elevator.elevatorIsBelowHome OR  gCtrl.elevator.elevatorIsBelowNearHome OR gCtrl.elevator.elevatorIsBelowHomeUnknown) AND (gCtrl.elevator.hmiBtnElevatorRevJog OR gCtrl.elevator.hmiBtnElevatorFwdJog) ) THEN
			gMachineVFD[1].vfdCtrl.iVelocitySetPoint := DINT_TO_INT(gPallete.palCfg.palSettings.vfd[1].velocitySlow_rpm); 										
		END_IF;	
			
		
	END_IF;
	
	//===========================================================================================
	//Process request for: Move elevator to Grouping Position
	IF gCtrl.elevator.hmiBtnElevatorToGrouping THEN	
		gCtrl.elevator.hmiBtnElevatorToPallete := 0;	
		gCtrl.elevator.hmiBtnElevatorToAbovePallete := 0;
		gCtrl.elevator.hmiBtnElevatorToTop := 0;
		
		//reset hmiBtnElevatorToGrouping only when at home and vfd at stand still (avoid issue with long decel)
		IF gCtrl.elevator.elevatorIsAtHome AND (gMachineVFD[1].vfdIn.Status.CurrentVelocity = 0) THEN
			gCtrl.elevator.hmiBtnElevatorToGrouping := 0;
		END_IF;
		
		IF gCtrl.elevator.elevatorIsAtHome THEN
			//gCtrl.elevator.hmiBtnElevatorToGrouping := 0;
			gCtrl.elevator.hmiBtnElevatorRev := 0;	
			gCtrl.elevator.hmiBtnElevatorFwd := 0;				
		ELSE
			
			IF NOT gCtrl.transfertable.isTableAtGrouping THEN//tansfer table back to grouping before driving elveator up/down
				gCtrl.transfertable.hmiBtnTableRev := 1;			
			END_IF;
			
			IF gCtrl.elevator.elevatorIsAboveHome THEN//above? > send it down
				gCtrl.elevator.hmiBtnElevatorFwd := 0;						
				gCtrl.elevator.hmiBtnElevatorRev := 1;
			ELSIF gCtrl.elevator.elevatorIsBelowHome THEN//below> > send it up
				gCtrl.elevator.hmiBtnElevatorFwd := 1;				
				gCtrl.elevator.hmiBtnElevatorRev := 0;
			ELSE //don't know > send it down ???? should not happen
				gCtrl.elevator.hmiBtnElevatorFwd := 0;						
				gCtrl.elevator.hmiBtnElevatorRev := 1;
			END_IF;	
		END_IF;	
	END_IF	
	
	
	//===========================================================================================
	//Process request for: Move elevator to top of the pallet position
	gCtrl.elevator.tmrPalletePEOn.PT := REAL_TO_TIME (gPallete.palCfg.palSettings.timers.onDlyEEPallete * 1000.0);
	gCtrl.elevator.tmrPalletePEOn.IN := gMachineIO.din.ElevatorDetectPalletLayerLF_EE1 OR gMachineIO.din.ElevatorFullDown_PR2; 
	gCtrl.elevator.tmrPalletePEOn();
	
	gCtrl.elevator.tmrPalletePEOff.PT := REAL_TO_TIME (gPallete.palCfg.palSettings.timers.offDlyEEPallete * 1000.0);
	gCtrl.elevator.tmrPalletePEOff.IN := gMachineIO.din.ElevatorDetectPalletLayerLF_EE1; 
	gCtrl.elevator.tmrPalletePEOff();
	
	//any move resets above pallete flags
	IF gCtrl.elevator.elevatorIsAtPalleteBelowHome AND (gCtrl.elevator.hmiBtnElevatorFwd OR gCtrl.elevator.hmiBtnElevatorRev) THEN
		//gCtrl.elevator.elevatorIsAtPalleteAboveHome := 0;//not used!!!
		gCtrl.elevator.elevatorIsAtPalleteBelowHome := 0;		
	END_IF;	
	
	
	//===========================================================================================
	IF (gCtrl.elevator.hmiBtnElevatorToPallete = 1) THEN
		gCtrl.elevator.hmiBtnElevatorToGrouping := 0;
		gCtrl.elevator.hmiBtnElevatorToAbovePallete := 0;
		gCtrl.elevator.hmiBtnElevatorToTop := 0;
		
		//Sequence starts here!
		IF (gCtrl.elevator.elevatorIsAtHome AND gCtrl.transfertable.isTableAtGrouping) THEN
			IF gMachineIO.din.ElevatorDetectPalletLayerLF_EE1 THEN
				//If pallete detect PE is blocked > move elevator up
				gCtrl.elevator.hmiBtnElevatorFwd := 1;						
				gCtrl.elevator.hmiBtnElevatorRev := 0;	
			ELSE
				//If pallete detect PE NOT blocked > move table to pallete
				gCtrl.transfertable.hmiBtnTableFwd := 1;						
				gCtrl.transfertable.hmiBtnTableRev := 0;						
			END_IF;			
		END_IF;	
		
		//monitor elevator up move
		IF gCtrl.elevator.hmiBtnElevatorFwd AND NOT gCtrl.elevator.tmrPalletePEOff.Q THEN
			//when elevator move up is complete > move the table to the pallete side
			gCtrl.elevator.hmiBtnElevatorFwd := 0;						
			gCtrl.elevator.hmiBtnElevatorRev := 0;
			
			//If pallete detect PE NOT blocked > move table to pallete
			gCtrl.transfertable.hmiBtnTableFwd := 1;						
			gCtrl.transfertable.hmiBtnTableRev := 0;						
		END_IF;
		
		//when table at pallete > move elevator down 
		IF gCtrl.transfertable.isTableAtPallete AND NOT gCtrl.elevator.hmiBtnElevatorRev THEN
			gCtrl.elevator.hmiBtnElevatorFwd := 0;						
			gCtrl.elevator.hmiBtnElevatorRev := 1;				
		END_IF;	
		
		IF gCtrl.elevator.hmiBtnElevatorRev AND gCtrl.elevator.tmrPalletePEOn.Q THEN
			gCtrl.elevator.elevatorIsAtPalleteBelowHome := 1;//elevator is at pallet (same flag used for above home OR below home)		
			gCtrl.elevator.hmiBtnElevatorFwd := 0;						
			gCtrl.elevator.hmiBtnElevatorRev := 0;									
			gCtrl.elevator.hmiBtnElevatorToPallete := 0;
		END_IF;
			
	END_IF;
	
	
	//===========================================================================================
	//Process request for: Move elevator to Above Pallete
	IF gCtrl.elevator.hmiBtnElevatorToAbovePallete THEN	
		gCtrl.elevator.hmiBtnElevatorToPallete := 0;	
		gCtrl.elevator.hmiBtnElevatorToGrouping := 0;
		gCtrl.elevator.hmiBtnElevatorToTop := 0;
		
		//Sequence starts here!
		IF gCtrl.transfertable.isTableAtGrouping THEN
			IF gMachineIO.din.ElevatorDetectPalletLayerLF_EE1 THEN
				//If pallete detect PE is blocked > move elevator up
				gCtrl.elevator.hmiBtnElevatorFwd := 1;						
				gCtrl.elevator.hmiBtnElevatorRev := 0;	
			END_IF;			
		END_IF;	
		
		//monitor elevator up move
		//IF gCtrl.elevator.hmiBtnElevatorFwd AND NOT gCtrl.elevator.tmrPalletePEOff.Q THEN
		IF NOT gCtrl.elevator.tmrPalletePEOff.Q THEN
			//when elevator move up is complete > move the table to the pallete side
			gCtrl.elevator.hmiBtnElevatorFwd := 0;						
			gCtrl.elevator.hmiBtnElevatorRev := 0;
			gCtrl.elevator.hmiBtnElevatorToAbovePallete := 0;
		END_IF;
		
	END_IF;
	
	//===========================================================================================
	//Process request for: Move elevator to Top Most Position
	IF gCtrl.elevator.hmiBtnElevatorToTop THEN	
		gCtrl.elevator.hmiBtnElevatorToPallete := 0;	
		gCtrl.elevator.hmiBtnElevatorToGrouping := 0;
		gCtrl.elevator.hmiBtnElevatorToAbovePallete := 0;
		
		//Sequence starts here!
		IF gCtrl.transfertable.isTableAtGrouping THEN
			//If pallete detect PE is blocked > move elevator up
			gCtrl.elevator.hmiBtnElevatorFwd := 1;						
			gCtrl.elevator.hmiBtnElevatorRev := 0;	
		END_IF;	
		
		//monitor elevator up move
		//IF gCtrl.elevator.hmiBtnElevatorFwd AND NOT gCtrl.elevator.tmrPalletePEOff.Q THEN
		IF gCtrl.elevator.elevatorIsAtTop THEN
			//when elevator move up is complete > move the table to the pallete side
			gCtrl.elevator.hmiBtnElevatorFwd := 0;						
			gCtrl.elevator.hmiBtnElevatorRev := 0;
			gCtrl.elevator.hmiBtnElevatorToTop := 0;
		END_IF;
		
	END_IF;
	
	//===========================================================================================
	//In case of faults > reset move requests, stop the VFD-s
	IF NOT gCtrl.main.noFaults THEN
		gCtrl.elevator.hmiBtnElevatorToPallete := 0;
		gCtrl.elevator.hmiBtnElevatorToGrouping := 0;
		gCtrl.elevator.hmiBtnElevatorToAbovePallete := 0;
		gCtrl.elevator.hmiBtnElevatorFwd := 0;						
		gCtrl.elevator.hmiBtnElevatorRev := 0;		
	END_IF;	
	
	
END_PROGRAM
