(*** /*****************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrServices
 * \file :   wbrServices.typ
 * \author : Blanton Radford
 * \date Created: July 17, 2015
 ********************************************************************
 * Data types of package wbrServices
 ***************************************************************/ *****)

TYPE
	wbrSvc_AsFBStatus_enum : 
		(
		wbrSvc_AsFBStatus_SUCCESS := 0,
		wbrSvc_AsFBStatus_NOT_ENABLED := 65534,
		wbrSvc_AsFBStatus_BUSY
		);
	wbrSvcBool_enum : 
		(
		NO := 0,
		YES,
		OFF := 0,
		ON,
		STOP := 0,
		START,
		UNCHECK := 0,
		CHECK
		);
	cfgFileInfo_typ : 	STRUCT 
		timestamp : STRING[63];
		path : STRING[127];
		machineNumber : UDINT;
		machineName : STRING[31];
	END_STRUCT;
	cfgCompileVersionInfo_typ : 	STRUCT 
		projVersion : STRING[63];
		AR_Version : STRING[15];
		AS_config : STRING[63];
		AS_configID : STRING[127];
		AS_build : STRING[63];
		date : STRING[31];
		AS_version : STRING[63];
		user : STRING[63];
		company : STRING[63];
		info : STRING[63];
	END_STRUCT;
END_TYPE

(*wbrUSBService types*)

TYPE
	wbrUSBSvcNodeList_enum : 
		(
		wbrusbLAST_NODE := 7,
		wbrusbNUM_NODES
		);
	wbrUSBSvcNodeList_typ : 	STRUCT 
		listCurr : {REDUND_UNREPLICABLE} ARRAY[0..wbrusbLAST_NODE]OF UDINT;
		listPrev : {REDUND_UNREPLICABLE} ARRAY[0..wbrusbLAST_NODE]OF UDINT;
		newNodeDetected : {REDUND_UNREPLICABLE} BOOL;
		nodeChangeDetected : {REDUND_UNREPLICABLE} BOOL;
		fb : {REDUND_UNREPLICABLE} UsbNodeListGet;
	END_STRUCT;
	wbrUSBSvcStringDescriptor_typ : 	STRUCT 
		isWorking : {REDUND_UNREPLICABLE} BOOL;
		fb : {REDUND_UNREPLICABLE} UsbDescriptorGet;
		descriptor : usbStringDescr_typ;
		descContainer : WSTRING[63] := "";
	END_STRUCT;
	wbrUSBSvcNodeData_typ : 	STRUCT 
		isNew : {REDUND_UNREPLICABLE} BOOL;
		isActive : {REDUND_UNREPLICABLE} BOOL;
		isWorking : {REDUND_UNREPLICABLE} BOOL;
		isReady : {REDUND_UNREPLICABLE} BOOL;
		deviceData : usbNode_typ;
		deviceDescriptor : usbDeviceDescr_typ;
		string : ARRAY[0..3]OF wbrUSBSvcStringDescriptor_typ;
		fbGetNode : {REDUND_UNREPLICABLE} UsbNodeGet;
		fbGetDescDev : {REDUND_UNREPLICABLE} UsbDescriptorGet;
		fbMonStorageReady : {REDUND_UNREPLICABLE} UsbMsDeviceReady;
	END_STRUCT;
	wbrUSBService_typ : 	STRUCT 
		list : {REDUND_UNREPLICABLE} wbrUSBSvcNodeList_typ;
		node : {REDUND_UNREPLICABLE} ARRAY[0..wbrusbLAST_NODE]OF wbrUSBSvcNodeData_typ;
		nextNodeIdx : {REDUND_UNREPLICABLE} USINT;
	END_STRUCT;
	wbrUSBServiceIF_typ : 	STRUCT 
		isReady : {REDUND_UNREPLICABLE} BOOL;
		isFileIODevice : {REDUND_UNREPLICABLE} BOOL; (*Can read and write files on device*)
		fileIODeviceParam : STRING[127] := '---'; (*FileIO device parameter string*)
	END_STRUCT;
END_TYPE
