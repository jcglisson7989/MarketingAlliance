(********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Library: wbrLogSvc
 * File: wbrLogSvc.fun
 * Author: Blanton Radford
 * Created: May 07, 2015
 ********************************************************************
 * Functions and function blocks of library wbrLogSvc
 ********************************************************************)

FUNCTION setLogServiceDataAddress : UDINT
	VAR_INPUT
		p : wbrLogService_typ;
	END_VAR
END_FUNCTION

FUNCTION initLogService : DINT
END_FUNCTION

FUNCTION requestMessageToLog : DINT
	VAR_INPUT
		msgAdr : UDINT;
		logIdent : UDINT;
		logMsgType : UDINT;
		erNum : UDINT;
		data : UDINT;
		dataLen : UDINT;
	END_VAR
END_FUNCTION

FUNCTION requestEventToLogDefault : DINT
	VAR_INPUT
		objectName : UDINT;
		logIdent : UDINT;
		evID : DINT;
	END_VAR
END_FUNCTION

FUNCTION requestSuccessEventToLog : DINT
	VAR_INPUT
		objectName : UDINT;
		logIdent : UDINT;
		evFacility : UINT;
		evCode : UINT;
		timestamp : UDINT;
		msg : UDINT;
		msgSize : UDINT;
	END_VAR
END_FUNCTION

FUNCTION requestInfoMsgToLogbookNoData : DINT
	VAR_INPUT
		msgAdr : UDINT;
		logIdent : UDINT;
	END_VAR
END_FUNCTION

FUNCTION requestMessageToLogDefault : DINT
	VAR_INPUT
		msgAdr : UDINT;
	END_VAR
END_FUNCTION

FUNCTION writeMessagesToLog : DINT
END_FUNCTION

FUNCTION decodeEventID : DINT
	VAR_INPUT
		eventID : DINT;
		decodedEventID : wbrLogServiceEventLogEventID_typ;
	END_VAR
END_FUNCTION

FUNCTION getLogbookInfo : DINT
	VAR_INPUT
		logInfo : wbrLogServiceLogbookInfo_typ;
	END_VAR
END_FUNCTION

FUNCTION requestEventToLogUsingObject : DINT
	VAR_INPUT
		el : wbrLogServiceEventLog_typ;
	END_VAR
END_FUNCTION

FUNCTION logSvcGetLastRecordID : UDINT
	VAR_INPUT
		logInfo : wbrLogServiceEventLog_typ;
	END_VAR
END_FUNCTION

FUNCTION logSvcGetLastWriteRecordID : UDINT
	VAR_INPUT
		logInfo : wbrLogServiceEventLog_typ;
	END_VAR
END_FUNCTION

FUNCTION getEventLogInfo : DINT
	VAR_INPUT
		logInfo : wbrLogServiceEventLog_typ;
	END_VAR
END_FUNCTION

FUNCTION getSystemUserLogIdent : UDINT
END_FUNCTION

FUNCTION createNewLogbook : DINT
	VAR_INPUT
		logInfo : wbrLogServiceLogbookInfo_typ;
	END_VAR
END_FUNCTION

FUNCTION createNewEventLogbook : DINT
	VAR_INPUT
		logInfo : wbrLogServiceEventLog_typ;
		size : UDINT;
		info : UDINT;
		persist : USINT;
	END_VAR
END_FUNCTION
