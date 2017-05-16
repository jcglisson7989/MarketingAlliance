
FUNCTION Set_Default_Config_Values : USINT
	VAR_INPUT
		pCfg : REFERENCE TO Global_Cfg_typ;
	END_VAR
	VAR
		ii_dispense_units : UDINT;
	END_VAR
END_FUNCTION

FUNCTION Set_Default_Recipe_Values : USINT
	VAR_INPUT
		pRec : REFERENCE TO Global_Rec_typ;
	END_VAR
	VAR
		ii_dispense_units : UDINT;
	END_VAR
END_FUNCTION
