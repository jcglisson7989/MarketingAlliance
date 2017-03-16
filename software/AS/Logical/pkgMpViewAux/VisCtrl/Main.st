
PROGRAM _INIT

END_PROGRAM

PROGRAM _CYCLIC
	clientSlots;
	usint_tmp;
	gVis;
	
	gVis.Alert.numAlarms := AlarmX_Control.ActiveAlarms;
	gVis.Alert.numWarnings := AlarmX_Control.PendingAlarms;
	gVis.Alert.idxImage := BOOL_TO_DINT(AlarmX_Control.ActiveAlarms > 0)*2;
	
	CASE gVis.Motion.indexAxis OF
		0:
			pAxisControl ACCESS ADR(gDelta.jointAxes[0].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Joint[0].Par);
		1:
			pAxisControl ACCESS ADR(gDelta.jointAxes[1].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Joint[1].Par);
		2:
			pAxisControl ACCESS ADR(gDelta.jointAxes[2].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Joint[2].Par);
		3:
			pAxisControl ACCESS ADR(gDelta.jointAxes[3].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Joint[3].Par);
		4:
			pAxisControl ACCESS ADR(gDelta.pathAxes[0].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Path[0].Par);
		5:
			pAxisControl ACCESS ADR(gDelta.pathAxes[1].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Path[1].Par);
		6:
			pAxisControl ACCESS ADR(gDelta.pathAxes[2].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Path[2].Par);
		7:
			pAxisControl ACCESS ADR(gDelta.pathAxes[3].Control);
			pAxisPar ACCESS ADR(gRecCfg.active.Cfg.Delta.Axes.Path[3].Par);
	END_CASE;
	

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

