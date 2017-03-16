(*** /*****************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrLogSvc
 * \file :   wbrLogSvc.typ
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 ********************************************************************
 * Data types of library wbrLogSvc
 ****************************************************************/ ****)

TYPE
	wbrLogServiceTextLog_typ : 	STRUCT 
		view : ARRAY[0..127]OF STRING[127]; (*View window into the log*)
		str : wbrListSvcStringList_typ;
	END_STRUCT;
	wbrLogServiceLogListNode_typ : 	STRUCT 
		fb : AsArLogWrite;
		inMsg : STRING[127];
	END_STRUCT;
	wbrLogService_typ : 	STRUCT 
		list : linkedList_typ;
		message : STRING[127] := 'no message to output';
		log : wbrLogServiceTextLog_typ;
		logLevel : USINT := 4; (*The higher the value, the more messages are logged, i.e. the log will contain more detail and will grow larger more quickly*)
		busy : BOOL;
		maxNodesUsed : UDINT;
	END_STRUCT;
	wbrLogServiceEventLogEventID_typ : 	STRUCT 
		eventID : DINT;
		severity : USINT;
		customer : BOOL;
		reserved : ARRAY[0..1]OF BOOL;
		facility : UINT;
		code : UINT;
	END_STRUCT;
	wbrLogSvcEventLogAccess_typ : 	STRUCT 
		name : STRING[15];
		ident : UDINT;
	END_STRUCT;
	wbrLogSvcEventRecord_typ : 	STRUCT  (*Contains elements of a record*)
		eventID : DINT;
		originID : UDINT;
		objectName : UDINT; (*Pointer to char array, 36 char max + null == 37*)
		timestamp : UDINT; (*Pointer to ArEventLogTimeStampType*)
		addData : UDINT;
		addDataSize : UDINT;
		addDataFormat : USINT;
		verbosity : USINT;
	END_STRUCT;
	wbrLogServiceWriteEvent_typ : 	STRUCT 
		oRecordID : UDINT;
	END_STRUCT;
	wbrLogServiceReadEvent_typ : 	STRUCT 
		iRecordID : UDINT;
		oRecordID : UDINT;
	END_STRUCT;
	wbrLogServiceEventLog_typ : 	STRUCT 
		access : wbrLogSvcEventLogAccess_typ;
		record : wbrLogSvcEventRecord_typ; (*Contains elements of a record*)
		read : wbrLogServiceReadEvent_typ;
		write : wbrLogServiceWriteEvent_typ;
		done : BOOL := 0;
		busy : BOOL := 0;
		error : BOOL := 0;
		status : DINT;
		verbosityFilter : USINT; (*Records with higher verbosity than this setting get ignored.  Use when more logging is needed for debugging.*)
	END_STRUCT;
	wbrLogServiceLogbookInfo_typ : 	STRUCT 
		name : STRING[15];
		length : UDINT := 65536;
		memType : UDINT := 2;
		status : DINT;
		ident : UDINT;
		index : UDINT;
		formatVer : UDINT;
	END_STRUCT;
END_TYPE
