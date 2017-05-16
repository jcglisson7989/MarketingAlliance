//     __ __                         __  ___               ___         __           _             ____         
//    / // /__ _______  ___  ___    /  |/  /__ ____  __ __/ _/__ _____/ /___ ______(_)__  ___ _  /  _/__  ____ 
//   / _  / -_) __/ _ \/ _ \/ _ \  / /|_/ / _ `/ _ \/ // / _/ _ `/ __/ __/ // / __/ / _ \/ _ `/ _/ // _ \/ __/ 
//  /_//_/\__/_/ /_//_/\___/_//_/ /_/  /_/\_,_/_//_/\_,_/_/ \_,_/\__/\__/\_,_/_/ /_/_//_/\_, / /___/_//_/\__(_)
//                                                                                      /___/                  
//  Copyright 
PROGRAM _INIT
	Init_Logbook.Enable := TRUE;
	Init_Logbook.Name := 'usr_table';
	Init_Logbook();

	//loadHMITable is a FBK with structures containing the values loaded from the textsystem files
	loadHMITable[TABLE_REC_CONTROL]		(tableName := 'Control Recipe',				nameSpace := 'hmiTable/Rec/Control',		Logbook := Init_Logbook.pLog, 	pOverallStats := ADR(tableStats.Overall));
	loadHMITable[TABLE_REC_DISPENSE]	(tableName := 'Dispense Recipe',			nameSpace := 'hmiTable/Rec/Dispense',		Logbook := Init_Logbook.pLog, 	pOverallStats := ADR(tableStats.Overall));
	loadHMITable[TABLE_CFG_CONTROL]		(tableName := 'Control Configuration',		nameSpace := 'hmiTable/Cfg/Control',		Logbook := Init_Logbook.pLog, 	pOverallStats := ADR(tableStats.Overall));
	loadHMITable[TABLE_CFG_DISPENSE]	(tableName := 'Dispense Configuration',		nameSpace := 'hmiTable/Cfg/Dispense',		Logbook := Init_Logbook.pLog, 	pOverallStats := ADR(tableStats.Overall));
END_PROGRAM

//TODO: Load param array with %s, replace with index.
//TODO: More scrutiny to ensure tables were done correctly

PROGRAM _CYCLIC
	IF gHmi.tables.Trigger.Rec.Control THEN
		gHmi.tables.Trigger.Rec.Control := FALSE;
		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_CONTROL].hmiStruct));//No Control recipe values
	END_IF;
	
	IF gHmi.tables.Trigger.Rec.Dispense THEN
		gHmi.tables.Trigger.Rec.Dispense := FALSE;
		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_REC_DISPENSE].hmiStruct));
	END_IF;
	
	IF gHmi.tables.Trigger.Cfg.Control THEN
		gHmi.tables.Trigger.Cfg.Control := FALSE;
		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_CONTROL].hmiStruct));
	END_IF;
	
	IF gHmi.tables.Trigger.Cfg.Dispense THEN
		gHmi.tables.Trigger.Cfg.Dispense := FALSE;
		ActivateHMITable(gRecCfg.active.Cfg.HMI.MachineLang, pHMITable := ADR(gHmiParamTable), pTableValues := ADR(loadHMITable[TABLE_CFG_DISPENSE].hmiStruct));
	END_IF;
	
	IF gHmi.tables.Load.Trigger THEN
		SYSreset(1,1);
	END_IF;
	
	hmiParamListTableCyclic(ADR(gHmiParamTable));
		
END_PROGRAM

