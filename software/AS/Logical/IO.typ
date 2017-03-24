
TYPE
	IO_Status_typ : 	STRUCT 
		iEmergencyStop : BOOL;
		oFolderInsertOK : BOOL;
		iProductInPlace : BOOL;
		oWarningLight : BOOL;
	END_STRUCT;
	IO_Motor_typ : 	STRUCT 
		iMotorTemperatureSwitch : BOOL;
		iBladeEngineStopSensor : BOOL;
		oCreasingEngineClutch : BOOL;
	END_STRUCT;
	CMA_Arimat_IO_typ : 	STRUCT 
		Status : IO_Status_typ;
		Motor : IO_Motor_typ;
	END_STRUCT;
END_TYPE
