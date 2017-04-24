
FUNCTION_BLOCK PulseTrain (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
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
