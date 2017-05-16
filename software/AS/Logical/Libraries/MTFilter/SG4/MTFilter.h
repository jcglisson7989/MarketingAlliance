/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _MTFILTER_
#define _MTFILTER_
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
 #define mtBCD_WRN_FILTER_WINDOW_INVALID (-2131753973)
 #define mtBCD_WRN_DAMPING_DEN_INVALID (-2131753974)
 #define mtBCD_WRN_FREQ_DEN_INVALID (-2131753975)
 #define mtBCD_WRN_DAMPING_NUM_INVALID (-2131753976)
 #define mtBCD_WRN_FREQ_NUM_INVALID (-2131753977)
 #define mtBCD_WRN_FILTER_BANDWIDTH (-2131753978)
 #define mtBCD_WRN_CENTER_FREQ_INVALID (-2131753979)
 #define mtBCD_WRN_CUTOFF_FREQ_INVALID (-2131753980)
 #define mtBCD_WRN_FILTER_ORDER_INVALID (-2131753981)
 #define mtBCD_WRN_FILTER_TYPE_INVALID (-2131753982)
 #define mtBCD_ERR_FILTER_WINDOW_INVALID (-1058012149)
 #define mtBCD_ERR_DAMPING_DEN_INVALID (-1058012150)
 #define mtBCD_ERR_FREQ_DEN_INVALID (-1058012151)
 #define mtBCD_ERR_DAMPING_NUM_INVALID (-1058012152)
 #define mtBCD_ERR_FREQ_NUM_INVALID (-1058012153)
 #define mtBCD_ERR_FILTER_BANDWIDTH (-1058012154)
 #define mtBCD_ERR_CENTER_FREQ_INVALID (-1058012155)
 #define mtBCD_ERR_CUTOFF_FREQ_INVALID (-1058012156)
 #define mtBCD_ERR_FILTER_ORDER_INVALID (-1058012157)
 #define mtBCD_ERR_FILTER_TYPE_INVALID (-1058012158)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long mtBCD_WRN_FILTER_WINDOW_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_DAMPING_DEN_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_FREQ_DEN_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_DAMPING_NUM_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_FREQ_NUM_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_FILTER_BANDWIDTH;
 _GLOBAL_CONST signed long mtBCD_WRN_CENTER_FREQ_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_CUTOFF_FREQ_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_FILTER_ORDER_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_FILTER_TYPE_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_FILTER_WINDOW_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DAMPING_DEN_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_FREQ_DEN_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DAMPING_NUM_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_FREQ_NUM_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_FILTER_BANDWIDTH;
 _GLOBAL_CONST signed long mtBCD_ERR_CENTER_FREQ_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_CUTOFF_FREQ_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_FILTER_ORDER_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_FILTER_TYPE_INVALID;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum MTFilterTypeEnum
{	mtFILTER_BESSEL = 0,
	mtFILTER_BUTTERWORTH = 1
} MTFilterTypeEnum;

typedef struct MTFilterMovingAvgInternalType
{	float Ts;
	plcbit ParameterValid;
	unsigned short NumOfElmements;
	double Sum;
	unsigned long pBuffer;
	unsigned short CntAct;
	unsigned short CntOld;
	unsigned short WindowLength;
	unsigned short BufferLength;
	plcbit BufferFull;
	plcbit MemAllocated;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	unsigned short statusTMP;
} MTFilterMovingAvgInternalType;

typedef struct MTFilterLowPassInternalType
{	float Ts;
	double SamplingFrequency;
	plcbit ParameterValid;
	double AngularFrequency;
	double Num[6];
	double Den[6];
	double BVector[6];
	double AVector[6];
	double XVector[5];
	unsigned char TypeOld;
	unsigned char OrderOld;
	float CutOffFrequencyOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTFilterLowPassInternalType;

typedef struct MTFilterHighPassInternalType
{	float Ts;
	double SamplingFrequency;
	plcbit ParameterValid;
	double AngularFrequency;
	double Num[6];
	double Den[6];
	double BVector[6];
	double AVector[6];
	double XVector[5];
	unsigned char TypeOld;
	unsigned char OrderOld;
	float CutOffFrequencyOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTFilterHighPassInternalType;

typedef struct MTFilterBandPassInternalType
{	float Ts;
	double SamplingFrequency;
	plcbit ParameterValid;
	double AngularFrequency;
	double BandwidthRad;
	double Num[6];
	double Den[6];
	double BVector[6];
	double AVector[6];
	double XVector[5];
	unsigned char TypeOld;
	unsigned char OrderOld;
	float CenterFrequencyOld;
	float BandwidthOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTFilterBandPassInternalType;

typedef struct MTFilterBandStopInternalType
{	float Ts;
	double SamplingFrequency;
	plcbit ParameterValid;
	double AngularFrequency;
	double BandwidthRad;
	double Num[6];
	double Den[6];
	double BVector[6];
	double AVector[6];
	double XVector[5];
	unsigned char TypeOld;
	unsigned char OrderOld;
	float CenterFrequencyOld;
	float BandwidthOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTFilterBandStopInternalType;

typedef struct MTFilterNotchInternalType
{	float Ts;
	double SamplingFrequency;
	plcbit ParametersValid;
	float UpperFrequency;
	float LowerFrequency;
	float BandwidthAct;
	float DampingConstant;
	float FilterTimeConstant;
	double Num[3];
	double Den[3];
	double BVector[3];
	double AVector[3];
	double XVector[2];
	unsigned char TypeOld;
	unsigned char OrderOld;
	float CutOffFrequencyOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	plcbit SysRefParaNew;
	unsigned long CounterOld;
	struct MTTransferFcnType SystemReference;
} MTFilterNotchInternalType;

typedef struct MTFilterBiQuadInternalType
{	float Ts;
	double SamplingFrequency;
	plcbit ParameterValid;
	double Num[3];
	double Den[3];
	double BVector[3];
	double AVector[3];
	double XVector[2];
	float FrequencyNumeratorOld;
	float DampingRatioNumeratorOld;
	float FrequencyDenominatorOld;
	float DampingRatioDenominatorOld;
	double FrequencyNumeratorRad;
	double FrequencyDenominatorRad;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	plcbit SysRefParaNew;
	unsigned long CounterOld;
	struct MTTransferFcnType SystemReference;
} MTFilterBiQuadInternalType;

typedef struct MTFilterBandPass
{
	/* VAR_INPUT (analog) */
	enum MTFilterTypeEnum Type;
	unsigned char Order;
	float CenterFrequency;
	float Bandwidth;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTFilterBandPassInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterBandPass_typ;

typedef struct MTFilterBandStop
{
	/* VAR_INPUT (analog) */
	enum MTFilterTypeEnum Type;
	unsigned char Order;
	float CenterFrequency;
	float Bandwidth;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTFilterBandStopInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterBandStop_typ;

typedef struct MTFilterBiQuad
{
	/* VAR_INPUT (analog) */
	float CenterFrequencyNum;
	float DampingRatioNum;
	float CenterFrequencyDen;
	float DampingRatioDen;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTFilterBiQuadInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterBiQuad_typ;

typedef struct MTFilterHighPass
{
	/* VAR_INPUT (analog) */
	enum MTFilterTypeEnum Type;
	unsigned char Order;
	float CutOffFrequency;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTFilterHighPassInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterHighPass_typ;

typedef struct MTFilterLowPass
{
	/* VAR_INPUT (analog) */
	enum MTFilterTypeEnum Type;
	unsigned char Order;
	float CutOffFrequency;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTFilterLowPassInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterLowPass_typ;

typedef struct MTFilterMovingAverage
{
	/* VAR_INPUT (analog) */
	unsigned short WindowLength;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTFilterMovingAvgInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterMovingAverage_typ;

typedef struct MTFilterNotch
{
	/* VAR_INPUT (analog) */
	float CenterFrequency;
	float Bandwidth;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTFilterNotchInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTFilterNotch_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MTFilterBandPass(struct MTFilterBandPass* inst);
_BUR_PUBLIC void MTFilterBandStop(struct MTFilterBandStop* inst);
_BUR_PUBLIC void MTFilterBiQuad(struct MTFilterBiQuad* inst);
_BUR_PUBLIC void MTFilterHighPass(struct MTFilterHighPass* inst);
_BUR_PUBLIC void MTFilterLowPass(struct MTFilterLowPass* inst);
_BUR_PUBLIC void MTFilterMovingAverage(struct MTFilterMovingAverage* inst);
_BUR_PUBLIC void MTFilterNotch(struct MTFilterNotch* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MTFILTER_ */

