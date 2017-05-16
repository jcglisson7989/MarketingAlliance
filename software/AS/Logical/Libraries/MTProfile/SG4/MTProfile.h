/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _MTPROFILE_
#define _MTPROFILE_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <sys_lib.h>
#include <brsystem.h>
#include <MTTypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define mtBCD_WRN_PERIOD_ZERO (-2131753907)
 #define mtBCD_WRN_TIMEVAL_UNSORTED (-2131753908)
 #define mtBCD_WRN_FUNCTION_MODE_INVALID (-2131753909)
 #define mtBCD_WRN_NB_NODES_INVALID (-2131753910)
 #define mtBCD_WRN_NODES_NULL_PTR (-2131753911)
 #define mtBCD_WRN_JOLTTIME_INVALID (-2131753912)
 #define mtBCD_WRN_DEC_NEG_DIR_NEG_ZERO (-2131753913)
 #define mtBCD_WRN_DEC_POS_DIR_NEG_ZERO (-2131753914)
 #define mtBCD_WRN_ACC_NEG_DIR_NEG_ZERO (-2131753915)
 #define mtBCD_WRN_ACC_POS_DIR_NEG_ZERO (-2131753916)
 #define mtBCD_WRN_VEL_NEG_DIR_NEG_ZERO (-2131753917)
 #define mtBCD_WRN_VEL_POS_DIR_NEG_ZERO (-2131753918)
 #define mtBCD_ERR_PERIOD_ZERO (-1058012083)
 #define mtBCD_ERR_TIMEVAL_UNSORTED (-1058012084)
 #define mtBCD_ERR_FUNCTION_MODE_INVALID (-1058012085)
 #define mtBCD_ERR_NB_NODES_INVALID (-1058012086)
 #define mtBCD_ERR_NODES_NULL_PTR (-1058012087)
 #define mtBCD_ERR_JOLTTIME_INVALID (-1058012088)
 #define mtBCD_ERR_DEC_NEG_DIR_NEG_ZERO (-1058012089)
 #define mtBCD_ERR_DEC_POS_DIR_NEG_ZERO (-1058012090)
 #define mtBCD_ERR_ACC_NEG_DIR_NEG_ZERO (-1058012091)
 #define mtBCD_ERR_ACC_POS_DIR_NEG_ZERO (-1058012092)
 #define mtBCD_ERR_VEL_NEG_DIR_NEG_ZERO (-1058012093)
 #define mtBCD_ERR_VEL_POS_DIR_NEG_ZERO (-1058012094)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long mtBCD_WRN_PERIOD_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_TIMEVAL_UNSORTED;
 _GLOBAL_CONST signed long mtBCD_WRN_FUNCTION_MODE_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_NB_NODES_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_NODES_NULL_PTR;
 _GLOBAL_CONST signed long mtBCD_WRN_JOLTTIME_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_DEC_NEG_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_DEC_POS_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_ACC_NEG_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_ACC_POS_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_VEL_NEG_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_VEL_POS_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_PERIOD_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_TIMEVAL_UNSORTED;
 _GLOBAL_CONST signed long mtBCD_ERR_FUNCTION_MODE_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_NB_NODES_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_NODES_NULL_PTR;
 _GLOBAL_CONST signed long mtBCD_ERR_JOLTTIME_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DEC_NEG_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_DEC_POS_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_ACC_NEG_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_ACC_POS_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_VEL_NEG_DIR_NEG_ZERO;
 _GLOBAL_CONST signed long mtBCD_ERR_VEL_POS_DIR_NEG_ZERO;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum MTProfileFunctionModeEnum
{	mtPROFILE_ZERO_ORDER_HOLD = 0,
	mtPROFILE_FIRST_ORDER_HOLD = 1
} MTProfileFunctionModeEnum;

typedef enum MTProfilePositionStateEnum
{	mtPROFILE_DEC_NEG_DIR = -3,
	mtPROFILE_CONST_VEL_NEG_DIR = -2,
	mtPROFILE_ACC_NEG_DIR = -1,
	mtPROFILE_STANDSTILL = 0,
	mtPROFILE_ACC_POS_DIR = 1,
	mtPROFILE_CONST_VEL_POS_DIR = 2,
	mtPROFILE_DEC_POS_DIR = 3
} MTProfilePositionStateEnum;

typedef struct MTProfilePositionParameterType
{	float VelocityPosDirection;
	float VelocityNegDirection;
	float AccelerationPosDirection;
	float DecelerationPosDirection;
	float AccelerationNegDirection;
	float DecelerationNegDirection;
	float JoltTime;
} MTProfilePositionParameterType;

typedef struct MTProfileFcnNodeInternalType
{	float TimeValue;
	float FcnValue;
	float C0;
	float C1;
} MTProfileFcnNodeInternalType;

typedef struct MTProfileFunctionNodeType
{	float TimeValue;
	float FcnValue;
	struct MTProfileFcnNodeInternalType Internal;
} MTProfileFunctionNodeType;

typedef struct MTProfilePosGenInternalType
{	float CycleTime;
	double Tv[3];
	plcbit ParametersValid;
	struct MTProfilePositionParameterType Parameter;
	unsigned char ProfileNb;
	unsigned char ProfileID;
	signed char MovementCase;
	unsigned char MovementPhase;
	unsigned char MovementStep;
	float HomeVelocity;
	unsigned char HomeVelocityIntrude;
	double HomeVelocityDbl;
	unsigned char HomeVelocityState;
	double Quantum0;
	float Quantum;
	float QuantumJolt;
	double QuantumSPF;
	double Position0;
	float Position;
	float PositionJolt;
	double PositionSPF;
	double PositionOffset;
	double Velocity0;
	float Velocity;
	float VelocityJolt;
	double VelocitySPF;
	double Acceleration0;
	float Acceleration;
	float AccelerationJolt;
	double AccelerationSPF;
	float JoltTimeMax;
	double JoltTime;
	float EndPosition;
	double PositionDifference;
	double BrakingDistance;
	double TopSpeed;
	float ParameterV[6];
	double AccelerationV[20];
	double ConstantV[20];
	double DecelerationV[20];
	double TimerV[2];
	double* QuantumBuffer;
	double* PositionBuffer;
	double* VelocityBuffer;
	double* AccelerationBuffer;
	signed long BufCntMax;
	signed long BufCnt;
	signed long CntJoltTime;
	signed long BufCntJoltTime;
	plcbit AtStandstill;
	unsigned char ExecutionEvent;
	plcbit Start;
	plcbit StartOld;
	plcbit Stop;
	plcbit StopOld;
	plcbit AbortOld;
	plcbit SetHomePositionOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	struct SysInfo SystemInfo;
	plcbit ConstTaskCycle;
	unsigned short TimeCounterState;
	unsigned long MicroSecondsOld;
	unsigned long SystemTicksOld;
	unsigned short MemStatus;
	unsigned long BufLen;
	float TCycle;
} MTProfilePosGenInternalType;

typedef struct MTProfileFcnGenInternalType
{	float CycleTime;
	double Tv[2];
	plcbit ParametersValid;
	struct MTProfileFunctionNodeType* Nodes;
	unsigned short NumberOfNodes;
	signed char TimeValueOrder;
	float Period;
	double TimerV[2];
	plcbit ResetTimer;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
	struct SysInfo SystemInfo;
	plcbit ConstTaskCycle;
	unsigned short TimeCounterState;
	unsigned long MicroSecondsOld;
	unsigned long SystemTicksOld;
	unsigned long BootkeyTimeCounter;
	float PerTemp;
	float TCycle;
} MTProfileFcnGenInternalType;

typedef struct MTProfilePositionGenerator
{
	/* VAR_INPUT (analog) */
	struct MTProfilePositionParameterType Parameter;
	float EndPosition;
	float HomePosition;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Position;
	float Velocity;
	float Acceleration;
	enum MTProfilePositionStateEnum MotionState;
	/* VAR (analog) */
	struct MTProfilePosGenInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit Start;
	plcbit Stop;
	plcbit Abort;
	plcbit SetHomePosition;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit Done;
} MTProfilePositionGenerator_typ;

typedef struct MTProfileFunctionGenerator
{
	/* VAR_INPUT (analog) */
	struct MTProfileFunctionNodeType* Nodes;
	unsigned short NumberOfNodes;
	enum MTProfileFunctionModeEnum Mode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTProfileFcnGenInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTProfileFunctionGenerator_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MTProfilePositionGenerator(struct MTProfilePositionGenerator* inst);
_BUR_PUBLIC void MTProfileFunctionGenerator(struct MTProfileFunctionGenerator* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MTPROFILE_ */

