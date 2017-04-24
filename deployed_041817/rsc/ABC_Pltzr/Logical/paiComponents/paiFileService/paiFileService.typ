(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiFileService
 * File: paiFileService.typ
 * Author: goran_2
 * Created: August 05, 2011
 ********************************************************************
 * Data types of package paiFileService
 ********************************************************************)

TYPE
	PAI_FILESERVICE_ENUMS : 
		(
		PAI_FS_DEVICE_MAXIDX := 19,
		PAI_FS_DEVICE_NONE := 0,
		PAI_FS_IDLE := 0,
		PAI_FS_RDFILE := 1,
		PAI_FS_WRFILE := 2,
		PAI_FS_INFOFILE := 3,
		PAI_FS_DELFILE := 4,
		PAI_FS_RDDIR := 10,
		PAI_FS_CRDIR := 11,
		PAI_FS_INFODIR := 12
		);
	paiFileServiceDevDirItem_typ : 	STRUCT 
		deviceName : STRING[31];
		dirName : STRING[127];
		deviceConfiguration : STRING[127];
		createdAtPowerUp : BOOL;
		status : INT;
	END_STRUCT;
	paiFileServiceDeviceTable_typ : 	STRUCT 
		listDevsDirs : ARRAY[0..19]OF paiFileServiceDevDirItem_typ;
	END_STRUCT;
	paiFileServicePublicIn_typ : 	STRUCT 
		request : USINT;
		adrDeviceName : UDINT; (*Address of the Device Name*)
		adrName : UDINT; (*File/dir name for the requested action (read, write, create, delete, etc)*)
		adrName2 : UDINT; (*File/dir name for the requested action (read, write, create, delete, etc)*)
		adrReadDst : UDINT; (*Destination address for the read action*)
		readDstLen : UDINT; (*Length of the space available for read at the given address*)
		readOffset : UDINT;
		adrWriteSrc : UDINT; (*Src address for the write action.*)
		writeSrcLen : UDINT; (*Length of data available at src address*)
		writeOffset : UDINT;
		pCallback : UDINT; (*ptr to Callback function*)
		pCallbackData : UDINT; (*ptr to Callback data*)
	END_STRUCT;
	paiFileServicePublicOut_typ : 	STRUCT 
		status : UINT; (*Output status for R or W request. Valid when writeDone or readDone set to 1.*)
		initOk : BOOL; (*Output status that indicates if service completed initialization after system start. Wait with any access until initOk == 1*)
		busy : BOOL; (*Output status to indicate that service is busy (busy == 1) servicing a current request. Avoid issuing new requests.*)
		powerUp : BOOL; (*Output status to indicate that service completed servicing a current request. Shall be cleared by the receiver of the event.*)
		done : BOOL; (*Output status to indicate that service completed servicing a current request. Shall be cleared by the receiver of the event.*)
		bytecount : UDINT; (*Number of bytes during file read.*)
	END_STRUCT;
	paiFileServicePrivateFileFBK_typ : 	STRUCT 
		open : FileOpen;
		close : FileClose;
		read : FileRead;
		readex : FileReadEx;
		write : FileWrite;
		writeex : FileWriteEx;
		copy : FileCopy;
		create : FileCreate;
		delete : FileDelete;
		rename : FileRename;
		truncate : FileTruncate;
		info : FileInfo;
		infoData : fiFILE_INFO;
	END_STRUCT;
	paiFileServicePrivateDevFBK_typ : 	STRUCT 
		link : DevLink;
		unlink : DevUnlink;
	END_STRUCT;
	paiFileServiceDirFBK_typ : 	STRUCT 
		open : DirOpen;
		close : DirClose;
		read : DirRead;
		copy : DirCopy;
		create : DirCreate;
		delete : DirDelete;
		deleteex : DirDeleteEx;
		rename : DirRename;
		info : DirInfo;
	END_STRUCT;
	paiFileServicePrivate_typ : 	STRUCT 
		requestType : USINT;
		status : UINT;
		bgssm : bgSSM_typ;
		currentDeviceIndex : UDINT;
		pDeviceTable : REFERENCE TO paiFileServiceDeviceTable_typ;
		device : paiFileServicePrivateDevFBK_typ;
		dir : paiFileServiceDirFBK_typ;
		file : paiFileServicePrivateFileFBK_typ;
	END_STRUCT;
	paiFileService_typ : 	STRUCT 
		i : paiFileServicePublicIn_typ;
		o : paiFileServicePublicOut_typ;
		prv : paiFileServicePrivate_typ;
	END_STRUCT;
END_TYPE
