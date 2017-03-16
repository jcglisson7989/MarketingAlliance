/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrPingSvc
 * \file :   wbrPingSvc.c
 * \author : Blanton Radford
 * \date Created: June 22, 2015
 *******************************************************************/

#include <string.h>
// #include <bur/plctypes.h>

// #include  "wbrsprintf.h"
#include  "wbrPingSvc.h"


DINT  wbrPingSvcInit(struct wbrPingService_typ* p)
{
  p->fb.enable=  1;
  // p->fb.pHost=   (UDINT)"192.168.44.220";
  p->fb.pHost=   (UDINT)p->destIPAddr;
  p->fb.timeout= p->timeout;                                                    // If ping not successful within (timeout x 10)ms, error occurs
  
  p->logbookID= arlogBASE_USER_LOG_IDENT;         /// \todo   change to user net log from wbrNetSvc
  
  return  0;
}


static  char* errorTextLookup(UINT erNum, char* erText, UDINT erTextLen)
{
  // TODO: use table(s) in file(s) for holding error text instead of the code below
  
  switch(erNum)
  {
   case 32750:  wbrsnprintf(erText, erTextLen, "No response from station %%s within the specified time"); 
    break;
   case 32751:  wbrsnprintf(erText, erTextLen, "IP address %%s not resolvable"); 
    break;
   case 32752:  wbrsnprintf(erText, erTextLen, "Resource problem in system.  Could not create socket for pinging %%s"); 
    break;
   case 32799:  wbrsnprintf(erText, erTextLen, "System level error when pinging %%s"); 
    break;
   case 0xFFFE: wbrsnprintf(erText, erTextLen, "System ping function not enabled when pinging %%s"); 
    break;
    
   default:     wbrsnprintf(erText, erTextLen, "Something went wrong with error text lookup - erNum in table?"); 
    break;
  }
  
  return erText;
}


// void printErrorText(UINT erNum, char* errorText, args)  //  TODO: with variable args
// {
// }

static  void printErrorText(BOOL prependErNum, UINT erNum, char* message, UDINT msgLen, char* ipAddr)
{
  // char  erText[100]= "",      // Will contain error text with inserted format specifiers for custom arguments
        // erFmtd[100]= "";      // Will contain above text with error number prepended
  char  erText[msgLen],      // Will contain error text with inserted format specifiers for custom arguments - v0.11.0
        erFmtd[msgLen];      // Will contain above text with error number prepended
      
  
  if(prependErNum)
  {
    wbrsnprintf(erFmtd,                                                           // Used in next wbrsnprintf
              sizeof(erFmtd),
              "%d: %s",
              erNum,
              errorTextLookup(erNum, erText, sizeof(erText)));                  // Finds custom error text for error erNum
    
    wbrsnprintf(message,
              msgLen,
              erFmtd,                                                           // From wbrsnprintf above
              ipAddr); 
    return;
  }
  
  // Else do not prepend error number
  wbrsnprintf(message,
            msgLen,
            errorTextLookup(erNum, erText, sizeof(erText)),                     // Finds custom error text for error erNum
            ipAddr); 
  return;
}

/*! \brief Print the number of successes for debugging
    \pre   None
*/
static  char * printMsgSuccess(struct wbrPingService_typ* p)
{
  wbrsnprintf(  p->message                                                    // Print the number of successes for debugging
              , sizeof(p->message)
              , "Station %s pinged successfully %d times"
              , p->destIPPrev
              , p->count
              );
  return  p->message;
}

/*! \brief Print the number of failures for debugging
    \pre   None
*/
static  char * printMsgFailure(struct wbrPingService_typ* p)
{
  wbrsnprintf(  p->message1                                                    // Print the number of failures for debugging
              , sizeof(p->message1)
              , "Station %s ping failed %d times"
              , p->destIPPrev
              , p->count
              );
  return  p->message1;
}


DINT  wbrPingStation(struct wbrPingService_typ* p)
{
  if(!p->enable && !p->count)  return  0xFFFE;
  
  if(!p->enable){
    
    if(p->failed) requestMessageToLogDefault( (UDINT)printMsgFailure(p));
    else          requestMessageToLogDefault( (UDINT)printMsgSuccess(p));
    
    p->count=
        p->failed=
        p->errorStatus= 0;
    
    return  0xFFFE;
  }
  
  bgTimerCyclic(&p->retryTimer);
  
  if(!p->failed && p->retryTimer.IN && !p->retryTimer.Q)  return  0xFFFF;       // Return if success and the timer is running for the next attempt
  
  if(strcmp(p->destIPPrev, p->destIPAddr) )                                                               // new station
  {
    wbrsnprintf(p->message,                                                     // Print the number of failures for debugging
              sizeof(p->message),
              "Station %s is a new station",
              p->destIPAddr
              ); 
    requestMessageToLogDefault( (UDINT)p->message);
    
    if(p->failed) requestMessageToLogDefault( (UDINT)printMsgFailure(p));
    else          requestMessageToLogDefault( (UDINT)printMsgSuccess(p));
    
    p->count=
        p->failed=
        p->errorStatus= 0;
    wbrsnprintf(p->destIPPrev, sizeof(p->destIPPrev), p->destIPAddr);
  }
    
  p->fb.pHost=   (UDINT)p->destIPAddr;
  p->fb.timeout= p->timeout;
  
  IcmpPing(&p->fb);
  
  switch(p->fb.status)
  {
   case 0xFFFF:       //  busy
    // p->errorStatus= 0;
    return  0xFFFF;
    
   case 0:            //  success
    if(p->failed)                                                               // fail state changed from fail to success
    {
      requestMessageToLogDefault( (UDINT)printMsgFailure(p));
      p->count=
          p->failed=
          p->errorStatus= 0;
    }
    
    p->failed=  0;
    p->count++;
    bgTimerStart(&p->retryTimer, p->repeatTime);
    
    printMsgSuccess(p);

    if(!((p->count - 1) % p->successesToCount))
    {
      requestMessageToLogDefault( (UDINT)p->message);
    }
    return  0;

   case 32750:        // Defined error statuses
   case 32751:
   case 32752:
   case 32799:
   case 0xFFFE:
    printErrorText(1, p->fb.status, p->message, sizeof(p->message), p->destIPAddr);
    break;
    
   default:
    wbrsnprintf(p->message,
              sizeof(p->message),
              "%d: Should not get here when pinging IP address %s",
              p->fb.status,
              p->destIPAddr); 
    break;
  }
  
  if(!p->failed || (p->fb.status != p->errorStatus)) // 
  {
    p->errorStatus= p->fb.status;
    requestMessageToLog( (UDINT)p->message
                       , p->logbookID
                       , arlogLEVEL_INFO
                       , 55550
                       , (UDINT)&p->fb.status
                       , (UDINT)sizeof(p->fb.status)
                       );
    p->count= 0;
  }
  
  if(p->count == 1)
  {
    requestMessageToLog( (UDINT)"Current ping error is repeating"
                       , p->logbookID
                       , arlogLEVEL_INFO
                       , 55550
                       , (UDINT)&p->fb.status
                       , (UDINT)sizeof(p->fb.status)
                       );
  }
  
  p->failed=  1;
  p->count++;
  return  p->count;
}


// void  mbTCPdiag()
// {
  // slave.diag.ping.fb.pHost=   (UDINT)slave.diag.ping.destIPAddr;
  // if(slave.diag.ping.enable)   pingPeer(&slave.diag.ping, 512);
// }

DINT  wbrSQL_DT2_ISOFmtdStringFromDT(struct DTStructure * pDT, char * pDst, UDINT dstSize)
{
  return  wbrsnprintf(pDst, dstSize, "%04d-%02d-%02dT%02d:%02d:%02d",
                      pDT->year, pDT->month, pDT->day,
                      pDT->hour, pDT->minute, pDT->second);
}

