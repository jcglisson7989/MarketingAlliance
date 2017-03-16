
//     __ __                         __  ___               ___         __           _             ____         
//    / // /__ _______  ___  ___    /  |/  /__ ____  __ __/ _/__ _____/ /___ ______(_)__  ___ _  /  _/__  ____ 
//   / _  / -_) __/ _ \/ _ \/ _ \  / /|_/ / _ `/ _ \/ // / _/ _ `/ __/ __/ // / __/ / _ \/ _ `/ _/ // _ \/ __/ 
//  /_//_/\__/_/ /_//_/\___/_//_/ /_/  /_/\_,_/_//_/\_,_/_/ \_,_/\__/\__/\_,_/_/ /_/_//_/\_, / /___/_//_/\__(_)
//                                                                                      /___/                  
//  Copyright 

PROGRAM _INIT
	Init_Logbook.Enable := TRUE;
	Init_Logbook.Name := 'usr_disp';
	Init_Logbook();
	
	gHMITable_Rec_Dispense	(tableName := 'REC_DISPENSE',		nameSpace := 'hmiTable/Rec/Dispense',	Logbook := Init_Logbook.pLog, 		pOverallStats := ADR(gTableStats.Overall));
	gHMITable_Cfg_Dispense	(tableName := 'CFG_DISPENSE',		nameSpace := 'hmiTable/Cfg/Dispense',	Logbook := Init_Logbook.pLog, 		pOverallStats := ADR(gTableStats.Overall));
	
	
	FBK_Disp_Valve[0].pDispVBlock := ADR(gMachine.Belt.Mailbox[gMachine.Belt.Dispense[0].Current_VBlock_At_Dispense]);
	FBK_Disp_Valve[0].pDispRec := ADR(gRecCfg.active.Rec.Dispense[0]);
	FBK_Disp_Valve[0].pDispCfg := ADR(gRecCfg.active.Cfg.Dispense[0]);
	FBK_Disp_Valve[0].pDispenseIO := ADR(gMachine.IO.Dispense.Projectile);
	FBK_Disp_Valve[0].pMechanics  := ADR(gRecCfg.active.Cfg.Mechanics);
	FBK_Disp_Valve[0].idx_disp_unit := 0;
END_PROGRAM

PROGRAM _CYCLIC
	
	
//	FBK_Disp_Valve[0].iNettime
//	FBK_Disp_Valve[0].MachineState
//	FBK_Disp_Valve[0].VBlock_Fractional_Position
//	FBK_Disp_Valve[0].Current_VBlock_At_PiP_Sensor
	FBK_Disp_Valve[0]();

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

