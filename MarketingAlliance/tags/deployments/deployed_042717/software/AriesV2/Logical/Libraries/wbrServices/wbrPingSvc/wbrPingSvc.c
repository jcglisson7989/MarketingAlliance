/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrPingSvc
 * \file :   wbrPingSvc.c
 * \author : Blanton Radford
 * \date Created: June 22, 2015
 *******************************************************************/

#include <bur/plctypes.h>

// #include  "wbrsprintf.h"
#include  "wbrPingSvc.h"


DINT  wbrPingSvcInit(struct wbrPingService_typ* p)
{
  p->fb.enable=  1;
  // p->fb.pHost=   (UDINT)"192.168.44.220";
  p->fb.pHost=   (UDINT)p->destIPAddr;
  p->fb.timeout= p->timeout;                                                    // If ping not successful within (timeout x 10)ms, error occurs
  
  return  0;
}


char* errorTextLookup(UINT erNum, char* erText, UDINT erTextLen)
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
    
   default:     wbrsnprintf(erText, erTextLen, "Something went wrong with error text lookup - erNum in table?"); 
    break;
  }
  
  return erText;
}


// void printErrorText(UINT erNum, char* errorText, args)  //  TODO: with variable args
// {
// }

void printErrorText(BOOL prependErNum, UINT erNum, char* message, UDINT msgLen, char* ipAddr)
{
  char  erText[100]= "",      // Will contain error text with inserted format specifiers for custom arguments
        erFmtd[100]= "";      // Will contain above text with error number prepended
      
  
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


DINT  wbrPingStation(struct wbrPingService_typ* p)
{
  if(!p->enable)  return  0xFFFE;
  
  bgTimerCyclic(&p->retryTimer);
  
  if(!p->failed && p->retryTimer.IN && !p->retryTimer.Q)  return  0xFFFF;       // Return if success and the timer is running for the next attempt
  
  p->fb.pHost=   (UDINT)p->destIPAddr;
  p->fb.timeout= p->timeout;
  
  IcmpPing(&p->fb);
  
  switch(p->fb.status)
  {
   case 0xFFFF:
    return  0xFFFF;
    
   case 0:
    if(p->failed)                                                               // fail state changed from fail to success
    {
      wbrsnprintf(p->message1,                                                     // Print the number of failures for debugging
                sizeof(p->message1),
                "Station %s ping failed %d times",
                p->fb.pHost,
                p->count); 
      requestMessageToLog( (UDINT)p->message1, 0, 0, 0, 0, 0);
      p->count=  0;                                                             // reset count  
    }
    
    p->failed=  0;
    p->count++;
    bgTimerStart(&p->retryTimer, p->repeatTime);
    
    wbrsnprintf(p->message,
              sizeof(p->message),
              "Station %s pinged successfully %d times",
              p->fb.pHost,
              p->count); 
    
    if(p->count >= p->successesToCount)
    {
      requestMessageToLog( (UDINT)p->message, 0, 0, 0, 0, 0);
    }
    return  0;

   case 32750:                                                                  // Defined error statuses
   case 32751:
   case 32752:
   case 32799:
    printErrorText(1, p->fb.status, p->message, sizeof(p->message), (char*)p->fb.pHost);
    break;
    
   default:
    wbrsnprintf(p->message,
              sizeof(p->message),
              "%d: Should not get here when pinging IP address %s",
              p->fb.status,
              p->fb.pHost); 
    break;
  }
  
  if(!p->failed || (p->fb.status != p->errorStatus)) // 
  {
    p->errorStatus= p->fb.status;
    requestMessageToLog( (UDINT)p->message, p->logbookID, p->fb.status, 0, 0, 0);
    p->count= 0;
  }
  
  if(p->count == 1)
  {
    requestMessageToLog( (UDINT)"Current ping error is repeating",
                        p->logbookID, 
                        p->fb.status, 
                        55550, 0, 0);
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

