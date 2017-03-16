
//     __ __                         __  ___               ___         __           _             ____         
//    / // /__ _______  ___  ___    /  |/  /__ ____  __ __/ _/__ _____/ /___ ______(_)__  ___ _  /  _/__  ____ 
//   / _  / -_) __/ _ \/ _ \/ _ \  / /|_/ / _ `/ _ \/ // / _/ _ `/ __/ __/ // / __/ / _ \/ _ `/ _/ // _ \/ __/ 
//  /_//_/\__/_/ /_//_/\___/_//_/ /_/  /_/\_,_/_//_/\_,_/_/ \_,_/\__/\__/\_,_/_/ /_/_//_/\_, / /___/_//_/\__(_)
//                                                                                      /___/                  
//  Copyright 

PROGRAM _INIT
	Init_Logbook.Enable := TRUE;
	Init_Logbook.Name := 'usr_insp';
	Init_Logbook();
	
	gHMITable_Rec_Inspect(tableName := 'REC_INSPECT',		nameSpace := 'hmiTable/Rec/Inspect',	Logbook := Init_Logbook.pLog, 		pOverallStats := ADR(gTableStats.Overall));
	gHMITable_Cfg_Inspect(tableName := 'CFG_INSPECT',		nameSpace := 'hmiTable/Cfg/Inspect',	Logbook := Init_Logbook.pLog, 		pOverallStats := ADR(gTableStats.Overall));
END_PROGRAM

PROGRAM _CYCLIC

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

