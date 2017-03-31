
ACTION Action_Set_Colorbar_IO: 
	
	CASE ColorBar OF
		COLOR_NONE:
			StatusIO.oStatusColor.Red := FALSE;
			StatusIO.oStatusColor.Green := FALSE;
			StatusIO.oStatusColor.Blue := FALSE;
		
		COLOR_GREEN_FLASH:
			StatusIO.oStatusColor.Red := FALSE;
			StatusIO.oStatusColor.Green := STATUS_LIGHT_FLASH.bFlashOut;
			StatusIO.oStatusColor.Blue := FALSE;
		
		COLOR_GREEN:
			StatusIO.oStatusColor.Red := FALSE;
			StatusIO.oStatusColor.Green := TRUE;
			StatusIO.oStatusColor.Blue := FALSE;
		
		COLOR_GREEN_BLUE_ALTERNATE:
			StatusIO.oStatusColor.Red := FALSE;
			StatusIO.oStatusColor.Green := STATUS_LIGHT_FLASH.bFlashOut;
			StatusIO.oStatusColor.Blue := NOT STATUS_LIGHT_FLASH.bFlashOut;
		
		COLOR_RED:
			StatusIO.oStatusColor.Red := TRUE;
			StatusIO.oStatusColor.Green := FALSE;
			StatusIO.oStatusColor.Blue := FALSE;
			
		COLOR_GREEN_RED_ALTERNATE:
			StatusIO.oStatusColor.Red := STATUS_LIGHT_FLASH.bFlashOut;
			StatusIO.oStatusColor.Green := NOT STATUS_LIGHT_FLASH.bFlashOut;
			StatusIO.oStatusColor.Blue := FALSE;
		
	END_CASE;
	
	STATUS_LIGHT_FLASH(TimeOn := COLORBAR_FLASH_TO, TimeOff := COLORBAR_FLASH_TO);

END_ACTION
