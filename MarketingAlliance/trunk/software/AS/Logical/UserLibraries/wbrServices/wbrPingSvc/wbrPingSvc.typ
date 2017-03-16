(*** /*****************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrPingSvc
 * \file :   wbrPingSvc.typ
 * \author : Blanton Radford
 * \date Created: June 22, 2015
 ********************************************************************
 * Data types of library wbrPingSvc
 ****************************************************************/ ****)

TYPE
	wbrPingService_typ : 	STRUCT 
		fb : IcmpPing; (*Ping function block*)
		enable : BOOL; (*optional enable can be used to call function only when desired*)
		timeout : UINT := 100; (*Multiply by 10ms*)
		count : UINT := 0;
		errorStatus : UINT := 0;
		failed : BOOL := FALSE;
		successesToCount : USINT := 4;
		failuresToCount : USINT;
		message1 : STRING[127] := 'No ping tried';
		message : STRING[127] := 'No ping tried';
		logbookID : UDINT; (*Ident of the logbook to log the ping messages to*)
		destIPPrev : STRING[15];
		destIPAddr : STRING[15] := '192.168.44.220';
		repeatTime : UINT := 1000; (*Multiply by 1ms*)
		retryTimer : TON;
	END_STRUCT;
END_TYPE
