/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _MTDATA_
#define _MTDATA_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <sys_lib.h>
#include <brsystem.h>
#include <astime.h>
#include <MTTypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define mtBCD_WRN_DATA_WINDOW_INVALID (-2131753988)
 #define mtBCD_ERR_DATA_WINDOW_INVALID (-1058012163)
 #define mtBCD_ERR_DATA_NB_VALUES_HIGH (-1058012164)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long mtBCD_WRN_DATA_WINDOW_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DATA_WINDOW_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DATA_NB_VALUES_HIGH;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct MTDataStdDeviationInternalType
{	float CycleTime;
	double Mean;
	double Mean2;
	unsigned long NumberOfValues;
	plcbit EnableOld;
	plcbit ResetOld;
	plcbit Hold;
} MTDataStdDeviationInternalType;

typedef struct MTDataVarianceInternalType
{	float CycleTime;
	double Mean;
	double Mean2;
	unsigned long NumberOfValues;
	plcbit EnableOld;
	plcbit ResetOld;
	plcbit Hold;
} MTDataVarianceInternalType;

typedef struct MTDataRMSInternalType
{	float CycleTime;
	double Mean2;
	unsigned long NumberOfValues;
	plcbit EnableOld;
	plcbit ResetOld;
	plcbit Hold;
} MTDataRMSInternalType;

typedef struct MTDataMeanInternalType
{	float CycleTime;
	double Mean;
	unsigned long NumberOfValues;
	plcbit EnableOld;
	plcbit ResetOld;
	plcbit Hold;
} MTDataMeanInternalType;

typedef struct MTDataMinMaxInternalType
{	float CycleTime;
	unsigned long NumberOfValues;
	plcbit EnableOld;
	plcbit ResetOld;
	plcbit Hold;
} MTDataMinMaxInternalType;

typedef struct MTDataStatisticsInternalType
{	float CycleTime;
	plcbit ParametersValid;
	unsigned long NumberOfValues;
	unsigned long Buffer;
	unsigned long BufferMax;
	unsigned long NumberMax;
	unsigned long Number0;
	double Mean;
	double Mean2;
	plcbit Change;
	float InOld;
	unsigned long BufferOld;
	plcbit ResetOld;
	plcbit EnableOld;
	plcbit UpdateOld;
	plcbit FirstTime;
	unsigned short MemStatus;
	unsigned long BufferCntMax;
	float* pBuffer;
} MTDataStatisticsInternalType;

typedef struct MTDataStdDeviation
{
	/* VAR_INPUT (analog) */
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTDataStdDeviationInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MTDataStdDeviation_typ;

typedef struct MTDataVariance
{
	/* VAR_INPUT (analog) */
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTDataVarianceInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MTDataVariance_typ;

typedef struct MTDataRMS
{
	/* VAR_INPUT (analog) */
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTDataRMSInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MTDataRMS_typ;

typedef struct MTDataMean
{
	/* VAR_INPUT (analog) */
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTDataMeanInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MTDataMean_typ;

typedef struct MTDataMinMax
{
	/* VAR_INPUT (analog) */
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float MinValue;
	unsigned long IndexMinValue;
	float MaxValue;
	unsigned long IndexMaxValue;
	/* VAR (analog) */
	struct MTDataMinMaxInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MTDataMinMax_typ;

typedef struct MTDataStatistics
{
	/* VAR_INPUT (analog) */
	unsigned long MovingWindowLength;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float MinValue;
	unsigned long IndexMinValue;
	float MaxValue;
	unsigned long IndexMaxValue;
	float Mean;
	float RMS;
	float Variance;
	float StdDeviation;
	/* VAR (analog) */
	struct MTDataStatisticsInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTDataStatistics_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MTDataStdDeviation(struct MTDataStdDeviation* inst);
_BUR_PUBLIC void MTDataVariance(struct MTDataVariance* inst);
_BUR_PUBLIC void MTDataRMS(struct MTDataRMS* inst);
_BUR_PUBLIC void MTDataMean(struct MTDataMean* inst);
_BUR_PUBLIC void MTDataMinMax(struct MTDataMinMax* inst);
_BUR_PUBLIC void MTDataStatistics(struct MTDataStatistics* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MTDATA_ */

