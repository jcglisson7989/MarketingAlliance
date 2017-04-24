(********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI object - Scrolling Messages (i.e. alarms)*)
(*########################################################################*)

TYPE
	hmiMsgScrolling_typ : 	STRUCT 
		iAdrAlarmArray : UDINT; (*input: address of the alarm array*)
		iAlarmArrayLen : UDINT; (*input: number of alarms in the alarm array*)
		iMsgTimeXms : UDINT; (*input: duration of the message display (if more than one message/alarm active)*)
		oMsgID : UINT; (*output: message ID of the active alarm / message*)
		oMsgVisible : UINT; (*output: visibilty control DP for the VC text message*)
		state : UINT; (*Status for common dialog layer*)
		tmr1 : TON; (*Dialog control timer*)
	END_STRUCT;
END_TYPE
