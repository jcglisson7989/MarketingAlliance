/* Automation Studio generated header file */
/* Do not edit ! */
/* MpDelta 1.40.1 */

#ifndef _MPDELTA_
#define _MPDELTA_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpDelta_VERSION
#define _MpDelta_VERSION 1.40.1
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "GmcManager.h"
		#include "GmcGrpAPI.h"
		#include "NcGlobal.h"
		#include "brsystem.h"
		#include "MpCom.h"
		#include "TRF_LIB.h"
		#include "MpAxis.h"
		#include "GmcArncGrp.h"
#endif

#ifdef _SG3
		#include "GmcManager.h"
		#include "GmcGrpAPI.h"
		#include "NcGlobal.h"
		#include "brsystem.h"
		#include "MpCom.h"
		#include "TRF_LIB.h"
		#include "MpAxis.h"
		#include "GmcArncGrp.h"
#endif

#ifdef _SGC
		#include "GmcManager.h"
		#include "GmcGrpAPI.h"
		#include "NcGlobal.h"
		#include "brsystem.h"
		#include "MpCom.h"
		#include "TRF_LIB.h"
		#include "MpAxis.h"
		#include "GmcArncGrp.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef enum MpDelta4AxisCoordEnum
{	mpDELTA_4AXIS_JOINT_Q1 = 0,
	mpDELTA_4AXIS_JOINT_Q2 = 1,
	mpDELTA_4AXIS_JOINT_Q3 = 2,
	mpDELTA_4AXIS_JOINT_Q4 = 3,
	mpDELTA_4AXIS_TCP_X = 4,
	mpDELTA_4AXIS_TCP_Y = 5,
	mpDELTA_4AXIS_TCP_Z = 6,
	mpDELTA_4AXIS_ROT_C = 7
} MpDelta4AxisCoordEnum;

typedef enum MpDelta3AxisCoordEnum
{	mpDELTA_3AXIS_JOINT_Q1 = 0,
	mpDELTA_3AXIS_JOINT_Q2 = 1,
	mpDELTA_3AXIS_JOINT_Q3 = 2,
	mpDELTA_3AXIS_TCP_X = 3,
	mpDELTA_3AXIS_TCP_Y = 4,
	mpDELTA_3AXIS_TCP_Z = 5
} MpDelta3AxisCoordEnum;

typedef enum MpDelta2AxisCoordEnum
{	mpDELTA_2AXIS_JOINT_Q1 = 0,
	mpDELTA_2AXIS_JOINT_Q2 = 1,
	mpDELTA_2AXIS_TCP_X = 2,
	mpDELTA_2AXIS_TCP_Z = 3
} MpDelta2AxisCoordEnum;

typedef enum MpDelta2AxisTRFTypeEnum
{	mpDELTA_2AXIS_TYPE_A = 35
} MpDelta2AxisTRFTypeEnum;

typedef enum MpDelta3AxisTRFTypeEnum
{	mpDELTA_3AXIS_TYPE_B = 13,
	mpDELTA_3AXIS_TYPE_C = 23,
	mpDELTA_3AXIS_TYPE_D = 24
} MpDelta3AxisTRFTypeEnum;

typedef enum MpDelta4AxisTRFTypeEnum
{	mpDELTA_4AXIS_TYPE_E = 25,
	mpDELTA_4AXIS_TYPE_F = 27
} MpDelta4AxisTRFTypeEnum;

typedef enum MpDeltaHomeSequenceTypeEnum
{	mpDELTA_HOME_ALL_TOGETHER = 0,
	mpDELTA_HOME_USER_DEFINED = 1
} MpDeltaHomeSequenceTypeEnum;

typedef enum MpDelta4AxisHomeSequenceEnum
{	mpDELTA_4AXIS_HOME_FIRST = 0,
	mpDELTA_4AXIS_HOME_SECOND = 1,
	mpDELTA_4AXIS_HOME_THIRD = 2,
	mpDELTA_4AXIS_HOME_FOURTH = 3
} MpDelta4AxisHomeSequenceEnum;

typedef enum MpDelta3AxisHomeSequenceEnum
{	mpDELTA_3AXIS_HOME_FIRST = 0,
	mpDELTA_3AXIS_HOME_SECOND = 1,
	mpDELTA_3AXIS_HOME_THIRD = 2
} MpDelta3AxisHomeSequenceEnum;

typedef enum MpDelta2AxisHomeSequenceEnum
{	mpDELTA_2AXIS_HOME_FIRST = 0,
	mpDELTA_2AXIS_HOME_SECOND = 1
} MpDelta2AxisHomeSequenceEnum;

typedef enum MpDeltaInterruptEnum
{	mpDELTA_NOT_INTERRUPTED = 0,
	mpDELTA_INTERRUPT_SINGLESTEP = 1,
	mpDELTA_INTERRUPT_FB = 2,
	mpDELTA_INTERRUPT_INTERPRETER = 3,
	mpDELTA_INTERRUPT_MFUNCTION = 4,
	mpDELTA_INTERRUPT_PROGRAM = 5
} MpDeltaInterruptEnum;

typedef enum MpDeltaManualMoveEnum
{	mpDELTA_MOVE_ABSOLUTE = 0,
	mpDELTA_MOVE_RELATIVE = 1
} MpDeltaManualMoveEnum;

typedef enum MpDeltaCoordSysEnum
{	mpDELTA_COORD_SYS_ACS = 0,
	mpDELTA_COORD_SYS_MCS = 1,
	mpDELTA_COORD_SYS_PCS = 2,
	mpDELTA_COORD_SYS_JACS = 100
} MpDeltaCoordSysEnum;

typedef enum MpDeltaPLCopenStateEnum
{	mpDELTA_DISABLED = 0,
	mpDELTA_STANDBY = 1,
	mpDELTA_HOMING = 2,
	mpDELTA_MOVING = 3,
	mpDELTA_ERRORSTOP = 4,
	mpDELTA_STOPPING = 5
} MpDeltaPLCopenStateEnum;

typedef enum MpDeltaWSMainEnum
{	mpDELTA_WS_NONE = 0,
	mpDELTA_WS_CUBIC = 1,
	mpDELTA_WS_CYLINDRIC = 2,
	mpDELTA_WS_CYLINDRIC_HSPHERE = 3
} MpDeltaWSMainEnum;

typedef enum MpDeltaWSParallelPlaneEnum
{	mpDELTA_WS_NO_PLANE = 0,
	mpDELTA_WS_PLANE_XY = 1,
	mpDELTA_WS_PLANE_XZ = 2,
	mpDELTA_WS_PLANE_YZ = 3
} MpDeltaWSParallelPlaneEnum;

typedef enum MpDeltaWSOrientationEnum
{	mpDELTA_WS_ORIENTATION_POS = 0,
	mpDELTA_WS_ORIENTATION_NEG = 1
} MpDeltaWSOrientationEnum;

typedef enum MpDeltaErrorEnum
{	mpDELTA_NO_ERROR = 0,
	mpDELTA_ERR_ACTIVATION = -1064239103,
	mpDELTA_ERR_MPLINK_NULL = -1064239102,
	mpDELTA_ERR_MPLINK_INVALID = -1064239101,
	mpDELTA_ERR_MPLINK_CHANGED = -1064239100,
	mpDELTA_ERR_MPLINK_CORRUPT = -1064239099,
	mpDELTA_ERR_MPLINK_IN_USE = -1064239098,
	mpDELTA_ERR_PAR_NULL = -1064239097,
	mpDELTA_ERR_CONFIG_NULL = -1064239096,
	mpDELTA_ERR_CONFIG_NO_PV = -1064239095,
	mpDELTA_ERR_CONFIG_LOAD = -1064239094,
	mpDELTA_WRN_CONFIG_LOAD = -2137980917,
	mpDELTA_ERR_CONFIG_SAVE = -1064239092,
	mpDELTA_ERR_CONFIG_INVALID = -1064239091,
	mpDELTA_ERR_TRANSFORMATION = -1064091136,
	mpDELTA_ERR_AXES_GROUP = -1064091135,
	mpDELTA_WRN_CMD_NOT_ALLOWED = -2137832958,
	mpDELTA_INF_NOT_ENOUGH_AXES = 1083392515,
	mpDELTA_ERR_AXES_GROUP_NULL = -1064091132,
	mpDELTA_ERR_WS_CREATE = -1064091131,
	mpDELTA_WRN_OVR_OUT_OF_RANGE = -2137832954,
	mpDELTA_ERR_INVALID_COORD = -1064091129,
	mpDELTA_ERR_WS_NOT_DEFINED = -1064091128
} MpDeltaErrorEnum;

typedef enum MpDeltaAlarmEnum
{	mpDELTA_ALM_SYSTEM_ERROR = 0,
	mpDELTA_ALM_INITIALIZATION = 1,
	mpDELTA_ALM_END_OF_WORKSPACE = 2,
	mpDELTA_ALM_VIOLATE_WORKSPACE = 3,
	mpDELTA_ALM_PROGRAM_SYNTAX = 4,
	mpDELTA_ALM_PROGRAM_MISSING = 5,
	mpDELTA_ALM_PATH_VEL_MISSING = 6
} MpDeltaAlarmEnum;

typedef struct MpDelta2AxisJogType
{	enum MpDelta2AxisCoordEnum Coord;
	float Velocity;
	float Acceleration;
	float Deceleration;
} MpDelta2AxisJogType;

typedef struct MpDelta2AxisParType
{	plcstring ProgramName[256];
	plcstring InitProgramName[256];
	float Velocity;
	double Distance[2];
	double Position[2];
	float Acceleration;
	float Deceleration;
	float Jerk;
	struct MpDelta2AxisJogType Jog;
	enum MpDeltaCoordSysEnum CoordSystem;
	plcbit ActivateWorkspaceMonitoring;
	enum MpDeltaManualMoveEnum ManualMoveType;
} MpDelta2AxisParType;

typedef struct MpDeltaBlockMonitorType
{	unsigned long LineNumber;
	unsigned long BlockNumber;
	plcstring LineLast2[101];
	plcstring LineLast1[101];
	plcstring LineActual[101];
	plcstring LineNext1[101];
	plcstring LineNext2[101];
	double RemainingDistance;
	double Length;
} MpDeltaBlockMonitorType;

typedef struct MpDeltaProgramInfoType
{	plcstring Name[256];
	plcstring InitProgramName[256];
	double PathPosition;
	float Runtime;
	float Feedrate;
	struct MpDeltaBlockMonitorType BlockMonitor;
} MpDeltaProgramInfoType;

typedef struct MpDeltaStatusIDType
{	enum MpDeltaErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpDeltaStatusIDType;

typedef struct MpDeltaDiagExtType
{	struct MpDeltaStatusIDType StatusID;
	struct MpComInternalIDType Internal;
} MpDeltaDiagExtType;

typedef struct MpDelta2AxisInfoType
{	plcbit AxesLinked;
	plcbit ReadyToPowerOn;
	plcbit Jogging;
	plcbit WorkspaceMonitoringActive;
	plcbit WorkspaceEnd;
	double CoordPosition[2];
	struct MpDeltaProgramInfoType Program;
	enum MpDeltaInterruptEnum Interrupt;
	enum MpDeltaPLCopenStateEnum PLCopenState;
	struct MpDeltaDiagExtType Diag;
	plcbit JerkLimitedTrajectoryActive;
} MpDelta2AxisInfoType;

typedef struct MpDelta2AxisInternTRFDataType
{	struct TRF_DATA35_typ TypeA;
} MpDelta2AxisInternTRFDataType;

typedef struct MpDelta2AxisInternalType
{	unsigned long pObject;
	unsigned long State;
	struct MpDelta2AxisInternTRFDataType TRF;
} MpDelta2AxisInternalType;

typedef struct MpDelta3AxisJogType
{	enum MpDelta3AxisCoordEnum Coord;
	float Velocity;
	float Acceleration;
	float Deceleration;
} MpDelta3AxisJogType;

typedef struct MpDeltaToolType
{	plcstring TableName[256];
	unsigned short Index;
} MpDeltaToolType;

typedef struct MpDelta3AxisParType
{	plcstring ProgramName[256];
	plcstring InitProgramName[256];
	float Velocity;
	double Distance[3];
	double Position[3];
	float Acceleration;
	float Deceleration;
	float Jerk;
	struct MpDelta3AxisJogType Jog;
	enum MpDeltaCoordSysEnum CoordSystem;
	plcbit ActivateWorkspaceMonitoring;
	enum MpDeltaManualMoveEnum ManualMoveType;
	struct MpDeltaToolType Tool;
} MpDelta3AxisParType;

typedef struct MpDelta3AxisInfoType
{	plcbit AxesLinked;
	plcbit ReadyToPowerOn;
	plcbit Jogging;
	plcbit WorkspaceMonitoringActive;
	plcbit WorkspaceEnd;
	double CoordPosition[3];
	struct MpDeltaProgramInfoType Program;
	struct MpDeltaToolType Tool;
	enum MpDeltaInterruptEnum Interrupt;
	enum MpDeltaPLCopenStateEnum PLCopenState;
	struct MpDeltaDiagExtType Diag;
	plcbit JerkLimitedTrajectoryActive;
} MpDelta3AxisInfoType;

typedef struct MpDelta3AxisInternTRFDataType
{	struct TRF_DATA13_typ TypeB;
	struct TRF_DATA23_typ TypeC;
	struct TRF_DATA24_typ TypeD;
} MpDelta3AxisInternTRFDataType;

typedef struct MpDelta3AxisInternalType
{	unsigned long pObject;
	unsigned long State;
	struct MpDelta3AxisInternTRFDataType TRF;
} MpDelta3AxisInternalType;

typedef struct MpDelta4AxisJogType
{	enum MpDelta4AxisCoordEnum Coord;
	float Velocity;
	float Acceleration;
	float Deceleration;
} MpDelta4AxisJogType;

typedef struct MpDelta4AxisParType
{	plcstring ProgramName[256];
	plcstring InitProgramName[256];
	float Velocity;
	double Distance[4];
	double Position[4];
	float Acceleration;
	float Deceleration;
	float Jerk;
	struct MpDelta4AxisJogType Jog;
	enum MpDeltaCoordSysEnum CoordSystem;
	plcbit ActivateWorkspaceMonitoring;
	enum MpDeltaManualMoveEnum ManualMoveType;
	struct MpDeltaToolType Tool;
} MpDelta4AxisParType;

typedef struct MpDelta4AxisInfoType
{	plcbit AxesLinked;
	plcbit ReadyToPowerOn;
	plcbit Jogging;
	plcbit WorkspaceMonitoringActive;
	plcbit WorkspaceEnd;
	double CoordPosition[4];
	struct MpDeltaProgramInfoType Program;
	struct MpDeltaToolType Tool;
	enum MpDeltaInterruptEnum Interrupt;
	enum MpDeltaPLCopenStateEnum PLCopenState;
	struct MpDeltaDiagExtType Diag;
	plcbit JerkLimitedTrajectoryActive;
} MpDelta4AxisInfoType;

typedef struct MpDelta4AxisInternTRFDataType
{	struct TRF_DATA25_typ TypeE;
	struct TRF_DATA27_typ TypeF;
} MpDelta4AxisInternTRFDataType;

typedef struct MpDelta4AxisInternalType
{	unsigned long pObject;
	unsigned long State;
	struct MpDelta4AxisInternTRFDataType TRF;
} MpDelta4AxisInternalType;

typedef struct MpDelta2AxisTRFSettingsType
{	enum MpDelta2AxisTRFTypeEnum Type;
	plcbit UpperShape;
	plcbit JerkLimitedTrajectoryPlanner;
} MpDelta2AxisTRFSettingsType;

typedef struct MpDelta2AxisBasePositionType
{	double X;
	double Z;
} MpDelta2AxisBasePositionType;

typedef struct MpDelta2AxisArmLinkPointType
{	double OffsetX;
	double OffsetZ;
} MpDelta2AxisArmLinkPointType;

typedef struct MpDeltaArmLengthType
{	double UpperArm;
	double LowerArm;
} MpDeltaArmLengthType;

typedef struct MpDelta2AxisTCPLinkPointType
{	double OffsetX;
	double OffsetZ;
} MpDelta2AxisTCPLinkPointType;

typedef struct MpDelta2AxisMechanicsType
{	struct MpDelta2AxisBasePositionType BasePosition;
	struct MpDelta2AxisArmLinkPointType ArmLinkPoint[2];
	struct MpDeltaArmLengthType ArmLength[2];
	struct MpDelta2AxisTCPLinkPointType TCPLinkPoint[2];
	double ToolHolderLength;
} MpDelta2AxisMechanicsType;

typedef struct MpDeltaTRFAxisType
{	double NegativeMoveLimit;
	double PositiveMoveLimit;
	plcbit UseMathPositive;
	plcbit UseTRFLimits;
} MpDeltaTRFAxisType;

typedef struct MpDelta2AxisHomeSequenceType
{	enum MpDeltaHomeSequenceTypeEnum Type;
	enum MpDelta2AxisHomeSequenceEnum JointQ1;
	enum MpDelta2AxisHomeSequenceEnum JointQ2;
} MpDelta2AxisHomeSequenceType;

typedef struct MpDeltaWSPositionType
{	double X;
	double Y;
	double Z;
} MpDeltaWSPositionType;

typedef struct MpDeltaWSCellType
{	struct MpDeltaWSPositionType Start;
	struct MpDeltaWSPositionType End;
	enum MpDeltaWSMainEnum Type;
} MpDeltaWSCellType;

typedef struct MpDeltaWSProtBlockType
{	struct MpDeltaWSPositionType Start;
	struct MpDeltaWSPositionType End;
} MpDeltaWSProtBlockType;

typedef struct MpDeltaWSProtHalfSpaceType
{	double StartPoint;
	enum MpDeltaWSOrientationEnum Orientation;
	enum MpDeltaWSParallelPlaneEnum ParallelPlane;
} MpDeltaWSProtHalfSpaceType;

typedef struct MpDeltaWSType
{	struct MpDeltaWSCellType Cell;
	struct MpDeltaWSProtBlockType ProtectedBlock[5];
	struct MpDeltaWSProtHalfSpaceType ProtectedHalfSpace[5];
} MpDeltaWSType;

typedef struct MpDelta2AxisConfigType
{	plcstring RobotName[21];
	struct MpDelta2AxisTRFSettingsType TRFSettings;
	struct MpDelta2AxisMechanicsType Mechanics;
	struct MpDeltaTRFAxisType Joint[2];
	struct MpDelta2AxisHomeSequenceType HomeSequence;
	struct MpDeltaWSType WorkspaceMonitoring;
} MpDelta2AxisConfigType;

typedef struct MpDelta3AxisTRFSettingsType
{	enum MpDelta3AxisTRFTypeEnum Type;
	plcbit JerkLimitedTrajectoryPlanner;
} MpDelta3AxisTRFSettingsType;

typedef struct MpDeltaBasePositionType
{	double X;
	double Y;
	double Z;
} MpDeltaBasePositionType;

typedef struct MpDeltaArmLinkPointType
{	double Angle;
	double Radius;
	double OffsetZ;
} MpDeltaArmLinkPointType;

typedef struct MpDeltaTCPLinkPointType
{	double Radius;
	double OffsetZ;
} MpDeltaTCPLinkPointType;

typedef struct MpDeltaTRFDMotorHolderType
{	double OffsetXY;
	double OffsetZ;
} MpDeltaTRFDMotorHolderType;

typedef struct MpDeltaTRFDMechanicsType
{	double ArmHolderOffset[3];
	struct MpDeltaTRFDMotorHolderType MotorHolder[3];
} MpDeltaTRFDMechanicsType;

typedef struct MpDelta3AxisMechanicsType
{	struct MpDeltaBasePositionType BasePosition;
	struct MpDeltaArmLinkPointType ArmLinkPoint[3];
	struct MpDeltaArmLengthType ArmLength[3];
	struct MpDeltaTCPLinkPointType TCPLinkPoint[3];
	double ToolHolderLength;
	struct MpDeltaTRFDMechanicsType OptionalTypeD;
} MpDelta3AxisMechanicsType;

typedef struct MpDelta3AxisHomeSequenceType
{	enum MpDeltaHomeSequenceTypeEnum Type;
	enum MpDelta3AxisHomeSequenceEnum JointQ1;
	enum MpDelta3AxisHomeSequenceEnum JointQ2;
	enum MpDelta3AxisHomeSequenceEnum JointQ3;
} MpDelta3AxisHomeSequenceType;

typedef struct MpDelta3AxisConfigType
{	plcstring RobotName[21];
	struct MpDelta3AxisTRFSettingsType TRFSettings;
	struct MpDelta3AxisMechanicsType Mechanics;
	struct MpDeltaTRFAxisType Joint[3];
	struct MpDelta3AxisHomeSequenceType HomeSequence;
	struct MpDeltaWSType WorkspaceMonitoring;
} MpDelta3AxisConfigType;

typedef struct MpDelta4AxisTRFSettingsType
{	enum MpDelta4AxisTRFTypeEnum Type;
	plcbit UseShortestWay;
	plcbit JerkLimitedTrajectoryPlanner;
} MpDelta4AxisTRFSettingsType;

typedef struct MpDelta4AxisMechanicsType
{	struct MpDeltaBasePositionType BasePosition;
	struct MpDeltaArmLinkPointType ArmLinkPoint[3];
	struct MpDeltaArmLengthType ArmLength[3];
	struct MpDeltaTCPLinkPointType TCPLinkPoint[3];
	double ToolHolderLength;
} MpDelta4AxisMechanicsType;

typedef struct MpDelta4AxisHomeSequenceType
{	enum MpDeltaHomeSequenceTypeEnum Type;
	enum MpDelta4AxisHomeSequenceEnum JointQ1;
	enum MpDelta4AxisHomeSequenceEnum JointQ2;
	enum MpDelta4AxisHomeSequenceEnum JointQ3;
	enum MpDelta4AxisHomeSequenceEnum RotaryC;
} MpDelta4AxisHomeSequenceType;

typedef struct MpDelta4AxisConfigType
{	plcstring RobotName[21];
	struct MpDelta4AxisTRFSettingsType TRFSettings;
	struct MpDelta4AxisMechanicsType Mechanics;
	struct MpDeltaTRFAxisType Joint[3];
	struct MpDeltaTRFAxisType Rotary;
	struct MpDelta4AxisHomeSequenceType HomeSequence;
	struct MpDeltaWSType WorkspaceMonitoring;
} MpDelta4AxisConfigType;

typedef struct MpDeltaDiagType
{	struct MpDeltaStatusIDType StatusID;
} MpDeltaDiagType;

typedef struct MpDeltaInfoType
{	struct MpDeltaDiagType Diag;
} MpDeltaInfoType;

typedef struct MpDelta2Axis
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDelta2AxisParType* Parameters;
	unsigned long AxesGroup;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Z;
	double PathVelocity;
	struct MpDelta2AxisInfoType Info;
	/* VAR (analog) */
	struct MpDelta2AxisInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit JogPositive;
	plcbit JogNegative;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpDelta2Axis_typ;

typedef struct MpDelta3Axis
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDelta3AxisParType* Parameters;
	unsigned long AxesGroup;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double PathVelocity;
	struct MpDelta3AxisInfoType Info;
	/* VAR (analog) */
	struct MpDelta3AxisInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit JogPositive;
	plcbit JogNegative;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpDelta3Axis_typ;

typedef struct MpDelta4Axis
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDelta4AxisParType* Parameters;
	unsigned long AxesGroup;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double C;
	double PathVelocity;
	struct MpDelta4AxisInfoType Info;
	/* VAR (analog) */
	struct MpDelta4AxisInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit JogPositive;
	plcbit JogNegative;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpDelta4Axis_typ;

typedef struct MpDelta2AxisConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDelta2AxisConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDeltaInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpDelta2AxisConfig_typ;

typedef struct MpDelta3AxisConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDelta3AxisConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDeltaInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpDelta3AxisConfig_typ;

typedef struct MpDelta4AxisConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDelta4AxisConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDeltaInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpDelta4AxisConfig_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpDelta2Axis(struct MpDelta2Axis* inst);
_BUR_PUBLIC void MpDelta3Axis(struct MpDelta3Axis* inst);
_BUR_PUBLIC void MpDelta4Axis(struct MpDelta4Axis* inst);
_BUR_PUBLIC void MpDelta2AxisConfig(struct MpDelta2AxisConfig* inst);
_BUR_PUBLIC void MpDelta3AxisConfig(struct MpDelta3AxisConfig* inst);
_BUR_PUBLIC void MpDelta4AxisConfig(struct MpDelta4AxisConfig* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPDELTA_ */

