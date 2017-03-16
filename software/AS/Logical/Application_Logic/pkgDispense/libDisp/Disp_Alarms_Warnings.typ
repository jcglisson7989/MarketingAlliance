
TYPE
	HERNON_Alarm_Dispense_typ : 	STRUCT 
		Valve_Error_1 : BOOL; (*0*)
		Valve_Not_On : BOOL; (*1*)
		Valve_Not_OFF : BOOL; (*2*)
		Dispense_Reset_Error : BOOL; (*3*)
		Valve_Not_Off : BOOL; (*4*)
		Err_Disp_VBlock_Acc_Idx : BOOL; (*5*)
		Dispense_IO_Alloc_Error : BOOL; (*6*)
		Disp_Output_Not_Reset : BOOL; (*7*)
		Dispense_ValveRdy_NegEdge_Err : BOOL; (*8*)
		Disp_Valve_On_Too_Long : BOOL; (*9*)
		Dispense_Twice_Single_VBlock : BOOL; (*10*)
		ValveRdy_Not_Reset : BOOL; (*11*)
		Dispense_Not_Ready_On_Start : BOOL; (*12*)
		Dispense_Error_During_Runtime : BOOL; (*13*)
		VBlock_idx_during_shot_wait : BOOL; (*14*)
		VBlock_Offset_Invalid : BOOL; (*15*)
	END_STRUCT;
END_TYPE
