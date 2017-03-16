
FUNCTION Tms : UDINT
	VAR_INPUT
		in : REAL;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK Debounce_Signal (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		input : {REDUND_UNREPLICABLE} USINT;
		pConfigVals : REFERENCE TO Debounce_Config_Struct;
	END_VAR
	VAR_OUTPUT
		Signal_Debounced : USINT;
	END_VAR
	VAR
		Ton : TON;
		Tof : TOF;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FBK_Init_Logbook (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL;
		Name : STRING[80];
	END_VAR
	VAR_OUTPUT
		pLog : UDINT;
	END_VAR
	VAR
		Logbook : wbrLogServiceLogbookInfo_typ;
		ii_init_calls : UDINT;
	END_VAR
END_FUNCTION_BLOCK
