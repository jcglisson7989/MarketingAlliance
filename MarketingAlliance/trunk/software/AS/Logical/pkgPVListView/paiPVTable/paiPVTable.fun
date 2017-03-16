
FUNCTION hmiParamListTableCyclic : USINT
	VAR_INPUT
		p_int : UDINT;
	END_VAR
END_FUNCTION

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
