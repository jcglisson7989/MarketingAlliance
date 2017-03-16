
TYPE
	MpDelta2AxisParType : 	STRUCT  (*Definition of MpDelta2Axis parameters*)
		ProgramName : STRING[255]; (*Name of the program that should be executed*)
		InitProgramName : STRING[255]; (*Name of the program that should be executed before the main program Reserved for future use*)
		Velocity : REAL := 100.0; (*Maximum path speed. Given as a system unit of the selected coordinate system [units/s]*)
		Distance : ARRAY[0..1]OF LREAL; (*Distance the robot should move. Given as a system unit of the selected coordinate system [units]*)
		Position : ARRAY[0..1]OF LREAL; (*Position to which the robot should move. Given as a system unit of the selected coordinate system [units/s]*)
		Acceleration : REAL := 1000.0; (*Maximum path acceleration of the movement [units/s²]*)
		Deceleration : REAL := 1000.0; (*Maximum path deceleration of the movement [units/s²]*)
		Jerk : REAL := 100000.0; (*Jerk of the movement [units/s³]*)
		Jog : MpDelta2AxisJogType := (0); (*Velocity during jogging. Given as a system unit of the selected coordinate system [units/s]*)
		CoordSystem : MpDeltaCoordSysEnum := (0); (*Coordinate system*)
		ActivateWorkspaceMonitoring : BOOL := FALSE; (*Enables or disables workspace monitoring*)
		ManualMoveType : MpDeltaManualMoveEnum := mpDELTA_MOVE_ABSOLUTE; (*Manual movement: Absolute or relative*)
	END_STRUCT;
	MpDelta2AxisInfoType : 	STRUCT  (*Definition of MpDelta2Axis informational structure*)
		AxesLinked : BOOL; (*TRUE as soon as MpAxis is connected to the robot*)
		ReadyToPowerOn : BOOL; (*TRUE as soon as MpAxis is operational (ready to be switched on)*)
		Jogging : BOOL; (*TRUE when the robot is jogging*)
		WorkspaceMonitoringActive : BOOL; (*TRUE when workspace monitoring is active*)
		WorkspaceEnd : BOOL; (*TRUE when the robot has reached the workspace monitoring limit*)
		CoordPosition : ARRAY[0..1]OF LREAL; (*Position in the selected coordinate system*)
		Program : MpDeltaProgramInfoType; (*Information about the current movement*)
		Interrupt : MpDeltaInterruptEnum; (*Information when interrupted*)
		PLCopenState : MpDeltaPLCopenStateEnum; (*PLCopen state of a group*)
		Diag : MpDeltaDiagExtType; (*Diagnostic structure for the function block*)
		JerkLimitedTrajectoryActive : BOOL; (*Jerk limited trajectory planner status*)
	END_STRUCT;
	MpDelta2AxisJogType : 	STRUCT  (*Definition of MpDelta2Axis jogging parameters*)
		Coord : MpDelta2AxisCoordEnum := (0); (*The axis that should be jogged*)
		Velocity : REAL := 50.0; (*The velocity that should be used for jogging [units/s]*)
		Acceleration : REAL := 500.0; (*The acceleration that should be used for jogging [units/s²]*)
		Deceleration : REAL := 500.0; (*The deceleration that should be used for jogging [units/s²]*)
	END_STRUCT;
	MpDelta2AxisInternalType : 	STRUCT  (*Definition of MpDelta2Axis internal type*)
		pObject : UDINT; (*Pointer to internal object*)
		State : UDINT; (*Component internal State*)
		TRF : MpDelta2AxisInternTRFDataType; (*Transformation Data*)
	END_STRUCT;
	MpDelta2AxisInternTRFDataType : 	STRUCT 
		TypeA : TRF_DATA35_typ;
	END_STRUCT;
	MpDelta3AxisParType : 	STRUCT  (*Definition of MpDelta3Axis parameters*)
		ProgramName : STRING[255]; (*Name of the program that should be executed*)
		InitProgramName : STRING[255]; (*Name of the program that should be executed before the main program Reserved for future use*)
		Velocity : REAL := 100.0; (*Maximum path speed. Given as a system unit of the selected coordinate system [units/s]*)
		Distance : ARRAY[0..2]OF LREAL; (*Distance the robot should move. Given as a system unit of the selected coordinate system [units]*)
		Position : ARRAY[0..2]OF LREAL; (*Position to which the robot should move. Given as a system unit of the selected coordinate system [units/s]*)
		Acceleration : REAL := 1000.0; (*Maximum path acceleration of the movement [units/s²]*)
		Deceleration : REAL := 1000.0; (*Maximum path deceleration of the movement [units/s²]*)
		Jerk : REAL := 100000.0; (*Jerk of the movement [units/s³]*)
		Jog : MpDelta3AxisJogType := (0); (*Velocity during jogging. Given as a system unit of the selected coordinate system [units/s]*)
		CoordSystem : MpDeltaCoordSysEnum := (0); (*Coordinate system*)
		ActivateWorkspaceMonitoring : BOOL := FALSE; (*Enables or disables workspace monitoring*)
		ManualMoveType : MpDeltaManualMoveEnum := mpDELTA_MOVE_ABSOLUTE; (*Manual movement: Absolute or relative*)
		Tool : MpDeltaToolType; (*Tool table settings (reserved for future use)*)
	END_STRUCT;
	MpDelta3AxisInfoType : 	STRUCT  (*Definition of MpDelta3Axis informational structure*)
		AxesLinked : BOOL; (*TRUE as soon as MpAxis is connected to the robot*)
		ReadyToPowerOn : BOOL; (*TRUE as soon as MpAxis is operational (ready to be switched on)*)
		Jogging : BOOL; (*TRUE when the robot is jogging*)
		WorkspaceMonitoringActive : BOOL; (*TRUE when workspace monitoring is active*)
		WorkspaceEnd : BOOL; (*TRUE when the robot has reached the workspace monitoring limit*)
		CoordPosition : ARRAY[0..2]OF LREAL; (*Position in the selected coordinate system*)
		Program : MpDeltaProgramInfoType; (*Information about the current movement*)
		Tool : MpDeltaToolType; (*Tool table settings (reserved for future use)*)
		Interrupt : MpDeltaInterruptEnum; (*Information when interrupted*)
		PLCopenState : MpDeltaPLCopenStateEnum; (*PLCopen state of a group*)
		Diag : MpDeltaDiagExtType; (*Diagnostic structure for the function block*)
		JerkLimitedTrajectoryActive : BOOL; (*Jerk limited trajectory planner status*)
	END_STRUCT;
	MpDelta3AxisJogType : 	STRUCT  (*Definition of MpDelta3Axis jogging parameters*)
		Coord : MpDelta3AxisCoordEnum := mpDELTA_3AXIS_JOINT_Q1; (*The axis that should be jogged*)
		Velocity : REAL := 50.0; (*The velocity that should be used for jogging [units/s]*)
		Acceleration : REAL := 500.0; (*The acceleration that should be used for jogging [units/s²]*)
		Deceleration : REAL := 500.0; (*The deceleration that should be used for jogging [units/s²]*)
	END_STRUCT;
	MpDelta3AxisInternalType : 	STRUCT  (*Definition of MpDelta3Axis internal type*)
		pObject : UDINT; (*Pointer to internal object*)
		State : UDINT; (*Component internal State*)
		TRF : MpDelta3AxisInternTRFDataType; (*Transformation Data*)
	END_STRUCT;
	MpDelta3AxisInternTRFDataType : 	STRUCT 
		TypeB : TRF_DATA13_typ;
		TypeC : TRF_DATA23_typ;
		TypeD : TRF_DATA24_typ;
	END_STRUCT;
	MpDelta4AxisParType : 	STRUCT  (*Definition of MpDelta4Axis parameters*)
		ProgramName : STRING[255]; (*Name of the program that should be executed*)
		InitProgramName : STRING[255]; (*Name of the program that should be executed before the main program. Reserved for future use*)
		Velocity : REAL := 100.0; (*Maximum path speed of the movement. Given as a system unit of the selected coordinate system [units/s]*)
		Distance : ARRAY[0..3]OF LREAL; (*Distance the robot should move. Given as a system unit of the selected coordinate system [units]*)
		Position : ARRAY[0..3]OF LREAL; (*Position to which the robot should move. Given as a system unit of the selected coordinate system [units/s]*)
		Acceleration : REAL := 1000.0; (*Maximum path acceleration of the movement [units/s²]*)
		Deceleration : REAL := 1000.0; (*Maximum path deceleration of the movement [units/s²]*)
		Jerk : REAL := 100000.0; (*Jerk of the movement [units/s³] *)
		Jog : MpDelta4AxisJogType := (0); (*Velocity during jogging. Given as a system unit of the selected coordinate system [units/s]*)
		CoordSystem : MpDeltaCoordSysEnum := (0); (*Coordinate system*)
		ActivateWorkspaceMonitoring : BOOL := FALSE; (*Enables or disables workspace monitoring*)
		ManualMoveType : MpDeltaManualMoveEnum := (0); (*Manual movement: Absolute or relative*)
		Tool : MpDeltaToolType; (*Tool table settings (reserved for future use)*)
	END_STRUCT;
	MpDelta4AxisInfoType : 	STRUCT  (*Definition of MpDelta4Axis informational structure*)
		AxesLinked : BOOL; (*TRUE as soon as MpAxis is connected to the robot*)
		ReadyToPowerOn : BOOL; (*TRUE as soon as MpAxis is operational (ready to be switched on)*)
		Jogging : BOOL; (*TRUE when the robot is jogging*)
		WorkspaceMonitoringActive : BOOL; (*TRUE when workspace monitoring is active*)
		WorkspaceEnd : BOOL; (*TRUE when the robot has reached the workspace monitoring limit*)
		CoordPosition : ARRAY[0..3]OF LREAL; (*Position in the selected coordinate system*)
		Program : MpDeltaProgramInfoType; (*Information about the current movement*)
		Tool : MpDeltaToolType; (*Tool table settings (reserved for future use)*)
		Interrupt : MpDeltaInterruptEnum; (*Information when interrupted*)
		PLCopenState : MpDeltaPLCopenStateEnum; (*PLCopen state of a group*)
		Diag : MpDeltaDiagExtType; (*Diagnostic structure for the function block*)
		JerkLimitedTrajectoryActive : BOOL; (*Jerk limited trajectory planner status*)
	END_STRUCT;
	MpDelta4AxisInternalType : 	STRUCT  (*Definition of MpDelta4Axis internal type*)
		pObject : UDINT; (*Pointer to internal object*)
		State : UDINT; (*Component internal State*)
		TRF : MpDelta4AxisInternTRFDataType; (*Transformation Data*)
	END_STRUCT;
	MpDelta4AxisInternTRFDataType : 	STRUCT 
		TypeE : TRF_DATA25_typ;
		TypeF : TRF_DATA27_typ;
	END_STRUCT;
	MpDelta4AxisJogType : 	STRUCT  (*Definition of MpDelta4Axis jogging parameters*)
		Coord : MpDelta4AxisCoordEnum := mpDELTA_4AXIS_JOINT_Q1; (*The axis that should be jogged*)
		Velocity : REAL := 50.0; (*The velocity that should be used for jogging [units/s]*)
		Acceleration : REAL := 500.0; (*The acceleration that should be used for jogging [units/s²]*)
		Deceleration : REAL := 500.0; (*The deceleration that should be used for jogging [units/s²]*)
	END_STRUCT;
	MpDelta4AxisCoordEnum : 
		( (*Definition of Joint/Coordinate index for MpDelta4Axis *)
		mpDELTA_4AXIS_JOINT_Q1 := 0, (*Joint Q1*)
		mpDELTA_4AXIS_JOINT_Q2 := 1, (*Joint Q2*)
		mpDELTA_4AXIS_JOINT_Q3 := 2, (*Joint Q3*)
		mpDELTA_4AXIS_JOINT_Q4 := 3, (*Joint Q4*)
		mpDELTA_4AXIS_TCP_X := 4, (*Cartesian X coordinate*)
		mpDELTA_4AXIS_TCP_Y := 5, (*Cartesian Y coordinate*)
		mpDELTA_4AXIS_TCP_Z := 6, (*Cartesian Z coordinate*)
		mpDELTA_4AXIS_ROT_C := 7 (*Cartesian c rotation*)
		);
	MpDelta3AxisCoordEnum : 
		( (*Definition of Joint/Coordinate index for MpDelta3Axis *)
		mpDELTA_3AXIS_JOINT_Q1 := 0, (*Joint Q1*)
		mpDELTA_3AXIS_JOINT_Q2 := 1, (*Joint Q2*)
		mpDELTA_3AXIS_JOINT_Q3 := 2, (*Joint Q3*)
		mpDELTA_3AXIS_TCP_X := 3, (*Cartesian X coordinate*)
		mpDELTA_3AXIS_TCP_Y := 4, (*Cartesian Y coordinate*)
		mpDELTA_3AXIS_TCP_Z := 5 (*Cartesian Z coordinate*)
		);
	MpDelta2AxisCoordEnum : 
		( (*Definition of Joint/Coordinate index for MpDelta3Axis *)
		mpDELTA_2AXIS_JOINT_Q1 := 0, (*Joint Q1*)
		mpDELTA_2AXIS_JOINT_Q2 := 1, (*Joint Q2*)
		mpDELTA_2AXIS_TCP_X := 2, (*Cartesian X coordinate*)
		mpDELTA_2AXIS_TCP_Z := 3 (*Cartesian Z coordinate*)
		);
	MpDelta2AxisConfigType : 	STRUCT  (*Definiition of MpDelta3Axis configuration datatype*)
		RobotName : STRING[20] := 'Delta 2-Axis'; (*Unique name of the robot throughout the entire project*)
		TRFSettings : MpDelta2AxisTRFSettingsType; (*Transformation settings*)
		Mechanics : MpDelta2AxisMechanicsType; (*Mechanical description of the robot*)
		Joint : ARRAY[0..1]OF MpDeltaTRFAxisType; (*Joint description of the robot*)
		HomeSequence : MpDelta2AxisHomeSequenceType; (*Defines the order in which the axes should be home*)
		WorkspaceMonitoring : MpDeltaWSType; (*Workspace monitoring configuration*)
	END_STRUCT;
	MpDelta3AxisConfigType : 	STRUCT  (*Definiition of MpDelta3Axis configuration datatype*)
		RobotName : STRING[20] := 'Delta1'; (*Unique name of the robot throughout the entire project*)
		TRFSettings : MpDelta3AxisTRFSettingsType; (*Transformation settings*)
		Mechanics : MpDelta3AxisMechanicsType; (*Mechanical description of the robot*)
		Joint : ARRAY[0..2]OF MpDeltaTRFAxisType; (*Joint description of the robot*)
		HomeSequence : MpDelta3AxisHomeSequenceType; (*Defines the order in which the axes should be home*)
		WorkspaceMonitoring : MpDeltaWSType; (*Workspace monitoring configuration*)
	END_STRUCT;
	MpDelta4AxisConfigType : 	STRUCT  (*Definiition of MpDelta4Axis configuration datatype*)
		RobotName : STRING[20] := 'Delta1'; (*Unique ID of the robot throughout the entire project*)
		TRFSettings : MpDelta4AxisTRFSettingsType; (*Transformation settings*)
		Mechanics : MpDelta4AxisMechanicsType; (*Mechanical description of the robot*)
		Joint : ARRAY[0..2]OF MpDeltaTRFAxisType; (*Joint description of the robot*)
		Rotary : MpDeltaTRFAxisType; (*TCP C rotary axes description of the robot*)
		HomeSequence : MpDelta4AxisHomeSequenceType; (*Defines the order in which the axes should be homed*)
		WorkspaceMonitoring : MpDeltaWSType; (*Workspace monitoring configuration*)
	END_STRUCT;
	MpDelta2AxisTRFTypeEnum : 
		(
		mpDELTA_2AXIS_TYPE_A := 35 (*Type A of delta kinematics. See TRF_LIB library help*)
		);
	MpDelta2AxisTRFSettingsType : 	STRUCT 
		Type : MpDelta2AxisTRFTypeEnum := mpDELTA_2AXIS_TYPE_A; (*Type of delta kinematics*)
		UpperShape : BOOL := FALSE; (*Upper shape of 2-Axis Delta mechanics is used*)
		JerkLimitedTrajectoryPlanner : BOOL := FALSE; (*Jerk limited trajectory planner activation*)
	END_STRUCT;
	MpDelta3AxisTRFTypeEnum : 
		(
		mpDELTA_3AXIS_TYPE_B := 13, (*Type B of delta kinematics. See TRF_LIB library help*)
		mpDELTA_3AXIS_TYPE_C := 23, (*Type C of delta kinematics. See TRF_LIB library help*)
		mpDELTA_3AXIS_TYPE_D := 24 (*Type D of delta kinematics. See TRF_LIB library help*)
		);
	MpDelta3AxisTRFSettingsType : 	STRUCT 
		Type : MpDelta3AxisTRFTypeEnum := mpDELTA_3AXIS_TYPE_B; (*Type of delta kinematics*)
		JerkLimitedTrajectoryPlanner : BOOL := FALSE; (*Jerk limited trajectory planner activation*)
	END_STRUCT;
	MpDelta4AxisTRFTypeEnum : 
		(
		mpDELTA_4AXIS_TYPE_E := 25, (*Type E of delta kinematics. See TRF_LIB library help*)
		mpDELTA_4AXIS_TYPE_F := 27 (*Type F of delta kinematics. See TRF_LIB library help*)
		);
	MpDelta4AxisTRFSettingsType : 	STRUCT 
		Type : MpDelta4AxisTRFTypeEnum := mpDELTA_4AXIS_TYPE_E; (*Type of delta kinematics*)
		UseShortestWay : BOOL := TRUE; (*Only relevant for rotating joint axes. If TRUE, then the shortest way between two points is always calculated for the transformation*)
		JerkLimitedTrajectoryPlanner : BOOL := FALSE; (*Jerk limited trajectory planner activation*)
	END_STRUCT;
	MpDelta4AxisMechanicsType : 	STRUCT  (*Definiition of mechanics of a robot*)
		BasePosition : MpDeltaBasePositionType; (*Base (zero point), definition in MCS coordinates*)
		ArmLinkPoint : ARRAY[0..2]OF MpDeltaArmLinkPointType; (*Definition of the point at which the robot arm is sitting in relation to the base*)
		ArmLength : ARRAY[0..2]OF MpDeltaArmLengthType; (*Definition of the arms*)
		TCPLinkPoint : ARRAY[0..2]OF MpDeltaTCPLinkPointType; (*Definition of the point at which the robot arm is connected to the TCP*)
		ToolHolderLength : LREAL := 0.0; (*TCP tool holder length (if an additional attachment lies between the TCP and tool) [mm]*)
	END_STRUCT;
	MpDelta3AxisMechanicsType : 	STRUCT  (*Definiition of mechanics of a robot*)
		BasePosition : MpDeltaBasePositionType; (*Base (zero point), definition in MCS coordinates*)
		ArmLinkPoint : ARRAY[0..2]OF MpDeltaArmLinkPointType; (*Definition of the point at which the robot arm is sitting in relation to the base*)
		ArmLength : ARRAY[0..2]OF MpDeltaArmLengthType; (*Definition of the arms*)
		TCPLinkPoint : ARRAY[0..2]OF MpDeltaTCPLinkPointType; (*Definition of the point at which the robot arm is connected to the TCP*)
		ToolHolderLength : LREAL := 0.0; (*TCP tool holder length (if an additional attachment lies between the TCP and tool) [mm]*)
		OptionalTypeD : MpDeltaTRFDMechanicsType; (*Optional parameters. Only necessary type D mechanics*)
	END_STRUCT;
	MpDelta2AxisMechanicsType : 	STRUCT  (*Definiition of mechanics of a robot*)
		BasePosition : MpDelta2AxisBasePositionType; (*Base (zero point), definition in MCS coordinates*)
		ArmLinkPoint : ARRAY[0..1]OF MpDelta2AxisArmLinkPointType; (*Definition of the point at which the robot arm is sitting in relation to the base*)
		ArmLength : ARRAY[0..1]OF MpDeltaArmLengthType; (*Definition of the arms*)
		TCPLinkPoint : ARRAY[0..1]OF MpDelta2AxisTCPLinkPointType; (*Definition of the point at which the robot arm is connected to the TCP*)
		ToolHolderLength : LREAL := 0.0; (*TCP tool holder length (if an additional attachment lies between the TCP and tool) [mm]*)
	END_STRUCT;
	MpDelta2AxisBasePositionType : 	STRUCT  (*Definiition of robot BASE in MCS coordinate  for 2-Axis Delta robot*)
		X : LREAL := 0.0; (*X position [units]*)
		Z : LREAL := 0.0; (*Z position [units]*)
	END_STRUCT;
	MpDeltaBasePositionType : 	STRUCT  (*Definiition of robot BASE in MCS coordinate*)
		X : LREAL := 0.0; (*X position [units]*)
		Y : LREAL := 0.0; (*Y position [units]*)
		Z : LREAL := 0.0; (*Z position [units]*)
	END_STRUCT;
	MpDeltaArmLengthType : 	STRUCT  (*Definition of delta robot arm*)
		UpperArm : LREAL := 220.0; (*Upper arm length [mm]*)
		LowerArm : LREAL := 420.0; (*Lower arm length [mm]*)
	END_STRUCT;
	MpDelta2AxisTCPLinkPointType : 	STRUCT  (*Definition of a point where TCP gondole is linked to robot arm. In relation to center of TCP for 2-Axis Delta robot*)
		OffsetX : LREAL; (*X-offset from the TCP link point [mm]*)
		OffsetZ : LREAL := 0.0; (*Z-offset (difference in height) from the TCP. Positive is over the TCP, negative is under it [mm]*)
	END_STRUCT;
	MpDeltaTCPLinkPointType : 	STRUCT  (*Definition of a point where TCP gondole is linked to robot arm. In relation to center of TCP*)
		Radius : LREAL; (*Radius calculated from the center of the TCP up to the connection point of the arm [mm]*)
		OffsetZ : LREAL := 0.0; (*Z-offset (difference in height) from the TCP. Positive is over the TCP, negative is under it [mm]*)
	END_STRUCT;
	MpDelta2AxisArmLinkPointType : 	STRUCT  (*Definition of point where motor is mounter. In relation to BASE position for 2-Axis Delta robot*)
		OffsetX : LREAL := 0.0; (*X-offset from the middle of the robot BASE [mm]*)
		OffsetZ : LREAL := 0.0; (*Z-offset (difference in height) from the base. Positive is over the base, negative is under it [mm]*)
	END_STRUCT;
	MpDeltaArmLinkPointType : 	STRUCT  (*Definition of point where motor is mounter. In relation to robot BASE*)
		Angle : LREAL; (*Angle between the 0° and current arm link point [°]*)
		Radius : LREAL; (*Radius calculated from the base up to the arm [mm]*)
		OffsetZ : LREAL := 0.0; (*Z-offset (difference in height) from the base. Positive is over the base, negative is under it [mm]*)
	END_STRUCT;
	MpDeltaTRFDMotorHolderType : 	STRUCT 
		OffsetXY : LREAL; (*Offset in X and Y direction between the linear motor and "ArmLinkPoint"*)
		OffsetZ : LREAL; (*Offset in Z direction between the linear motor and "ArmLinkPoint"*)
	END_STRUCT;
	MpDeltaTRFDMechanicsType : 	STRUCT 
		ArmHolderOffset : ARRAY[0..2]OF LREAL; (*Distance between the position where the arm is connected to the base ("ArmLinkPoint") and the point at which the linear motor cylinder is connected with the arm*)
		MotorHolder : ARRAY[0..2]OF MpDeltaTRFDMotorHolderType; (*Position of the linear motor in relation to the point at which the arm is connected to the base ("ArmLinkPoint")*)
	END_STRUCT;
	MpDeltaHomeSequenceTypeEnum : 
		( (*Homing order enumerator*)
		mpDELTA_HOME_ALL_TOGETHER := 0, (*Homes all axes at the same time*)
		mpDELTA_HOME_USER_DEFINED := 1 (*Carries out the homing procedure in a defined order*)
		);
	MpDelta4AxisHomeSequenceEnum : 
		(
		mpDELTA_4AXIS_HOME_FIRST := 0, (*Axis homed first*)
		mpDELTA_4AXIS_HOME_SECOND := 1, (*Axis homed second*)
		mpDELTA_4AXIS_HOME_THIRD := 2, (*Axis homed third*)
		mpDELTA_4AXIS_HOME_FOURTH := 3 (*Axis homed fourth*)
		);
	MpDelta4AxisHomeSequenceType : 	STRUCT 
		Type : MpDeltaHomeSequenceTypeEnum := mpDELTA_HOME_ALL_TOGETHER; (*Type of homing*)
		JointQ1 : MpDelta4AxisHomeSequenceEnum := mpDELTA_4AXIS_HOME_FIRST; (*Order for joint Q1*)
		JointQ2 : MpDelta4AxisHomeSequenceEnum := mpDELTA_4AXIS_HOME_FIRST; (*Order for joint Q2*)
		JointQ3 : MpDelta4AxisHomeSequenceEnum := mpDELTA_4AXIS_HOME_FIRST; (*Order for joint Q3*)
		RotaryC : MpDelta4AxisHomeSequenceEnum := mpDELTA_4AXIS_HOME_FIRST; (*Order for rotary axis*)
	END_STRUCT;
	MpDelta3AxisHomeSequenceEnum : 
		(
		mpDELTA_3AXIS_HOME_FIRST := 0, (*Axis homed first*)
		mpDELTA_3AXIS_HOME_SECOND := 1, (*Axis homed second*)
		mpDELTA_3AXIS_HOME_THIRD := 2 (*Axis homed third*)
		);
	MpDelta3AxisHomeSequenceType : 	STRUCT 
		Type : MpDeltaHomeSequenceTypeEnum := mpDELTA_HOME_ALL_TOGETHER; (*Type of homing*)
		JointQ1 : MpDelta3AxisHomeSequenceEnum := mpDELTA_3AXIS_HOME_FIRST; (*Order for joint Q1*)
		JointQ2 : MpDelta3AxisHomeSequenceEnum := mpDELTA_3AXIS_HOME_FIRST; (*Order for joint Q2*)
		JointQ3 : MpDelta3AxisHomeSequenceEnum := mpDELTA_3AXIS_HOME_FIRST; (*Order for joint Q3*)
	END_STRUCT;
	MpDelta2AxisHomeSequenceEnum : 
		(
		mpDELTA_2AXIS_HOME_FIRST := 0, (*Axis homed first*)
		mpDELTA_2AXIS_HOME_SECOND := 1 (*Axis homed second*)
		);
	MpDelta2AxisHomeSequenceType : 	STRUCT 
		Type : MpDeltaHomeSequenceTypeEnum := mpDELTA_HOME_ALL_TOGETHER; (*Type of homing*)
		JointQ1 : MpDelta2AxisHomeSequenceEnum := mpDELTA_2AXIS_HOME_FIRST; (*Order for joint Q1*)
		JointQ2 : MpDelta2AxisHomeSequenceEnum := mpDELTA_2AXIS_HOME_FIRST; (*Order for joint Q2*)
	END_STRUCT;
	MpDeltaDiagType : 	STRUCT  (*Definiition of configuration diagnostic*)
		StatusID : MpDeltaStatusIDType; (*StatusID diagnostic structure*)
	END_STRUCT;
	MpDeltaInfoType : 	STRUCT  (*Definition of MpDeltaXAxisCfg informational structure*)
		Diag : MpDeltaDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpDeltaDiagExtType : 	STRUCT  (*Definition of additional diagnostic information*)
		StatusID : MpDeltaStatusIDType; (*StatusID diagnostic structure*)
		Internal : MpComInternalIDType; (*Internal error diagnostic structure*)
	END_STRUCT;
	MpDeltaStatusIDType : 	STRUCT  (*Definition of StatusID*)
		ID : MpDeltaErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code for the status ID. This error number can be used to search for additional information in the help system*)
	END_STRUCT;
	MpDeltaBlockMonitorType : 	STRUCT  (*Definition of program block monitoring*)
		LineNumber : UDINT; (*Current line number*)
		BlockNumber : UDINT; (*Current block number*)
		LineLast2 : STRING[100]; (*Next to last line in the robot program*)
		LineLast1 : STRING[100]; (*Last line in the robot program*)
		LineActual : STRING[100]; (*Current line in the robot program*)
		LineNext1 : STRING[100]; (*Next line in the robot program*)
		LineNext2 : STRING[100]; (*Line after the next line in the robot program*)
		RemainingDistance : LREAL; (*Distance remaining until the end of the block [units]*)
		Length : LREAL; (*Length of the path of the current block [units]*)
	END_STRUCT;
	MpDeltaInterruptEnum : 
		( (*Definition of interrupt source*)
		mpDELTA_NOT_INTERRUPTED := 0, (*The program has not been interrupted*)
		mpDELTA_INTERRUPT_SINGLESTEP := 1, (*The robot was interrupted by single-step mode*)
		mpDELTA_INTERRUPT_FB := 2, (*The robot was interrupted by another function block command*)
		mpDELTA_INTERRUPT_INTERPRETER := 3, (*The program was interrupted by an interpreter halt (G170)*)
		mpDELTA_INTERRUPT_MFUNCTION := 4, (*The program was interrupted by a blocking M-code*)
		mpDELTA_INTERRUPT_PROGRAM := 5 (*The program was interrupted by a programmed command*)
		);
	MpDeltaToolType : 	STRUCT  (*Definition of robot tool*)
		TableName : STRING[255]; (*Name of the table*)
		Index : UINT; (*Index of the selected table*)
	END_STRUCT;
	MpDeltaProgramInfoType : 	STRUCT  (*Definition of program informational*)
		Name : STRING[255]; (*Name of the running program*)
		InitProgramName : STRING[255]; (*Name of the program that should be executed before the main program. Reserved for future use*)
		PathPosition : LREAL; (*Current path position in the running program [units]*)
		Runtime : REAL; (*Runtime of the current program [s]*)
		Feedrate : REAL; (*Current feed rate factor*)
		BlockMonitor : MpDeltaBlockMonitorType; (*Block monitor*)
	END_STRUCT;
	MpDeltaManualMoveEnum : 
		( (*Definition of movement positioning type*)
		mpDELTA_MOVE_ABSOLUTE := 0, (*Absolute Movement*)
		mpDELTA_MOVE_RELATIVE := 1 (*Relative Movement*)
		);
	MpDeltaCoordSysEnum : 
		( (*Definition of coordinate system*)
		mpDELTA_COORD_SYS_ACS := 0, (*Axis coordinate system*)
		mpDELTA_COORD_SYS_MCS := 1, (*Machine coordinate system*)
		mpDELTA_COORD_SYS_PCS := 2, (*Product coordinate system*)
		mpDELTA_COORD_SYS_JACS := 100 (*Joint coordinate system*)
		);
	MpDeltaPLCopenStateEnum : 
		( (*Definition of PLCopen group state*)
		mpDELTA_DISABLED := 0, (*The robot is switched off*)
		mpDELTA_STANDBY := 1, (*The robot is switched on*)
		mpDELTA_HOMING := 2, (*The robot is actively homing*)
		mpDELTA_MOVING := 3, (*At least one robot axis is moving. This movement can be caused by a group movement command or a single-axis movement command*)
		mpDELTA_ERRORSTOP := 4, (*The robot is in an error state. Movements are stopped*)
		mpDELTA_STOPPING := 5 (*The robot is stopping*)
		);
	MpDeltaWSType : 	STRUCT  (*Definition of workspace monitoiring configuration*)
		Cell : MpDeltaWSCellType; (*Defines the workspace itself*)
		ProtectedBlock : ARRAY[0..4]OF MpDeltaWSProtBlockType; (*Defines protected areas*)
		ProtectedHalfSpace : ARRAY[0..4]OF MpDeltaWSProtHalfSpaceType; (*Defines protected half-spaces*)
	END_STRUCT;
	MpDeltaWSCellType : 	STRUCT  (*Definition of robot workspace monitoring cell*)
		Start : MpDeltaWSPositionType; (*Starting point of workspace monitoring in the machine coordinate system*)
		End : MpDeltaWSPositionType; (*Ending point of workspace monitoring in the machine coordinate system*)
		Type : MpDeltaWSMainEnum; (*Appearance of the workspace (cube, cylinder, etc.)*)
	END_STRUCT;
	MpDeltaWSPositionType : 	STRUCT  (*Definition of workspace monitoring position*)
		X : LREAL; (*X position [units]*)
		Y : LREAL; (*Y position [units]*)
		Z : LREAL; (*Z position [units]*)
	END_STRUCT;
	MpDeltaWSMainEnum : 
		( (*Definition of main robotic cell*)
		mpDELTA_WS_NONE := 0, (*No workspace monitoring*)
		mpDELTA_WS_CUBIC := 1, (*Cube-shaped workspace*)
		mpDELTA_WS_CYLINDRIC := 2, (*Cylindrical workspace*)
		mpDELTA_WS_CYLINDRIC_HSPHERE := 3 (*Cylindrical workspace with a hemisphere on the top and bottom of the cylinder*)
		);
	MpDeltaWSProtBlockType : 	STRUCT  (*Definition of protected block*)
		Start : MpDeltaWSPositionType; (*Starting position of the workspace in the machine coordinate system*)
		End : MpDeltaWSPositionType; (*Ending position of the workspace in the machine coordinate system*)
	END_STRUCT;
	MpDeltaWSProtHalfSpaceType : 	STRUCT  (*Definition of protected half space*)
		StartPoint : LREAL; (*Coordinate of the intersection between the half-space and the corresponding axis*)
		Orientation : MpDeltaWSOrientationEnum; (*Orientation of the protected half-space*)
		ParallelPlane : MpDeltaWSParallelPlaneEnum; (*Definition of the parallel plane*)
	END_STRUCT;
	MpDeltaWSParallelPlaneEnum : 
		( (*Definition of parallel plane*)
		mpDELTA_WS_NO_PLANE := 0, (*No Plane selected*)
		mpDELTA_WS_PLANE_XY := 1, (*XY Plane*)
		mpDELTA_WS_PLANE_XZ := 2, (*XZ Plane*)
		mpDELTA_WS_PLANE_YZ := 3 (*YZ Plane*)
		);
	MpDeltaWSOrientationEnum : 
		( (*Definition of halfspace orientations*)
		mpDELTA_WS_ORIENTATION_POS := 0, (*Positive oreinatation*)
		mpDELTA_WS_ORIENTATION_NEG := 1 (*Negative orientation*)
		);
	MpDeltaTRFAxisType : 	STRUCT  (*Definition of transformation axis properties*)
		NegativeMoveLimit : LREAL := -25.0; (*Position limit in the negative direction [°]*)
		PositiveMoveLimit : LREAL := 120.0; (*Position limit in the positive direction [°]*)
		UseMathPositive : BOOL := TRUE; (*If active, the mathematic positive direction of rotation and translation is used*)
		UseTRFLimits : BOOL := TRUE; (*Enable transformation software end limits*)
	END_STRUCT;
END_TYPE
