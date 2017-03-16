
FUNCTION_BLOCK MpDelta2Axis (*Control a delta robot with 2 axes*) (* $GROUP=mapp,$CAT=2-Axis Delta Robot,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpDelta2.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors *) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpDelta2AxisParType; (*Function block parameters *) (* *) (*#PAR#;*)
		Update : BOOL; (*Applies changed parameters*) (* *) (*#PAR#;*)
		AxesGroup : UDINT; (*Pointer to the PLCopen P4 axis group*) (* *) (*#PAR#;*)
		Override : REAL; (*Feed rate factor for the robot's velocity of 0-100%*) (* *) (*#CYC#OPT#;*)
		Power : BOOL; (*Switches on the robot's axes*) (* *) (*#CMD#;*)
		Home : BOOL; (*Homes the robot's axes*) (* *) (*#CMD#;*)
		MoveProgram : BOOL; (*Start a robot's program*) (* *) (*#CMD#;*)
		Interrupt : BOOL; (*Interrupts a robot's program*) (* *) (*#CMD#;*)
		Continue : BOOL; (*Resumes a robot's program*) (* *) (*#CMD#;*)
		Stop : BOOL; (*Stops a robot's program*) (* *) (*#CMD#;*)
		JogPositive : BOOL; (*Jogs the robot in the positive direction in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		JogNegative : BOOL; (*Jogs the robot in the negative direction in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		MoveDirect : BOOL; (*Direct movement to a point in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		MoveLinear : BOOL; (* Linear movement to a point in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		SingleStep : BOOL; (*Controls the robot in single-step mode*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR#;*)
		X : LREAL; (*Current X-position in the machine's coordinate system [units] *) (* *) (*#CYC#;*)
		Z : LREAL; (*Current Z-position in the machine's coordinate system [units] *) (* *) (*#CYC#;*)
		PathVelocity : LREAL; (*Current path velocity [units/s] *) (* *) (*#CYC#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandAborted : BOOL; (*Function block interrupted while executing a command*) (* *) (*#CMD#OPT#;*)
		PowerOn : BOOL; (*Robot switched on*) (* *) (*#CMD#;*)
		IsHomed : BOOL; (*Robot homed*) (* *) (*#CMD#;*)
		MoveActive : BOOL; (*Robot movement active (program, linear, direct)*) (* *) (*#CMD#;*)
		MoveInterrupted : BOOL; (*Movement interrupted*) (* *) (*#CMD#;*)
		MoveDone : BOOL; (*Movement completed (only for "MoveProgram", "MoveLinear" and "MoveDirect")*) (* *) (*#CMD#;*)
		Stopped : BOOL; (*Movement stopped*) (* *) (*#CMD#;*)
		InMotion : BOOL; (*At least one of the robot's axes is performing a movement*) (* *) (*#CMD#;*)
		SingleStepActive : BOOL; (*Single-step mode active*) (* *) (*#CMD#OPT#;*)
		Info : MpDelta2AxisInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpDelta2AxisInternalType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDelta3Axis (*Control a delta robot with 3 axes*) (* $GROUP=mapp,$CAT=3-Axis Delta Robot,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpDelta3.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors *) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpDelta3AxisParType; (*Function block parameters *) (* *) (*#PAR#;*)
		Update : BOOL; (*Applies changed parameters*) (* *) (*#PAR#;*)
		AxesGroup : UDINT; (*Pointer to the PLCopen P4 axis group*) (* *) (*#PAR#;*)
		Override : REAL; (*Feed rate factor for the robot's velocity of 0-100%*) (* *) (*#CYC#OPT#;*)
		Power : BOOL; (*Switches on the robot's axes*) (* *) (*#CMD#;*)
		Home : BOOL; (*Homes the robot's axes*) (* *) (*#CMD#;*)
		MoveProgram : BOOL; (*Start a robot's program*) (* *) (*#CMD#;*)
		Interrupt : BOOL; (*Interrupts a robot's program*) (* *) (*#CMD#;*)
		Continue : BOOL; (*Resumes a robot's program*) (* *) (*#CMD#;*)
		Stop : BOOL; (*Stops a robot's program*) (* *) (*#CMD#;*)
		JogPositive : BOOL; (*Jogs the robot in the positive direction in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		JogNegative : BOOL; (*Jogs the robot in the negative direction in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		MoveDirect : BOOL; (*Direct movement to a point in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		MoveLinear : BOOL; (* Linear movement to a point in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		SingleStep : BOOL; (*Controls the robot in single-step mode*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR#;*)
		X : LREAL; (*Current X-position in the machine's coordinate system [units] *) (* *) (*#CYC#;*)
		Y : LREAL; (*Current Y-position in the machine's coordinate system [units] *) (* *) (*#CYC#;*)
		Z : LREAL; (*Current Z-position in the machine's coordinate system [units] *) (* *) (*#CYC#;*)
		PathVelocity : LREAL; (*Current path velocity [units/s] *) (* *) (*#CYC#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandAborted : BOOL; (*Function block interrupted while executing a command*) (* *) (*#CMD#OPT#;*)
		PowerOn : BOOL; (*Robot switched on*) (* *) (*#CMD#;*)
		IsHomed : BOOL; (*Robot homed*) (* *) (*#CMD#;*)
		MoveActive : BOOL; (*Robot movement active (program, linear, direct)*) (* *) (*#CMD#;*)
		MoveInterrupted : BOOL; (*Movement interrupted*) (* *) (*#CMD#;*)
		MoveDone : BOOL; (*Movement completed (only for "MoveProgram", "MoveLinear" and "MoveDirect")*) (* *) (*#CMD#;*)
		Stopped : BOOL; (*Movement stopped*) (* *) (*#CMD#;*)
		InMotion : BOOL; (*At least one of the robot's axes is performing a movement*) (* *) (*#CMD#;*)
		SingleStepActive : BOOL; (*Single-step mode active*) (* *) (*#CMD#OPT#;*)
		Info : MpDelta3AxisInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpDelta3AxisInternalType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDelta4Axis (*Control a delta robot with 4 axes*) (* $GROUP=mapp,$CAT=4-Axis Delta Robot,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpDelta4.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors *) (* *) (*#PAR#;*)
		Parameters : REFERENCE TO MpDelta4AxisParType; (*Function block parameters *) (* *) (*#PAR#;*)
		Update : BOOL; (*Applies changed parameters*) (* *) (*#PAR#;*)
		AxesGroup : UDINT; (*Pointer to the PLCopen P4 axis group*) (* *) (*#PAR#;*)
		Override : REAL; (*Feed rate factor for the robot's velocity of 0-100%*) (* *) (*#CYC#OPT#;*)
		Power : BOOL; (*Switches on the robot's axes *) (* *) (*#CMD#;*)
		Home : BOOL; (*Homes the robot's axes*) (* *) (*#CMD#;*)
		MoveProgram : BOOL; (*Start a robot's program*) (* *) (*#CMD#;*)
		Interrupt : BOOL; (*Interrupts a robot's program*) (* *) (*#CMD#;*)
		Continue : BOOL; (*Resumes a robot's program*) (* *) (*#CMD#;*)
		Stop : BOOL; (*Stops a robot's program*) (* *) (*#CMD#;*)
		JogPositive : BOOL; (*Jogs the robot in the positive direction in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		JogNegative : BOOL; (*Jogs the robot in the negative direction in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		MoveDirect : BOOL; (*Direct movement to a point in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		MoveLinear : BOOL; (*Linear movement to a point in a defined coordinate system*) (* *) (*#CMD#OPT#;*)
		SingleStep : BOOL; (*Controls the robot in single-step mode*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR#;*)
		X : LREAL; (*Current x-position in the machine's coordinate system [units]*) (* *) (*#CYC#;*)
		Y : LREAL; (*Current y-position in the machine's coordinate system [units]*) (* *) (*#CYC#;*)
		Z : LREAL; (*Current z-position in the machine's coordinate system [units]*) (* *) (*#CYC#;*)
		C : LREAL; (*Current c-position in the machine's coordinate system [units]*) (* *) (*#CYC#;*)
		PathVelocity : LREAL; (*Current path velocity [units/s]*) (* *) (*#CYC#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandAborted : BOOL; (*Function block interrupted while executing a command*) (* *) (*#CMD#OPT#;*)
		PowerOn : BOOL; (*Robot switched on*) (* *) (*#CMD#;*)
		IsHomed : BOOL; (*Robot homed*) (* *) (*#CMD#;*)
		MoveActive : BOOL; (*Robot movement active (program, linear, direct)*) (* *) (*#CMD#;*)
		MoveInterrupted : BOOL; (*Movement interrupted*) (* *) (*#CMD#;*)
		MoveDone : BOOL; (*Movement completed (only for "MoveProgram", "MoveLinear" and "MoveDirect")*) (* *) (*#CMD#;*)
		Stopped : BOOL; (*Movement stopped*) (* *) (*#CMD#;*)
		InMotion : BOOL; (*At least one of the robot's axes is performing a movement*) (* *) (*#CMD#;*)
		SingleStepActive : BOOL; (*SingleStep is activated*) (* *) (*#CMD#OPT#;*)
		Info : MpDelta4AxisInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpDelta4AxisInternalType; (*Internal data*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDelta2AxisConfig (*Configuration for 2 axis delta robot*) (* $GROUP=mapp,$CAT=2-Axis Delta Robot,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpDelta2.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors *) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpDelta2AxisConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpDeltaInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDelta3AxisConfig (*Configuration for 3 axis delta robot*) (* $GROUP=mapp,$CAT=3-Axis Delta Robot,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpDelta3.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors *) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpDelta3AxisConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpDeltaInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpDelta4AxisConfig (*Configuration for 4 axis delta robot*) (* $GROUP=mapp,$CAT=4-Axis Delta Robot,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpDelta4.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors *) (* *) (*#PAR#;*)
		Configuration : REFERENCE TO MpDelta4AxisConfigType; (*Structure used to specify the configuration*) (* *) (*#PAR#;*)
		Load : BOOL; (*Loads the configuration of the component*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the configuration of the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpDeltaInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : MpComInternalDataType;
	END_VAR
END_FUNCTION_BLOCK
