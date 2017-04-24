(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiFileService
 * File: paiPVSerDesMgr
 * Author: goran_2
 * Created: August 05, 2015
 ********************************************************************
 * Data types of package paiFileService
 ********************************************************************)

TYPE
	paiFSEnums_typ : 
		(
		PAI_FS_PVNAME_MAXLEN := 63,
		PAI_FS_PATH_MAXLEN := 127,
		PAI_FS_TXTLEN_MID := 127,
		PAI_FS_SERDESMGR_PWRUP_NA := 0, (*PV restore option at Power Up: no action*)
		PAI_FS_SERDESMGR_PWRUP_DFLT := 1, (*PV restore option at Power Up: test storage, if different preload defaults*)
		PAI_FS_SERDESMGR_PWRUP_DFLT_fRD := 2, (*PV restore option at Power Up: test storage, if different preload defaults then read data from file*)
		PAI_FS_SERDESMGR_MAXITEMIDX := 19
		);
	paiPVSerDesChangeMonitor_typ : 	STRUCT  (*Change monitor: optional feature*)
		iChngEnable : BOOL; (*0-disabled;1-enabled*)
		iChngRejected : BOOL; (*1-reject PV changes, restore previous value*)
		iChngAccepted : BOOL; (*1-accept PV changes, store PV to file*)
		oChngDetected : BOOL; (*1-PV is changed, use information to prompt user*)
		oError : UDINT; (*1-option is enabled, but provided memory is unsufficent*)
		oState : UDINT; (*1-option is enabled, but provided memory is unsufficent*)
		iChangeMonitorMemSize : UDINT; (*size of the address space for this feature (shall be the same size or greater than the size of the PV)*)
		pChangeMonitorMem : UDINT; (*ptr to address space which has the same size as the PV (use for memory compare to detect changes)*)
	END_STRUCT;
	paiPVSerDesHMI_typ : 	STRUCT 
		iBtnChangeReject : USINT;
		iBtnChangeAccept : USINT;
		iBtnSerRequest : USINT;
		iBtnDesRequest : USINT;
		oBtnVisible : USINT;
		oBtnClick : USINT;
	END_STRUCT;
	paiPVSerDesPowerUp_typ : 	STRUCT  (*Option: control of a behaivor at power up*)
		iPowerUpConfig : UDINT; (*0-nothing to do; 1-use test data; if diff, run defaults; 2-use test data; if diff, read from file*)
		iTestData : UDINT; (*Test data value (i.e. magic word 0x55555555)*)
		pTestDataStorage : UDINT; (*Ptr to the location of the magic word for this variable*)
		oError : UDINT; (*0-not ready after power up; 1-ready after power up*)
		oInitReady : UDINT; (*0-not ready after power up; 1-ready after power up*)
		oStatus : STRING[15]; (*0-not ready after power up; 1-ready after power up*)
	END_STRUCT;
	paiPVSerDesItem_typ : 	STRUCT 
		iPVName : STRING[PAI_FS_PVNAME_MAXLEN]; (*PV name*)
		iDevicename : STRING[PAI_FS_PVNAME_MAXLEN]; (*Name of the file device to store PV*)
		iFilename : STRING[PAI_FS_PATH_MAXLEN]; (*Filename to store PV*)
		iSerRequest : BOOL; (*Request to write PV to file (i.e. serialize PV to file buffer > write data to  file)*)
		iDesRequest : BOOL; (*Request to read PV from file (i.e. read file to file buffer > deserialize data to PV)*)
		pPV : UDINT; (*ptr to PV*)
		iPVSize : UDINT; (*size of the PV (in bytes)*)
		pFilebuffer : UDINT; (*ptr to file r/w buffer*)
		iFilebufferSize : UDINT; (*size (bytes) of the file r/w buffer*)
		optChangeMonitor : paiPVSerDesChangeMonitor_typ; (*optional feature for automatic / HMI assisted read/write of PV-s upon changes*)
		optInitAtPowerUp : paiPVSerDesPowerUp_typ; (*optional feature: control PV init at power up; see above*)
		optPtrHMIData : REFERENCE TO paiPVSerDesHMI_typ; (*optional feature: HMI interface for PV read/write to/from file*)
		pCallbackDes : UDINT; (*deserialize callback function - processes PV deser request*)
		pCallbackSer : UDINT; (*serialize callback function - processes PV serialize request*)
		pCallbackDefault : UDINT; (*default callback function - function to set PV default values*)
		oState : UDINT; (*mgr current state*)
		oDone : UDINT; (*1 - ser or deser request is complete; *)
		oSerCount : UDINT;
		oDesCount : UDINT;
		oSerCountOld : UDINT;
		oDesCountOld : UDINT;
		oFilesizeLastSer : UDINT;
		oFilesizeLastDes : UDINT;
		oTimestampLastSer : STRING[63];
		oTimestampLastDes : STRING[63];
		oErrorCount : UDINT;
		oErrorCountOld : UDINT;
		oError : UDINT;
		oErrorTxt : STRING[PAI_FS_TXTLEN_MID];
	END_STRUCT;
	paiPVSerDesMgr_typ : 	STRUCT 
		pPaiFS : UDINT;
		oState : UDINT;
		iItemCount : UDINT;
		pvItems : ARRAY[0..PAI_FS_SERDESMGR_MAXITEMIDX]OF paiPVSerDesItem_typ;
	END_STRUCT;
END_TYPE
