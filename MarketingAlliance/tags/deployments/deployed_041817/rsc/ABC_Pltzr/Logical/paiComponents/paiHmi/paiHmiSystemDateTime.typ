(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI object - System Time*)
(*########################################################################*)

TYPE
	paiHmiSystemTime_typ : 	STRUCT 
		iChangeTimeRequest : BOOL;
		oDateTimeActual : DTStructure;
		mDateTime : DATE_AND_TIME;
		mSetTime : DTSetTime;
		mGetTime : DTGetTime;
	END_STRUCT;
END_TYPE
