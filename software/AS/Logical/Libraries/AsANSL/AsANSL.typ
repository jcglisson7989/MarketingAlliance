(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsANSL
 * File: AsANSL.typ
 * Author: B+R
 ********************************************************************
 * Data types of library AsANSL
 ********************************************************************)
                                                                      
TYPE
	AsANSLTimeStampType : STRUCT		(*timestamp structure*)
		timeStampSec	: UDINT;		(*seconds since 01.01.1970*)
		timeStampNsec	: UDINT;		(*nanoseconds*)
	END_STRUCT;

	AsANSLClientDiagInfoType : STRUCT					(*client diagnose structure*)
		clientDataObjName	: STRING[256];				(*name of the data object*)
		clientTimeStamp 	: AsANSLTimeStampType;		(*timestamp of last update*)
		clientConn			: UDINT;					(*number of the connections*)
		clientConnErr		: UDINT;					(*number of the connections with error*)
	END_STRUCT;
	
	AsANSLClientDiagConnInfoType : STRUCT				(*connection diagnose structure*)
		connName			: STRING[64];				(*name of the connection*)
		connTargetAddr		: STRING[64];				(*address/hostname of the target*)
		connTimeStamp 		: AsANSLTimeStampType;		(*timestamp of last update*)
		connStatus			: UDINT;					(*state of the connection*)
		connError			: UDINT;					(*error of the connection*)
		connPvRead			: UDINT;					(*number of read pv*)
		connPvReadErr		: UDINT;					(*number of read pv with error*)
		connPvWrite			: UDINT;					(*number of write pv*)
		connPvWriteErr		: UDINT;					(*number of write pv with error*)
		connNumReadJobs		: UDINT;					(*read jobs since last initialization*)
		connNumSendJobs		: UDINT;					(*send jobs since last initialization*)
		connNumErr			: UDINT;					(*number of connection error since last initialization*)
	END_STRUCT;

	AsANSLClientDiagPvInfoType : STRUCT					(*pv connection diagnose structure*)
		pvNameLocal			: STRING[512];				(*name of the local pv*)
		pvNameRemote		: STRING[512];				(*name of the remote pv*)
		pvTimeStamp 		: AsANSLTimeStampType;		(*timestamp of last update*)
		pvStatus			: UDINT;					(*state of the pv connection*)
		pvError				: UDINT;					(*error of the pv connection*)
		pvDirection			: UDINT;					(*direction of pv - read/write*)
	END_STRUCT;
END_TYPE
