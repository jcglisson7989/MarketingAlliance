/********************************************************************
 * COPYRIGHT -- belgor
 ********************************************************************
 * Library: bglibas
 * File: bglibas.c
 * Author: admin
 * Created: March 07, 2012
 ********************************************************************
 * Implementation of library bglibas
 ********************************************************************/

#ifdef __cplusplus
  extern "C"
  {
#endif

#include <string.h>
// #include <stdarg.h>

#include  "bglibasWBR.h"                                                        //  WBR: could also keep the bglibas.h name and change the library's Properties->Library setting away from using the default name
#include  "bglibasWBR_C.h"

/* Init state machine. MUST be called once, before any other bgSSM function call. */
unsigned long bgSSMInit(struct bgSSM_typ* p, unsigned long pFunGetStateName, unsigned long pFunCyclicCallback)
{
  memset(p, 0, sizeof(struct bgSSM_typ));
  
  p->pfunGetStateName = (UDINT)pFunGetStateName;
  p->pfunCyclicCallback = (UDINT)pFunCyclicCallback;
  p->stateInit = 1;
  return(0);
}

/** Function pointer Init state machine. MUST be called once, before any other bgSSM function call. */
unsigned long bgSSMInitWbr(struct bgSSM_typ* p,                                    //  Pointer to state machine members and methods
                           unsigned long pfunInitState,                            //  Mandatory - initial method must be assigned
                           unsigned long pfunInterrupt,                            //  Optional
                           unsigned long pFunCyclicCallback)                       //  Optional
{
  memset(p, 0, sizeof(struct bgSSM_typ));
  
  p->pfunInitState=       (UDINT)pfunInitState;
  p->pfunInterrupt=       (UDINT)pfunInterrupt;
  p->pfunCyclicCallback=  (UDINT)pFunCyclicCallback;
  
  p->log.str.i.maxNodes=  200;
  p->log.str.list=  (linkedList_typ *)listSvcRequestList(BGSSM_MESSAGE_LENGTH_C,  lsQUEUE);
  
  p->stateNext= p->pfunInitState;                                                   //  WBR: assign init state function
  
  return(0);
}

/** State machine (SM) cyclic operation. */
unsigned long bgSSMCyclic(struct bgSSM_typ* p)
{
  int ii;
  
  //  TODO: implement interrupt/pause here to pause the delays with the SM
  
  //operate all timers
  for(ii=0; ii<BGSSM_TIMER_COUNT;ii++){
    bgTimerCyclic(&p->timer_x1ms[ii]);
  }
  bgTimerCyclic(&p->dlytimer_x1ms);
  bgTimerCyclic(&p->wdogTimer_x1ms);        //! \todo   log watchdog timeout \
                                                        provide automatic error state and go there? \
                                                        test func bgSSMStateNextWithWatchdog() 
  
  //operate dlyCycle counter
  if(p->dlyCycles){
    p->dlyCycles--;
  }
  
  //call cyclic callback function if defined
  if(p->pfunCyclicCallback){
    void(*callback)(bgSSM_typ*) = ( void (*) (bgSSM_typ*) ) p->pfunCyclicCallback;
    (*callback)(p);
  }
  
  //clear single cycle flag every scan
  p->stateInit = 0;
  
  /// Evaluate breakpoint feature
  if(p->scanLimit.breakpoint && !p->scanLimit.active)   p->scanLimit.active=  1;          //  breakpoint has been found
  if(p->scanLimit.breakpointPrev && !p->scanLimit.breakpoint)   p->scanLimit.active=  0;  //  breakpoint switched off by 
  
  /// Evaluate limit scan feature
  if(p->scanLimit.triggerNextScan)
  {
    p->scanLimit.triggerNextScan= p->scanLimit.count= 0;
  }
  if(!p->scanLimit.active)          memset(&p->scanLimit, 0, sizeof(p->scanLimit));
  else
  {
    if(p->scanLimit.count >= p->scanLimit.limit)   return 1;
    p->scanLimit.count++;
  }
  
  //check if state change requested
  if(p->state != p->stateNext){
    
    //if state change w. delay > wait for delay timer to expire or dlyCycles == 0
    if(!bgTimerIsTimeOut(&p->dlytimer_x1ms) || p->dlyCycles){                   //  TODO: add delay until event?
      return 1;
    }
    
    p->state = p->stateNext;
    //generate stateInit single scan flag
    p->stateInit = 1;
    
    //define state name if external function for state names is defined
    if( p->pfunGetStateName ){
      char*(*getStateName)(UDINT) = ( char* (*) (UDINT) )p->pfunGetStateName;
      strcpy(p->stateText, (*getStateName)(p->state));
    }else{
      strcpy(p->stateText, "???");    
    }   
  }

  if(p->pfunInitState)                                                          //  if the init state function pointer is defined...
  {
    void(*callState)(bgSSM_typ*) = ( void (*) (bgSSM_typ*) ) p->state;          //  ... call the function for the current state, i.e. use function pointer SM - WBR:
    (*callState)(p);
  }
  return(0);
}

/** SM state change methods 
=============================*/

/** Change to next state. */
unsigned long bgSSMStateNext(struct bgSSM_typ* p, unsigned long stateNext)
{
  p->stateNext = stateNext; 
  return(p->stateNext);
}

/** Store state to go to after SM subroutine. */
unsigned long bgSSMStateAfterSub(struct bgSSM_typ* p, unsigned long stateAfterSub)
{
  if(p->stateAfterSubIndex >= BGSSM_SUBROUTINE_COUNT)   return -99;     //  TODO: handle this error
  
  p->stateAfterSub[p->stateAfterSubIndex] = stateAfterSub; 
  return(p->stateAfterSub[p->stateAfterSubIndex++]);
}

/** Activate state to go to after SM subroutine. */
unsigned long bgSSMReturnFromSub(struct bgSSM_typ* p)
{
  if(p->stateAfterSubIndex >= BGSSM_SUBROUTINE_COUNT)   return -99;     //  TODO: handle this error
  
  p->stateNext=    p->stateAfterSub[p->stateAfterSubIndex--]; 
  return(p->stateNext);
}

/** Change to next state w. timer delay. */
unsigned long bgSSMStateNextWithWatchdog(struct bgSSM_typ* p, unsigned long stateNext, unsigned long wdogTimeX1ms)
{
  p->stateNext = stateNext;
  bgTimerStart(&p->wdogTimer_x1ms, wdogTimeX1ms);
  return(p->stateNext);
}

/** Change to next state w. timer delay. */
unsigned long bgSSMStateNextTimeDelay(struct bgSSM_typ* p, unsigned long stateNext, unsigned long delayTimeX1ms)
{
  p->stateNext = stateNext;
  bgTimerStart(&p->dlytimer_x1ms, delayTimeX1ms);
  return(p->stateNext);
}

/** Change to next state w. cycles delay. */
unsigned long bgSSMStateNextCycleDelay(struct bgSSM_typ* p, unsigned long stateNext, unsigned long delayCycles)
{
  p->stateNext = stateNext;
  p->dlyCycles = delayCycles;
  return(p->stateNext);
}

/** Check if first scan for the state. */
plcbit bgSSMIsStateInit(struct bgSSM_typ* p)
{
  return(p->stateInit);
}


/** \todo  document */
UDINT  bgSSMPrintToTextLog(struct bgSSM_typ* p, const char* format, ...)
{
 va_list ap;

  va_start(ap, format);
  wbrvsnprintf((char *)listSvcRequestListNode(p->log.str.list), BGSSM_MESSAGE_LENGTH_C, format, ap);
  va_end(ap);

  return  listSvcCharListToStringArray(
                  p->log.str.list
                , &p->log.view[0][0]
                , BGSSM_MESSAGE_LENGTH_C
                , BGSSM_LOG_ENTRIES
                , p->log.str.i.offset
                , p->log.str.i.pageOffset
                , p->log.str.i.maxNodes
                , 1
                , ""
               );
}

/** \todo  document */
UDINT  bgSSMPrintLogMessage(struct bgSSM_typ* p)
{
  return  bgSSMPrintToTextLog(p, "%s", p->msg.log);
}

/** \todo  document */
UDINT  bgSSMPrintToTextLogIEC(struct bgSSM_typ* p, char* message)
{
  return  bgSSMPrintToTextLog(p, "%s", message);
}


/** \todo  document */
DINT  bgSSMPrintToLogbook(struct bgSSM_typ* p, const char* text, UDINT logIdent)
{
  return  requestMessageToLog( (UDINT)text, logIdent, 0, 0, 0, 0);              //  logIdent currently not used if logMsgType param is zero
}

/** \todo  document */
DINT  bgSSMPrintLogMessageToLogbook(struct bgSSM_typ* p, UDINT logIdent)    //! \todo   strcpy(loggermsg, requestedmsg) since msg gets destroyed, at least in ARsim
{
  return  requestMessageToLog( (UDINT)p->msg.log, logIdent, 0, 0, 0, 0);           //  logIdent currently not used if logMsgType param is zero
}

/** \todo  document */
DINT  bgSSMPrintToLogbookIEC(struct bgSSM_typ* p, char* message, UDINT logIdent)    //! \todo   strcpy(loggermsg, requestedmsg) since msg gets destroyed, at least in ARsim
{
  return  requestMessageToLog( (UDINT)message, logIdent, 0, 0, 0, 0);           //  logIdent currently not used if logMsgType param is zero
}

/** Check if first scan for the state.  If yes, perform some standard state change functions */
BOOL bgSSMIsStateInitWBR( struct bgSSM_typ* p                    //!  \todo   move this to C header
                        , /* const */ char* stateText            //!< This can take __FUNCTION__ or "text"
                        )
{
  if(p->stateInit)
  {
    if(stateText)  strcpy(p->stateText, stateText);
    wbrsnprintf(p->msg.log, sizeof(p->msg.log), "%s(%d)", bgSSMGetStateText(p), bgSSMGetState(p));      //! \todone? reserve p->message for other messages?
    bgSSMPrintToTextLog(p, "%s", p->msg.log);
    bgSSMPrintToLogbook(p, p->msg.log, 1);
  }
  
  return(p->stateInit);
}

/** SM data retrieval methods 
=============================*/

/** Get current state */
unsigned long bgSSMGetState(struct bgSSM_typ* p)
{
  return(p->state);
}

/** Get current state text*/
plcstring* bgSSMGetStateText(struct bgSSM_typ* p)
{
  return(&p->stateText[0]);
}


#ifdef __cplusplus
  };
#endif

