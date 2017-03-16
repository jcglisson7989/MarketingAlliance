
FUNCTION_BLOCK HernonDispValve (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDispVBlock : REFERENCE TO VBlock_Object_typ;
		pDispRec : REFERENCE TO HERNON_Rec_Dispense_typ;
		pDispCfg : REFERENCE TO HERNON_Cfg_Dispense_typ;
		pDispenseIO : REFERENCE TO HERNON_Inline_Dispense_Item_typ;
		pMechanics : REFERENCE TO HERNON_Cfg_Mechanics_typ;
		iNettime : DINT;
		MachineState : Global_State_Enum;
		VBlock_Fractional_Position : REAL;
		Current_VBlock_At_PiP_Sensor : UDINT;
		idx_disp_unit : USINT;
	END_VAR
	VAR
		DispVar : HERNON_Dispense_App_typ;
		DispVar_LastCycle : HERNON_Dispense_App_typ;
		Alarms : HERNON_Alarm_Dispense_typ;
	END_VAR
END_FUNCTION_BLOCK
