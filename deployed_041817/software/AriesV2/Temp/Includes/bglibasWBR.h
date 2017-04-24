/* Automation Studio generated header file */
/* Do not edit ! */
/* bglibasWBR  */

#ifndef _BGLIBASWBR_
#define _BGLIBASWBR_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "standard.h"
		#include "wbrLogSvc.h"
#endif
#ifdef _SG3
		#include "standard.h"
		#include "wbrLogSvc.h"
#endif
#ifdef _SGC
		#include "standard.h"
		#include "wbrLogSvc.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef enum BGWBR_TIMER_CONSTANT
{	BG_TIMERTIME_1SEC = 1000,
	BG_TIMERTIME_1MIN = 60000,
	BG_TIMERTIME_1HOUR = 3600000
} BGWBR_TIMER_CONSTANT;

typedef enum BGSSM_CONST_XYZ
{	BGSSM_FLAG_COUNT = 5,
	BGSSM_EVENT_COUNT = 5,
	BGSSM_COUNTER_COUNT = 5,
	BGSSM_TIMER_COUNT = 5,
	BGSSM_REGISTER_COUNT = 5,
	BGSSM_SUBROUTINE_COUNT = 5,
	BGSSM_MAX_LOG_ENTRY_INDEX = 31,
	BGSSM_LOG_ENTRIES,
	BGSSM_TEXT_LENGTH = 31,
	BGSSM_MESSAGE_LENGTH_IEC = 127,
	BGSSM_MESSAGE_LENGTH_C
} BGSSM_CONST_XYZ;

typedef struct bgFIFO_typ
{	unsigned long iPtrPushData;
	unsigned long cfgEntrySize;
	unsigned long cfgMaxEntries;
	unsigned long oPtrPullData;
	unsigned long oFIFOCount;
	unsigned long oFIFOFull;
	unsigned long oPushIdx;
	unsigned long oPullIdx;
	unsigned long prvFIFOMemory;
} bgFIFO_typ;

typedef struct bgSSMScanLimit_typ
{	plcbit breakpoint;
	plcbit breakpointPrev;
	plcbit active;
	plcbit triggerNextScan;
	unsigned long limit;
	unsigned long count;
} bgSSMScanLimit_typ;

typedef struct bgSSMMessage_typ
{	plcstring log[128];
	plcstring err[128];
	plcstring sts[128];
} bgSSMMessage_typ;

typedef struct bgSSMLog_typ
{	plcstring view[32][128];
	struct wbrListSvcStringList_typ str;
} bgSSMLog_typ;

typedef struct bgSSM_typ
{	struct bgSSMScanLimit_typ scanLimit;
	struct bgSSMLog_typ log;
	unsigned long state;
	unsigned long stateNext;
	unsigned long stateAfterSubIndex;
	unsigned long stateAfterSub[6];
	unsigned long stateRet;
	unsigned long stateOld;
	plcstring stateText[32];
	unsigned long pfunInitState;
	unsigned long pfunInterrupt;
	unsigned long pfunGetStateName;
	unsigned long pfunCyclicCallback;
	plcbit stateInit;
	unsigned long error;
	plcstring errorText[32];
	plcstring message[128];
	struct bgSSMMessage_typ msg;
	plcbit event[6];
	plcbit flag[6];
	unsigned long counter[6];
	unsigned long value[6];
	struct TON timer_x1ms[6];
	struct TON dlytimer_x1ms;
	struct TON wdogTimer_x1ms;
	unsigned long dlyCycles;
} bgSSM_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned long bgSSMInitWbr(struct bgSSM_typ* p, unsigned long pfunInitState, unsigned long pfunInterrupt, unsigned long pfunCyclicCallback);
_BUR_PUBLIC unsigned long bgSSMInit(struct bgSSM_typ* p, unsigned long pfunGetStateName, unsigned long pfunCyclicCallback);
_BUR_PUBLIC unsigned long bgSSMCyclic(struct bgSSM_typ* p);
_BUR_PUBLIC unsigned long bgSSMStateNextWithWatchdog(struct bgSSM_typ* p, unsigned long stateNext, unsigned long wdogTimeX1ms);
_BUR_PUBLIC unsigned long bgSSMStateNextTimeDelay(struct bgSSM_typ* p, unsigned long stateNext, unsigned long timeDelayX1ms);
_BUR_PUBLIC unsigned long bgSSMStateNextCycleDelay(struct bgSSM_typ* p, unsigned long stateNext, unsigned long delayCycles);
_BUR_PUBLIC unsigned long bgSSMStateAfterSub(struct bgSSM_typ* p, unsigned long stateAfterSub);
_BUR_PUBLIC unsigned long bgSSMReturnFromSub(struct bgSSM_typ* p);
_BUR_PUBLIC unsigned long bgSSMStateNext(struct bgSSM_typ* p, unsigned long stateNext);
_BUR_PUBLIC plcbit bgSSMIsStateInit(struct bgSSM_typ* p);
_BUR_PUBLIC unsigned long bgSSMPrintLogMessage(struct bgSSM_typ* p);
_BUR_PUBLIC unsigned long bgSSMPrintToTextLogIEC(struct bgSSM_typ* p, plcstring* message);
_BUR_PUBLIC signed long bgSSMPrintLogMessageToLogbook(struct bgSSM_typ* p, unsigned long logIdent);
_BUR_PUBLIC signed long bgSSMPrintToLogbookIEC(struct bgSSM_typ* p, plcstring* message, unsigned long logIdent);
_BUR_PUBLIC unsigned long bgSSMGetState(struct bgSSM_typ* p);
_BUR_PUBLIC plcstring* bgSSMGetStateText(struct bgSSM_typ* p);
_BUR_PUBLIC unsigned long bgFIFOInit(struct bgFIFO_typ* p, unsigned long entrySize, unsigned long entryTotalCount, unsigned long pFIFOmem);
_BUR_PUBLIC unsigned long bgFIFOPush(struct bgFIFO_typ* p, unsigned long pSrc, unsigned long srcSize);
_BUR_PUBLIC unsigned long bgFIFOPull(struct bgFIFO_typ* p, unsigned long pDst, unsigned long dstSize);
_BUR_PUBLIC unsigned long bgFIFOGetCount(struct bgFIFO_typ* p);
_BUR_PUBLIC unsigned long bgFIFOIsFull(struct bgFIFO_typ* p);
_BUR_PUBLIC unsigned long bgTimerOffCyclic(struct TOF* pTOF);
_BUR_PUBLIC unsigned long bgTimerCyclic(struct TON* pTON);
_BUR_PUBLIC unsigned long bgTimerStart(struct TON* pTON, unsigned long timeoutTimeX1ms);
_BUR_PUBLIC unsigned long bgTimerStop(struct TON* pTON);
_BUR_PUBLIC plcbit bgTimerIsEnabled(struct TON* pTON);
_BUR_PUBLIC plcbit bgTimerIsTimeOut(struct TON* pTON);
_BUR_PUBLIC unsigned long bgTimerTimeElapsed(struct TON* pTON);
_BUR_PUBLIC unsigned long bgTimerTimeRemaining(struct TON* pTON);


#ifdef __cplusplus
};
#endif
#endif /* _BGLIBASWBR_ */

