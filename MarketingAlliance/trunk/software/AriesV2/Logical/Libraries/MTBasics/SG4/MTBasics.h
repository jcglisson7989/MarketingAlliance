/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _MTBASICS_
#define _MTBASICS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <sys_lib.h>
#include <brsystem.h>

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Datatypes and datatypes of function blocks */
typedef enum MTBasicsPWMModeEnum
{	mtPULSE_BEGINNING = 0,
	mtPULSE_MIDDLE = 1
} MTBasicsPWMModeEnum;

typedef enum MTBasicsStatusEnum
{	mtTUNING_ABORTED_BY_USER = 36250,
	mtFIRST_TIME_CONSTANT_ZERO = 36251,
	mtSECOND_TIME_CONSTANT_ZERO = 36252,
	mtERR_OUTPUT_LIMIT_INVALID = 36260,
	mtERR_GAIN_INVALID = 36261,
	mtERR_INTEGRATION_TIME_NEGATIV = 36262,
	mtERR_DERIVATIVE_TIME_NEGATIV = 36263,
	mtERR_FILTER_TIME_NEGATIV = 36264,
	mtERR_INTEGRATION_LIMIT_INVALID = 36265,
	mtERR_THRESHOLD_NOT_DEFINED = 36266,
	mtERR_THRESHOLD_INVALID = 36267,
	mtERR_OUTPUT_VALUE_NOT_DEFINED = 36268,
	mtERR_MIN_OUT_NEGATIV = 36269,
	mtERR_SAMPLING_INVALID = 36270,
	mtERR_SET_VALUE_NEGATIV = 36271,
	mtERR_FIRST_TIME_CONSTANT_NEG = 36272,
	mtERR_SECOND_TIME_CONSTANT_NEG = 36273,
	mtERR_GAIN_NEGATIV = 36274,
	mtERR_MEMORY_ALLOCATION_ERROR = 36275,
	mtERR_DELAY_TIME_NEGATIV = 36276,
	mtERR_DELAY_TIME_HIGH = 36277,
	mtERR_MAX_POS_SLEW_RATE_NEGATIV = 36278,
	mtERR_MAX_NEG_SLEW_RATE_NEGATIV = 36279,
	mtERR_DENOM_COEFF_INVALID = 36280,
	mtERR_ORDER_NOT_MINIMAL = 36281,
	mtERR_ORDER_LIMIT_EXCEEDED = 36282,
	mtERR_MIN_PULSE_HIGH = 36283,
	mtERR_MIN_PULSE_LOW = 36284,
	mtERR_PERIOD_LOW = 36285,
	mtERR_PULSE_WIDTH_LOW = 36286,
	mtERR_MIN_PAUSE_LOW = 36287,
	mtWARN_OUTPUT_LIMIT_INVALID = 36300,
	mtWARN_FILTER_TIME_LOW = 36301,
	mtWARN_GAIN_INVALID = 36302,
	mtWARN_INTEGRATION_TIME_NEGATIV = 36303,
	mtWARN_DERIVATIVE_TIME_NEGATIV = 36304,
	mtWARN_FILTER_TIME_NEGATIV = 36305,
	mtWARN_INTEGRATION_LIMIT_INVALID = 36306,
	mtWARN_THRESHOLD_NOT_DEFINED = 36307,
	mtWARN_THRESHOLD_INVALID = 36308,
	mtWARN_OUTPUT_VALUE_NOT_DEFINED = 36309,
	mtWARN_MIN_OUT_NEGATIV = 36310,
	mtWARN_SET_VALUE_NEGATIV = 36311,
	mtWARN_GAIN_ZERO = 36312,
	mtWARN_FIRST_TIME_CONSTANT_NEG = 36313,
	mtWARN_SECOND_TIME_CONSTANT_NEG = 36314,
	mtWARN_GAIN_NEGATIV = 36315,
	mtWARN_MEMORY_ALLOCATION_EROR = 36316,
	mtWARN_DELAY_TIME_NEGATIV = 36317,
	mtWARN_DELAY_TIME_HIGH = 36318,
	mtWARN_MAX_POS_SLEW_RATE_NEGATIV = 36319,
	mtWARN_MAX_NEG_SLEW_RATE_NEGATIV = 36320,
	mtWARN_DENOM_COEFF_INVALID = 36321,
	mtWARN_ORDER_NOT_MINIMAL = 36322,
	mtWARN_ORDER_LIMIT_EXCEEDED = 36323,
	mtWARN_PRESET_INVALID = 36324,
	mtWARN_MIN_PULSE_HIGH = 36325,
	mtWARN_MIN_PULSE_LOW = 36326,
	mtWARN_PERIOD_LOW = 36327,
	mtWARN_PULSE_WIDTH_LOW = 36328,
	mtWARN_MIN_PAUSE_LOW = 36329
} MTBasicsStatusEnum;

typedef struct MTBasicsPIDParameterType
{	float Gain;
	float IntegrationTime;
	float DerivativeTime;
	float FilterTime;
	float MinIntegrationPartValue;
	float MaxIntegrationPartValue;
	float MinOut;
	float MaxOut;
} MTBasicsPIDParameterType;

typedef struct MTBasicsLevelCtrlParaType
{	float OutputValue1;
	float OutputValue2;
	float OutputValue3;
	float ThresholdLevel1;
	float ThresholdLevel2;
	float ThresholdLevel3;
	float ThresholdLevel4;
} MTBasicsLevelCtrlParaType;

typedef struct MTBasicsPIDInternalType
{	float CycleTime;
	plcbit ParameterValid;
	struct MTBasicsPIDParameterType Parameter;
	float ControlErrorOld;
	plcbit OutLimitation;
	float IntegrationPartPresetValue;
	plcbit SetIntegrationPart;
	plcbit SetIntegrationPartOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsPIDInternalType;

typedef struct MTBasicsOscTuningInternalType
{	float CycleTime;
	plcbit Activate3rdPhase;
	float X0;
	unsigned char State;
	float CriticalGain;
	float OscillationPeriod;
	unsigned char NumberOfOscillations;
	unsigned char NumberOfPhases;
	float MaxRelayOut;
	float MinRelayOut;
	plcbit ParameterValid;
	float SetValue;
	float AverageOutValue;
	float MaxActValueTime[4];
	float MinActValueTime[4];
	float MaxActValue[4];
	float MinActValue[4];
	float OutNegEdgeTime[4];
	float OutPosEdgeTime[4];
	float TuningTime;
	float StartingActValue;
	float ControlError;
	float ActValueAverageAmplitude;
	float AverageActValue;
	float AverageMaxActValue;
	float AverageMinActValue;
	float AmplitudeRatio;
	float ControlErrorOldFalling;
	float ControlErrorOldRising;
	float DeltaOut;
	signed char EffectiveDirection;
	plcbit StartOld;
	float ControlErrorSetValueCross;
	plcbit RisingProportionalController;
	plcbit FallingProportionalController;
	float SaturatedControlError;
	float ControlErrorOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
	float MinOscillationAmplitude;
	float MinOut;
	float MaxOut;
	float TemporaryQuality;
	float TemporaryDerivativeTime;
	float TemporaryIntegrationTime;
	float TemporaryGain;
} MTBasicsOscTuningInternalType;

typedef struct MTBasicsLevelCtrlInternalType
{	float CycleTime;
	plcbit ParameterValid;
	struct MTBasicsLevelCtrlParaType Parameter;
	unsigned char State;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsLevelCtrlInternalType;

typedef struct MTBasicsPT1InternalType
{	float CycleTime;
	plcbit ParameterValid;
	float Gain;
	float TimeConstant;
	float BVector[2];
	float AVector[2];
	float XVector;
	float OutPresetValue;
	plcbit SetOut;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsPT1InternalType;

typedef struct MTBasicsPT2InternalType
{	float CycleTime;
	plcbit ParameterValid;
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float BVector[3];
	float AVector[3];
	float XVector[2];
	float OutPresetValue;
	plcbit SetOut;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsPT2InternalType;

typedef struct MTBasicsDT1InternalType
{	float CycleTime;
	plcbit ParameterValid;
	float Gain;
	float BVector[2];
	float AVector[2];
	float XVector;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsDT1InternalType;

typedef struct MTBasicsDT2InternalType
{	float CycleTime;
	plcbit ParameterValid;
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float BVector[3];
	float AVector[3];
	float XVector[2];
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsDT2InternalType;

typedef struct MTBasicsIntegratorInternalType
{	float CycleTime;
	plcbit ParameterValid;
	float BVector[2];
	float AVector[2];
	float XVector;
	float OutPresetValue;
	plcbit SetOut;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsIntegratorInternalType;

typedef struct MTBasicsTimeDelayInternalType
{	float CycleTime;
	plcbit ParameterValid;
	float DelayTimeAct;
	unsigned long MaxNumberOfBufferElements;
	unsigned long ActNumberOfBufferElements;
	unsigned long DelayCounter;
	unsigned long ActBufferIndex;
	float* BufferPointer;
	float OutPresetValue;
	plcbit SetOut;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsTimeDelayInternalType;

typedef struct MTBasicsLimiterInternalType
{	float CycleTime;
	plcbit ParameterValid;
	float MaxOut;
	float MinOut;
	float MaxPosSlewRate;
	float MaxNegSlewRate;
	float Out;
	float OutOld;
	float UpperOutLimit;
	float LowerOutLimit;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsLimiterInternalType;

typedef struct MTBasicsTransFcnInternalType
{	float CycleTime;
	plcbit ParameterValid;
	unsigned char Order;
	plcbit PresetOK;
	double PresetCoefficients;
	double BVector[6];
	double AVector[6];
	double XVector[5];
	float OutPresetValue;
	plcbit SetOut;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsTransFcnInternalType;

typedef struct MTBasicsDiscrTransFcnInternType
{	float CycleTime;
	plcbit ParameterValid;
	unsigned char Order;
	plcbit PresetOK;
	double PresetCoefficients;
	double BVector[6];
	double AVector[6];
	double XVector[5];
	float OutPresetValue;
	plcbit SetOut;
	plcbit SetOutOld;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsDiscrTransFcnInternType;

typedef struct MTBasicsPWMInternalType
{	float CycleTime;
	float OnTime;
	float OffTime;
	plcbit ParameterValid;
	unsigned char Mode;
	float Period;
	float MinPulseWidth;
	float PeriodCounter;
	float OnTimeCounter;
	float TimeCorrection;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsPWMInternalType;

typedef struct MTBasicsPFMInternalType
{	float CycleTime;
	plcbit ParameterValid;
	float In;
	float PulseWidth;
	float MinPause;
	float Area;
	float AreaC;
	float OffTime;
	float OnTime;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned long Bootkey;
} MTBasicsPFMInternalType;

typedef struct MTBasicsPID
{
	/* VAR_INPUT (analog) */
	struct MTBasicsPIDParameterType Parameter;
	float SetValue;
	float ActValue;
	float IntegrationPartPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	float ControlError;
	float ProportionalPart;
	float IntegrationPart;
	float DerivativePart;
	/* VAR (analog) */
	struct MTBasicsPIDInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetIntegrationPart;
	plcbit HoldOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsPID_typ;

typedef struct MTBasicsOscillationTuning
{
	/* VAR_INPUT (analog) */
	float SetValue;
	float MinOut;
	float MaxOut;
	float ActValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	float Gain;
	float IntegrationTime;
	float DerivativeTime;
	float FilterTime;
	float Quality;
	/* VAR (analog) */
	struct MTBasicsOscTuningInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit Start;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit TuningDone;
} MTBasicsOscillationTuning_typ;

typedef struct MTBasicsLevelController
{
	/* VAR_INPUT (analog) */
	struct MTBasicsLevelCtrlParaType Parameter;
	float In;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsLevelCtrlInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsLevelController_typ;

typedef struct MTBasicsPT1
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsPT1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsPT1_typ;

typedef struct MTBasicsPT2
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsPT2InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsPT2_typ;

typedef struct MTBasicsDT1
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant;
	float In;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsDT1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsDT1_typ;

typedef struct MTBasicsDT2
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float In;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsDT2InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsDT2_typ;

typedef struct MTBasicsIntegrator
{
	/* VAR_INPUT (analog) */
	float Gain;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsIntegratorInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	plcbit HoldOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsIntegrator_typ;

typedef struct MTBasicsTimeDelay
{
	/* VAR_INPUT (analog) */
	float DelayTime;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsTimeDelayInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsTimeDelay_typ;

typedef struct MTBasicsLimiter
{
	/* VAR_INPUT (analog) */
	float MinOut;
	float MaxOut;
	float MaxPosSlewRate;
	float MaxNegSlewRate;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsLimiterInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsLimiter_typ;

typedef struct MTBasicsTransferFcn
{
	/* VAR_INPUT (analog) */
	unsigned char Order;
	float Numerator[6];
	float Denominator[6];
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsTransFcnInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsTransferFcn_typ;

typedef struct MTBasicsDiscreteTransferFcn
{
	/* VAR_INPUT (analog) */
	unsigned char Order;
	float Numerator[6];
	float Denominator[6];
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsDiscrTransFcnInternType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsDiscreteTransferFcn_typ;

typedef struct MTBasicsPWM
{
	/* VAR_INPUT (analog) */
	enum MTBasicsPWMModeEnum Mode;
	float MinPulseWidth;
	float Period;
	float DutyCycle;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	/* VAR (analog) */
	struct MTBasicsPWMInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit Out;
} MTBasicsPWM_typ;

typedef struct MTBasicsPFM
{
	/* VAR_INPUT (analog) */
	float PulseWidth;
	float MinPause;
	float DutyCycle;
	/* VAR_OUTPUT (analog) */
	enum MTBasicsStatusEnum StatusID;
	/* VAR (analog) */
	struct MTBasicsPFMInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit Out;
} MTBasicsPFM_typ;



/* Prototyping of functions and function blocks */
void MTBasicsPID(struct MTBasicsPID* inst);
void MTBasicsOscillationTuning(struct MTBasicsOscillationTuning* inst);
void MTBasicsLevelController(struct MTBasicsLevelController* inst);
void MTBasicsPT1(struct MTBasicsPT1* inst);
void MTBasicsPT2(struct MTBasicsPT2* inst);
void MTBasicsDT1(struct MTBasicsDT1* inst);
void MTBasicsDT2(struct MTBasicsDT2* inst);
void MTBasicsIntegrator(struct MTBasicsIntegrator* inst);
void MTBasicsTimeDelay(struct MTBasicsTimeDelay* inst);
void MTBasicsLimiter(struct MTBasicsLimiter* inst);
void MTBasicsTransferFcn(struct MTBasicsTransferFcn* inst);
void MTBasicsDiscreteTransferFcn(struct MTBasicsDiscreteTransferFcn* inst);
void MTBasicsPWM(struct MTBasicsPWM* inst);
void MTBasicsPFM(struct MTBasicsPFM* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MTBASICS_ */

