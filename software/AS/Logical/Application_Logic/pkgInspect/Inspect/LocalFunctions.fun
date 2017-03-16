
FUNCTION_BLOCK Hernon_Inspection_Camera (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pInspectionIO : REFERENCE TO HERNON_Inline_Inspect_Item_typ;
		pInspVBlock : REFERENCE TO VBlock_Object_typ;
		pInspRec : REFERENCE TO HERNON_Rec_Inspect_typ;
		pInspCfg : REFERENCE TO HERNON_Cfg_Inspect_typ;
		pInspStats : REFERENCE TO HERNON_Prcs_Stats_typ;
		pMechanics : REFERENCE TO HERNON_Cfg_Mechanics_typ;
		pInspSeqFails : REFERENCE TO UDINT;
		MachineState : Global_State_Enum;
		VBlock_Fractional_Position : REAL;
		Current_VBlock_At_PiP_Sensor : UDINT;
		idx_inspect_unit : USINT;
	END_VAR
	VAR
		InspVar_LastCycle : HERNON_Inspect_App_typ;
		InspVar : HERNON_Inspect_App_typ;
		Alarms : HERNON_Alarm_Inspect_typ;
	END_VAR
END_FUNCTION_BLOCK
