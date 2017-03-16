
PROGRAM _INIT
	Init_Logbook.Enable := TRUE;
	Init_Logbook.Name := 'usr_table';
	Init_Logbook();

	

END_PROGRAM

//TODO: Load param array with %s, replace with index.
//TODO: More scrutiny to ensure tables were done correctly

PROGRAM _CYCLIC
	svnRevision;
	
	
//	IF loc.tables.Trigger.Rec.Dispense THEN
//		loc.tables.Trigger.Rec.Dispense := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_DISPENSE].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Rec.Inspect THEN
//		loc.tables.Trigger.Rec.Inspect := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_INSPECT].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Rec.Eject THEN
//		loc.tables.Trigger.Rec.Eject := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_EJECT].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Rec.Motor THEN
//		loc.tables.Trigger.Rec.Motor := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_MOTOR].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Rec.Process THEN
//		loc.tables.Trigger.Rec.Process := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_PROCESS].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Rec.Loader THEN
//		loc.tables.Trigger.Rec.Loader := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_LOADER].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Dispense THEN
//		loc.tables.Trigger.Cfg.Dispense := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_DISPENSE].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Inspect THEN
//		loc.tables.Trigger.Cfg.Inspect := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_INSPECT].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Eject THEN
//		loc.tables.Trigger.Cfg.Eject := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_EJECT].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Motor THEN
//		loc.tables.Trigger.Cfg.Motor := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_MOTOR].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Process THEN
//		loc.tables.Trigger.Cfg.Process := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_PROCESS].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Loader THEN
//		loc.tables.Trigger.Cfg.Loader := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_LOADER].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Trigger.Cfg.Admin THEN
//		loc.tables.Trigger.Cfg.Admin := FALSE;
//		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_ADMIN].hmiStruct));
//	END_IF;
//	
//	IF loc.tables.Load.Trigger THEN
//		SYSreset(1,1);
//	END_IF;
//	
//	hmiParamListTableCyclic(ADR(gHmiParamTable));
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

