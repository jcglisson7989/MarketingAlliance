
TYPE
	AS3500_Cure_IO_typ : 	STRUCT 
		oUVCureChannel : ARRAY[0..1]OF BOOL;
		iUVCuringChannelOK : ARRAY[0..1]OF BOOL;
	END_STRUCT;
	StatusColors_typ : 	STRUCT 
		Red : BOOL;
		Green : BOOL;
		Blue : BOOL;
	END_STRUCT;
	ErrorIO_typ : 	STRUCT 
		oQuitError : BOOL;
		iErrorStatus : BOOL;
	END_STRUCT;
	AS5300_Encoder_Status_typ : 	STRUCT 
		CycleTimeViolation : ErrorIO_typ;
		DataError : ErrorIO_typ;
		BWChannel : ErrorIO_typ;
		iPowerSupply : ARRAY[0..1]OF BOOL;
	END_STRUCT;
	AS5300_Dispense_Status_typ : 	STRUCT 
		EdgeDetect : ErrorIO_typ;
	END_STRUCT;
	AS3500_Status_IO_typ : 	STRUCT 
		iProcessStopRelay : ARRAY[0..1]OF BOOL;
		oStatusColor : StatusColors_typ;
		oSystemNeedsAttention : BOOL;
		oRunningReady : BOOL;
		iClearError : BOOL;
		Encoder : AS5300_Encoder_Status_typ;
		Dispense : AS5300_Dispense_Status_typ;
	END_STRUCT;
	AS5300_Inspection_typ : 	STRUCT 
		oInspectionValid : BOOL;
		oInspectionGood : BOOL;
	END_STRUCT;
	AS3500_Control_IO_typ : 	STRUCT 
		oTargetPresent : BOOL;
		iRunCmd : BOOL;
		iEncoderValue : UINT;
		iReservoirLevel : BOOL;
		iTargetPiP : BOOL;
		Inspection : AS5300_Inspection_typ;
		iX2XNettime : DINT;
		PiP_Sensor_Debounce : Debounce_Signal;
	END_STRUCT;
END_TYPE
