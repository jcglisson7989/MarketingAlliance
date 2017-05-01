(********************************************************************
 * COPYRIGHT -- HP
 ********************************************************************
 * File: Global.typ
 * Author: goran
 * Created: January 23, 2013
 ********************************************************************
 * Global data types of project YieldPlus
 ********************************************************************)
(*==========================*)
(*==== UDP Message Header ====*)
(*==========================*)

TYPE
	jsonOverUDPMsgConst_typ : 
		( (*Consts used for json messaging over UDP*)
		CONST_JSONMSG_WEIGHTS := 100,
		CONST_JSONMSG_WORKERS := 30,
		CONST_JSONMSG_INSPECTORS := 40,
		CONST_JSONMSG_PRODUCTS := 50,
		CONST_JSONMSG_DASHBMAIN := 60,
		CONST_JSONMSG_WRKTMUPD := 61,
		CONST_JSONMSG_DASHBDEFECTS := 62,
		CONST_JSONMSG_STATIONDATA := 70,
		CONST_JSONMSG_HMISECURITY := 71,
		CONST_JSONMSG_HMILOGGING := 72
		);
	ctrlInterfaceMsgHeader_typ : 	STRUCT 
		msgVersion : STRING[31];
		msgCounter : UDINT;
		msgEchoRequest : UDINT;
		msgEchoResponse : UDINT;
	END_STRUCT;
END_TYPE

(*==========================*)
(*==== UDP Message Common===*)
(*==========================*)

TYPE
	ctrlInterfaceCmdScaleCalib_typ : 	STRUCT 
		avgBufferSize : UDINT;
		FIRfilter : UDINT;
		mask : UDINT;
		analogConverterSpeed : UDINT;
		calibrationCmd : UDINT; (*Calibration command: 0-normal operation;1-doZero;2-doCalibration*)
		calibrationWt : REAL; (*Calibraton wt*)
	END_STRUCT;
	ctrlInterfaceCmdScaleWt_typ : 	STRUCT 
		zeroThresholdWt : REAL; (*threshold wt under which a scale is assumed empty*)
		targetWt : REAL; (*target wt to fill in the infeed bin*)
		weighDelay : REAL; (*delay time to wait wt measurment in order to accept the wt value*)
		zeroDelay : REAL; (*delay time between measuring zero value and pronouncing the zero wt*)
		breakoutTime : REAL; (*time to wait for product to breakaway from the scale. In other words, time to wait for measured weight to drop below zeroThresholdWt*)
		breakoutAttempts : UDINT; (*number of breakout attempts. 0-none (zero the scale) 1..9-try to breakout the product*)
		breakoutMode : UDINT; (*0-rezero scale after breakout time expires, don't stop the machine 1-stop the machine, generate alarm for the user*)
	END_STRUCT;
	ctrlInterfaceCmdRecordOk_typ : 	STRUCT 
		lastDBSavedRecId : UDINT; (*record ID of the last successfuly saved data aquisition record*)
	END_STRUCT;
END_TYPE

(*==========================*)
(*==== UDP Command Message ====*)
(*==========================*)

TYPE
	ctrlInterfaceCmd_typ : 	STRUCT 
		listQCInspectors : STRING[511];
	END_STRUCT;
END_TYPE
