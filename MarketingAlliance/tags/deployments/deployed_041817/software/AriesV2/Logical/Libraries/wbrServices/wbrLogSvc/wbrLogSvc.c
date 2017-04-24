/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrLogSvc
 * \file :   wbrLogSvc.c
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 ******************************************************************* /
 * Implementation of library wbrLogSvc
 ********************************************************************/

#include "wbrLogSvc.h"

linkedList_typ    *   logList;

wbrLogService_typ *   lsvc;


/** Function info
    These functions wrap around multiple instances of AsArLogWrite() in an 
array format to implement a LIFO for handling multiple, rapid requests 
for entries to the same log module.
    requestMessageToLog() should only be called once for each message to be 
inserted. Then, writeMessagesToLog() will continue calling the 
appropriate AsArLogWrite() FB instance until the message is written to 
the log module (i.e. status == 0). It is possible that the message will 
be written to the log on the first call, and so subsequent calls to 
writeMessagesToLog() will not be necessary in every case. The busy bit 
is be used to control whether or not writeMessagesToLog() needs to be 
called.  See 
    The entries are (believed to be) timestamped as the original calls are 
made to insert them. Therefore the order of the function calls to the 
individual FB instances to handle multiple busy statuses is not 
important. 


 \todo : 
- find out why last log entry repeats sometimes rather than printing the entries 
  in their proper order. Possible remedies include: 
  - (ironically) improve the logging for this service for better debgging
  - delete requested node immediately if status == 0
  - declare new entries on the func stack and only add to list (i.e. copy the fb 
    to a list fb) if status == FFFF. Not sure if copying FBs this way will work. 
  I believe this is fixed.  Was caused by stack mem being destroyed.  See
    declaration of variable called 'node' in code below.
**/




/*! \brief For debugging the log list
*   
rettyp            ƒ(x)——————¬  —————————————argument comments———————————————•••™  */
linkedList_typ *  getLogList()
{
  return  logList;
}

/*! \brief  Copies log list to pv struct for debugging/monitoring
            
rettyp  ƒ(x)—————————————¬  ————————————————argument comments———————————————•••™  */
UDINT   getLogServiceData()
{
  // lsvc->list= *(getLogList());
  lsvc->list= *logList;
  
  return  (UDINT)lsvc;
}

/*! \brief    Points lsvc to a declared memory space
              Declaration is in WBRServicesGlobal.var
              Otherwise, service can use heap memory from wbrMemSvc
    \warning  Must call in Init-SP before calling initLogService() or
              getLogServiceData()
    
rettyp  ƒ(x)————————————————————¬  —————————argument comments———————————————•••™  */
UDINT   setLogServiceDataAddress(
            
            wbrLogService_typ * p
          )
{
  lsvc= p;
  
  return  (UDINT)lsvc;
}





/*! \brief    Init the logging service
*   \pre      Init wbrListService
    \warning  call prior to requestMessageToLog()
    
rettyp  ƒ(x)——————————¬  ———————————————————argument comments———————————————•••™  */
DINT    initLogService()
{
  logList=  (linkedList_typ *)listSvcRequestList(sizeof(wbrLogServiceLogListNode_typ),  lsQUEUE);
  lsvc->log.str.list=  (linkedList_typ *)listSvcRequestList(128,  lsQUEUE);
  
  return  0;
}



/** \todo  document * /
rettyp  ƒ(x)——————————————————————————————¬  argument comments——————————————•••™  */
UDINT   wbrLogServicePrintMessageToTextLog()
{
  wbrsnprintf((char *)listSvcRequestListNode(lsvc->log.str.list)
            , 128
            , "%s"
            , lsvc->message
           );

  return  listSvcCharListToStringArray(
                lsvc->log.str.list
              , &lsvc->log.view[0][0]
              , 128
              , 128
              , lsvc->log.str.i.offset
              , lsvc->log.str.i.pageOffset
              , 1
              , ""
             );
}


/*! \brief Get info about a logbook
    \pre   
    
rettyp  ƒ(x)——————————¬  ———————————————————argument comments———————————————•••™  */
DINT    getLogbookInfo(

          wbrLogServiceLogbookInfo_typ * logInfo                     //!< see type for details
        )
//************************************************
{
 static AsArLogGetInfo_typ fb;
 
 
  // logInfo->fb.enable= 1;
  // logInfo->fb.pName=  (UDINT)logInfo->name;
  
  // AsArLogGetInfo(&logInfo->fb);
  
  
  // if(!logInfo->fb.status)
  // {
    // logInfo->ident=     logInfo->fb.ident;
    // logInfo->length=    logInfo->fb.len;
    // logInfo->memType=   logInfo->fb.memType;
    // logInfo->index=     logInfo->fb.actualIndex;
    // logInfo->formatVer= logInfo->fb.FormatVer;
  // }
  
  // logInfo->fb.enable= 0;
  
  // return  logInfo->status=    logInfo->fb.status;
  fb.enable= 1;
  fb.pName=  (UDINT)logInfo->name;
  
  AsArLogGetInfo(&fb);
  
  
  if(!fb.status)
  {
    logInfo->ident=     fb.ident;
    logInfo->length=    fb.len;
    logInfo->memType=   fb.memType;
    logInfo->index=     fb.actualIndex;
    logInfo->formatVer= fb.FormatVer;
  }
  
  fb.enable= 0;
  
  return  logInfo->status=    fb.status;
}


/*! \brief Create a new logbook
    \pre   
    
rettyp  ƒ(x)————————————¬  —————————————————argument comments———————————————•••™  */
DINT    createNewLogbook(

            wbrLogServiceLogbookInfo_typ * logInfo                     //!< see type for details
          )
//************************************************
{
 static AsArLogCreate_typ fb;   //! \todo   allocate fb with MemSvc, e.g. if(!logInfo->fb)  allocmem
 
 
  fb.enable=  1;
  fb.pName=  (UDINT)logInfo->name;
  fb.len=     logInfo->length;
  fb.memType= logInfo->memType= arlogUSRROM;
  
  AsArLogCreate(&fb);
  
  if(!fb.status)
  {
    logInfo->ident=     fb.ident;
    logInfo->status=    fb.status;
    //! \todo   destroy fb
  }
  
  fb.enable= 0;
  
  return  logInfo->status=    fb.status;
}


/*! \brief Request a message to be written to a logbook
    \pre   call initLogService()
    
rettyp  ƒ(x)———————————————¬  ——————————————argument comments———————————————•••™  */
DINT    requestMessageToLog(

            UDINT msgAdr              //!< address that points to the message text, cast as a 32-bit integer
          , UDINT logIdent            //!< identifier of the logbook
          , UDINT logMsgType          //!< 1==info, 2==warn, 3==err, 0==default
          , UDINT erNum               //!< 50000 thru 59999 are reserved for user defined errors
          , UDINT data                //!< address that points to any binary data to include with msg (zero for no data)
          , UDINT dataLen             //!< length of binary data
          )
//************************************************
{
//	return 0;
	if(!logIdent || !logList || !msgAdr){
		return 0;
	}
	
 wbrLogServiceLogListNode_typ *  node=  (wbrLogServiceLogListNode_typ *)listSvcRequestListNode(logList);
 AsArLogWrite_typ *  fb=  &node->fb;    //! \todo   eliminate fb?
 
	/*return;*/
  fb->enable= 1;
  
  if(logMsgType)
  {
    fb->ident=        logIdent;
    fb->logLevel=     logMsgType;
    fb->errornr=      erNum;
    fb->mem=          data;
    fb->len=          dataLen;
  }
  else    // if the message type is not specified, use default ident, logLevel, errornr, and data (default defined in declaration)
  {
    fb->ident=        arlogBASE_USER_LOG_IDENT;
    fb->logLevel=     arlogLEVEL_INFO;
    fb->errornr=      50000;
    fb->mem=          0;
    fb->len=          0;
  }
  
  wbrsnprintf(node->inMsg, 128, "%s", msgAdr);
  fb->asciiString=  (UDINT)(node->inMsg);

  AsArLogWrite(fb);
	
//	fb->status = 0xFFFF;
  
  if(fb->status == 0xFFFF)
  {
    lsvc->busy=  1;
    return  fb->status;
  }
  
  if(fb->status)
  {
    wbrsnprintf(lsvc->message,
                sizeof(lsvc->message),
                "Error number %d occurred when writing to the user log",
                fb->status);
  }
  else  {
  wbrsnprintf(lsvc->message,
              sizeof(lsvc->message),
              "Message logged in one cycle");
  }
  
  lsvc->busy=  logList->numNodes > 10;         //  if more than 10 nodes accumulate, set busy to have writeMessagesToLog() delete them

  getLogServiceData();
  
  wbrLogServicePrintMessageToTextLog();
  return  fb->status;
}   ///¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\™

/*! \brief Request a message to be written to a logbook at level INFO - no data
    \pre   call initLogService()
    
rettyp  ƒ(x)—————————————————————————————¬  argument comments———————————————•••™  */
DINT    requestInfoMsgToLogbookNoData(

            UDINT msgAdr              //!< address that points to the message text, cast as a 32-bit integer
          , UDINT logIdent            //!< identifier of the logbook
          )
{
  return  requestMessageToLog(  msgAdr
                              , logIdent
                              , arlogLEVEL_INFO
                              , 50000                 //!<  \todo   create a library constant for this index value
                              , 0
                              , 0
                              );
}   ///¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\™

/*! \brief  Request a message to be written to a logbook using an input struct
            hopefully might reduce verbosity of app code
    \pre   call initLogService()
    
rettyp  ƒ(x)—————————————————————————————¬  argument comments———————————————•••™  * /
DINT    requestMessageToLogUsingStruct(

            ??_typ * inputStruct              //!< address that points to a struct containing the arguments
          )
{
  return  requestMessageToLog( msgAdr, 0, 0, 0, 0, 0);                          //!<  writes to arlogusr (user logbook) using default settings
}   */

/*! \brief Request a message to be written to a logbook using default settings
    \pre   call initLogService()
    
rettyp  ƒ(x)——————————————————————¬  ———————argument comments———————————————•••™  */
DINT    requestMessageToLogDefault(

            UDINT msgAdr              //!< address that points to the message text, cast as a 32-bit integer
          )

//************************************************
{
  return  requestMessageToLog( msgAdr, 0, 0, 0, 0, 0);                          //!<  writes to arlogusr (user logbook) using default settings
}


/*! \brief Request a message to be written to a logbook using default settings
    \pre   call initLogService()
    
rettyp  ƒ(x)————————————¬  —————————————————argument comments———————————————•••™  */
DINT  writeMessagesToLog()            /// call cyclicly while status is not 0
{
 UDINT  i= logList->numNodes > 100 ? 100 : logList->numNodes;       //  attempt to process all nodes but limit to 100 
 
 wbrLogServiceLogListNode_typ*  node= (wbrLogServiceLogListNode_typ *)listSvcGetHeadData(logList);              //  will assign the address of the data or zero if the list is empty
 AsArLogWrite_typ *  fb=  &node->fb;    //! \todo   eliminate fb?
 
 
  if(logList->numNodes > lsvc->maxNodesUsed)  lsvc->maxNodesUsed= logList->numNodes;

  if(!fb)
  {
    lsvc->busy=  0;
    wbrsnprintf(lsvc->message,
                sizeof(lsvc->message),
                "No messages to write to a log");
    wbrLogServicePrintMessageToTextLog();
    return  -1;
  }
  
  for( ; i>0; i--)
  {
    switch(fb->status)
    {
     case 65535:  break;                                                        // busy
                      
     default:                                                                   // error - fall through to 'done'
      wbrsnprintf(lsvc->message,
                  sizeof(lsvc->message),
                  "Error number %d occurred when writing to the user log",
                  fb->status);
      wbrLogServicePrintMessageToTextLog();
      // break;
                      
     case 0:                                                                    // done
      listSvcDeleteCurrentNode(logList);

      if(!(node= (wbrLogServiceLogListNode_typ *)listSvcGetHeadData(logList)))
      {
        lsvc->busy=  0;
        wbrsnprintf(lsvc->message,
                    sizeof(lsvc->message),
                    "All queued messages written to logs");
        wbrLogServicePrintMessageToTextLog();
        getLogServiceData();
        return  0;
      }
      fb=  &node->fb;
      continue;
    }
    
    AsArLogWrite(fb);                                                           // call again if busy or error
  }

  getLogServiceData();
  return  fb->status;
}

