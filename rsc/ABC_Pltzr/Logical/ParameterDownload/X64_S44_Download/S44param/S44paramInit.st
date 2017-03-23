(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: S44param
 * File: S44paramInit.st
 * Author: scoccimaroj
 * Created: July 15, 2010
 ********************************************************************
 * Implementation of program S44param
 ********************************************************************)

PROGRAM _INIT


strcpy( ADR(S44ParRead.pDevice) , ADR('SS1.IF1.ST1') );
AsIOAccRead_0.pDeviceName := ADR(S44ParRead.pDevice);
strcpy( ADR(S44ParRead.FileDevice), ADR('DISK') );
 
 
 (* Initialize the CSV file writing operation *)
 strcpy( ADR(S44ParRead.CsvFileName), ADR(S44ParRead.pDevice) );
 
 
 FOR i:= 0 TO 10 BY 1 DO
 	position := FIND(S44ParRead.CsvFileName, '.');
	
	IF (position <> 0) THEN
 		S44ParRead.CsvFileName := REPLACE(S44ParRead.CsvFileName, '_', 1, position);
	END_IF	
		
 END_FOR 
  
 
 strcat( ADR(S44ParRead.CsvFileName), ADR('.csv') ); 
 
 
 pNames[0] := ADR('S44ParRead');
 
 csvInit.pStructName := ADR(pNames);
 csvInit.NumOfStructs := 1;
 csvInit.FullNameLenght := 0;
 csvInit.Options := 0;
 
 csvInit();
 
 IF (csvInit.status = 0) THEN
 	csvMemLength := csvInit.MemCounter;
	csvStrucMem := csvInit.pStructMem;
	
	csvInitCheckFile.MemCounter := csvMemLength;
	csvInitCheckFile.enable := 1;
	csvInitCheckFile();		
	
 END_IF	 

(* Initialize the parameter channel names *)
strcpy( ADR(S44ParRead.Parameters[0].ChannelName) , ADR('COD_Input') );
strcpy( ADR(S44ParRead.Parameters[1].ChannelName) , ADR('BFR_Input') );
strcpy( ADR(S44ParRead.Parameters[2].ChannelName) , ADR('FR1_Input') );
strcpy( ADR(S44ParRead.Parameters[3].ChannelName) , ADR('ACC_Input') );
strcpy( ADR(S44ParRead.Parameters[4].ChannelName) , ADR('DEC_Input') );
strcpy( ADR(S44ParRead.Parameters[5].ChannelName) , ADR('LSP_Input') );
strcpy( ADR(S44ParRead.Parameters[6].ChannelName) , ADR('HSP_Input') );
strcpy( ADR(S44ParRead.Parameters[7].ChannelName) , ADR('NPR_Input') );
strcpy( ADR(S44ParRead.Parameters[8].ChannelName) , ADR('NCR_Input') );
strcpy( ADR(S44ParRead.Parameters[9].ChannelName) , ADR('AI1T_Input') );
strcpy( ADR(S44ParRead.Parameters[10].ChannelName) , ADR('TCC_Input') );
strcpy( ADR(S44ParRead.Parameters[11].ChannelName) , ADR('TCT_Input') );
strcpy( ADR(S44ParRead.Parameters[12].ChannelName) , ADR('NPL_Input') );
strcpy( ADR(S44ParRead.Parameters[13].ChannelName) , ADR('CRL1_Input') );
strcpy( ADR(S44ParRead.Parameters[14].ChannelName) , ADR('CRH1_Input') );
strcpy( ADR(S44ParRead.Parameters[15].ChannelName) , ADR('R1_Input') );
strcpy( ADR(S44ParRead.Parameters[16].ChannelName) , ADR('LO1_Input') );
strcpy( ADR(S44ParRead.Parameters[17].ChannelName) , ADR('LO1S_Input') );
strcpy( ADR(S44ParRead.Parameters[18].ChannelName) , ADR('TOL_Input') );
strcpy( ADR(S44ParRead.Parameters[19].ChannelName) , ADR('LOC_Input') );
strcpy( ADR(S44ParRead.Parameters[20].ChannelName) , ADR('ULT_Input') );
strcpy( ADR(S44ParRead.Parameters[21].ChannelName) , ADR('LUL_Input') );
strcpy( ADR(S44ParRead.Parameters[22].ChannelName) , ADR('FTD_Input') );
strcpy( ADR(S44ParRead.Parameters[23].ChannelName) , ADR('CTD_Input') );
strcpy( ADR(S44ParRead.Parameters[24].ChannelName) , ADR('TTD_Input') );
strcpy( ADR(S44ParRead.Parameters[25].ChannelName) , ADR('AO1_Input') );
strcpy( ADR(S44ParRead.Parameters[26].ChannelName) , ADR('AO1T_Input') );
strcpy( ADR(S44ParRead.Parameters[27].ChannelName) , ADR('COS_Input') );
strcpy( ADR(S44ParRead.Parameters[28].ChannelName) , ADR('UNS_Input') );
strcpy( ADR(S44ParRead.Parameters[29].ChannelName) , ADR('FRS_Input') );
strcpy( ADR(S44ParRead.Parameters[30].ChannelName) , ADR('NSP_Input') );
strcpy( ADR(S44ParRead.Parameters[31].ChannelName) , ADR('TFR_Input') );
strcpy( ADR(S44ParRead.Parameters[32].ChannelName) , ADR('CTT_Input') );
strcpy( ADR(S44ParRead.Parameters[33].ChannelName) , ADR('UFR_Input') );
strcpy( ADR(S44ParRead.Parameters[34].ChannelName) , ADR('SLP_Input') );
strcpy( ADR(S44ParRead.Parameters[35].ChannelName) , ADR('STA_Input') );
strcpy( ADR(S44ParRead.Parameters[36].ChannelName) , ADR('FLG_Input') );
strcpy( ADR(S44ParRead.Parameters[37].ChannelName) , ADR('PFL_Input') );
strcpy( ADR(S44ParRead.Parameters[38].ChannelName) , ADR('SFR_Input') );
strcpy( ADR(S44ParRead.Parameters[39].ChannelName) , ADR('SFT_Input') );
strcpy( ADR(S44ParRead.Parameters[40].ChannelName) , ADR('NRD_Input') );
strcpy( ADR(S44ParRead.Parameters[41].ChannelName) , ADR('TUN_Input') );
strcpy( ADR(S44ParRead.Parameters[42].ChannelName) , ADR('MPC_Input') );
strcpy( ADR(S44ParRead.Parameters[43].ChannelName) , ADR('RIN_Input') );
strcpy( ADR(S44ParRead.Parameters[44].ChannelName) , ADR('PST_Input') );
strcpy( ADR(S44ParRead.Parameters[45].ChannelName) , ADR('CHCF_Input') );
strcpy( ADR(S44ParRead.Parameters[46].ChannelName) , ADR('CD1_Input') );
strcpy( ADR(S44ParRead.Parameters[47].ChannelName) , ADR('FLO_Input') );
strcpy( ADR(S44ParRead.Parameters[48].ChannelName) , ADR('FLOC_Input') );
strcpy( ADR(S44ParRead.Parameters[49].ChannelName) , ADR('RPT_Input') );
strcpy( ADR(S44ParRead.Parameters[50].ChannelName) , ADR('RPS_Input') );
strcpy( ADR(S44ParRead.Parameters[51].ChannelName) , ADR('AC2_Input') );
strcpy( ADR(S44ParRead.Parameters[52].ChannelName) , ADR('DE2_Input') );
strcpy( ADR(S44ParRead.Parameters[53].ChannelName) , ADR('BRA_Input') );
strcpy( ADR(S44ParRead.Parameters[54].ChannelName) , ADR('STT_Input') );
strcpy( ADR(S44ParRead.Parameters[55].ChannelName) , ADR('NST_Input') );
strcpy( ADR(S44ParRead.Parameters[56].ChannelName) , ADR('FST_Input') );
strcpy( ADR(S44ParRead.Parameters[57].ChannelName) , ADR('DCF_Input') );
strcpy( ADR(S44ParRead.Parameters[58].ChannelName) , ADR('RRS_Input') );
strcpy( ADR(S44ParRead.Parameters[59].ChannelName) , ADR('ADC_Input') );
strcpy( ADR(S44ParRead.Parameters[60].ChannelName) , ADR('SDC1_Input') );
strcpy( ADR(S44ParRead.Parameters[61].ChannelName) , ADR('TDC1_Input') );
strcpy( ADR(S44ParRead.Parameters[62].ChannelName) , ADR('JOG_Input') );
strcpy( ADR(S44ParRead.Parameters[63].ChannelName) , ADR('PS2_Input') );
strcpy( ADR(S44ParRead.Parameters[64].ChannelName) , ADR('PS4_Input') );
strcpy( ADR(S44ParRead.Parameters[65].ChannelName) , ADR('PS8_Input') );
strcpy( ADR(S44ParRead.Parameters[66].ChannelName) , ADR('SP2_Input') );
strcpy( ADR(S44ParRead.Parameters[67].ChannelName) , ADR('SP3_Input') );
strcpy( ADR(S44ParRead.Parameters[68].ChannelName) , ADR('SP4_Input') );
strcpy( ADR(S44ParRead.Parameters[69].ChannelName) , ADR('SP5_Input') );
strcpy( ADR(S44ParRead.Parameters[70].ChannelName) , ADR('SP6_Input') );
strcpy( ADR(S44ParRead.Parameters[71].ChannelName) , ADR('SP7_Input') );
strcpy( ADR(S44ParRead.Parameters[72].ChannelName) , ADR('SP8_Input') );
strcpy( ADR(S44ParRead.Parameters[73].ChannelName) , ADR('JPF_Input') );
strcpy( ADR(S44ParRead.Parameters[74].ChannelName) , ADR('PIF_Input') );
strcpy( ADR(S44ParRead.Parameters[75].ChannelName) , ADR('RPG_Input') );
strcpy( ADR(S44ParRead.Parameters[76].ChannelName) , ADR('RIG_Input') );
strcpy( ADR(S44ParRead.Parameters[77].ChannelName) , ADR('RDG_Input') );
strcpy( ADR(S44ParRead.Parameters[78].ChannelName) , ADR('FBS_Input') );
strcpy( ADR(S44ParRead.Parameters[79].ChannelName) , ADR('PII_Input') );
strcpy( ADR(S44ParRead.Parameters[80].ChannelName) , ADR('PR2_Input') );
strcpy( ADR(S44ParRead.Parameters[81].ChannelName) , ADR('PR4_Input') );
strcpy( ADR(S44ParRead.Parameters[82].ChannelName) , ADR('RP2_Input') );
strcpy( ADR(S44ParRead.Parameters[83].ChannelName) , ADR('RP3_Input') );
strcpy( ADR(S44ParRead.Parameters[84].ChannelName) , ADR('RP4_Input') );
strcpy( ADR(S44ParRead.Parameters[85].ChannelName) , ADR('RPI_Input') );
strcpy( ADR(S44ParRead.Parameters[86].ChannelName) , ADR('PRP_Input') );
strcpy( ADR(S44ParRead.Parameters[87].ChannelName) , ADR('RPL_Input') );
strcpy( ADR(S44ParRead.Parameters[88].ChannelName) , ADR('RPH_Input') );
strcpy( ADR(S44ParRead.Parameters[89].ChannelName) , ADR('SFS_Input') );
strcpy( ADR(S44ParRead.Parameters[90].ChannelName) , ADR('PIC_Input') );
strcpy( ADR(S44ParRead.Parameters[91].ChannelName) , ADR('PAU_Input') );
strcpy( ADR(S44ParRead.Parameters[92].ChannelName) , ADR('PIM_Input') );
strcpy( ADR(S44ParRead.Parameters[93].ChannelName) , ADR('RSL_Input') );
strcpy( ADR(S44ParRead.Parameters[94].ChannelName) , ADR('UPP_Input') );
strcpy( ADR(S44ParRead.Parameters[95].ChannelName) , ADR('LC2_Input') );
strcpy( ADR(S44ParRead.Parameters[96].ChannelName) , ADR('CLI_Input') );
strcpy( ADR(S44ParRead.Parameters[97].ChannelName) , ADR('CL2_Input') );
strcpy( ADR(S44ParRead.Parameters[98].ChannelName) , ADR('TLS_Input') );
strcpy( ADR(S44ParRead.Parameters[99].ChannelName) , ADR('SH2_Input') );
strcpy( ADR(S44ParRead.Parameters[100].ChannelName) , ADR('SH4_Input') );
strcpy( ADR(S44ParRead.Parameters[101].ChannelName) , ADR('HSP2_Input') );
strcpy( ADR(S44ParRead.Parameters[102].ChannelName) , ADR('HSP3_Input') );
strcpy( ADR(S44ParRead.Parameters[103].ChannelName) , ADR('HSP4_Input') );
strcpy( ADR(S44ParRead.Parameters[104].ChannelName) , ADR('RSF_Input') );
strcpy( ADR(S44ParRead.Parameters[105].ChannelName) , ADR('ATR_Input') );
strcpy( ADR(S44ParRead.Parameters[106].ChannelName) , ADR('TAR_Input') );
strcpy( ADR(S44ParRead.Parameters[107].ChannelName) , ADR('FLR_Input') );
strcpy( ADR(S44ParRead.Parameters[108].ChannelName) , ADR('ITH_Input') );
strcpy( ADR(S44ParRead.Parameters[109].ChannelName) , ADR('THT_Input') );
strcpy( ADR(S44ParRead.Parameters[110].ChannelName) , ADR('OLL_Input') );
strcpy( ADR(S44ParRead.Parameters[111].ChannelName) , ADR('MTM_Input') );
strcpy( ADR(S44ParRead.Parameters[112].ChannelName) , ADR('OPL_Input') );
strcpy( ADR(S44ParRead.Parameters[113].ChannelName) , ADR('IPL_Input') );
strcpy( ADR(S44ParRead.Parameters[114].ChannelName) , ADR('USB_Input') );
strcpy( ADR(S44ParRead.Parameters[115].ChannelName) , ADR('STP_Input') );
strcpy( ADR(S44ParRead.Parameters[116].ChannelName) , ADR('STM_Input') );
strcpy( ADR(S44ParRead.Parameters[117].ChannelName) , ADR('STRT_Input') );
strcpy( ADR(S44ParRead.Parameters[118].ChannelName) , ADR('LFL_Input') );
strcpy( ADR(S44ParRead.Parameters[119].ChannelName) , ADR('INH_Input') );
strcpy( ADR(S44ParRead.Parameters[120].ChannelName) , ADR('SLL_Input') );
strcpy( ADR(S44ParRead.Parameters[121].ChannelName) , ADR('DRN_Input') );
strcpy( ADR(S44ParRead.Parameters[122].ChannelName) , ADR('TTO_Input') );



END_PROGRAM

