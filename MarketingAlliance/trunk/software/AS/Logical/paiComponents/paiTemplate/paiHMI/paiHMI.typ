(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)

TYPE
	hmiControlLogicEnums_typ : 
		(
		hmiREMMEM_MAGIC := 16#55555555, (*Magic number*)
		hmiSecurityHMIUsersMAXIDX := 11, (*Max number of HMI users - 1*)
		hmiLoggerPVCmpBufSize := 2047, (*Size of the PV compare buffer*)
		HMI_PWD_LEVELS := 5, (*Number of password levels (0-operator;1-supervisor;2-admin;3-maintenance;4-factory)*)
		HMI_PWD_MAXLEN := 15 (*Max pwd len*)
		);
END_TYPE

(*########################################################################*)
(*Application object - Security Manager*)
(*########################################################################*)

TYPE
	hmiSecurityUser_typ : 	STRUCT 
		loginLevel : UDINT; (*0-operator (no HMI access);1-supervisor;2-admin;3-maintenance;4-GAINCO*)
		userPIN : STRING[7];
		userName : STRING[63];
	END_STRUCT;
	hmiSecurityManager_typ : 	STRUCT 
		webSecurityActive : UDINT;
		dbUpdateEvent : UDINT;
		visibleIfUserSecurityActive : UDINT;
		visibleIfUserSecurityNOTActive : UDINT;
		userIsLoggedIn : UDINT;
		loggedInUserIdx : UDINT;
		hmiUserIndex : UDINT;
		hmiUserIndexMax : UDINT;
		hmiPINSelected : UDINT;
		hmiPINCompletion : UDINT;
		hmiLoggedUserName : STRING[63];
		hmiListOfUserPINs : ARRAY[0..hmiSecurityHMIUsersMAXIDX]OF STRING[7];
		hmiListOfUserNames : ARRAY[0..hmiSecurityHMIUsersMAXIDX]OF STRING[63];
		listOfUsers : ARRAY[0..hmiSecurityHMIUsersMAXIDX]OF hmiSecurityUser_typ;
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*Application object - Event Logger Manager*)
(*########################################################################*)

TYPE
	hmiEventLoggerManager_typ : 	STRUCT 
		pvCompareEvent : UDINT; (*Set to 1 when MachineCfg strucutres changes. Allows logger manager to capture changed values and send them to DB.*)
		pvCompareResult : INT;
		pvCompareBuf : STRING[hmiLoggerPVCmpBufSize];
	END_STRUCT;
END_TYPE
