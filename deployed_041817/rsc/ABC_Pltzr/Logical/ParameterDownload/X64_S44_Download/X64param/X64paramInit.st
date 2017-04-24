(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: X64param
 * File: X64paramInit.st
 * Author: scoccimaroj
 * Created: July 14, 2010
 ********************************************************************
 * Implementation of program X64param
 ********************************************************************)

PROGRAM _INIT


strcpy( ADR(X64ParRead.pDevice) , ADR('IF5.ST9') );
AsIOAccRead_0.pDeviceName := ADR(X64ParRead.pDevice);
strcpy( ADR(X64ParRead.FileDevice), ADR('CONFIG') );
 
 
 (* Initialize the CSV file writing operation *)
 strcpy( ADR(X64ParRead.CsvFileName), ADR(X64ParRead.pDevice) );
 
 
 FOR i:= 0 TO 10 BY 1 DO
 	position := FIND(X64ParRead.CsvFileName, '.');
	
	IF (position <> 0) THEN
 		X64ParRead.CsvFileName := REPLACE(X64ParRead.CsvFileName, '_', 1, position);
	END_IF	
		
 END_FOR 
  
 
 strcat( ADR(X64ParRead.CsvFileName), ADR('.csv') ); 
 
 
 pNames[0] := ADR('X64ParRead');
 
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
strcpy( ADR(X64ParRead.Parameters[0].ChannelName) , ADR('ACC_Input') );
strcpy( ADR(X64ParRead.Parameters[1].ChannelName) , ADR('DEC_Input') );
strcpy( ADR(X64ParRead.Parameters[2].ChannelName) , ADR('LSP_Input') );
strcpy( ADR(X64ParRead.Parameters[3].ChannelName) , ADR('HSP_Input') );
strcpy( ADR(X64ParRead.Parameters[4].ChannelName) , ADR('ITH_Input') );
strcpy( ADR(X64ParRead.Parameters[5].ChannelName) , ADR('UFR_Input') );
strcpy( ADR(X64ParRead.Parameters[6].ChannelName) , ADR('FLG_Input') );
strcpy( ADR(X64ParRead.Parameters[7].ChannelName) , ADR('STA_Input') );
strcpy( ADR(X64ParRead.Parameters[8].ChannelName) , ADR('SLP_Input') );
strcpy( ADR(X64ParRead.Parameters[9].ChannelName) , ADR('JPF_Input') );
strcpy( ADR(X64ParRead.Parameters[10].ChannelName) , ADR('JF2_Input') );
strcpy( ADR(X64ParRead.Parameters[11].ChannelName) , ADR('CLI_Input') );
strcpy( ADR(X64ParRead.Parameters[12].ChannelName) , ADR('TLS_Input') );
strcpy( ADR(X64ParRead.Parameters[13].ChannelName) , ADR('FTD_Input') );
strcpy( ADR(X64ParRead.Parameters[14].ChannelName) , ADR('TTD_Input') );
strcpy( ADR(X64ParRead.Parameters[15].ChannelName) , ADR('CTD_Input') );
strcpy( ADR(X64ParRead.Parameters[16].ChannelName) , ADR('SDS_Input') );
strcpy( ADR(X64ParRead.Parameters[17].ChannelName) , ADR('BFR_Input') );
strcpy( ADR(X64ParRead.Parameters[18].ChannelName) , ADR('UNS_Input') );
strcpy( ADR(X64ParRead.Parameters[19].ChannelName) , ADR('FRS_Input') );
strcpy( ADR(X64ParRead.Parameters[20].ChannelName) , ADR('NCR_Input') );
strcpy( ADR(X64ParRead.Parameters[21].ChannelName) , ADR('NSP_Input') );
strcpy( ADR(X64ParRead.Parameters[22].ChannelName) , ADR('COS_Input') );
strcpy( ADR(X64ParRead.Parameters[23].ChannelName) , ADR('RSC_Input') );
strcpy( ADR(X64ParRead.Parameters[24].ChannelName) , ADR('TUN_Input') );
strcpy( ADR(X64ParRead.Parameters[25].ChannelName) , ADR('UFT_Input') );
strcpy( ADR(X64ParRead.Parameters[26].ChannelName) , ADR('NRD_Input') );
strcpy( ADR(X64ParRead.Parameters[27].ChannelName) , ADR('SFR_Input') );
strcpy( ADR(X64ParRead.Parameters[28].ChannelName) , ADR('TFR_Input') );
strcpy( ADR(X64ParRead.Parameters[29].ChannelName) , ADR('SRF_Input') );
strcpy( ADR(X64ParRead.Parameters[30].ChannelName) , ADR('TCC_Input') );
strcpy( ADR(X64ParRead.Parameters[31].ChannelName) , ADR('TCT_Input') );
strcpy( ADR(X64ParRead.Parameters[32].ChannelName) , ADR('RRS_Input') );
strcpy( ADR(X64ParRead.Parameters[33].ChannelName) , ADR('R2_Input') );
strcpy( ADR(X64ParRead.Parameters[34].ChannelName) , ADR('LAC_Input') );
strcpy( ADR(X64ParRead.Parameters[35].ChannelName) , ADR('FR1_Input') );
strcpy( ADR(X64ParRead.Parameters[36].ChannelName) , ADR('FR2_Input') );
strcpy( ADR(X64ParRead.Parameters[37].ChannelName) , ADR('RFC_Input') );
strcpy( ADR(X64ParRead.Parameters[38].ChannelName) , ADR('CHCF_Input') );
strcpy( ADR(X64ParRead.Parameters[39].ChannelName) , ADR('CD1_Input') );
strcpy( ADR(X64ParRead.Parameters[40].ChannelName) , ADR('CD2_Input') );
strcpy( ADR(X64ParRead.Parameters[41].ChannelName) , ADR('CCS_Input') );
strcpy( ADR(X64ParRead.Parameters[42].ChannelName) , ADR('COP_Input') );
strcpy( ADR(X64ParRead.Parameters[43].ChannelName) , ADR('PST_Input') );
strcpy( ADR(X64ParRead.Parameters[44].ChannelName) , ADR('ROT_Input') );
strcpy( ADR(X64ParRead.Parameters[45].ChannelName) , ADR('RPT_Input') );
strcpy( ADR(X64ParRead.Parameters[46].ChannelName) , ADR('TA1_Input') );
strcpy( ADR(X64ParRead.Parameters[47].ChannelName) , ADR('TA2_Input') );
strcpy( ADR(X64ParRead.Parameters[48].ChannelName) , ADR('TA3_Input') );
strcpy( ADR(X64ParRead.Parameters[49].ChannelName) , ADR('TA4_Input') );
strcpy( ADR(X64ParRead.Parameters[50].ChannelName) , ADR('INR_Input') );
strcpy( ADR(X64ParRead.Parameters[51].ChannelName) , ADR('RPS_Input') );
strcpy( ADR(X64ParRead.Parameters[52].ChannelName) , ADR('FRT_Input') );
strcpy( ADR(X64ParRead.Parameters[53].ChannelName) , ADR('AC2_Input') );
strcpy( ADR(X64ParRead.Parameters[54].ChannelName) , ADR('DE2_Input') );
strcpy( ADR(X64ParRead.Parameters[55].ChannelName) , ADR('BRA_Input') );
strcpy( ADR(X64ParRead.Parameters[56].ChannelName) , ADR('STT_Input') );
strcpy( ADR(X64ParRead.Parameters[57].ChannelName) , ADR('FST_Input') );
strcpy( ADR(X64ParRead.Parameters[58].ChannelName) , ADR('DCF_Input') );
strcpy( ADR(X64ParRead.Parameters[59].ChannelName) , ADR('DCI_Input') );
strcpy( ADR(X64ParRead.Parameters[60].ChannelName) , ADR('IDC_Input') );
strcpy( ADR(X64ParRead.Parameters[61].ChannelName) , ADR('TDC_Input') );
strcpy( ADR(X64ParRead.Parameters[62].ChannelName) , ADR('NST_Input') );
strcpy( ADR(X64ParRead.Parameters[63].ChannelName) , ADR('ADC_Input') );
strcpy( ADR(X64ParRead.Parameters[64].ChannelName) , ADR('TDC1_Input') );
strcpy( ADR(X64ParRead.Parameters[65].ChannelName) , ADR('SDC1_Input') );
strcpy( ADR(X64ParRead.Parameters[66].ChannelName) , ADR('TDC2_Input') );
strcpy( ADR(X64ParRead.Parameters[67].ChannelName) , ADR('SDC2_Input') );
strcpy( ADR(X64ParRead.Parameters[68].ChannelName) , ADR('SA2_Input') );
strcpy( ADR(X64ParRead.Parameters[69].ChannelName) , ADR('SA3_Input') );
strcpy( ADR(X64ParRead.Parameters[70].ChannelName) , ADR('PS2_Input') );
strcpy( ADR(X64ParRead.Parameters[71].ChannelName) , ADR('PS4_Input') );
strcpy( ADR(X64ParRead.Parameters[72].ChannelName) , ADR('PS8_Input') );
strcpy( ADR(X64ParRead.Parameters[73].ChannelName) , ADR('PS16_Input') );
strcpy( ADR(X64ParRead.Parameters[74].ChannelName) , ADR('SP2_Input') );
strcpy( ADR(X64ParRead.Parameters[75].ChannelName) , ADR('SP3_Input') );
strcpy( ADR(X64ParRead.Parameters[76].ChannelName) , ADR('SP4_Input') );
strcpy( ADR(X64ParRead.Parameters[77].ChannelName) , ADR('SP5_Input') );
strcpy( ADR(X64ParRead.Parameters[78].ChannelName) , ADR('SP6_Input') );
strcpy( ADR(X64ParRead.Parameters[79].ChannelName) , ADR('SP7_Input') );
strcpy( ADR(X64ParRead.Parameters[80].ChannelName) , ADR('SP8_Input') );
strcpy( ADR(X64ParRead.Parameters[81].ChannelName) , ADR('SP9_Input') );
strcpy( ADR(X64ParRead.Parameters[82].ChannelName) , ADR('SP10_Input') );
strcpy( ADR(X64ParRead.Parameters[83].ChannelName) , ADR('SP11_Input') );
strcpy( ADR(X64ParRead.Parameters[84].ChannelName) , ADR('SP12_Input') );
strcpy( ADR(X64ParRead.Parameters[85].ChannelName) , ADR('SP13_Input') );
strcpy( ADR(X64ParRead.Parameters[86].ChannelName) , ADR('SP14_Input') );
strcpy( ADR(X64ParRead.Parameters[87].ChannelName) , ADR('SP15_Input') );
strcpy( ADR(X64ParRead.Parameters[88].ChannelName) , ADR('SP16_Input') );
strcpy( ADR(X64ParRead.Parameters[89].ChannelName) , ADR('JOG_Input') );
strcpy( ADR(X64ParRead.Parameters[90].ChannelName) , ADR('JGF_Input') );
strcpy( ADR(X64ParRead.Parameters[91].ChannelName) , ADR('USP_Input') );
strcpy( ADR(X64ParRead.Parameters[92].ChannelName) , ADR('DSP_Input') );
strcpy( ADR(X64ParRead.Parameters[93].ChannelName) , ADR('STR_Input') );
strcpy( ADR(X64ParRead.Parameters[94].ChannelName) , ADR('BLC_Input') );
strcpy( ADR(X64ParRead.Parameters[95].ChannelName) , ADR('BRL_Input') );
strcpy( ADR(X64ParRead.Parameters[96].ChannelName) , ADR('IBR_Input') );
strcpy( ADR(X64ParRead.Parameters[97].ChannelName) , ADR('BRT_Input') );
strcpy( ADR(X64ParRead.Parameters[98].ChannelName) , ADR('BEN_Input') );
strcpy( ADR(X64ParRead.Parameters[99].ChannelName) , ADR('BET_Input') );
strcpy( ADR(X64ParRead.Parameters[100].ChannelName) , ADR('BIP_Input') );
strcpy( ADR(X64ParRead.Parameters[101].ChannelName) , ADR('LC2_Input') );
strcpy( ADR(X64ParRead.Parameters[102].ChannelName) , ADR('CL2_Input') );
strcpy( ADR(X64ParRead.Parameters[103].ChannelName) , ADR('CHP_Input') );
strcpy( ADR(X64ParRead.Parameters[104].ChannelName) , ADR('UNS2_Input') );
strcpy( ADR(X64ParRead.Parameters[105].ChannelName) , ADR('FRS2_Input') );
strcpy( ADR(X64ParRead.Parameters[106].ChannelName) , ADR('NCR2_Input') );
strcpy( ADR(X64ParRead.Parameters[107].ChannelName) , ADR('NSP2_Input') );
strcpy( ADR(X64ParRead.Parameters[108].ChannelName) , ADR('COS2_Input') );
strcpy( ADR(X64ParRead.Parameters[109].ChannelName) , ADR('UFT2_Input') );
strcpy( ADR(X64ParRead.Parameters[110].ChannelName) , ADR('UFR2_Input') );
strcpy( ADR(X64ParRead.Parameters[111].ChannelName) , ADR('FLG2_Input') );
strcpy( ADR(X64ParRead.Parameters[112].ChannelName) , ADR('STA2_Input') );
strcpy( ADR(X64ParRead.Parameters[113].ChannelName) , ADR('SLP2_Input') );
strcpy( ADR(X64ParRead.Parameters[114].ChannelName) , ADR('LAF_Input') );
strcpy( ADR(X64ParRead.Parameters[115].ChannelName) , ADR('LAR_Input') );
strcpy( ADR(X64ParRead.Parameters[116].ChannelName) , ADR('LAS_Input') );
strcpy( ADR(X64ParRead.Parameters[117].ChannelName) , ADR('ATR_Input') );
strcpy( ADR(X64ParRead.Parameters[118].ChannelName) , ADR('TAR_Input') );
strcpy( ADR(X64ParRead.Parameters[119].ChannelName) , ADR('RSF_Input') );
strcpy( ADR(X64ParRead.Parameters[120].ChannelName) , ADR('FLR_Input') );
strcpy( ADR(X64ParRead.Parameters[121].ChannelName) , ADR('ETF_Input') );
strcpy( ADR(X64ParRead.Parameters[122].ChannelName) , ADR('LET_Input') );
strcpy( ADR(X64ParRead.Parameters[123].ChannelName) , ADR('EPL_Input') );
strcpy( ADR(X64ParRead.Parameters[124].ChannelName) , ADR('OPL_Input') );
strcpy( ADR(X64ParRead.Parameters[125].ChannelName) , ADR('IPL_Input') );
strcpy( ADR(X64ParRead.Parameters[126].ChannelName) , ADR('OHL_Input') );
strcpy( ADR(X64ParRead.Parameters[127].ChannelName) , ADR('OLL_Input') );
strcpy( ADR(X64ParRead.Parameters[128].ChannelName) , ADR('COL_Input') );
strcpy( ADR(X64ParRead.Parameters[129].ChannelName) , ADR('TNL_Input') );
strcpy( ADR(X64ParRead.Parameters[130].ChannelName) , ADR('LFF_Input') );
strcpy( ADR(X64ParRead.Parameters[131].ChannelName) , ADR('DRN_Input') );
strcpy( ADR(X64ParRead.Parameters[132].ChannelName) , ADR('STP_Input') );
strcpy( ADR(X64ParRead.Parameters[133].ChannelName) , ADR('INH_Input') );
strcpy( ADR(X64ParRead.Parameters[134].ChannelName) , ADR('FLO_Input') );
strcpy( ADR(X64ParRead.Parameters[135].ChannelName) , ADR('FLOC_Input') );
strcpy( ADR(X64ParRead.Parameters[136].ChannelName) , ADR('COD_Input') );
strcpy( ADR(X64ParRead.Parameters[137].ChannelName) , ADR('DO_Input') );



END_PROGRAM

