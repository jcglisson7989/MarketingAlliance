
TYPE
	IO_Status_typ : 	STRUCT 
		iEmergencyStopStatus_3SB1A_I00 : BOOL;
		iBatteryPresent_3BF7A_I06 : BOOL;
		oFolderInsertOKLight_6HL1E_U16 : USINT;
		oWarningLightAlarm_6HL2E_U17 : USINT;
		New_Member : USINT;
		New_Member5 : USINT;
		New_Member4 : USINT;
		New_Member3 : USINT;
		New_Member2 : USINT;
	END_STRUCT;
	IO_Buttons_typ : 	STRUCT 
		iStart_3SB3A_I02 : USINT;
		iStop_3SB4A_I03 : USINT;
		iReset_3SB5A_I04 : USINT;
		New_Member1 : USINT;
		New_Member : USINT;
		New_Member5 : USINT;
		New_Member4 : USINT;
		New_Member3 : USINT;
		New_Member2 : USINT;
	END_STRUCT;
	IO_Motor_typ : 	STRUCT 
		iMotorInhibitStatus_SM1_I05 : BOOL;
		iBladeEngineTravelStop_3SQ8A_I07 : BOOL;
		iDriveOK_4KA4B_I11 : USINT;
		iBladeStartSignal_4SB5A_I12 : USINT;
		iRollerStartSignal_4SB6A_I13 : USINT;
		oCreasingEngineContactor_SM1_U23 : USINT;
	END_STRUCT;
	IO_Control_typ : 	STRUCT 
		iCreaseSelector_3SA2A_I01 : USINT;
		iAutoModeSelector_4SA2A_I09 : USINT;
		iManualModeSelector_4SA2AI10 : USINT;
		oDriveEnable_3SB1A_U20 : USINT;
		New_Member1 : USINT;
	END_STRUCT;
	CMA_Arimat_IO_typ : 	STRUCT 
		Button : IO_Buttons_typ;
		Status : IO_Status_typ;
		Motor : IO_Motor_typ;
		Control : IO_Control_typ;
		New_Member3 : USINT;
		New_Member2 : USINT;
		New_Member1 : USINT;
		New_Member : USINT;
	END_STRUCT;
END_TYPE
