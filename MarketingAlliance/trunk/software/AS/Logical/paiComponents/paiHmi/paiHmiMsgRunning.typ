(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2015
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI object - Running Messages (i.e. content scrolls )*)
(*########################################################################*)

TYPE
	paiHmiMsgRunning_typ : 	STRUCT  (*0-disable; 1-enable*)
		iEnable : BOOL; (*input: address of the alarm array*)
		iScrollMode : UDINT; (*scroll mode*)
		iScrollLength : UDINT; (*scroll length*)
		iScrollDelayXms : UDINT; (*scroll speed*)
		iMsgAddr : UDINT; (*address of the message for scroll*)
		oMsg : STRING[255]; (*output: message ID of the active alarm / message*)
		oMsgVisible : UINT; (*output: visibilty control DP for the VC text message*)
		oMsgFCIdx : UINT; (*output: visibilty control DP for the VC text message*)
		state : UINT; (*Status for common dialog layer*)
		curIdx : UINT; (*Status for common dialog layer*)
		tmr1 : TON; (*Dialog control timer*)
	END_STRUCT;
END_TYPE
