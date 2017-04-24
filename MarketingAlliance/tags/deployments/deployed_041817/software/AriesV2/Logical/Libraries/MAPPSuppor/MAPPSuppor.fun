(********************************************************************
 * COPYRIGHT -- Microsoft
 ********************************************************************
 * Library: MAPPSuppor
 * File: MAPPSuppor.fun
 * Author: John
 * Created: April 23, 2015
 ********************************************************************
 * Functions and function blocks of library MAPPSuppor
 ********************************************************************)

FUNCTION hmiParamListTableCyclic : USINT
	VAR_INPUT
		p_int : UDINT;
	END_VAR
END_FUNCTION

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

FUNCTION_BLOCK hmiTableFBK_typ (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		tableName : STRING[DEFINE_PAR_NAME_MAXLEN];
		nameSpace : STRING[DEFINE_PAR_NAME_MAXLEN];
		hmiStruct : {REDUND_UNREPLICABLE} HMI_Table_Data_typ;
		Logbook : UDINT;
		TableStats : {REDUND_UNREPLICABLE} hmiTableStatStruct_typ;
		pOverallStats : REFERENCE TO hmiTableStatStruct_typ;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION ActivateHMITable : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		langIdx : DINT;
		pHMITable : UDINT;
		pTableValues : UDINT;
	END_VAR
END_FUNCTION
