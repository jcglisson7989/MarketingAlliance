(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: paiPingService
 * File: paiPingService.typ
 * Author: goran
 * Created: August 17, 2015
 ********************************************************************
 * Local data types of program paiPingService
 ********************************************************************)

TYPE
	paiPing_typ : 	STRUCT 
		iEnable : BOOL;
		iNewIpAddr : BOOL;
		iIPAddrStr : STRING[31];
		iNumericIpAddr : ARRAY[0..3]OF USINT;
		iPingIntervalxms : UDINT;
		iPingTimeoutxms : UDINT;
		oPingOk : BOOL;
		oPingStatus : UDINT; (*0-ping off;1-ping NOT ok; 2-ping ok > connect to a text group to display status*)
		mState : UDINT;
		mPingTimer : TON;
		mIcmpPing : IcmpPing;
	END_STRUCT;
END_TYPE
