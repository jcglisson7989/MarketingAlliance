(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * File: Global.typ
 * Author: John
 * Created: January 18, 2015
 ********************************************************************
 * Global data types of project CNC_Lite
 ********************************************************************)

TYPE
	GenericKinetics_typ : 	STRUCT 
		Distance : REAL;
		Position : REAL;
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
		Direction : USINT;
		JogVelocity : REAL;
	END_STRUCT;
	DSP_Error_typ : 	STRUCT 
		FifoEmpty : BOOL;
		FifoFull : BOOL;
		TargetTimeViolation : BOOL;
		FrequencyViolation : BOOL;
	END_STRUCT;
	X20DS1119_PosCtrl_typ : 	STRUCT 
		iModuleOK : BOOL;
		iSDCLifeCount : SINT;
		oMoveEnable : BOOL;
		oMoveTargetPos : DINT;
		iMovePos : DINT;
		iCounterPosition : DINT;
		iR : BOOL;
	END_STRUCT;
	PAIDemoKitIO_typ : 	STRUCT 
		DM1321 : X67DM1321_L12_1_typ;
		BT9400 : X20BT9400_typ;
		PLK_IF : Plk_IF_typ;
		DS1119 : X20DS1119_PosCtrl_typ;
	END_STRUCT;
	Plk_IF_typ : 	STRUCT 
		iCycleCongestionCount : UDINT;
		iCycleIdleTime : UDINT;
		iCycleTimeViolationCount : UDINT;
		iFailedCycleCount : UDINT;
		iCycleCount : UDINT;
		iNettimeOffset : DINT;
		iNettimeSoC : DINT;
		iTimeNanoSeconds : UDINT;
		iTimeSeconds : UDINT;
		iSyncOK : BOOL;
		iCycleOK : BOOL;
		iNodeNumber : USINT;
		iOutputDMAMargin : DINT;
		iLinkOK : BOOL;
	END_STRUCT;
	X20AI1744_typ : 	STRUCT 
		iModuleOk : BOOL;
		oOutputConfig : USINT;
		iStatusAI : USINT;
		iAI : DINT;
	END_STRUCT;
	X20BR9300_typ : 	STRUCT 
		iModuleOk : BOOL;
		iStatusInput : ARRAY[0..1]OF BOOL;
	END_STRUCT;
	X20BT9100_typ : 	STRUCT 
		iModuleOk : BOOL;
		iStatusInput : ARRAY[0..1]OF BOOL;
		iSupplyCurrent : USINT;
		iSupplyVoltage : USINT;
	END_STRUCT;
	X20BT9400_typ : 	STRUCT 
		iModuleOk : BOOL;
		iStatusInput : ARRAY[0..1]OF BOOL;
		iSupplyCurrent : USINT;
		iSupplyVoltage : USINT;
	END_STRUCT;
	X20DC4395_typ : 	STRUCT 
		iModuleOK : BOOL;
		iStaleData : BOOL;
		iAB_Enc_Val : ARRAY[0..3]OF DINT;
		iPowerSupply : BOOL;
		oRefMode : USINT;
		iStatusABR : USINT;
	END_STRUCT;
	X20DI9372_typ : 	STRUCT 
		iDI : ARRAY[0..11]OF BOOL;
		iModuleOk : BOOL;
	END_STRUCT;
	X20DO9322_typ : 	STRUCT 
		iModuleOk : BOOL;
		iStatusDO : ARRAY[0..11]OF BOOL;
		oDO : ARRAY[0..11]OF BOOL;
	END_STRUCT;
	X20DS1119_typ : 	STRUCT 
		iModuleOK : BOOL;
		iStaleData : BOOL;
		iSDCLifeCnt : SINT;
		iProtocolError : UINT;
		iProtocolSequenceViolation : UINT;
		iPowerSupply : ARRAY[0..1]OF BOOL;
		oMoveEnable : BOOL;
		oMoveTargetTime : INT;
		oMoveTargetPosition : DINT;
		iMovePosition : DINT;
		iMoveTimeValid : INT;
		oError : DSP_Error_typ;
		iError : DSP_Error_typ;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	X67DM1321_L12_1_typ : 	STRUCT 
		iModuleOK : BOOL;
		oDigitalOutput : ARRAY[0..15]OF BOOL;
		iStatusDigitalOutput : ARRAY[0..15]OF BOOL;
	END_STRUCT;
	X20SLX910_typ : 	STRUCT 
		iModuleOK : BOOL;
	END_STRUCT;
	X20DM9324_typ : 	STRUCT 
		iModuleOK : BOOL;
	END_STRUCT;
	X20CM8281_typ : 	STRUCT 
		iModuleOK : BOOL;
	END_STRUCT;
	X20DOF322_typ : 	STRUCT 
		iModuleOK : BOOL;
	END_STRUCT;
	X20DIF371_typ : 	STRUCT 
		iModuleOK : BOOL;
	END_STRUCT;
	X20BC0083_typ : 	STRUCT 
		iModuleOK : BOOL;
		iSerialNumber : UDINT;
		iModuleID : UINT;
		iHWVariant : UINT;
		iFirmwareVersion : UINT;
		iEthRxLost : DINT;
		iEthRxOverSize : DINT;
		iEthRxCRCErr : DINT;
		iEthRxOverflow : DINT;
		iEthTxCollision : DINT;
		iEthPhy1LinkOK : BOOL;
		iEthPhy1LinkLoss : DINT;
		iEthPhy2LinkOK : BOOL;
		iEthPhy2LinkLoss : DINT;
		iNetTime : DINT;
	END_STRUCT;
	X20CS1030_typ : 	STRUCT 
		iModuleOK : BOOL;
		iSerialNumber : UDINT;
		iModuleID : UINT;
		iHWVariant : UINT;
		iFirmwareVersion : UINT;
	END_STRUCT;
	X20PD2113_typ : 	STRUCT 
		iModuleOK : BOOL;
		iSerialNumber : UDINT;
		iModuleID : UINT;
		iHWVariant : UINT;
		iFirmwareVersion : UINT;
		iStatusFuse : BOOL;
		iPowerSupply : BOOL;
	END_STRUCT;
	X20PS9400_typ : 	STRUCT 
		iModuleOK : BOOL;
		iSerialNumber : UDINT;
		iModuleID : UINT;
		iHWVariant : UINT;
		iFirmwareVersion : UINT;
		iStatusInput1 : BOOL;
		iStatusInput2 : BOOL;
	END_STRUCT;
	X20SM1436_typ : 	STRUCT 
		iModuleOK : BOOL;
		iStaleData : BOOL;
		iSerialNumber : UDINT;
		iModuleID : UINT;
		iHWVariant : UINT;
		iFirmwareVersion : UINT;
		iLifeCount : SINT;
		oSetTime : INT;
		oMotor1Step : INT;
		oDriveEnable : BOOL;
		oBoostCurrent : BOOL;
		oStandStillCurrent : BOOL;
		oClearError : BOOL;
		iDriveOK : BOOL;
		iStallError : BOOL;
		iTempError : BOOL;
		iCurrentError : BOOL;
		iOverCurrentError : BOOL;
		iActPos : INT;
		iRefPulsePos : INT;
		iRefPulsCount : SINT;
		iEncOK : BOOL;
		iActTime : INT;
		iTriggerTime : INT;
		iTriggerCount : SINT;
		iStatusInput : ARRAY[0..3]OF BOOL;
		iModPowerSupplyError : BOOL;
	END_STRUCT;
	X20SO4110_typ : 	STRUCT 
		iModuleOK : BOOL;
		iSerialNumber : UDINT;
		iModuleID : UINT;
		iHWVariant : UINT;
		iFirmwareVersion : UINT;
	END_STRUCT;
END_TYPE
