
TYPE
	HERNON_Alarm_Inspect_typ : 	STRUCT 
		Inspection_Error_1 : BOOL; (*0,1*)
		Inspection_Error_2 : BOOL; (*2,3*)
		Inspect_IO_Alloc_Error : BOOL; (*4,5*)
		Err_Insp_VBlock_Acc_Idx : BOOL; (*6,7*)
		Inspection_Not_Running : BOOL; (*8,9*)
		Inspection_Busy_Without_Signal : BOOL; (*10,11*)
		Insp_Err_Max_Busy_TO : BOOL; (*12,13*)
		Inspection_Results_TO_NoAnswer : BOOL; (*14,15*)
		Inspection_VBlock_Idx_Waiting : BOOL; (*16,17*)
		Inspect_Not_Ready_On_Start : BOOL; (*18*)
		Inspect_Error_During_Runtime : BOOL; (*19*)
		Inspection_Sequential_Fails : BOOL; (*20,21*)
	END_STRUCT;
END_TYPE
