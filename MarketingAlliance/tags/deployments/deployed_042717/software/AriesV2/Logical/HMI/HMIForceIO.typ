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
(*Force IO support from the HMI*)
(*########################################################################*)

TYPE
	hmiForceIOItem_typ : 	STRUCT 
		reset : UDINT; (*value returned when button pressed (0-busy, button not pressed, dialog active, OK pressed returns resultForOk (eg.1); Cancel pressed returns resultForCancel (eg.2)*)
		set : UDINT; (*value to return when Ok pressed (if 0 return value is 1)*)
		toggle : UDINT; (*value to return when Cancel pressed (if 0 return value is 2)*)
		pAddrIO : UDINT; (*value to return when Cancel pressed (if 0 return value is 2)*)
	END_STRUCT;
	hmiForceIO_typ : 	STRUCT 
		forceEnable : UDINT;
		forceItemsVisibility : UDINT; (*0-visible;1-not visible*)
		forceItems : ARRAY[0..HMI_ENUM_FORCEIO_LASTINDEX]OF hmiForceIOItem_typ; (*value returned when button pressed (0-busy, button not pressed, dialog active, OK pressed returns resultForOk (eg.1); Cancel pressed returns resultForCancel (eg.2)*)
		Flag_Reset_All : BOOL;
	END_STRUCT;
END_TYPE
