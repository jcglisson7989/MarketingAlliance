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
(*HMI object - Status message (data from real-time to HMI)*)
(*########################################################################*)

TYPE
	hmiStatus_typ : 	STRUCT 
		main : hmiStatusMain_typ;
		infeed : hmiStatusInfeed_typ;
		outfeed : hmiStatusOutfeed_typ;
		qc : hmiStatusQC_typ;
		lights : hmiStatusLights_typ;
		diag : hmiStatusDiag_typ;
	END_STRUCT;
	hmiStatusOutfeed_typ : 	STRUCT 
		wt : REAL; (*current outfeed wt *)
		status : UDINT; (*current state of the outfeed subsystem*)
		zeroTabCounter : UDINT; (*increments each time a zeroTab gets detected. Reset to 0 after power up.*)
	END_STRUCT;
	hmiStatusInfeed_typ : 	STRUCT 
		wt : REAL; (*current infeed wt *)
		state : UDINT; (*current state of the infeed subsystem*)
	END_STRUCT;
	hmiStatusIOInfeed_typ : 	STRUCT  (*infeed IO*)
		x2xBuxRx : hmiStatusX20TR_typ; (*x2x bus rx module*)
		wt : hmiStatusX20AI_typ; (*wt analog input*)
		DOModule : hmiStatusX20DO_typ; (*infeed outputs*)
		x2xBuxTx : hmiStatusX20TR_typ; (*x2x bus tx module*)
	END_STRUCT;
	hmiStatusDiag_typ : 	STRUCT 
		state : UDINT; (*current state of the Diag subsystem*)
		alarms : ARRAY[0..19]OF UDINT;
		io : hmiStatusIO_typ; (*status of IO for display on the windows side*)
		dummy : UDINT;
	END_STRUCT;
	hmiStatusLights_typ : 	STRUCT 
		dummy : UDINT;
	END_STRUCT;
	hmiStatusMain_typ : 	STRUCT 
		state : UDINT; (*current state of the main subsystem*)
	END_STRUCT;
	hmiStatusIO_typ : 	STRUCT  (*status of the entire machine IO*)
		infeed : hmiStatusIOInfeed_typ; (*infeed*)
		outfeed : hmiStatusIOOutfeed_typ; (*outfeed*)
		stations : ARRAY[0..30]OF hmiStatusIOStation_typ; (*stations*)
	END_STRUCT;
	hmiStatusIOOutfeed_typ : 	STRUCT  (*infeed IO*)
		x2xBuxRx : hmiStatusX20TR_typ; (*x2x bus rx module*)
		wt : hmiStatusX20AI_typ; (*wt analog input*)
		DIModule : hmiStatusX20DI_typ; (*infeed inputs*)
		DOModule : hmiStatusX20DO_typ; (*outfeed outputs*)
		x2xBuxTx : hmiStatusX20TR_typ; (*x2x bus tx module*)
	END_STRUCT;
	hmiStatusIOStation_typ : 	STRUCT  (*infeed IO*)
		x2xBuxRx : hmiStatusX20TR_typ; (*x2x bus rx module*)
		DIModule : hmiStatusX20DI_typ; (*station inputs*)
		DOLights : hmiStatusX20DO_typ; (*station light outputs*)
		DOModule : hmiStatusX20DO_typ; (*station outputs*)
		x2xBuxTx : hmiStatusX20TR_typ; (*x2x bus tx module*)
	END_STRUCT;
	hmiStatusX20DO_typ : 	STRUCT  (*status of an X20 DO output module*)
		moduleOk : UDINT; (*moduleOk bit map (only bit0 used)*)
		out : UDINT; (*state of outputs (bit map)*)
		outStatus : UDINT; (*status of outputs (bit map)*)
	END_STRUCT;
	hmiStatusX20TR_typ : 	STRUCT  (*status of an X20 bus Tx or bus Rx  module*)
		moduleOk : UDINT; (*moduleOk bit map (only bit0 used)*)
		statusInput01 : UDINT; (*see module description (bit map, only bit 0 used)*)
		statusInput02 : UDINT; (*see module description (bit map, only bit 0 used)*)
	END_STRUCT;
END_TYPE

(*==========================*)
(*==== IO Status Support      ====*)
(*==========================*)

TYPE
	hmiStatusX20DI_typ : 	STRUCT  (*status of an X20 DI input module*)
		moduleOk : UDINT; (*moduleOk bit map (only bit0 used)*)
		in : UDINT; (*state of inputs (bit map)*)
		notused : UDINT; (*state of inputs (bit map)*)
	END_STRUCT;
	hmiStatusQC_typ : 	STRUCT 
		state : UDINT; (*current state of the QC subsystem*)
		stationInQC : UDINT; (*number of the station beeing currently inspected at the QC*)
		stationInQC2 : UDINT; (*number of the station beeing currently inspected at the QC2*)
	END_STRUCT;
	hmiStatusX20AI_typ : 	STRUCT  (*status of an X20 DO output module*)
		moduleOk : UDINT; (*moduleOk bit map (only bit0 used)*)
		inAnalog : DINT; (*analog input value*)
		inStatus : UDINT; (*analog input status*)
		config : UDINT; (*analog input configuraton*)
	END_STRUCT;
END_TYPE
