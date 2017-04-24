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
	wbrLogServiceLogbookInfo_typ : 	STRUCT 
		name : STRING[15];
		length : UDINT := 65535;
		memType : UDINT := 2;
		status : UINT;
		ident : UDINT;
		index : UDINT;
		formatVer : UDINT;
		fb : REFERENCE TO AsArLogGetInfo;
	END_STRUCT;
END_TYPE
