(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: P84param
 * File: P84paramInit.st
 * Author: scoccimaroj
 * Created: July 14, 2010
 ********************************************************************
 * Implementation of program P84param
 ********************************************************************)

PROGRAM _INIT

 	
 P84ParRead.NodeNr := 1;
 strcpy( ADR(P84ParRead.pDevice), ADR('IF3.ST1') ); 
 strcpy( ADR(P84ParRead.FileDevice), ADR('DISK') );
 
 
 (* Initialize the CSV file writing operation *)
 strcpy( ADR(P84ParRead.CsvFileName), ADR(P84ParRead.pDevice) );
 
 
 FOR i:= 0 TO 10 BY 1 DO
 	position := FIND(P84ParRead.CsvFileName, '.');
	
	IF (position <> 0) THEN
 		P84ParRead.CsvFileName := REPLACE(P84ParRead.CsvFileName, '_', 1, position);
	END_IF	
		
 END_FOR 
  
 
 strcat( ADR(P84ParRead.CsvFileName), ADR('.csv') ); 
 
 
 pNames[0] := ADR('P84ParRead');
 
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
 
 
 (* Initializing the parameter structure - 362 parameters *)
 P84ParRead.Parameters[0].Index := 16#203C; (* INR *)
 P84ParRead.Parameters[0].Subindex := 15;	
 
 P84ParRead.Parameters[1].Index := 16#203C; (* ACC *)
 P84ParRead.Parameters[1].Subindex := 2;	
 
 P84ParRead.Parameters[2].Index := 16#203C; (* DEC *)
 P84ParRead.Parameters[2].Subindex := 3;	
 
 P84ParRead.Parameters[3].Index := 16#2001; (* LSP *)
 P84ParRead.Parameters[3].Subindex := 6;	
 
 P84ParRead.Parameters[4].Index := 16#2001; (* HSP *)
 P84ParRead.Parameters[4].Subindex := 5;	
 
 P84ParRead.Parameters[5].Index := 16#2042; (* ITH *)
 P84ParRead.Parameters[5].Subindex := 17;	
 
 P84ParRead.Parameters[6].Index := 16#203D; (* SPG *)
 P84ParRead.Parameters[6].Subindex := 4;	
 
 P84ParRead.Parameters[7].Index := 16#203D; (* SIT *)
 P84ParRead.Parameters[7].Subindex := 5;	

 P84ParRead.Parameters[8].Index := 16#203D; (* SFC *)
 P84ParRead.Parameters[8].Subindex := 6;	
 
 P84ParRead.Parameters[9].Index := 16#2001; (* SFR *)
 P84ParRead.Parameters[9].Subindex := 3;	
 
 P84ParRead.Parameters[10].Index := 16#203E; (* CLI *)
 P84ParRead.Parameters[10].Subindex := 2;	
 
 P84ParRead.Parameters[11].Index := 16#206D; (* FLU *)
 P84ParRead.Parameters[11].Subindex := 3;	
 
 P84ParRead.Parameters[12].Index := 16#2057; (* TLS *)
 P84ParRead.Parameters[12].Subindex := 2;	
 
 P84ParRead.Parameters[13].Index := 16#2058; (* MFR *)
 P84ParRead.Parameters[13].Subindex := 20;	
 
 P84ParRead.Parameters[14].Index := 16#2050; (* CTD *)
 P84ParRead.Parameters[14].Subindex := 2;	
 
 P84ParRead.Parameters[15].Index := 16#2050; (* TTH *)
 P84ParRead.Parameters[15].Subindex := 11;	
 
 P84ParRead.Parameters[16].Index := 16#2050; (* TTL *)
 P84ParRead.Parameters[16].Subindex := 10;	
 
 P84ParRead.Parameters[17].Index := 16#2050; (* FTD *)
 P84ParRead.Parameters[17].Subindex := 4;	
 
 P84ParRead.Parameters[18].Index := 16#2050; (* F2D *)
 P84ParRead.Parameters[18].Subindex := 5;	
 
 P84ParRead.Parameters[19].Index := 16#2053; (* JPF *)
 P84ParRead.Parameters[19].Subindex := 2;	
 
 P84ParRead.Parameters[20].Index := 16#2053; (* JF2 *)
 P84ParRead.Parameters[20].Subindex := 3;	
 
 P84ParRead.Parameters[21].Index := 16#2053; (* JF3 *)
 P84ParRead.Parameters[21].Subindex := 4;	
 
 P84ParRead.Parameters[22].Index := 16#2053; (* JFH *)
 P84ParRead.Parameters[22].Subindex := 16#C;	
 
 P84ParRead.Parameters[23].Index := 16#2000; (* BFR  *)
 P84ParRead.Parameters[23].Subindex := 10;	
 
 P84ParRead.Parameters[24].Index := 16#2042; (* NPR *)
 P84ParRead.Parameters[24].Subindex := 16#E;	
 
 P84ParRead.Parameters[25].Index := 16#2042; (* UNS *)
 P84ParRead.Parameters[25].Subindex := 2;	
 
 P84ParRead.Parameters[26].Index := 16#2042; (* NCR *)
 P84ParRead.Parameters[26].Subindex := 4;	
 
 P84ParRead.Parameters[27].Index := 16#2042; (* FRS *)
 P84ParRead.Parameters[27].Subindex := 3;	
 
 P84ParRead.Parameters[28].Index := 16#2042; (* INSP *)
 P84ParRead.Parameters[28].Subindex := 1;	
 
 P84ParRead.Parameters[29].Index := 16#2042; (* NSP *)
 P84ParRead.Parameters[29].Subindex := 5;	
 
 P84ParRead.Parameters[30].Index := 16#2001; (* TFR *)
 P84ParRead.Parameters[30].Subindex := 4;	
 
 P84ParRead.Parameters[31].Index := 16#2042; (* AUT *)
 P84ParRead.Parameters[31].Subindex := 10;	
 
 P84ParRead.Parameters[32].Index := 16#2042; (* CTT *)
 P84ParRead.Parameters[32].Subindex := 8;	
 
 P84ParRead.Parameters[33].Index := 16#205E; (* U0 *)
 P84ParRead.Parameters[33].Subindex := 2;	
 
 P84ParRead.Parameters[34].Index := 16#205E; (* U1 *)
 P84ParRead.Parameters[34].Subindex := 4;	
 
 P84ParRead.Parameters[35].Index := 16#205E; (* F1 *)
 P84ParRead.Parameters[35].Subindex := 5;	
 
 P84ParRead.Parameters[36].Index := 16#205E; (* U2 *)
 P84ParRead.Parameters[36].Subindex := 6;	
 
 P84ParRead.Parameters[37].Index := 16#205E; (* F2 *)
 P84ParRead.Parameters[37].Subindex := 7;	
 
 P84ParRead.Parameters[38].Index := 16#205E; (* U3 *)
 P84ParRead.Parameters[38].Subindex := 8;	
 
 P84ParRead.Parameters[39].Index := 16#205E; (* F3 *)
 P84ParRead.Parameters[39].Subindex := 9;	
 
 P84ParRead.Parameters[40].Index := 16#205E; (* U4 *)
 P84ParRead.Parameters[40].Subindex := 16#A;	
 
 P84ParRead.Parameters[41].Index := 16#205E; (* F4 *)
 P84ParRead.Parameters[41].Subindex := 16#B;	
 
 P84ParRead.Parameters[42].Index := 16#205E; (* U5 *)
 P84ParRead.Parameters[42].Subindex := 16#C;	
 
 P84ParRead.Parameters[43].Index := 16#205E; (* F5 *)
 P84ParRead.Parameters[43].Subindex := 16#D;	
 
 P84ParRead.Parameters[44].Index := 16#2070; (* VC2 *)
 P84ParRead.Parameters[44].Subindex := 2;	
 
 P84ParRead.Parameters[45].Index := 16#2070; (* UCP *)
 P84ParRead.Parameters[45].Subindex := 3;	
 
 P84ParRead.Parameters[46].Index := 16#2070; (* FCP *)
 P84ParRead.Parameters[46].Subindex := 4;	
 
 P84ParRead.Parameters[47].Index := 16#2042; (* UFR *)
 P84ParRead.Parameters[47].Subindex := 16#18;	
 
 P84ParRead.Parameters[48].Index := 16#2042; (* SLP *)
 P84ParRead.Parameters[48].Subindex := 16#1A;	
 
 P84ParRead.Parameters[49].Index := 16#205B; (* ENA *)
 P84ParRead.Parameters[49].Subindex := 2;	
 
 P84ParRead.Parameters[50].Index := 16#205B; (* GPE *)
 P84ParRead.Parameters[50].Subindex := 4;	
 
 P84ParRead.Parameters[51].Index := 16#205B; (* GIE *)
 P84ParRead.Parameters[51].Subindex := 5;	
 
 P84ParRead.Parameters[52].Index := 16#205B; (* RAP *)
 P84ParRead.Parameters[52].Subindex := 6;	
 
 P84ParRead.Parameters[53].Index := 16#2001; (* OFI *)
 P84ParRead.Parameters[53].Subindex := 16#A;	
 
 P84ParRead.Parameters[54].Index := 16#2001; (* NRD *)
 P84ParRead.Parameters[54].Subindex := 8;	
 
 P84ParRead.Parameters[55].Index := 16#2060; (* SVL *)
 P84ParRead.Parameters[55].Subindex := 2;	
 
 P84ParRead.Parameters[56].Index := 16#2060; (* SOP *)
 P84ParRead.Parameters[56].Subindex := 3;	
 
 P84ParRead.Parameters[57].Index := 16#206F; (* VBR *)
 P84ParRead.Parameters[57].Subindex := 2;	
 
 P84ParRead.Parameters[58].Index := 16#206F; (* BBA *)
 P84ParRead.Parameters[58].Subindex := 3;	
 
 P84ParRead.Parameters[59].Index := 16#2071; (* LBA *)
 P84ParRead.Parameters[59].Subindex := 2;	
 
 P84ParRead.Parameters[60].Index := 16#2071; (* LBC *)
 P84ParRead.Parameters[60].Subindex := 3;	
 
 P84ParRead.Parameters[61].Index := 16#2071; (* LBC1 *)
 P84ParRead.Parameters[61].Subindex := 4;	
 
 P84ParRead.Parameters[62].Index := 16#2071; (* LBC2 *)
 P84ParRead.Parameters[62].Subindex := 5;	
 
 P84ParRead.Parameters[63].Index := 16#2071; (* LBC3 *)
 P84ParRead.Parameters[63].Subindex := 6;	
 
 P84ParRead.Parameters[64].Index := 16#2071; (* LBF *)
 P84ParRead.Parameters[64].Subindex := 7;	
 
 P84ParRead.Parameters[65].Index := 16#2051; (* TCC *)
 P84ParRead.Parameters[65].Subindex := 2;	
 
 P84ParRead.Parameters[66].Index := 16#2051; (* TCT *)
 P84ParRead.Parameters[66].Subindex := 3;	
 
 P84ParRead.Parameters[67].Index := 16#2051; (* RRS *)
 P84ParRead.Parameters[67].Subindex := 6;	
 
 P84ParRead.Parameters[68].Index := 16#200A; (* L1D *)
 P84ParRead.Parameters[68].Subindex := 2;	
 
 P84ParRead.Parameters[69].Index := 16#200A; (* L2D *)
 P84ParRead.Parameters[69].Subindex := 3;	
 
 P84ParRead.Parameters[70].Index := 16#200A; (* L3D *)
 P84ParRead.Parameters[70].Subindex := 4;	
 
 P84ParRead.Parameters[71].Index := 16#200A; (* L4D *)
 P84ParRead.Parameters[71].Subindex := 5;	
 
 P84ParRead.Parameters[72].Index := 16#200A; (* L6D *)
 P84ParRead.Parameters[72].Subindex := 7;	
 
 P84ParRead.Parameters[73].Index := 16#2001; (* BSP *)
 P84ParRead.Parameters[73].Subindex := 7;	
 
 P84ParRead.Parameters[74].Index := 16#200E; (* AI1T *)
 P84ParRead.Parameters[74].Subindex := 3;	
 
 P84ParRead.Parameters[75].Index := 16#200E; (* UIL1 *)
 P84ParRead.Parameters[75].Subindex := 16#D;	
 
 P84ParRead.Parameters[76].Index := 16#200E; (* AI1F *)
 P84ParRead.Parameters[76].Subindex := 16#35;	
 
 P84ParRead.Parameters[77].Index := 16#200E; (* AI1E *)
 P84ParRead.Parameters[77].Subindex := 16#3F;	
 
 P84ParRead.Parameters[78].Index := 16#200E; (* AI1S *)
 P84ParRead.Parameters[78].Subindex := 16#49;	
 
 P84ParRead.Parameters[79].Index := 16#200E; (* AI2T *)
 P84ParRead.Parameters[79].Subindex := 4;	
 
 P84ParRead.Parameters[80].Index := 16#200E; (* CRL2 *)
 P84ParRead.Parameters[80].Subindex := 16#22;	
 
 P84ParRead.Parameters[81].Index := 16#200E; (* UIL2 *)
 P84ParRead.Parameters[81].Subindex := 16#E;	
 
 P84ParRead.Parameters[82].Index := 16#200E; (* CRH2 *)
 P84ParRead.Parameters[82].Subindex := 16#2C;	
 
 P84ParRead.Parameters[83].Index := 16#200E; (* UIH2 *)
 P84ParRead.Parameters[83].Subindex := 16#18;	
 
 P84ParRead.Parameters[84].Index := 16#200E; (* AI2F *)
 P84ParRead.Parameters[84].Subindex := 16#36;	
 
 P84ParRead.Parameters[85].Index := 16#200E; (* AI2L *)
 P84ParRead.Parameters[85].Subindex := 16#54;	
 
 P84ParRead.Parameters[86].Index := 16#200E; (* AI2E *)
 P84ParRead.Parameters[86].Subindex := 16#40;	
 
 P84ParRead.Parameters[87].Index := 16#200E; (* AI2S *)	 
 P84ParRead.Parameters[87].Subindex := 16#4A;	
 
 P84ParRead.Parameters[88].Index := 16#201A; (* ENS *)
 P84ParRead.Parameters[88].Subindex := 9;	
 
 P84ParRead.Parameters[89].Index := 16#201A; (* ENC *)
 P84ParRead.Parameters[89].Subindex := 6;	
 
 P84ParRead.Parameters[90].Index := 16#201A; (* ENU *)
 P84ParRead.Parameters[90].Subindex := 7;	
 
 P84ParRead.Parameters[91].Index := 16#201A; (* PGI *)
 P84ParRead.Parameters[91].Subindex := 5;	
 
 P84ParRead.Parameters[92].Index := 16#2067; (* PGA *)
 P84ParRead.Parameters[92].Subindex := 2;	
 
 P84ParRead.Parameters[93].Index := 16#2067; (* EIL *)
 P84ParRead.Parameters[93].Subindex := 16#B;	
 
 P84ParRead.Parameters[94].Index := 16#2067; (* EFR *)
 P84ParRead.Parameters[94].Subindex := 16#C;	
 
 P84ParRead.Parameters[95].Index := 16#2067; (* EFI *)
 P84ParRead.Parameters[95].Subindex := 16#D;	
 
 P84ParRead.Parameters[96].Index := 16#2014; (* R1 *)
 P84ParRead.Parameters[96].Subindex := 2;	
 
 P84ParRead.Parameters[97].Index := 16#200C; (* R1D *)
 P84ParRead.Parameters[97].Subindex := 16#2A;	
 
 P84ParRead.Parameters[98].Index := 16#200C; (* R1S *)
 P84ParRead.Parameters[98].Subindex := 2;	
 
 P84ParRead.Parameters[99].Index := 16#200C; (* R1H *)
 P84ParRead.Parameters[99].Subindex := 16#16;	
 
 P84ParRead.Parameters[100].Index := 16#2014; (* R2 *)
 P84ParRead.Parameters[100].Subindex := 3;	
 
 P84ParRead.Parameters[101].Index := 16#200C; (* R2D *)
 P84ParRead.Parameters[101].Subindex := 16#2B;	
 
 P84ParRead.Parameters[102].Index := 16#200C; (* R2S *)
 P84ParRead.Parameters[102].Subindex := 3;	
 
 P84ParRead.Parameters[103].Index := 16#200C; (* R2H *)
 P84ParRead.Parameters[103].Subindex := 16#17;	
 
 P84ParRead.Parameters[104].Index := 16#2014; (* DO1 *)
 P84ParRead.Parameters[104].Subindex := 16#20;	
 
 P84ParRead.Parameters[105].Index := 16#200C; (* DO1D *)
 P84ParRead.Parameters[105].Subindex := 16#52;	
 
 P84ParRead.Parameters[106].Index := 16#200C; (* DO1S *)
 P84ParRead.Parameters[106].Subindex := 16#3E;	
 
 P84ParRead.Parameters[107].Index := 16#200C; (* DO1H *)
 P84ParRead.Parameters[107].Subindex := 16#48;	
 
 P84ParRead.Parameters[108].Index := 16#2014; (* AO1 *)
 P84ParRead.Parameters[108].Subindex := 16#16;	
 
 P84ParRead.Parameters[109].Index := 16#2010; (* AO1T *)
 P84ParRead.Parameters[109].Subindex := 2;	
 
 P84ParRead.Parameters[110].Index := 16#2010; (* AOL1 *)
 P84ParRead.Parameters[110].Subindex := 16#2A;	
 
 P84ParRead.Parameters[111].Index := 16#2010; (* AOH1 *)
 P84ParRead.Parameters[111].Subindex := 16#34;	
 
 P84ParRead.Parameters[112].Index := 16#2010; (* UOL1 *)
 P84ParRead.Parameters[112].Subindex := 16#16;	
 
 P84ParRead.Parameters[113].Index := 16#2010; (* UOH1 *)
 P84ParRead.Parameters[113].Subindex := 16#20;	
 
 P84ParRead.Parameters[114].Index := 16#2010; (* ASL1 *)
 P84ParRead.Parameters[114].Subindex := 16#3E;	
 
 P84ParRead.Parameters[115].Index := 16#2010; (* ASH1 *)
 P84ParRead.Parameters[115].Subindex := 16#48;	
 
 P84ParRead.Parameters[116].Index := 16#2010; (* AO1F *)
 P84ParRead.Parameters[116].Subindex := 16#C;	
 
 P84ParRead.Parameters[117].Index := 16#2036; (* FR1 *)
 P84ParRead.Parameters[117].Subindex := 16#E;	
 
 P84ParRead.Parameters[118].Index := 16#2001; (* RIN *)
 P84ParRead.Parameters[118].Subindex := 9;	
 
 P84ParRead.Parameters[119].Index := 16#2036; (* CHCF *)
 P84ParRead.Parameters[119].Subindex := 2;	
 
 P84ParRead.Parameters[120].Index := 16#2036; (* CCS *)
 P84ParRead.Parameters[120].Subindex := 16#16;	
 
 P84ParRead.Parameters[121].Index := 16#2036; (* CD1 *)
 P84ParRead.Parameters[121].Subindex := 16#18;	
 
 P84ParRead.Parameters[122].Index := 16#2036; (* CD2 *)
 P84ParRead.Parameters[122].Subindex := 16#19;	
 
 P84ParRead.Parameters[123].Index := 16#2036; (* RFC *)
 P84ParRead.Parameters[123].Subindex := 16#C;	
 
 P84ParRead.Parameters[124].Index := 16#2036; (* FR2 *)
 P84ParRead.Parameters[124].Subindex := 16#F;	
 
 P84ParRead.Parameters[125].Index := 16#2036; (* COP *)
 P84ParRead.Parameters[125].Subindex := 3;	
 
 P84ParRead.Parameters[126].Index := 16#2036; (* RCB *)
 P84ParRead.Parameters[126].Subindex := 16#D;	
 
 P84ParRead.Parameters[127].Index := 16#2036; (* FR1B  *)
 P84ParRead.Parameters[127].Subindex := 16#10;	
 
 P84ParRead.Parameters[128].Index := 16#2058; (* SA2 *)
 P84ParRead.Parameters[128].Subindex := 2;	
 
 P84ParRead.Parameters[129].Index := 16#2058; (* SA3 *)
 P84ParRead.Parameters[129].Subindex := 3;	
 
 P84ParRead.Parameters[130].Index := 16#2058; (* DA2 *)
 P84ParRead.Parameters[130].Subindex := 16#C;	
 
 P84ParRead.Parameters[131].Index := 16#2058;  (* DA3 *)
 P84ParRead.Parameters[131].Subindex := 16#D;	
 
 P84ParRead.Parameters[132].Index := 16#2058; (* MA2 *)
 P84ParRead.Parameters[132].Subindex := 16#16;	
 
 P84ParRead.Parameters[133].Index := 16#2058; (* MA3 *)
 P84ParRead.Parameters[133].Subindex := 16#17;	
 
 P84ParRead.Parameters[134].Index := 16#203C; (* RPT *)
 P84ParRead.Parameters[134].Subindex := 5;	
 
 P84ParRead.Parameters[135].Index := 16#203C; (* TA1 *)
 P84ParRead.Parameters[135].Subindex := 6;	
 
 P84ParRead.Parameters[136].Index := 16#203C; (* TA2 *)
 P84ParRead.Parameters[136].Subindex := 7;	
 
 P84ParRead.Parameters[137].Index := 16#203C; (* TA3 *)
 P84ParRead.Parameters[137].Subindex := 8;	
 
 P84ParRead.Parameters[138].Index := 16#203C; (* TA4 *)
 P84ParRead.Parameters[138].Subindex := 9;	
 
 P84ParRead.Parameters[139].Index := 16#203C; (* FRT *)
 P84ParRead.Parameters[139].Subindex := 16#C;	
 
 P84ParRead.Parameters[140].Index := 16#203C; (* RPS *)
 P84ParRead.Parameters[140].Subindex := 16#B;	
 
 P84ParRead.Parameters[141].Index := 16#203C; (* AC2 *)
 P84ParRead.Parameters[141].Subindex := 16#D;	
 
 P84ParRead.Parameters[142].Index := 16#203C; (* DE2 *)
 P84ParRead.Parameters[142].Subindex := 16#E;	
 
 P84ParRead.Parameters[143].Index := 16#203C; (* BRA *)
 P84ParRead.Parameters[143].Subindex := 4;	
 
 P84ParRead.Parameters[144].Index := 16#2052;  (* STT *)
 P84ParRead.Parameters[144].Subindex := 2;	
 
 P84ParRead.Parameters[145].Index := 16#2052; (* FFT *)
 P84ParRead.Parameters[145].Subindex := 16#15;	
 
 P84ParRead.Parameters[146].Index := 16#2052; (* NST *)
 P84ParRead.Parameters[146].Subindex := 3;	
 
 P84ParRead.Parameters[147].Index := 16#2052; (* FST *)
 P84ParRead.Parameters[147].Subindex := 5;	
 
 P84ParRead.Parameters[148].Index := 16#2052; (* DCF *)
 P84ParRead.Parameters[148].Subindex := 16#1F;	
 
 P84ParRead.Parameters[149].Index := 16#2052; (* DCI *)
 P84ParRead.Parameters[149].Subindex := 4;	
 
 P84ParRead.Parameters[150].Index := 16#2052; (* IDC *)
 P84ParRead.Parameters[150].Subindex := 16#B;	
 
 P84ParRead.Parameters[151].Index := 16#2052; (* TDI *)
 P84ParRead.Parameters[151].Subindex := 16#E;	
 
 P84ParRead.Parameters[152].Index := 16#2052; (* IDC2 *)
 P84ParRead.Parameters[152].Subindex := 16#D;	
 
 P84ParRead.Parameters[153].Index := 16#2052; (* TDC *)
 P84ParRead.Parameters[153].Subindex := 16#C;	
 
 P84ParRead.Parameters[154].Index := 16#204A; (* ADC *)
 P84ParRead.Parameters[154].Subindex := 2;	
 
 P84ParRead.Parameters[155].Index := 16#204A; (* SDC1 *)
 P84ParRead.Parameters[155].Subindex := 4;	
 
 P84ParRead.Parameters[156].Index := 16#204A; (* TDC1 *)
 P84ParRead.Parameters[156].Subindex := 3;	
 
 P84ParRead.Parameters[157].Index := 16#204A; (* SDC2 *)
 P84ParRead.Parameters[157].Subindex := 6;	
 
 P84ParRead.Parameters[158].Index := 16#204A; (* TDC2 *)
 P84ParRead.Parameters[158].Subindex := 5;	
 
 P84ParRead.Parameters[159].Index := 16#2051; (* JOG *)
 P84ParRead.Parameters[159].Subindex := 16#B;	
 
 P84ParRead.Parameters[160].Index := 16#2051;	(* JGF *)
 P84ParRead.Parameters[160].Subindex := 16#C;	
 
 P84ParRead.Parameters[161].Index := 16#2051; (* JGT *)
 P84ParRead.Parameters[161].Subindex := 16#D;	
 
 P84ParRead.Parameters[162].Index := 16#2054; (* PS2 *)
 P84ParRead.Parameters[162].Subindex := 2;	
 
 P84ParRead.Parameters[163].Index := 16#2054; (* PS4 *)
 P84ParRead.Parameters[163].Subindex := 3;	
 
 P84ParRead.Parameters[164].Index := 16#2054; (* PS8 *)
 P84ParRead.Parameters[164].Subindex := 4;	
 
 P84ParRead.Parameters[165].Index := 16#2054; (* PS16 *)
 P84ParRead.Parameters[165].Subindex := 5;	
 
 P84ParRead.Parameters[166].Index := 16#2054; (* SP2 *)
 P84ParRead.Parameters[166].Subindex := 16#B;	
 
 P84ParRead.Parameters[167].Index := 16#2054; (* SP3 *)
 P84ParRead.Parameters[167].Subindex := 16#C;	
 
 P84ParRead.Parameters[168].Index := 16#2054; (* SP4 *)
 P84ParRead.Parameters[168].Subindex := 16#D;	
 
 P84ParRead.Parameters[169].Index := 16#2054; (* SP5 *)
 P84ParRead.Parameters[169].Subindex := 16#E;	
 
 P84ParRead.Parameters[170].Index := 16#2054; (* SP6 *)
 P84ParRead.Parameters[170].Subindex := 16#F;	
 
 P84ParRead.Parameters[171].Index := 16#2054; (* SP7 *)
 P84ParRead.Parameters[171].Subindex := 16#10;	
 
 P84ParRead.Parameters[172].Index := 16#2054; (* SP8 *)
 P84ParRead.Parameters[172].Subindex := 16#11;	
 
 P84ParRead.Parameters[173].Index := 16#2054; (* SP9 *)
 P84ParRead.Parameters[173].Subindex := 16#12;	
 
 P84ParRead.Parameters[174].Index := 16#2054; (* SP10 *)
 P84ParRead.Parameters[174].Subindex := 16#13;	
 
 P84ParRead.Parameters[175].Index := 16#2054; (* SP11 *)
 P84ParRead.Parameters[175].Subindex := 16#14;	
 
 P84ParRead.Parameters[176].Index := 16#2054; (* SP12 *)
 P84ParRead.Parameters[176].Subindex := 16#15;	
 
 P84ParRead.Parameters[177].Index := 16#2054; (* SP13 *)
 P84ParRead.Parameters[177].Subindex := 16#16;	
 
 P84ParRead.Parameters[178].Index := 16#2054; (* SP14 *)
 P84ParRead.Parameters[178].Subindex := 16#17;	
 
 P84ParRead.Parameters[179].Index := 16#2054; (* SP15 *)
 P84ParRead.Parameters[179].Subindex := 16#18;	
 
 P84ParRead.Parameters[180].Index := 16#2054; (* SP16 *)
 P84ParRead.Parameters[180].Subindex := 16#19;	
 
 P84ParRead.Parameters[181].Index := 16#2055; (* USP *)
 P84ParRead.Parameters[181].Subindex := 2;	
 
 P84ParRead.Parameters[182].Index := 16#2055; (* DSP *)
 P84ParRead.Parameters[182].Subindex := 3;	
 
 P84ParRead.Parameters[183].Index := 16#2055; (* STR *)
 P84ParRead.Parameters[183].Subindex := 4;	
 
 P84ParRead.Parameters[184].Index := 16#2055; (* USI *)
 P84ParRead.Parameters[184].Subindex := 16#15;	
 
 P84ParRead.Parameters[185].Index := 16#2055; (* DSI *)
 P84ParRead.Parameters[185].Subindex := 16#16;	
 
 P84ParRead.Parameters[186].Index := 16#2055; (* SRP *)
 P84ParRead.Parameters[186].Subindex := 6;	
 
 P84ParRead.Parameters[187].Index := 16#2036; (* SPM *)
 P84ParRead.Parameters[187].Subindex := 16#5C;	
 
 P84ParRead.Parameters[188].Index := 16#206D; (* FLI *)
 P84ParRead.Parameters[188].Subindex := 2;	
 
 P84ParRead.Parameters[189].Index := 16#2056; (* LAF *)
 P84ParRead.Parameters[189].Subindex := 2;	
 
 P84ParRead.Parameters[190].Index := 16#2056; (* LAR *)
 P84ParRead.Parameters[190].Subindex := 3;	
 
 P84ParRead.Parameters[191].Index := 16#2056; (* LAS *)
 P84ParRead.Parameters[191].Subindex := 4;	
 
 P84ParRead.Parameters[192].Index := 16#2046; (* BLC *)
 P84ParRead.Parameters[192].Subindex := 2;	
 
 P84ParRead.Parameters[193].Index := 16#2046; (* BST *)
 P84ParRead.Parameters[193].Subindex := 9;	
 
 P84ParRead.Parameters[194].Index := 16#2046; (* BCI *)
 P84ParRead.Parameters[194].Subindex := 16#A;	
 
 P84ParRead.Parameters[195].Index := 16#2046; (* BIP *)
 P84ParRead.Parameters[195].Subindex := 8;	
 
 P84ParRead.Parameters[196].Index := 16#2046; (* IBR *)
 P84ParRead.Parameters[196].Subindex := 7;	
 
 P84ParRead.Parameters[197].Index := 16#2046; (* IRD *)
 P84ParRead.Parameters[197].Subindex := 16#C;	
 
 P84ParRead.Parameters[198].Index := 16#2046; (* BRT *)
 P84ParRead.Parameters[198].Subindex := 5;	
 
 P84ParRead.Parameters[199].Index := 16#2046; (* BIR *)
 P84ParRead.Parameters[199].Subindex := 16#D;	
 
 P84ParRead.Parameters[200].Index := 16#2046; (* BEN *)
 P84ParRead.Parameters[200].Subindex := 4;	
 
 P84ParRead.Parameters[201].Index := 16#2046; (* BECD *)
 P84ParRead.Parameters[201].Subindex := 16#F;	
 
 P84ParRead.Parameters[202].Index := 16#2046; (* TBE *)
 P84ParRead.Parameters[202].Subindex := 16#B;	
 
 P84ParRead.Parameters[203].Index := 16#2046; (* BET *)
 P84ParRead.Parameters[203].Subindex := 6;	
 
 P84ParRead.Parameters[204].Index := 16#2046; (* BED *)
 P84ParRead.Parameters[204].Subindex := 16#15;	
 
 P84ParRead.Parameters[205].Index := 16#2046; (* JDC *)
 P84ParRead.Parameters[205].Subindex := 16#E;	
 
 P84ParRead.Parameters[206].Index := 16#2046; (* TTR *)
 P84ParRead.Parameters[206].Subindex := 16#17;	
 
 P84ParRead.Parameters[207].Index := 16#2046; (* BRR *)
 P84ParRead.Parameters[207].Subindex := 16#10;	
 
 P84ParRead.Parameters[208].Index := 16#2046; (* PES *)
 P84ParRead.Parameters[208].Subindex := 16#47;	
 
 P84ParRead.Parameters[209].Index := 16#2046; (* LP1 *)
 P84ParRead.Parameters[209].Subindex := 16#48;	
 
 P84ParRead.Parameters[210].Index := 16#2046; (* CP1 *)
 P84ParRead.Parameters[210].Subindex := 16#49;	
 
 P84ParRead.Parameters[211].Index := 16#2046; (* LP2 *)
 P84ParRead.Parameters[211].Subindex := 16#4A;	
 
 P84ParRead.Parameters[212].Index := 16#2046; (* CP2 *)
 P84ParRead.Parameters[212].Subindex := 16#4B;	
  
 P84ParRead.Parameters[213].Index := 16#2046; (* IBRA *)
 P84ParRead.Parameters[213].Subindex := 16#4C;	
 
 P84ParRead.Parameters[214].Index := 16#205D; (* HSO *)
 P84ParRead.Parameters[214].Subindex := 2;	
 
 P84ParRead.Parameters[215].Index := 16#205D; (* COF *)
 P84ParRead.Parameters[215].Subindex := 4;	
 
 P84ParRead.Parameters[216].Index := 16#205D; (* COR *)
 P84ParRead.Parameters[216].Subindex := 5;	
 
 P84ParRead.Parameters[217].Index := 16#205D; (* TOS *)
 P84ParRead.Parameters[217].Subindex := 8;	
 
 P84ParRead.Parameters[218].Index := 16#205D; (* OSP *)
 P84ParRead.Parameters[218].Subindex := 6;	
 
 P84ParRead.Parameters[219].Index := 16#205D; (* CLO *)
 P84ParRead.Parameters[219].Subindex := 3;	
 
 P84ParRead.Parameters[220].Index := 16#205D; (* SCL *)
 P84ParRead.Parameters[220].Subindex := 7;	
 
 P84ParRead.Parameters[221].Index := 16#205D; (* RSD *)
 P84ParRead.Parameters[221].Subindex := 16#16;	
 
 P84ParRead.Parameters[222].Index := 16#205D; (* RSTL *)
 P84ParRead.Parameters[222].Subindex := 16#17;	
 
 P84ParRead.Parameters[223].Index := 16#205D; (* TLD *)
 P84ParRead.Parameters[223].Subindex := 16#D;	
 
 P84ParRead.Parameters[224].Index := 16#205D; (* DLD *)
 P84ParRead.Parameters[224].Subindex := 16#C;	
 
 P84ParRead.Parameters[225].Index := 16#205D; (* DLB *)
 P84ParRead.Parameters[225].Subindex := 16#E;	
 
 P84ParRead.Parameters[226].Index := 16#2059; (* PIF *)
 P84ParRead.Parameters[226].Subindex := 2;	
 
 P84ParRead.Parameters[227].Index := 16#2016; (* AIC1 *)
 P84ParRead.Parameters[227].Subindex := 16#53;	
 
 P84ParRead.Parameters[228].Index := 16#2059; (* PIF1 *)
 P84ParRead.Parameters[228].Subindex := 5;	
 
 P84ParRead.Parameters[229].Index := 16#2059; (* PIF2 *)
 P84ParRead.Parameters[229].Subindex := 6;	
 
 P84ParRead.Parameters[230].Index := 16#2059; (* PIP1 *)
 P84ParRead.Parameters[230].Subindex := 7;	
 
 P84ParRead.Parameters[231].Index := 16#2059; (* PIP2 *)
 P84ParRead.Parameters[231].Subindex := 8;	
 
 P84ParRead.Parameters[232].Index := 16#2059; (* PII *)
 P84ParRead.Parameters[232].Subindex := 9;	
 
 P84ParRead.Parameters[233].Index := 16#2059; (* RPI *)
 P84ParRead.Parameters[233].Subindex := 16#15;	
 
 P84ParRead.Parameters[234].Index := 16#2059; (* RPG *)
 P84ParRead.Parameters[234].Subindex := 16#2A;	
 
 P84ParRead.Parameters[235].Index := 16#2059; (* RIG *)
 P84ParRead.Parameters[235].Subindex := 16#2B;	
 
 P84ParRead.Parameters[236].Index := 16#2059; (* RDG *)
 P84ParRead.Parameters[236].Subindex := 16#2C;	
 
 P84ParRead.Parameters[237].Index := 16#2059; (* PRP *)
 P84ParRead.Parameters[237].Subindex := 16#55;	
 
 P84ParRead.Parameters[238].Index := 16#2059; (* PIC *)
 P84ParRead.Parameters[238].Subindex := 16#29;	
 
 P84ParRead.Parameters[239].Index := 16#2059; (* POL *)
 P84ParRead.Parameters[239].Subindex := 16#35;	
 
 P84ParRead.Parameters[240].Index := 16#2059; (* POH *)
 P84ParRead.Parameters[240].Subindex := 16#36;	
 
 P84ParRead.Parameters[241].Index := 16#2059; (* PAL *)
 P84ParRead.Parameters[241].Subindex := 16#3E;	
 
 P84ParRead.Parameters[242].Index := 16#2059; (* PAH *)
 P84ParRead.Parameters[242].Subindex := 16#3F;	
 
 P84ParRead.Parameters[243].Index := 16#2059; (* PER *)
 P84ParRead.Parameters[243].Subindex := 16#40;
 
 P84ParRead.Parameters[244].Index := 16#2059; (* PIS *)
 P84ParRead.Parameters[244].Subindex := 16#2D;	
 
 P84ParRead.Parameters[245].Index := 16#2059; (* FPI *)
 P84ParRead.Parameters[245].Subindex := 16#33;	
 
 P84ParRead.Parameters[246].Index := 16#2059; (* PSR *)
 P84ParRead.Parameters[246].Subindex := 16#34;	
 
 P84ParRead.Parameters[247].Index := 16#2059; (* PAU *)
 P84ParRead.Parameters[247].Subindex := 16#47;	
 
 P84ParRead.Parameters[248].Index := 16#2059; (* PIM *)
 P84ParRead.Parameters[248].Subindex := 16#37;	
 
 P84ParRead.Parameters[249].Index := 16#2059; (* RSL *)
 P84ParRead.Parameters[249].Subindex := 16#3D;	
 
 P84ParRead.Parameters[250].Index := 16#2059; (* PR2 *)
 P84ParRead.Parameters[250].Subindex := 16#A;	
 
 P84ParRead.Parameters[251].Index := 16#2059; (* PR4 *)
 P84ParRead.Parameters[251].Subindex := 16#B;	
 
 P84ParRead.Parameters[252].Index := 16#2059; (* RP2 *)
 P84ParRead.Parameters[252].Subindex := 16#16;	
 
 P84ParRead.Parameters[253].Index := 16#2059; (* RP3 *)
 P84ParRead.Parameters[253].Subindex := 16#17;	
 
 P84ParRead.Parameters[254].Index := 16#2059; (* RP4 *)
 P84ParRead.Parameters[254].Subindex := 16#18;	
 
 P84ParRead.Parameters[255].Index := 16#203E; (* TSS *)
 P84ParRead.Parameters[255].Subindex := 16#15;
 
 P84ParRead.Parameters[256].Index := 16#203E; (* TR1 *)
 P84ParRead.Parameters[256].Subindex := 16#16;	
 
 P84ParRead.Parameters[257].Index := 16#203E; (* TSD *)
 P84ParRead.Parameters[257].Subindex := 16#17;	
 
 P84ParRead.Parameters[258].Index := 16#203E; (* TRT *)
 P84ParRead.Parameters[258].Subindex := 16#1A;	
 
 P84ParRead.Parameters[259].Index := 16#203E; (* TRP *)
 P84ParRead.Parameters[259].Subindex := 16#1B;	
 
 P84ParRead.Parameters[260].Index := 16#203E; (* TST *)
 P84ParRead.Parameters[260].Subindex := 16#1C;	
 
 P84ParRead.Parameters[261].Index := 16#203E; (* SPT *)
 P84ParRead.Parameters[261].Subindex := 16#1F;	
 
 P84ParRead.Parameters[262].Index := 16#203E; (* DBP *)
 P84ParRead.Parameters[262].Subindex := 16#19;	
 
 P84ParRead.Parameters[263].Index := 16#203E; (* DBN *)
 P84ParRead.Parameters[263].Subindex := 16#18;	
 
 P84ParRead.Parameters[264].Index := 16#203E; (* RTO *)
 P84ParRead.Parameters[264].Subindex := 16#1E;	
 
 P84ParRead.Parameters[265].Index := 16#203E; (* TOB *)
 P84ParRead.Parameters[265].Subindex := 16#1D;	
 
 P84ParRead.Parameters[266].Index := 16#203E; (* TLA *)
 P84ParRead.Parameters[266].Subindex := 16#B;	
 
 P84ParRead.Parameters[267].Index := 16#203E; (* INTP *)
 P84ParRead.Parameters[267].Subindex := 16#10;
 
 P84ParRead.Parameters[268].Index := 16#203E; (* TLIM *)
 P84ParRead.Parameters[268].Subindex := 16#C;	
 
 P84ParRead.Parameters[269].Index := 16#203E; (* TLIG *)
 P84ParRead.Parameters[269].Subindex := 16#D;	
 
 P84ParRead.Parameters[270].Index := 16#203E; (* TAA *)
 P84ParRead.Parameters[270].Subindex := 16#F;	
 
 P84ParRead.Parameters[271].Index := 16#203E; (* TLC *)
 P84ParRead.Parameters[271].Subindex := 16#E;	
 
 P84ParRead.Parameters[272].Index := 16#203E; (* LC2 *)
 P84ParRead.Parameters[272].Subindex := 3;	
 
 P84ParRead.Parameters[273].Index := 16#203E; (* CL2 *)
 P84ParRead.Parameters[273].Subindex := 4;	
 
 P84ParRead.Parameters[274].Index := 16#206A; (* LLC *)
 P84ParRead.Parameters[274].Subindex := 3;	
 
 P84ParRead.Parameters[275].Index := 16#206A; (* LES *)
 P84ParRead.Parameters[275].Subindex := 2;	
 
 P84ParRead.Parameters[276].Index := 16#206A; (* LCT *)
 P84ParRead.Parameters[276].Subindex := 4;	
 
 P84ParRead.Parameters[277].Index := 16#2065; (* OCC *)
 P84ParRead.Parameters[277].Subindex := 5;	
 
 P84ParRead.Parameters[278].Index := 16#2065; (* RCA *)
 P84ParRead.Parameters[278].Subindex := 4;	
 
 P84ParRead.Parameters[279].Index := 16#2065; (* DBS *)
 P84ParRead.Parameters[279].Subindex := 2;
 
 P84ParRead.Parameters[280].Index := 16#2065; (* DAS *)
 P84ParRead.Parameters[280].Subindex := 3;	
 
 P84ParRead.Parameters[281].Index := 16#205F; (* SAF *)
 P84ParRead.Parameters[281].Subindex := 2;	 
 
 P84ParRead.Parameters[282].Index := 16#205F; (* SAR *)
 P84ParRead.Parameters[282].Subindex := 3;	
 
 P84ParRead.Parameters[283].Index := 16#205F; (* SAL *)
 P84ParRead.Parameters[283].Subindex := 9;	
 
 P84ParRead.Parameters[284].Index := 16#205F; (* DAF *)
 P84ParRead.Parameters[284].Subindex := 4;	
 
 P84ParRead.Parameters[285].Index := 16#205F; (* DAR *)
 P84ParRead.Parameters[285].Subindex := 5;	
 
 P84ParRead.Parameters[286].Index := 16#205F; (* DAL *)
 P84ParRead.Parameters[286].Subindex := 16#A;	
 
 P84ParRead.Parameters[287].Index := 16#205F; (* CLS *)
 P84ParRead.Parameters[287].Subindex := 8;	
 
 P84ParRead.Parameters[288].Index := 16#205F; (* PAS *)
 P84ParRead.Parameters[288].Subindex := 7;	
 
 P84ParRead.Parameters[289].Index := 16#205F; (* DSF *)
 P84ParRead.Parameters[289].Subindex := 6;	
 
 P84ParRead.Parameters[290].Index := 16#2059; (* STD *)
 P84ParRead.Parameters[290].Subindex := 16#16;	
 
 P84ParRead.Parameters[291].Index := 16#205F; (* NLS *)
 P84ParRead.Parameters[291].Subindex := 16#C;
 
 P84ParRead.Parameters[292].Index := 16#205F; (* SFD *)
 P84ParRead.Parameters[292].Subindex := 16#17;	
 
 P84ParRead.Parameters[293].Index := 16#2042; (* TUL  *)
 P84ParRead.Parameters[293].Subindex := 16#B;	
 
 P84ParRead.Parameters[294].Index := 16#205C; (* TRC *)
 P84ParRead.Parameters[294].Subindex := 2;	
 
 P84ParRead.Parameters[295].Index := 16#205C; (* TRH *)
 P84ParRead.Parameters[295].Subindex := 3;	
 
 P84ParRead.Parameters[296].Index := 16#205C; (* TRL *)
 P84ParRead.Parameters[296].Subindex := 4;	
 
 P84ParRead.Parameters[297].Index := 16#205C; (* QSH *)
 P84ParRead.Parameters[297].Subindex := 5;	
 
 P84ParRead.Parameters[298].Index := 16#205C; (* QSL *)
 P84ParRead.Parameters[298].Subindex := 6;	
 
 P84ParRead.Parameters[299].Index := 16#205C; (* TUP *)
 P84ParRead.Parameters[299].Subindex := 7;	
 
 P84ParRead.Parameters[300].Index := 16#205C; (* TDN *)
 P84ParRead.Parameters[300].Subindex := 8;	
 
 P84ParRead.Parameters[301].Index := 16#205C; (* TBO *)
 P84ParRead.Parameters[301].Subindex := 9;	
 
 P84ParRead.Parameters[302].Index := 16#205C; (* EBO *)
 P84ParRead.Parameters[302].Subindex := 16#E;	
 
 P84ParRead.Parameters[303].Index := 16#205C; (* SNC *)
 P84ParRead.Parameters[303].Subindex := 16#D;
 
 P84ParRead.Parameters[304].Index := 16#205C; (* TSY *)
 P84ParRead.Parameters[304].Subindex := 16#F;	
 
 P84ParRead.Parameters[305].Index := 16#205C; (* DTF *)
 P84ParRead.Parameters[305].Subindex := 16#C;	
 
 P84ParRead.Parameters[306].Index := 16#205C; (* RTR *)
 P84ParRead.Parameters[306].Subindex := 16#B;	
 
 P84ParRead.Parameters[307].Index := 16#206C; (* RFT *)
 P84ParRead.Parameters[307].Subindex := 16#20;	
 
 P84ParRead.Parameters[308].Index := 16#206C; (* RSU *)
 P84ParRead.Parameters[308].Subindex := 16#21;	
 
 P84ParRead.Parameters[309].Index := 16#206C; (* RSP *)
 P84ParRead.Parameters[309].Subindex := 16#22;	
 
 P84ParRead.Parameters[310].Index := 16#2075; (* HLS *)
 P84ParRead.Parameters[310].Subindex := 2;	
 
 P84ParRead.Parameters[311].Index := 16#206C; (* DCO *) 
 P84ParRead.Parameters[311].Subindex := 16#2A;	
 
 P84ParRead.Parameters[312].Index := 16#2066; (* PTCL *)
 P84ParRead.Parameters[312].Subindex := 4;	
 
 P84ParRead.Parameters[313].Index := 16#2029; (* RSF *)
 P84ParRead.Parameters[313].Subindex := 16#19;	
 
 P84ParRead.Parameters[314].Index := 16#2029; (* RPA *)
 P84ParRead.Parameters[314].Subindex := 16#1E;	
 
 P84ParRead.Parameters[315].Index := 16#2029; (* ATR *)
 P84ParRead.Parameters[315].Subindex := 16#17;
 
 P84ParRead.Parameters[316].Index := 16#2029; (* TAR *)
 P84ParRead.Parameters[316].Subindex := 16#18;	
 
 P84ParRead.Parameters[317].Index := 16#2001; (* FLR *)
 P84ParRead.Parameters[317].Subindex := 16#B;	
 
 P84ParRead.Parameters[318].Index := 16#2001; (* VCB *)
 P84ParRead.Parameters[318].Subindex := 16#C;	
 
 P84ParRead.Parameters[319].Index := 16#2042; (* THT *)
 P84ParRead.Parameters[319].Subindex := 16#D;	
 
 P84ParRead.Parameters[320].Index := 16#2050; (* TTD *)
 P84ParRead.Parameters[320].Subindex := 3;	
 
 P84ParRead.Parameters[321].Index := 16#2050; (* TTD2 *)
 P84ParRead.Parameters[321].Subindex := 7;	
 
 P84ParRead.Parameters[322].Index := 16#2050; (* TTD3 *)
 P84ParRead.Parameters[322].Subindex := 8;	
 
 P84ParRead.Parameters[323].Index := 16#2028; (* OLL *)
 P84ParRead.Parameters[323].Subindex := 16#A;	
 
 P84ParRead.Parameters[324].Index := 16#2042; (* OPL *)
 P84ParRead.Parameters[324].Subindex := 16#C;	
 
 P84ParRead.Parameters[325].Index := 16#2028; (* ODT *)
 P84ParRead.Parameters[325].Subindex := 16#52;	
 
 P84ParRead.Parameters[326].Index := 16#2028; (* IPL *)
 P84ParRead.Parameters[326].Subindex := 3;	
 
 P84ParRead.Parameters[327].Index := 16#2028; (* OHL *)
 P84ParRead.Parameters[327].Subindex := 9;
 
 P84ParRead.Parameters[328].Index := 16#2050; (* THA *)
 P84ParRead.Parameters[328].Subindex := 16#A;	
 
 P84ParRead.Parameters[329].Index := 16#2050; (* SAT *)
 P84ParRead.Parameters[329].Subindex := 16#16;	
 
 P84ParRead.Parameters[330].Index := 16#2029; (* ETF *)
 P84ParRead.Parameters[330].Subindex := 16#20;	
 
 P84ParRead.Parameters[331].Index := 16#2028; (* LET *)
 P84ParRead.Parameters[331].Subindex := 16#5B;	
 
 P84ParRead.Parameters[332].Index := 16#2028; (* EPL *)
 P84ParRead.Parameters[332].Subindex := 7;	
 
 P84ParRead.Parameters[333].Index := 16#206C; (* USB *)
 P84ParRead.Parameters[333].Subindex := 4;	
 
 P84ParRead.Parameters[334].Index := 16#206C; (* URES *)
 P84ParRead.Parameters[334].Subindex := 2;	
 
 P84ParRead.Parameters[335].Index := 16#206C; (* USL *)
 P84ParRead.Parameters[335].Subindex := 3;	
 
 P84ParRead.Parameters[336].Index := 16#206C; (* UST *)
 P84ParRead.Parameters[336].Subindex := 5;	
 
 P84ParRead.Parameters[337].Index := 16#2028; (* STP *)
 P84ParRead.Parameters[337].Subindex := 5;	
 
 P84ParRead.Parameters[338].Index := 16#206C; (* TSM *)
 P84ParRead.Parameters[338].Subindex := 16#E;	
 
 P84ParRead.Parameters[339].Index := 16#206C; (* UPL *)
 P84ParRead.Parameters[339].Subindex := 16#C;
 
 P84ParRead.Parameters[340].Index := 16#206C; (* STM *)
 P84ParRead.Parameters[340].Subindex := 16#F;	
 
 P84ParRead.Parameters[341].Index := 16#206C; (* TBS *)
 P84ParRead.Parameters[341].Subindex := 16#D;	
 
 P84ParRead.Parameters[342].Index := 16#2001; (* STRT *)
 P84ParRead.Parameters[342].Subindex := 16#D;	
 
 P84ParRead.Parameters[343].Index := 16#2028; (* LFL2 *)
 P84ParRead.Parameters[343].Subindex := 4;	
 
 P84ParRead.Parameters[344].Index := 16#2029; (* INH *)
 P84ParRead.Parameters[344].Subindex := 16#1A;	
 
 P84ParRead.Parameters[345].Index := 16#2028; (* COL *)
 P84ParRead.Parameters[345].Subindex := 16#C;	
 
 P84ParRead.Parameters[346].Index := 16#2028; (* SDD *)
 P84ParRead.Parameters[346].Subindex := 6;	
 
 P84ParRead.Parameters[347].Index := 16#201A; (* ECC *)
 P84ParRead.Parameters[347].Subindex := 8;	
 
 P84ParRead.Parameters[348].Index := 16#201A; (* ECT *)
 P84ParRead.Parameters[348].Subindex := 16#A;	
 
 P84ParRead.Parameters[349].Index := 16#203E; (* SSB *)
 P84ParRead.Parameters[349].Subindex := 16#29;	
 
 P84ParRead.Parameters[350].Index := 16#203E; (* STO *)
 P84ParRead.Parameters[350].Subindex := 16#2A;	
 
 P84ParRead.Parameters[351].Index := 16#206F; (* BRO *)
 P84ParRead.Parameters[351].Subindex := 16#C;
 
 P84ParRead.Parameters[352].Index := 16#206F; (* BRP *)
 P84ParRead.Parameters[352].Subindex := 16#D;	
 
 P84ParRead.Parameters[353].Index := 16#206F; (* BRV *)
 P84ParRead.Parameters[353].Subindex := 16#E;	
 
 P84ParRead.Parameters[354].Index := 16#2028; (* BUB *)
 P84ParRead.Parameters[354].Subindex := 16#11;	
 
 P84ParRead.Parameters[355].Index := 16#2028; (* TNL *)
 P84ParRead.Parameters[355].Subindex := 16#D;	
 
 P84ParRead.Parameters[356].Index := 16#2028; (* LFF *)
 P84ParRead.Parameters[356].Subindex := 16#51;	
 
 P84ParRead.Parameters[357].Index := 16#2036; (* FLO *)
 P84ParRead.Parameters[357].Subindex := 16#20;	
 
 P84ParRead.Parameters[358].Index := 16#2036; (* FLOC *)
 P84ParRead.Parameters[358].Subindex := 16#21;	
 
 P84ParRead.Parameters[359].Index := 16#2036; (* FLOT *)
 P84ParRead.Parameters[359].Subindex := 16#22;	
 
  

END_PROGRAM

