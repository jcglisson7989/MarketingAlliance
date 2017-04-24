(********************************************************************

 * COPYRIGHT -- Piedmont Automation Inc.

 ********************************************************************

 * File: MachineIO.typ

 * Author: goran

 * Created: Jun 1, 2015

 ********************************************************************

 *)
(*********************************************************************************							

B&R VFD related IO Structures	
In - direction from VFD to PLC
Out - direction from PLC to VFD							

*********************************************************************************)
(**)

TYPE
	paiVFDInFault_typ : 	STRUCT 
		FaultCounter : UINT;
		CurrentFault : UINT; (*CiA402 fault code*)
		CurrentFaultTxt : STRING[63];
		LastFault : INT; (*Last dedected fault*)
	END_STRUCT;
	paiVFDInIO_typ : 	STRUCT  (*Logic inputs states*)
		LogicInput1 : BOOL; (*Logic inputs states (Value of LI1)*)
		LogicInput2 : BOOL; (*Logic inputs states (Value of LI2)*)
		LogicInput3 : BOOL; (*Logic inputs states (Value of LI3)*)
		LogicInput4 : BOOL; (*Logic inputs states (Value of LI4)*)
		LogicInput5 : BOOL;
		LogicInput6 : BOOL;
		Relay01State : BOOL;
		Relay02State : BOOL;
		AnalogInput1 : INT;
		AnalogInput2 : INT;
	END_STRUCT;
	paiVFDInStatus_typ : 	STRUCT  (*Status words*)
		SpeedMode : BOOL;
		PowerRemoval : BOOL;
		ReadyToSwitchOn : BOOL; (*(1 = Ready to switch on)*)
		SwitchedOn : BOOL; (*(1 = Switched on, ready)*)
		OperationEnabled : BOOL; (*(1 = Operation enabled, running)*)
		FaultDetection : BOOL; (*(1 = Fault detection)*)
		VoltageEnabled : BOOL; (*(Voltage disabled, always = 0)*)
		QuickStop : BOOL; (*(0 = Quick stop, emergency stop)*)
		SwitchOnDisabled : BOOL; (*(1 = Switched on disabled)	*)
		WarningAlarm : BOOL; (*(1 = Alarm)*)
		TargetReached : BOOL; (*(1 = Target reached, reference reached)*)
		StopKey : BOOL; (*(1 = Stop via STOP key)*)
		Direction : BOOL; (*(Direction of rotation 0 = Forward rotation; 1 = Reverse rotation)*)
		Accelerating : BOOL; (*(1 = Acceleration in progress)*)
		Decelerating : BOOL; (*(1 = Deceleration in progress)*)
		FastStop : BOOL; (*(1 = Fast stop in progress)*)
		CurrentVelocity : INT; (*Output velocity [rpm]*)
		MotorTorque : INT; (*Motor torque [%]*)
		MotorCurrent : UINT; (*Motor current [0.1 A]*)
		DriveThermalState : UINT; (*Drive thermal state [%]*)
		MotorThermalState : UINT; (*Motor thermal state [%]*)
	END_STRUCT;
	paiVFDIn_typ : 	STRUCT 
		ModuleInfo : paiBnRHWModuleInfo_typ;
		IO : paiVFDInIO_typ;
		Status : paiVFDInStatus_typ;
		Fault : paiVFDInFault_typ;
	END_STRUCT;
	paiVFDOutControl_typ : 	STRUCT  (*Control words*)
		SwitchOn : BOOL; (* (1 = Switch on)*)
		DisableVoltage : BOOL; (*(0 = Disable voltage)*)
		QuickStop : BOOL; (*(0 = Quick stop/Emergency stop)*)
		EnableOperation : BOOL; (*(1 = Enable operation/Run command)*)
		FaultReset : BOOL; (*(Fault reset/Fault acknowledgment active on 0 V 1 rising edge)*)
		RunAsked : BOOL;
		Direction : BOOL; (*(0 = Forward rotation; 1 = Reverse rotation)*)
		FastStop : BOOL; (*Stop command (0 = No action; 1 = Depending on the STT Type of stop parameter)*)
		DCInjectionBraking : BOOL;
		VelocitySetpoint : INT; (*Speed setpoint [rpm]*)
		TorqueSetpoint : INT;
		TorqueMode : BOOL;
	END_STRUCT;
	paiVFDOutIO_typ : 	STRUCT 
		Relay1 : BOOL;
		Relay2 : BOOL;
		AnalogOut1 : INT;
		LogicOut1 : BOOL;
	END_STRUCT;
	paiVFDOut_typ : 	STRUCT 
		Control : paiVFDOutControl_typ;
		IO : paiVFDOutIO_typ;
	END_STRUCT;
	paiVFDApplicationIF_typ : 	STRUCT 
		iVoltageEnable : BOOL;
		iEnable : BOOL;
		iMoveFwd : BOOL;
		iMoveRev : BOOL;
		iEStop : BOOL;
		iRampStop : BOOL;
		iFaultReset : BOOL;
		iVelocitySetPoint : INT;
		iTorqueSetPoint : INT;
		oReady : BOOL;
		oRunning : BOOL;
		oFault : BOOL;
	END_STRUCT;
	paiVFD_typ : 	STRUCT 
		description : STRING[79];
		location : STRING[79];
		stateText : STRING[31];
		appID : UDINT;
		vfdCtrl : paiVFDApplicationIF_typ;
		vfdIn : paiVFDIn_typ;
		vfdOut : paiVFDOut_typ;
	END_STRUCT;
END_TYPE
