
FUNCTION_BLOCK FLASH
	VAR_INPUT
		TimeOn : TIME;
		TimeOff : TIME;
	END_VAR
	VAR_OUTPUT
		bFlashOut : BOOL;
	END_VAR
	VAR
		bFlashTrig : BOOL;
		TP_FLASH : TP;
		MaxTime : TIME;
	END_VAR
END_FUNCTION_BLOCK
