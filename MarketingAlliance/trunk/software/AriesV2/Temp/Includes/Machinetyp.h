/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491508150_2_
#define _BUR_1491508150_2_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef enum CreaserPrcsState_Enum
{	PRCS_STATE_INIT = 0,
	PRCS_STATE_READY = 1,
	PRCS_STATE_FEED_BOARD = 2,
	PRCS_STATE_MOVE_CREASE = 3,
	PRCS_STATE_CREASE = 4,
	PRCS_STATE_MOVE_CREASE_WIDTH = 5,
	PRCS_STATE_ERROR = 6
} CreaserPrcsState_Enum;

typedef enum AriesMachineState_Enum
{	MACHINE_STATE_INIT = 0,
	MACHINE_STATE_IDLE = 1,
	MACHINE_STATE_RUNNING = 2,
	MACHINE_STATE_ERROR = 3,
	MACHINE_STATE_HARDWARE_INIT = 4,
	MACHINE_STATE_AXIS_POWER = 5,
	MACHINE_STATE_AXIS_HOME = 6
} AriesMachineState_Enum;

typedef struct CreaserConfig_typ
{	float FeedAxisAccel;
	float FeedAxisDecel;
} CreaserConfig_typ;

typedef struct AriesCreaserParams_typ
{	float CreaseDistance_mm[10];
	float CreaseWidth_mm;
	unsigned long CreaseCount;
	unsigned long ShaftSensorEdge;
	unsigned long CreaserDirection;
	float CreaserMotorIdxLag_S;
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
} Machine_Alarms_typ;

typedef struct Global_Statistics_typ
{	unsigned long total_runtime;
	unsigned long runtime_h;
	unsigned long runtime_m;
	unsigned long runtime_s;
	unsigned long total_processed;
	plcbit Reset;
} Global_Statistics_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Machine.typ\\\" scope \\\"global\\\"\\n\"");

/* Additional IEC dependencies */
__asm__(".ascii \"iecdep \\\"Logical/GlobalConstants.var\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491508150_2_ */

