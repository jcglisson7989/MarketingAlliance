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

wbrLogServiceEventLog_typ   sysUserEventLog     //!< Sets up struct data for managing the system user logbook
                          , genericLog
                          ;
wbrLogServiceEventLogEventID_typ  eventID
                                ;

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




/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief \b Utility to decode an EventID
    \pre   
                                                                                
rtyp  ƒ(x)—————————¬
              ———————————————————————————————————argument   comments————————•••™  */

DINT  decodeEventID(
              DINT                                eventID   //! 
            , wbrLogServiceEventLogEventID_typ *  decoded
            )
{
  decoded->code=      (UINT)eventID;
  decoded->facility=  (UINT)(0x0FFF & (eventID >> 16));
  decoded->customer=  (BOOL)(0x0001 & (eventID >> 29));
  decoded->severity= (USINT)(0x0003 & (eventID >> 30));
  
  return 0;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Get last RecordID in logbook
    \pre                            
    
rtyp    ƒ(x)—————————————————¬  ————————————argument comments———————————————•••™  */

UDINT   logSvcGetLastRecordID(

          wbrLogServiceEventLog_typ * logInfo       //!< see type for details
        )
{
 static ArEventLogGetLatestRecordID_typ fb;
 
 
  fb.Ident= logInfo->access.ident;
  fb.Execute= 1;
  ArEventLogGetLatestRecordID(&fb);
  
  logInfo->read.oRecordID=  fb.RecordID;
  
  fb.Execute= 0;
  ArEventLogGetLatestRecordID(&fb);
  
  return logInfo->read.oRecordID;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Get last RecordID output from write
    \pre                                                                        
                                                                                
rtyp    ƒ(x)———————————————————————¬  ——————argument comments———————————————•••™  */

UDINT    logSvcGetLastWriteRecordID(

          wbrLogServiceEventLog_typ * logInfo       //!< see type for details
        )
{
  return logInfo->write.oRecordID= genericLog.write.oRecordID;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Get info about an event logbook                                      
    \pre                                                                        
                                                                                
rtyp    ƒ(x)———————————¬  ——————————————————argument comments———————————————•••™  */

DINT    getEventLogInfo(

          wbrLogServiceEventLog_typ * logInfo       //!< see type for details
        )
{
 static ArEventLogGetIdent_typ fb;   //  Maybe there will be other info in the future, similar to AsArLogGetInfo()?
 
 
  wbrsnprintf(fb.Name, sizeof(fb.Name), logInfo->access.name);
  
  fb.Execute= 1;
  ArEventLogGetIdent(&fb);
  
  logInfo->access.ident=  0;
  if(!(logInfo->error= fb.Error))   logInfo->access.ident= fb.Ident;
  
  logInfo->done=    fb.Done;
  logInfo->status=  fb.StatusID;
  
  fb.Execute= 0;
  ArEventLogGetIdent(&fb);      //  Clear the fb for next use
  
  return  logInfo->status;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief For debugging the log list
*   
rtyp              ƒ(x)——————¬  —————————————argument comments———————————————•••™  */

linkedList_typ *  getLogList()
{
  return  logList;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief  Copies log list to pv struct for debugging/monitoring
            
rtyp    ƒ(x)—————————————¬  ————————————————argument comments———————————————•••™  */

UDINT   getLogServiceData()
{
  // lsvc->list= *(getLogList());
  lsvc->list= *logList;
  
  return  (UDINT)lsvc;
}

/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief  Copies log list to pv struct for debugging/monitoring
            
rtyp    ƒ(x)—————————————¬  ————————————————argument comments———————————————•••™  */

UDINT   getSystemUserLogIdent()
{
  return  sysUserEventLog.access.ident;
}

/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief    Points lsvc to a declared memory space
              Declaration is in WBRServicesGlobal.var
              Otherwise, service can use heap memory from wbrMemSvc
    \warning  Must call in Init-SP before calling initLogService() or
              getLogServiceData()
    
rtyp    ƒ(x)————————————————————¬  —————————argument comments———————————————•••™  */

UDINT   setLogServiceDataAddress(
            
            wbrLogService_typ * p
          )
{
  lsvc= p;
  
  return  (UDINT)lsvc;
}

/*————————————————————————————————————————————————————————————————————————————*/





/*! \brief    Init the logging service
*   \pre      Init wbrListService
    \warning  call prior to requestMessageToLog()
    
rtyp    ƒ(x)——————————¬  ———————————————————argument comments———————————————•••™  */

DINT    initLogService()
{
  lsvc->log.str.sLength=    128;
  lsvc->log.str.elements=   128;
  lsvc->log.str.i.maxNodes= 200;
  
  logList=  (linkedList_typ *)listSvcRequestList(sizeof(wbrLogServiceLogListNode_typ),  lsQUEUE);
  // logList=  (linkedList_typ *)listSvcRequestList(sizeof(wbrLogServiceEventListNode_typ),  lsQUEUE);
  lsvc->log.str.list=  (linkedList_typ *)listSvcRequestList(lsvc->log.str.sLength,  lsQUEUE);
  
  
  wbrsnprintf(  sysUserEventLog.access.name
              , sizeof(sysUserEventLog.access.name)
              , "$arlogusr"                              //  System user logbook
              );
  getEventLogInfo(&sysUserEventLog);

  
  return  0;
}



/** \todo  document * /
rtyp    ƒ(x)——————————————————————————————¬  argument comments——————————————•••™  */

UDINT   wbrLogServicePrintMessageToTextLog()
{
  return  wbrsnprintf((char *)listSvcRequestListNode(lsvc->log.str.list)
                    , lsvc->log.str.sLength
                    , "%s"
                    , lsvc->message
                   );

}

/** \todo  document * /
rtyp    ƒ(x)——————————————————————¬  argument comments——————————————————————•••™  */

UDINT   wbrLogServiceUpdateTextLog()
{
  return  listSvcCharListToStringArray(
                lsvc->log.str.list
              , &lsvc->log.view[0][0]
              , lsvc->log.str.sLength
              , lsvc->log.str.elements > 128 ? 128 : lsvc->log.str.elements
              , lsvc->log.str.i.offset
              , lsvc->log.str.i.pageOffset
              , lsvc->log.str.i.maxNodes
              , 1
              , ""
             );
}


/*! \brief Get info about a logbook
    \pre   
    
rtyp    ƒ(x)——————————¬  ———————————————————argument comments———————————————•••™  */

DINT    getLogbookInfo(

          wbrLogServiceLogbookInfo_typ * logInfo                     //!< see type for details
        )
{
 static AsArLogGetInfo_typ fb;
 
 
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
    
rtyp  ƒ(x)————————————¬  —————————————————argument comments———————————————•••™  */

DINT    createNewLogbook(

            wbrLogServiceLogbookInfo_typ * logInfo                     //!< see type for details
          )
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
    
rtyp  ƒ(x)———————————————¬  ——————————————argument comments———————————————•••™  */

DINT    requestMessageToLog(

            UDINT msgAdr              //!< address that points to the message text, cast as a 32-bit integer
          , UDINT logIdent            //!< identifier of the logbook
          , UDINT logMsgType          //!< 1==info, 2==warn, 3==err, 0==default
          , UDINT erNum               //!< 50000 thru 59999 are reserved for user defined errors
          , UDINT data                //!< address that points to any binary data to include with msg (zero for no data)
          , UDINT dataLen             //!< length of binary data
          )
{
 wbrLogServiceLogListNode_typ *  node=  (wbrLogServiceLogListNode_typ *)listSvcRequestListNode(logList);
 AsArLogWrite_typ *  fb=  node == 0 ? 0 : &node->fb;    //! \todo   eliminate fb?
 
 
  if(node == 0)   {
    wbrsnprintf(lsvc->message
              , sizeof(lsvc->message)
              , "Memory was not allocated"
              );
    return  -1;     //  memory was not allocated
  }
  
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
    fb->logLevel=     arEVENTLOG_SEVERITY_INFO;   //  arlogLEVEL_INFO;
    fb->errornr=      50000;
    fb->mem=          0;
    fb->len=          0;
  }
  
  wbrsnprintf(node->inMsg, 128, "%s", msgAdr);
  fb->asciiString=  (UDINT)(node->inMsg);

  // AsArLogWrite(&node->fb);
  AsArLogWrite(fb);
  
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
  wbrLogServiceUpdateTextLog();
  return  fb->status;
}   ///¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\™
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief    Request an event to be written to a logbook
    \pre      call initLogService()
    \warning  ArEventLogWrite fb is defined as synchronous, but requested event 
              will fail to be added to the log if fb is on the stack (thus 
              using static heap memory)
    
rtyp  ƒ(x)———————————————¬  ——————————————argument comments———————————————•••™  */

DINT    requestEventToLog(

            UDINT   objectName        //!< Pointer to name of calling object
          , UDINT   logIdent          //!< identifier of the logbook
          , USINT   evSeverity        //!< 0==success, 1==info (default), 2==warn, 3==err, 
          ,  UINT   evFacility        //!< range 0 - 0xF (the rest are reserved)
          ,  UINT   evCode            //!< range 0 - 0xFFFF (all)
          ,  DINT   evID              //!< use this if logging a returned ID, e.g. a fb status, etc.
          , UDINT   originID          //!< RecordID of a linked record, e.g. for a multi-entry message/event
          , UDINT   timestamp         //!< application can supply a pointer to a timestamp, use 0 for generated timestamp
          , UDINT   data              //!< address that points to data to be included with event (zero for no data)
          , UDINT   dataSize          //!< length of binary data
          , USINT   dataFormat        //!< 0==binary, 1==null-term text strings, 2==encoded, 100-150 customer(??)
          )
{
 static ArEventLogWrite_typ fb;
 
 
  if(!evID && evCode)
    evID= ArEventLogMakeEventID(evSeverity, evFacility, evCode);
  
  // evID|=  0x20000000;     //  Make sure customer bit is set
  
  wbrsnprintf(fb.ObjectID, 37, (char *)objectName);
  fb.Ident=          logIdent;
  fb.EventID=        evID;
  fb.OriginRecordID= originID;
  fb.TimeStamp=      timestamp;
  fb.AddData=        data;
  fb.AddDataSize=    dataSize;
  fb.AddDataFormat=  dataFormat;

  fb.Execute= 1;
  ArEventLogWrite(&fb);
  
  if(fb.Error)
  {
    wbrsnprintf(lsvc->message,
                sizeof(lsvc->message),
                "Error number %d occurred when writing to the user log",
                fb.StatusID);
  genericLog.write.oRecordID= 0;
  }
  else  {
  wbrsnprintf(lsvc->message,
              sizeof(lsvc->message),
              "Event logged in one cycle");
  genericLog.write.oRecordID= fb.RecordID;
  }
  
  fb.Execute= 0;
  ArEventLogWrite(&fb);      //  Clear the fb for next use
  
  return  fb.StatusID;
}   ///¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\™
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Request a message to be written to a logbook at level INFO - no data
    \pre   call initLogService()
    
rtyp  ƒ(x)—————————————————————————————¬  argument comments———————————————•••™  */

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
}   ///¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\___/¯¯¯\™ */

/*! \brief  Request a message to be written to a logbook using an input struct
            hopefully might reduce verbosity of app code
    \pre   call initLogService()
    
rtyp  ƒ(x)—————————————————————————————¬  argument comments———————————————•••™  * /

DINT    requestMessageToLogUsingStruct(

            ??_typ * inputStruct              //!< address that points to a struct containing the arguments
          )
{
  return  requestMessageToLog( msgAdr, 0, 0, 0, 0, 0);                          //!<  writes to arlogusr (user logbook) using default settings
}   */

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Request a message to be written to a logbook using default settings
    \pre   call initLogService()
    
rtyp  ƒ(x)——————————————————————¬  ———————argument comments———————————————•••™  */

DINT  requestMessageToLogDefault(

            UDINT msgAdr              //!< address that points to the message text, cast as a 32-bit integer
          )
{
  return  requestMessageToLog( msgAdr, 0, 0, 0, 0, 0);                          //!<  writes to arlogusr (user logbook) using default settings
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Request an event to be written to a logbook using default settings
    \pre                                                                        
                                                                                
rtyp  ƒ(x)————————————————————¬  —————————argument comments———————————————•••™  */

DINT  requestEventToLogDefault(

            UDINT   objectName        //!< name of calling object
          , UDINT   logIdent          //!< identifier of the logbook
          ,  DINT   evID              //!< use this if logging a returned ID, e.g. a fb status, etc.
          )
{
  return  requestEventToLog( objectName, logIdent, 1,0,0, evID, 0,0,0,0,0);                          //!<  writes to arlogusr (user logbook) using default settings
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Request an event success to be written to a logbook
    \pre                                                                        
                                                                                
rtyp  ƒ(x)————————————————————¬  ——————————argument comments———————————————•••™  */

DINT  requestSuccessEventToLog(

            UDINT   objectName        //!< name of calling object
          , UDINT   logIdent          //!< identifier of the logbook
          ,  UINT   evFacility        //!< range 0 - 0xF (the rest are reserved)
          ,  UINT   evCode            //!< range 0 - 0xFFFF (all)
          , UDINT   timestamp         //!< application can supply a pointer to a timestamp, use 0 for generated timestamp
          , UDINT   msg               //!< address (cast as UDINT) that points to message to be included with success event (zero for no data)
          , UDINT   msgSize           //!< length of binary data
          )

/* Implementation */
{
  // return  requestEventToLog( objectName, logIdent, 0,0,0, evID, 0,0,0,0,0);                          //!<  writes to arlogusr (user logbook) using default settings
  return  requestEventToLog(  objectName
                            , logIdent
                            , arEVENTLOG_SEVERITY_SUCCESS 
                            , evFacility
                            , evCode
                            , 0
                            , 0
                            , timestamp
                            , msg
                            , msgSize
                            , arEVENTLOG_ADDFORMAT_TEXT
                            );
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Request an event to be written to a logbook using default settings
    \pre                                                                        
                                                                                
rtyp    ƒ(x)——————————————————————¬  ———————argument comments———————————————•••™  */

DINT    requestEventToLogUsingObject(

            wbrLogServiceEventLog_typ * el        //!< an event log object
          )
{
  return  requestEventToLog(  el->record.objectName
                            , el->access.ident
                            , 0, 0, 0
                            , el->record.eventID
                            , el->record.originID
                            , el->record.timestamp
                            , el->record.addData
                            , el->record.addDataSize
                            , el->record.addDataFormat
                            );
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Print the name of the memory type used for logbook storage
    \pre   
    
rtyp  ƒ(x)——————————————————————————¬  ———argument comments———————————————•••™  */

static const char *  printMemoryTypeFromPersistence(

            USINT                       persist       //!< 0==Volatile, 1==USRRAM, 2==USRROM.  Use ArEventLog constants in code.
          )
//************************************************
{
  switch(persist)
  {
   case arEVENTLOG_PERSISTENCE_VOLATILE:
    return  "DRAM";
   case arEVENTLOG_PERSISTENCE_REMANENT:
    return  "USRRAM";
   case arEVENTLOG_PERSISTENCE_PERSIST:
    return  "USRROM";
  }
  
  return  "Ooops! Persistence apparently not in range";
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Create a new event logbook
    \pre   
    
rtyp  ƒ(x)—————————————————¬  ————————————argument comments———————————————•••™  */

DINT    createNewEventLogbook(

            wbrLogServiceEventLog_typ * logInfo   //!< event log object
          , UDINT                       size      //!< see type for details
          , UDINT                       info      //!< FUTURE, always zero until implemented
          , USINT                       persist   //!< 0==Volatile, 1==USRRAM, 2==USRROM.  Use ArEventLog constants in code.
          )
{
 #define  cNEL_BUF_LEN  128
 static ArEventLogCreate_typ fb;   //! \todo   allocate fb with MemSvc, e.g. if(!logInfo->fb)  allocmem
 static char    
                errfmt[cNEL_BUF_LEN - 48]=  "Error %d from facility %d (code %d) when creating event logbook %s."
          ,     fmt[cNEL_BUF_LEN - 48]=     "Event logbook %s of size 0x%X created in %s."
          ,     msg[cNEL_BUF_LEN]=          ""
          ,     len
          ;
 
 
  if(!logInfo->busy)   {
    logInfo->done=  logInfo->error=  0;
    wbrsnprintf(fb.Name, sizeof(fb.Name), logInfo->access.name);
    fb.Size=        size;
    fb.Persistence= persist;   //  = arlogUSRROM;    arEVENTLOG_PERSISTENCE_PERSIST
    fb.Info=        0;    //  FUTURE  info;
    fb.Execute= 1;
  }
  
  ArEventLogCreate(&fb);
  
  if((logInfo->busy= fb.Busy))      return  logInfo->status;
  if(!(logInfo->error= fb.Error))   logInfo->access.ident= fb.Ident;
  
  logInfo->done=    fb.Done;
  logInfo->status=  fb.StatusID;
  
    fb.Execute= 0;
    ArEventLogCreate(&fb);      //  Clear the fb for next use
  
  //  write success event to log    return  requestCreateSuccessEventToLogUsingObject(logInfo);
  if(!logInfo->error){
    len=  wbrsnprintf(msg
                    , cNEL_BUF_LEN
                    , fmt
                    , logInfo->access.name
                    , size
                    , printMemoryTypeFromPersistence(persist)
                    );
    memset(msg + len + 1, 0, cNEL_BUF_LEN - len - 1);   //  buffer must be flushed
    return  requestEventToLog(  (UDINT)"wbrLogSvc->createNewEventLogbook()"
                              , logInfo->access.ident
                              , 0, 0, 50000
                              , 0
                              , 0
                              , 0
                              , (UDINT)msg
                              , cNEL_BUF_LEN
                              , arEVENTLOG_ADDFORMAT_TEXT
                              );
  }
  
  decodeEventID(logInfo->status, &eventID);
  len=  wbrsnprintf(msg
                  , cNEL_BUF_LEN
                  , errfmt
                  , eventID.code
                  , eventID.facility
                  , logInfo->status
                  , logInfo->access.name
                  );
  memset(msg + len + 1, 0, cNEL_BUF_LEN - len - 1);
  requestEventToLog(  (UDINT)"wbrLogSvc->createNewEventLogbook()"
                    , sysUserEventLog.access.ident
                    , arEVENTLOG_SEVERITY_ERROR 
                    , 0
                    , 50000
                    , 0
                    , 0
                    , 0
                    , (UDINT)msg
                    , cNEL_BUF_LEN
                    , arEVENTLOG_ADDFORMAT_TEXT
                    );
  return  logInfo->status;
}
/*————————————————————————————————————————————————————————————————————————————*/

/* ****************************************************************************/
/*! \brief Request a message to be written to a logbook using default settings
    \pre   call initLogService()                                                
                                                                                
rtyp  ƒ(x)——————————————¬  —————————————————argument comments———————————————•••™  */

DINT  writeMessagesToLog()            /// call cyclicly while status is not 0

{
 UDINT  i= logList->numNodes > 100 ? 100 : logList->numNodes;       //  attempt to process all nodes but limit to 100 
 
 wbrLogServiceLogListNode_typ*  node= (wbrLogServiceLogListNode_typ *)listSvcGetHeadData(logList);              //  will assign the address of the data or zero if the list is empty
 // AsArLogWrite_typ *  fb=  &node->fb;    // ! \todo   eliminate fb?
 AsArLogWrite_typ *  fb=  node == 0 ? 0 : &node->fb;    //! \todo   eliminate fb?
 
 
  if(!node)
  {
    lsvc->busy=  0;
    wbrsnprintf(lsvc->message,
                sizeof(lsvc->message),
                "No messages to write to a log");
    wbrLogServicePrintMessageToTextLog();
    wbrLogServiceUpdateTextLog();
    getLogServiceData();
    return  -1;
  }
  
  if(logList->numNodes > lsvc->maxNodesUsed)  lsvc->maxNodesUsed= logList->numNodes;

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
      if(listSvcDeleteCurrentNode(logList)) {
        wbrsnprintf(lsvc->message,
                    sizeof(lsvc->message),
                    "Error when freeing node memory");
        wbrLogServicePrintMessageToTextLog();
      }

      if(!(node= (wbrLogServiceLogListNode_typ *)listSvcGetHeadData(logList)))
      {
        lsvc->busy=  0;
        wbrsnprintf(lsvc->message,
                    sizeof(lsvc->message),
                    "All queued messages written to logs");
        wbrLogServicePrintMessageToTextLog();
        wbrLogServiceUpdateTextLog();
        getLogServiceData();
        return  0;
      }
      fb=  &node->fb;
      continue;
    }
    
    AsArLogWrite(fb);                                                           // call again if busy or error
  }

  wbrLogServiceUpdateTextLog();
  getLogServiceData();
  return  fb->status;
}
/*————————————————————————————————————————————————————————————————————————————*/

