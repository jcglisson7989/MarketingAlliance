
TYPE
	paiSL_Operations_typ : 	STRUCT 
		Ack_All_UDID : BOOL;
		Ack_Firmware : BOOL;
		Ack_Safekey_Exchange : BOOL;
		Test_LED : BOOL;
		Sys_Scan : BOOL;
		Alter_SK_Password : BOOL;
		Format_SK : BOOL;
		Reset : BOOL;
		Clear_Data : BOOL;
		Download_Application : BOOL;
	END_STRUCT;
	paiSL_Public_In_typ : 	STRUCT 
		Password_for_command : STRING[16];
		Password_New : STRING[16];
		Command : paiSL_Operations_typ;
		Reset : BOOL;
	END_STRUCT;
	paiSL_RCTRL_Public_out_typ : 	STRUCT 
		Status : paiSafeLogicStatusOut_Enum;
		State : paiSafeLogicStateOut_Enum;
		SafeOSState : paiSafeLogicSafeOSOut_Enum;
		FailSafe : BOOL;
	END_STRUCT;
	paiSL_Public_Out_typ : 	STRUCT 
		State : paiInitSafelogicStates_Enum;
		Command_Allowed : paiSL_Operations_typ;
		HMI_Hide : paiSL_Operations_typ;
		Command_Being_Executed : paiSL_Operations_typ;
		Status_Print : STRING[255];
		RCTRL : paiSL_RCTRL_Public_out_typ;
		State_Old : paiInitSafelogicStates_Enum;
	END_STRUCT;
	paiSL_FBK_typ : 	STRUCT 
		RemoteControl : safeRemoteControl;
		DownloadApplication : safeDownloadApplication;
		UDID_Low : AsIOAccRead;
		UDID_High : AsIOAccRead;
	END_STRUCT;
	paiSL_Read_UDID_typ : 	STRUCT 
		Value : UDINT;
		Valid : BOOL;
	END_STRUCT;
	paiSL_Data_typ : 	STRUCT 
		RemoteControlCmd : RemoteControlCmdTypeV1;
		DownloadAppCmd : DownloadCmdApplicationTypeV1;
		Read_UDID_High : paiSL_Read_UDID_typ;
		Read_UDID_Low : paiSL_Read_UDID_typ;
	END_STRUCT;
	paiSL_prv_timers_typ : 	STRUCT 
		Timer_Print_HMI_Status : TON;
		Timer_Max_RCTRL_Cmd : TON;
		Timer_Error_Retry : TON;
		Timer_Rescan : TON;
	END_STRUCT;
	paiSL_Prv_typ : 	STRUCT 
		FBK : paiSL_FBK_typ;
		Data : paiSL_Data_typ;
		Timer : paiSL_prv_timers_typ;
		Command_Number : UINT;
	END_STRUCT;
	paiSL_typ : 	STRUCT 
		i : paiSL_Public_In_typ;
		o : paiSL_Public_Out_typ;
		prv : paiSL_Prv_typ;
	END_STRUCT;
	paiSafeLogicSafeOSOut_Enum : 
		(
		SAFEOS_INVALID_OR_BOOT := 0,
		SAFEOS_ON_OR_ERROR := 1,
		SAFEOS_LOADING := 2,
		SAFEOS_STOP_SAFE := 3,
		SAFEOS_RUN_SAFE := 4,
		SAFEOS_HALT_DEBUG := 5,
		SAFEOS_STOP_DEBUG := 6,
		SAFEOS_RUN_DEBUG := 7,
		SAFEOS_NO_EXECUTION := 8,
		SAFEOS_UPDATING_STATUS := 9
		);
	paiSafeLogicStateOut_Enum : 
		(
		RCTRL_IDLE := 0,
		RCTRL_ENTER_RECD := 1,
		RCTRL_EXECUTING_ENTER := 2,
		RCTRL_PREPARING_ENTER := 3,
		RCTRL_ENTER_EXECUTED_WAIT_RESET := 4
		);
	paiSafeLogicStatusOut_Enum : 
		(
		COMMAND_VALID_IN_EXECUTION := 0,
		HMI_COMMAND_EXECUTE_SUCCESS := 1,
		HMI_COMMAND_EXECUTE_ERROR := 2,
		REMOTE_COMMAND_EXECUTE_SUCCESS := 3,
		REMOTE_COMMAND_EXECUTE_ERROR := 4,
		ERROR_COMMAND_UNKNOWN := 5,
		ERROR_ENTER_COMMAND_UNKNOWN := 6,
		ERROR_RCTRL_DISABLED_SAFEDES := 7,
		ERROR_INCORRECT_PASSWORD := 8,
		ERROR_RCTRL_SM_NOT_IDLE := 9,
		ERROR_LOCKED_AT_HMI := 10,
		ERROR_SW_ACK_UNAUTHORIZED := 11,
		ERROR_FW_ACK_UNAUTHORIZED := 12,
		ERR_SMX_TO_CMX_UNAUTHORIZED := 13,
		ERR_SK_ACK_CANT_EXECUTE := 14,
		FW_ACK_CANT_EXECUTE := 15,
		ERR_SMX_CANT_EXECUTE := 16,
		ERR_DMX_CANT_EXECUTE := 17,
		ERR_TMX_CANT_EXECUTE := 18,
		ERR_QMX_CANT_EXECUTE := 19,
		ERR_CMX_CANT_EXECUTE := 20,
		ERR_SK_CONTINUE_CANT_EXEC := 21,
		ERR_ENTER_IMPOSS_SK_ACK_REQD := 22,
		ERR_SK_FORMAT_EXECUTING_SL_LOCK := 23,
		ERR_SK_COPY_EXECUTING_SL_LOCK := 24,
		ERR_SK_ACK_EXECUTING_SL_LOCK := 25,
		ERR_SMX_ACK_CMX_EXECUTING := 26,
		ERR_SCAN_EXECUTING_SL_LOCK := 27,
		ERR_REMOTE_SEND_FAILURE := 28,
		ERR_INCORRECT_CMD_LEN := 29,
		ERR_INCORRECT_CMD_LEN_2 := 30,
		ERR_USRDATA_FORMAT_RUNNING := 31
		);
	paiInitSafelogicStates_Enum : 
		(
		SAFE_PROGRAM_INIT := 0,
		SAFE_PROGRAM_READ_STATUS := 1,
		SAFE_PROGRAM_WAIT_COMMAND := 2,
		SAFE_PROGRAM_DOWNLOAD_APP := 4,
		SAFE_PROGRAM_SET_PASSWORD := 5,
		SAFE_PROGRAM_FORMAT_SAFEKEY := 6,
		SAFE_PROGRAM_CONFIRM_SK_XCHG := 7,
		SAFE_PROGRAM_CONFIRM_FW := 8,
		SAFE_PROGRAM_SCAN := 9,
		SAFE_PROGRAM_LED_TEST := 10,
		SAFE_PROGRAM_CLEAR_DATA := 11,
		SAFE_PROGRAM_CONFIRM_MODULES := 12,
		SAFE_PROGRAM_RESET := 14,
		SAFE_PROGRAM_ERROR := 15,
		SAFE_PROGRAM_PRINT_STATUS_WAIT := 16,
		SAFE_PROGRAM_READ_UDID := 17
		);
	paiSL_Perm_Info_typ : 	STRUCT 
		Safekey_Formatted : USINT;
		Password_Set : USINT;
		Application_Downloaded : USINT;
		SKey_Exchanged : USINT;
		ACK_UDID_Firmware : USINT;
		Run_State : USINT;
	END_STRUCT;
END_TYPE
