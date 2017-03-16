(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiComponents
 * File: paiBRHW.typ
 * Author: goran
 * Created: June 23, 2015
 ********************************************************************
 * Data types of package paiTelnet
 ********************************************************************)

TYPE
	paiBnRHWModuleInfo_typ : 	STRUCT 
		ModuleOk : BOOL;
		SerialNumber : UDINT;
		ModuleID : UINT;
		HardwareVariant : UINT;
		FirmwareVersion : UINT;
	END_STRUCT;
END_TYPE
