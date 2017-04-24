
PROGRAM _INIT
	//loadHMITable is a FBK with structures containing the values loaded from the textsystem files
	loadHMITable[TABLE_RECIPE]		(tableName := 'Process Recipe',			nameSpace := 'hmiTable/Recipe',	Logbook := Init_Logbook.pLog, 	pOverallStats := ADR(tableStats.Overall));
	loadHMITable[TABLE_CONFIG]		(tableName := 'Machine Configuration',	nameSpace := 'hmiTable/Config',	Logbook := Init_Logbook.pLog, 	pOverallStats := ADR(tableStats.Overall));
END_PROGRAM

//TODO: Load param array with %s, replace with index.
//TODO: More scrutiny to ensure tables were done correctly

PROGRAM _CYCLIC
	IF gHmi.tables.Trigger.Rec THEN
		gHmi.tables.Trigger.Rec := FALSE;
		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_RECIPE].hmiStruct));//No Control recipe values
	END_IF;
	
	IF gHmi.tables.Trigger.Cfg THEN
		gHmi.tables.Trigger.Cfg := FALSE;
		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CONFIG].hmiStruct));//No Control recipe values
	END_IF;

	hmiParamListTableCyclic(ADR(gHmiParamTable));
		
END_PROGRAM

