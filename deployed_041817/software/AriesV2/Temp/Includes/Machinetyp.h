/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1493049543_2_
#define _BUR_1493049543_2_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef enum CreaserPrcsState_Enum
{	PRCS_STATE_INIT = 0,
	PRCS_STATE_READY = 1,
	PRCS_STATE_FEED_BOARD = 2,
	PRCS_STATE_MOVE_CREASE = 3,
	PRCS_STATE_CREASE = 4,
	PRCS_STATE_MOVE_CREASE_WIDTH = 5,
	PRCS_STATE_ERROR = 6,
	PRCS_STATE_EJECT_FINISHED_BOARD = 7,
	PRCS_STATE_SOFT_STOP = 8,
	PRCS_STATE_MOVE_PHOTOEYE_OFFSET = 9
} CreaserPrcsState_Enum;

typedef enum AriesMachineState_Enum
{	MACHINE_STATE_INIT = 0,
	MACHINE_STATE_IDLE = 1,
	MACHINE_STATE_RUNNING = 2,
	MACHINE_STATE_ERROR = 3,
	MACHINE_STATE_HARDWARE_INIT = 4,
	MACHINE_STATE_AXIS_POWER = 5,
	MACHINE_STATE_AXIS_HOME = 6,
	MACHINE_STATE_MANUAL_EJECT = 7
} AriesMachineState_Enum;

typedef struct CreaserConfig_typ
{	float FeedAxisAccel;
	float FeedAxisDecel;
	float PhotoEyeOffset;
	float PreInsertSpeed;
	float BoardLengthTolerance;
	float CreaseInfeedDelay;
} CreaserConfig_typ;

typedef struct AriesCreaserParams_typ
{	float CreaseDistance_mm[20];
	float CreaseWidth_mm;
	unsigned long CreaseCount;
	unsigned long ShaftSensorEdge;
	unsigned long CreaserDirection;
	float CreaserMotorIdxLag_S;
	float TotalBoardLength;
} AriesCreaserParams_typ;

typedef struct AriesIOPoints_typ
{	plcbit oCreaserCCWRotation;
	plcbit oCreaserCWRotation;
	plcbit oBoardFeedingLight;
	plcbit oUIIndicatorLight;
	plcbit iSafeMachineState;
	plcbit iCreaserShaftSensor;
	plcbit iFiberOpticSensor;
	plcbit iSM1Disabled;
} AriesIOPoints_typ;

typedef struct Machine_Alarms_typ
{	plcbit SM1_Disabled;
	plcbit Unsafe_Machine_State;
	plcbit Fiber_Optic_Blocked_RunCmd;
	plcbit Creaser_Shaft_Edge_Timeout;
	plcbit Error_State_Unsafe_Machine;
	plcbit Error_State_SM1_Power;
	plcbit Feed_Axis_Motor_Error;
	plcbit Crease_Count_Greater_Max;
	plcbit Error_State_Process_Error;
	plcbit Load_Recipe;
	plcbit Manual_Home_Creaser_Blade;
	plcbit Board_Length_GT_Confgd_Amount;
	plcbit Board_Length_LT_Confgd_Amount;
	plcbit Measured_Length_GT_Configured;
	plcbit Measured_Length_LT_Configured;
	plcbit Unsaved_Recipe_Params;
} Machine_Alarms_typ;

typedef struct Global_Statistics_typ
{	unsigned long total_runtime;
	unsigned long runtime_h;
	unsigned long runtime_m;
	unsigned long runtime_s;
	unsigned long total_processed;
	plcbit Reset;
	unsigned long total_creases;
	float Sum_Board_Travel_Lengths;
	float Avg_Board_Length;
} Global_Statistics_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Machine.typ\\\" scope \\\"global\\\"\\n\"");

/* Additional IEC dependencies */
__asm__(".ascii \"iecdep \\\"Logical/Global.var\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1493049543_2_ */

