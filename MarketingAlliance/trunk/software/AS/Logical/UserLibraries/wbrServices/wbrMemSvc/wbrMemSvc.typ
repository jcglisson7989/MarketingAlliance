(*** /*****************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrMemSvc
 * \file :   wbrMemSvc.typ
 * \author : Blanton Radford
 * \date Created: April 14, 2016
 ********************************************************************
 * Data types of library wbrMemSvc
 ****************************************************************/ ****)

TYPE
	wbrMemSvcFBStatus_typ : 	STRUCT 
		isError : BOOL;
		status : UDINT; (*Size of the largest available heap memory bock*)
	END_STRUCT;
	wbrMemSvcStatus_typ : 	STRUCT 
		memInitValid : BOOL;
		blockFree : UDINT; (*Size of the largest available heap memory bock*)
		alloc : wbrMemSvcFBStatus_typ;
		free : wbrMemSvcFBStatus_typ;
	END_STRUCT;
	wbrMemSvcStoredConfig_typ : 	STRUCT 
		memRequestSize : UDINT; (*Size of the heap memory partition to be requested during initialization*)
	END_STRUCT;
	wbrMemService_typ : {REDUND_UNREPLICABLE} 	STRUCT 
		status : {REDUND_UNREPLICABLE} wbrMemSvcStatus_typ;
		config : REFERENCE TO wbrMemSvcStoredConfig_typ;
	END_STRUCT;
END_TYPE
