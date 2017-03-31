(********************************************************************
 * COPYRIGHT -- Microsoft
 ********************************************************************
 * Library: Hernon
 * File: FLASH.st
 * Author: Rocky Hafen
 * Created: March 18, 2015
 ********************************************************************
 * Implementation of library Hernon
 ********************************************************************) 

(* Flashes a BOOL output on/Off based on the inputs OnTime and OffTime *)
FUNCTION_BLOCK FLASH
		
	MaxTime := TimeOn + TimeOff ;
	TP_FLASH(IN:=bFlashTrig, PT:= (MaxTime + T#100ms));
	IF NOT bFlashTrig THEN
		bFlashTrig := TRUE;
	END_IF;
				
	IF (TP_FLASH.ET < TimeOn) THEN
		bFlashOut := TRUE;
	ELSIF (TP_FLASH.ET >= TimeOn) AND (TP_FLASH.ET <= MaxTime) THEN
		bFlashOut := FALSE;
		
	ELSE
		bFlashTrig := FALSE;
	END_IF;
	
	
END_FUNCTION_BLOCK