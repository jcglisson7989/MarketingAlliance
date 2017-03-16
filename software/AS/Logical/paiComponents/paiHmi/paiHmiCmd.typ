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
(*==========================*)
(*==== HMI Command Interface ==*)
(*==========================*)

TYPE
	hmiCmd_typ : 	STRUCT 
		main : hmiCmdMain_typ;
		infeed : hmiCmdInfeed_typ;
		outfeed : hmiCmdOutfeed_typ;
		qc : hmiCmdQC_typ;
		lights : hmiCmdLights_typ;
		diag : hmiCmdDiag_typ;
		listQCInspectors : STRING[511];
	END_STRUCT;
	hmiCmdX20Outfeed_typ : 	STRUCT  (*command to control / force an OUTFEED output module*)
		doDoorWeigh : BOOL; (*weigh door*)
		doBelt : BOOL; (*belt control clutch*)
		doQC1 : BOOL; (*qc1 diverter *)
		doQC2 : BOOL; (*qc2 diverter*)
	END_STRUCT;
	hmiCmdX20Station_typ : 	STRUCT  (*command to control / force an STATION output module(s)*)
		doTakeout0 : BOOL; (*takeout (0 + moduleNum*4)*)
		doTakeout1 : BOOL; (*takeout (1 + moduleNum*4)*)
		doTakeout2 : BOOL; (*takeout (2 + moduleNum*4)*)
		doTakeout3 : BOOL; (*takeout (3 + moduleNum*4)*)
		doDumpAll : BOOL; (*station dump ALL (0..3 + moduleNum*4)*)
		doDump0 : BOOL; (*station dump (0 + moduleNum*4)*)
		doDump1 : BOOL; (*station dump (1 + moduleNum*4)*)
		doDump2 : BOOL; (*station dump (2 + moduleNum*4)*)
		doDump3 : BOOL; (*station dump (3 + moduleNum*4)*)
		doLights : BOOL; (*state of outputs (bit map)*)
	END_STRUCT;
	hmiCmdX20Infeed_typ : 	STRUCT  (*command to control / force an INFEED output module*)
		doDoorBuffer : BOOL; (*buffer door*)
		doDoorWeigh : BOOL; (*weigh door*)
		doLine : BOOL; (*line control valve*)
	END_STRUCT;
	hmiCmdIO_typ : 	STRUCT  (*command to control/force outputs of the entire machine*)
		enableDOForce : UDINT; (*enable DO force *)
		infeed : hmiCmdX20Infeed_typ; (*infeed*)
		outfeed : hmiCmdX20Outfeed_typ; (*outfeed*)
		stations : ARRAY[0..30]OF hmiCmdX20Station_typ; (*stations*)
	END_STRUCT;
	hmiCmdLights_typ : 	STRUCT 
		enableLightControl : UDINT; (*0-Lights control feature off; 1-Lights control feature on; 2-Lights control test mode*)
		LightsDO : ARRAY[0..30]OF UDINT; (*Bit mapped Light outputs; A UDINT per station*)
	END_STRUCT;
	hmiCmdInfeed_typ : 	STRUCT 
		scaleCalibration : hmiCmdScaleCalib_typ;
		pauseOperation : UDINT; (*0-normal 1-pause operation*)
		gateEnable : UDINT; (*gate enable bit array (bit encoded UDINT), bit0-station 1*)
	END_STRUCT;
	hmiCmdDiag_typ : 	STRUCT 
		alarmsAck : ARRAY[0..19]OF UDINT;
		io : hmiCmdIO_typ; (*control of the outputs from the Windows side (testing and troubleshooting)*)
	END_STRUCT;
	hmiCmdScaleCalib_typ : 	STRUCT 
		calibrationCmd : UDINT; (*Calibration command: 0-normal operation;1-doZero;2-doCalibration*)
		calibrationWt : REAL; (*Calibraton wt*)
	END_STRUCT;
	hmiCmdX20DO_typ : 	STRUCT  (*command to control / force an X20 DO output module*)
		out : UDINT; (*state of outputs (bit map)*)
	END_STRUCT;
	hmiCmdQC_typ : 	STRUCT 
		stationQCEnabled : UDINT; (*bit codded UDINT indicating a station for QC (bit0-station1, etc)*)
		QCMode : UDINT; (*0-stop the outfeed if needed to wait for QC; 1-don't stop the outfeed even if QC is needed for the current station (i.e. never stop the outfeed to wait for QC to complete)*)
		workerScoreAtQC : UDINT; (*score of the worker that is currently inspected at QC (uses status.qc.stationInQC)*)
		workerNameAtQC : STRING[31]; (*name of the worker that is currently inspected at QC (uses status.qc.stationInQC)*)
		workerScoreAtQC2 : UDINT; (*score of the worker that is currently inspected at QC2 (uses status.qc.stationInQC2)*)
		workerNameAtQC2 : STRING[31]; (*name of the worker that is currently inspected at QC2 (uses status.qc.stationInQC2)*)
	END_STRUCT;
	hmiCmdMain_typ : 	STRUCT 
		machineState : UDINT; (*0-stopped;1-filling;2-run;3-washdown*)
	END_STRUCT;
	hmiCmdOutfeed_typ : 	STRUCT 
		scaleCalibration : hmiCmdScaleCalib_typ;
		pauseOperation : UDINT; (*0-normal 1-pause operation*)
	END_STRUCT;
END_TYPE
