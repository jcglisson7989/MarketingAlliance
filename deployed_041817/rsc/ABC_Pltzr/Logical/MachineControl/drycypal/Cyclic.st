
PROGRAM _CYCLIC
	(* Insert code here *)	
	palleteTimer();

	IF ((dryCycleStatePallete <> 0) AND (NOT gCtrl.main.noFaults)) THEN
		dryCycleStatePallete := 0;
	END_IF;	
	
	
	CASE dryCycleStatePallete OF
		0 : IF gCtrl.main.modeAuto THEN//wait here for auto mode
				dryCycleStatePallete := 10;
				gCtrl.palletDispenser.hmiBtnClawsLiftToTop := 1;
//				elevatorTimer.IN := 0;
//				elevatorTimer.PT := T#3s * gCtrlAnimation.currentLayer;			
			END_IF;	
		10: //make sure to start at top						
			IF gCtrl.palletDispenser.atTop THEN
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 1;//CLOSE CLAWS
			END_IF;	
			IF gCtrl.palletDispenser.atTop AND gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToBottom := 1;//GO TO BOTTOM
				dryCycleStatePallete := 20;
			END_IF;		
		20://wait to bottom
			IF gCtrl.palletDispenser.atBottom THEN//WAIT TO GET TO BOTTOM
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 0;//OPEN CLAWS
				palleteTimer.IN := 0;
				palleteTimer.PT := T#3s;			
				dryCycleStatePallete := 30;
			END_IF;	
		30://WAIT FOR CLAWS TO OPEN
			palleteTimer.IN := 1;
			IF palleteTimer.Q THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToMidLo := 1;//move to MID low
				dryCycleStatePallete := 40;			
			END_IF;	
		40:
			IF gCtrl.palletDispenser.atMidLo THEN//Wait for At mit Low
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 1;//CLOSE CLAWS
				palleteTimer.IN := 0;
				palleteTimer.PT := T#3s;			
				dryCycleStatePallete := 50;
			END_IF;
		
		50://
			palleteTimer.IN := 1;
			IF palleteTimer.Q THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToTop := 1;
				dryCycleStatePallete := 60;			
			END_IF;	
		60://wait for elevator to come back home
			IF gCtrl.palletDispenser.atTop THEN
				palleteTimer.IN := 0;
				palleteTimer.PT := T#10s;			
				dryCycleStatePallete := 70;
			END_IF;	
		70://dwell here
			palleteTimer.IN := 1;
			IF palleteTimer.Q THEN
				dryCycleStatePallete := 80;			
				gCtrl.palletDispenser.hmiBtnClawsLiftToMidLo := 1;
			END_IF;	
	
		80:
			IF gCtrl.palletDispenser.atMidLo THEN//Wait for At mit Low
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 0;//OPEN CLAWS
				palleteTimer.IN := 0;
				palleteTimer.PT := T#3s;			
				dryCycleStatePallete := 90;
			END_IF;
		90:
			palleteTimer.IN := 1;
			IF palleteTimer.Q THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToBottom := 1;
				dryCycleStatePallete := 100;			
			END_IF;	
		100:
			IF gCtrl.palletDispenser.atBottom THEN//Wait for At mit Low
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 1;//CLOSE CLAWS
				palleteTimer.IN := 0;
				palleteTimer.PT := T#3s;			
				dryCycleStatePallete := 110;
			END_IF;
		
		110:	
			palleteTimer.IN := 1;
			IF palleteTimer.Q THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToTop := 1;
				dryCycleStatePallete := 120;			
			END_IF;	
		
		120:		
			IF gCtrl.palletDispenser.atTop THEN
				palleteTimer.IN := 0;
				palleteTimer.PT := T#15s;			
				dryCycleStatePallete := 130;
			END_IF;	
		130:	
			palleteTimer.IN := 1;
			IF palleteTimer.Q THEN
				dryCycleStatePallete := 0;			
			END_IF;						
		ELSE
			
	END_CASE;	
	
END_PROGRAM
