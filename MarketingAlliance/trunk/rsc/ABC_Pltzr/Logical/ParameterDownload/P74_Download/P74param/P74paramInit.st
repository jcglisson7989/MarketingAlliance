(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: P74param
 * File: P74paramInit.st
 * Author: scoccimaroj
 * Created: July 14, 2010
 ********************************************************************
 * Implementation of program P74param
 ********************************************************************)

PROGRAM _INIT

 	
	P74ParRead.NodeNr := 1;
	strcpy( ADR(P74ParRead.pDevice), ADR('IF3.ST1') ); 
	strcpy( ADR(P74ParRead.FileDevice), ADR('DISK') );
 
 
	(* Initialize the CSV file writing operation *)
	strcpy( ADR(P74ParRead.CsvFileName), ADR(P74ParRead.pDevice) );
 
 
	FOR i:= 0 TO 10 BY 1 DO
		position := FIND(P74ParRead.CsvFileName, '.');
	
		IF (position <> 0) THEN
			P74ParRead.CsvFileName := REPLACE(P74ParRead.CsvFileName, '_', 1, position);
		END_IF	
		
	END_FOR 
  
 
	strcat( ADR(P74ParRead.CsvFileName), ADR('.csv') ); 
 
 
	pNames[0] := ADR('P74ParRead');
 
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
 
	P74ParRead.Parameters[0].Index  := 16#2037;  (* CMD *)
	P74ParRead.Parameters[0].Subindex := 16#2;
	
	P74ParRead.Parameters[1].Index  := 16#2037;  (* CMI *)
	P74ParRead.Parameters[1].Subindex := 16#5;

	P74ParRead.Parameters[2].Index  := 16#2001;  (* RPR *)
	P74ParRead.Parameters[2].Subindex := 16#15;

	P74ParRead.Parameters[3].Index  := 16#2038;  (* LFRD *)
	P74ParRead.Parameters[3].Subindex := 16#3;

	P74ParRead.Parameters[4].Index  := 16#2037;  (* LFR *)
	P74ParRead.Parameters[4].Subindex := 16#3;

	P74ParRead.Parameters[5].Index  := 16#2037;  (* PISP *)
	P74ParRead.Parameters[5].Subindex := 16#4;

	P74ParRead.Parameters[6].Index  := 16#2016;  (* AIV1 *)
	P74ParRead.Parameters[6].Subindex := 16#52;

	P74ParRead.Parameters[7].Index  := 16#2016;  (* AIV2 *)
	P74ParRead.Parameters[7].Subindex := 16#54;

	P74ParRead.Parameters[8].Index  := 16#2058;  (* MFR *)
	P74ParRead.Parameters[8].Subindex := 16#20;

	P74ParRead.Parameters[9].Index  := 16#2002;  (* ETA *)
	P74ParRead.Parameters[9].Subindex := 16#2;

	P74ParRead.Parameters[10].Index  := 16#2002;  (* HMIS *)
	P74ParRead.Parameters[10].Subindex := 16#29;

	P74ParRead.Parameters[11].Index  := 16#2002;  (* ETI *)
	P74ParRead.Parameters[11].Subindex := 16#7;

	P74ParRead.Parameters[12].Index  := 16#2002;  (* LRS1 *)
	P74ParRead.Parameters[12].Subindex := 16#33;

	P74ParRead.Parameters[13].Index  := 16#2002;  (* LRS2 *)
	P74ParRead.Parameters[13].Subindex := 16#34;

	P74ParRead.Parameters[14].Index  := 16#2002;  (* LRS3 *)
	P74ParRead.Parameters[14].Subindex := 16#35;

	P74ParRead.Parameters[15].Index  := 16#2002;  (* LRS4 *)
	P74ParRead.Parameters[15].Subindex := 16#36;

	P74ParRead.Parameters[16].Index  := 16#2002;  (* LRS5 *)
	P74ParRead.Parameters[16].Subindex := 16#37;

	P74ParRead.Parameters[17].Index  := 16#2002;  (* LRS6 *)
	P74ParRead.Parameters[17].Subindex := 16#38;

	P74ParRead.Parameters[18].Index  := 16#2002;  (* LRS7 *)
	P74ParRead.Parameters[18].Subindex := 16#39;

	P74ParRead.Parameters[19].Index  := 16#2002;  (* LRS8 *)
	P74ParRead.Parameters[19].Subindex := 16#3A;

	P74ParRead.Parameters[20].Index  := 16#2036;  (* CRC *)
	P74ParRead.Parameters[20].Subindex := 16#2A;

	P74ParRead.Parameters[21].Index  := 16#2036;  (* CCC *)
	P74ParRead.Parameters[21].Subindex := 16#2B;

	P74ParRead.Parameters[22].Index  := 16#2032;  (* CNFS *)
	P74ParRead.Parameters[22].Subindex := 16#15;

	P74ParRead.Parameters[23].Index  := 16#2042;  (* STUN *)
	P74ParRead.Parameters[23].Subindex := 16#12;

	P74ParRead.Parameters[24].Index  := 16#2042;  (* TUNU *)
	P74ParRead.Parameters[24].Subindex := 16#14;

	P74ParRead.Parameters[25].Index  := 16#2042;  (* SMOT *)
	P74ParRead.Parameters[25].Subindex := 16#2E;

	P74ParRead.Parameters[26].Index  := 16#2038;  (* RFRD *)
	P74ParRead.Parameters[26].Subindex := 16#5;

	P74ParRead.Parameters[27].Index  := 16#2002;  (* RFR *)
	P74ParRead.Parameters[27].Subindex := 16#3;

	P74ParRead.Parameters[28].Index  := 16#2002;  (* OTR *)
	P74ParRead.Parameters[28].Subindex := 16#6;

	P74ParRead.Parameters[29].Index  := 16#2002;  (* LCR *)
	P74ParRead.Parameters[29].Subindex := 16#5;

	P74ParRead.Parameters[30].Index  := 16#2002;  (* UOP *)
	P74ParRead.Parameters[30].Subindex := 16#9;

	P74ParRead.Parameters[31].Index  := 16#2002;  (* OPR *)
	P74ParRead.Parameters[31].Subindex := 16#C;

	P74ParRead.Parameters[32].Index  := 16#2038;  (* FRHD *)
	P74ParRead.Parameters[32].Subindex := 16#6;

	P74ParRead.Parameters[33].Index  := 16#2038;  (* FROD *)
	P74ParRead.Parameters[33].Subindex := 16#2A;

	P74ParRead.Parameters[34].Index  := 16#2002;  (* FRH *)
	P74ParRead.Parameters[34].Subindex := 16#4;

	P74ParRead.Parameters[35].Index  := 16#203C;  (* FRO *)
	P74ParRead.Parameters[35].Subindex := 16#16;

	P74ParRead.Parameters[36].Index  := 16#2059;  (* RPC *)
	P74ParRead.Parameters[36].Subindex := 16#53;

	P74ParRead.Parameters[37].Index  := 16#2059;  (* RPF *)
	P74ParRead.Parameters[37].Subindex := 16#52;

	P74ParRead.Parameters[38].Index  := 16#2059;  (* RPE *)
	P74ParRead.Parameters[38].Subindex := 16#51;

	P74ParRead.Parameters[39].Index  := 16#2059;  (* RPO *)
	P74ParRead.Parameters[39].Subindex := 16#54;

	P74ParRead.Parameters[40].Index  := 16#2002;  (* ULN *)
	P74ParRead.Parameters[40].Subindex := 16#8;

	P74ParRead.Parameters[41].Index  := 16#2002;  (* APH *)
	P74ParRead.Parameters[41].Subindex := 16#1F;

	P74ParRead.Parameters[42].Index  := 16#2002;  (* THD *)
	P74ParRead.Parameters[42].Subindex := 16#A;

	P74ParRead.Parameters[43].Index  := 16#2042;  (* THR *)
	P74ParRead.Parameters[43].Subindex := 16#1F;

	P74ParRead.Parameters[44].Index  := 16#2002;  (* RTH *)
	P74ParRead.Parameters[44].Subindex := 16#20;

	P74ParRead.Parameters[45].Index  := 16#2002;  (* PTH *)
	P74ParRead.Parameters[45].Subindex := 16#22;

	P74ParRead.Parameters[46].Index  := 16#2002;  (* TAC *)
	P74ParRead.Parameters[46].Subindex := 16#24;

	P74ParRead.Parameters[47].Index  := 16#2002;  (* TAC2 *)
	P74ParRead.Parameters[47].Subindex := 16#2B;

	P74ParRead.Parameters[48].Index  := 16#2016;  (* IL1R *)
	P74ParRead.Parameters[48].Subindex := 16#3;

	P74ParRead.Parameters[49].Index  := 16#2016;  (* OL1R *)
	P74ParRead.Parameters[49].Subindex := 16#D;

	P74ParRead.Parameters[50].Index  := 16#2016;  (* AI1C *)
	P74ParRead.Parameters[50].Subindex := 16#2B;

	P74ParRead.Parameters[51].Index  := 16#2016;  (* AI1R *)
	P74ParRead.Parameters[51].Subindex := 16#21;

	P74ParRead.Parameters[52].Index  := 16#2016;  (* AI2C *)
	P74ParRead.Parameters[52].Subindex := 16#2C;

	P74ParRead.Parameters[53].Index  := 16#2016;  (* AI2R *)
	P74ParRead.Parameters[53].Subindex := 16#22;

	P74ParRead.Parameters[54].Index  := 16#2016;  (* AI3C *)
	P74ParRead.Parameters[54].Subindex := 16#2D;

	P74ParRead.Parameters[55].Index  := 16#2016;  (* AI3R *)
	P74ParRead.Parameters[55].Subindex := 16#23;

	P74ParRead.Parameters[56].Index  := 16#2016;  (* AO1C *)
	P74ParRead.Parameters[56].Subindex := 16#48;

	P74ParRead.Parameters[57].Index  := 16#2016;  (* AO1R *)
	P74ParRead.Parameters[57].Subindex := 16#3E;

	P74ParRead.Parameters[58].Index  := 16#2074;  (* FQS *)
	P74ParRead.Parameters[58].Subindex := 16#4;

	P74ParRead.Parameters[59].Index  := 16#2038;  (* ERRD *)
	P74ParRead.Parameters[59].Subindex := 16#7;

	P74ParRead.Parameters[60].Index  := 16#2029;  (* LFT *)
	P74ParRead.Parameters[60].Subindex := 16#16;

	P74ParRead.Parameters[61].Index  := 16#2029;  (* CIC *)
	P74ParRead.Parameters[61].Subindex := 16#1F;

	P74ParRead.Parameters[62].Index  := 16#2029;  (* CNF *)
	P74ParRead.Parameters[62].Subindex := 16#21;

	P74ParRead.Parameters[63].Index  := 16#2029;  (* ILF1 *)
	P74ParRead.Parameters[63].Subindex := 16#23;

	P74ParRead.Parameters[64].Index  := 16#202B;  (* FNB *)
	P74ParRead.Parameters[64].Subindex := 16#5E;

	P74ParRead.Parameters[65].Index  := 16#202A;  (* DP0 *)
	P74ParRead.Parameters[65].Subindex := 16#1;

	P74ParRead.Parameters[66].Index  := 16#202A;  (* ULP0 *)
	P74ParRead.Parameters[66].Subindex := 16#47;

	P74ParRead.Parameters[67].Index  := 16#202A;  (* LCP0 *)
	P74ParRead.Parameters[67].Subindex := 16#29;

	P74ParRead.Parameters[68].Index  := 16#202A;  (* RFP0 *)
	P74ParRead.Parameters[68].Subindex := 16#33;

	P74ParRead.Parameters[69].Index  := 16#202A;  (* THP0 *)
	P74ParRead.Parameters[69].Subindex := 16#51;

	P74ParRead.Parameters[70].Index  := 16#202A;  (* EP0 *)
	P74ParRead.Parameters[70].Subindex := 16#B;

	P74ParRead.Parameters[71].Index  := 16#202A;  (* IP0 *)
	P74ParRead.Parameters[71].Subindex := 16#15;

	P74ParRead.Parameters[72].Index  := 16#202A;  (* CMP0 *)
	P74ParRead.Parameters[72].Subindex := 16#1F;

	P74ParRead.Parameters[73].Index  := 16#202A;  (* CRP0 *)
	P74ParRead.Parameters[73].Subindex := 16#5B;

	P74ParRead.Parameters[74].Index  := 16#202A;  (* RTP0 *)
	P74ParRead.Parameters[74].Subindex := 16#3D;

	P74ParRead.Parameters[75].Index  := 16#202B;  (* OTP0 *)
	P74ParRead.Parameters[75].Subindex := 16#1F;

	P74ParRead.Parameters[76].Index  := 16#202B;  (* TDP0 *)
	P74ParRead.Parameters[76].Subindex := 16#29;

	P74ParRead.Parameters[77].Index  := 16#202B;  (* TJP0 *)
	P74ParRead.Parameters[77].Subindex := 16#33;

	P74ParRead.Parameters[78].Index  := 16#202B;  (* SFP0 *)
	P74ParRead.Parameters[78].Subindex := 16#3D;

	P74ParRead.Parameters[79].Index  := 16#202A;  (* DP1 *)
	P74ParRead.Parameters[79].Subindex := 16#2;

	P74ParRead.Parameters[80].Index  := 16#202A;  (* ULP1 *)
	P74ParRead.Parameters[80].Subindex := 16#48;

	P74ParRead.Parameters[81].Index  := 16#202A;  (* LCP1 *)
	P74ParRead.Parameters[81].Subindex := 16#2A;

	P74ParRead.Parameters[82].Index  := 16#202A;  (* RFP1 *)
	P74ParRead.Parameters[82].Subindex := 16#34;

	P74ParRead.Parameters[83].Index  := 16#202A;  (* THP1 *)
	P74ParRead.Parameters[83].Subindex := 16#52;

	P74ParRead.Parameters[84].Index  := 16#202A;  (* EP1 *)
	P74ParRead.Parameters[84].Subindex := 16#C;

	P74ParRead.Parameters[85].Index  := 16#202A;  (* IP1 *)
	P74ParRead.Parameters[85].Subindex := 16#16;

	P74ParRead.Parameters[86].Index  := 16#202A;  (* CMP1 *)
	P74ParRead.Parameters[86].Subindex := 16#20;

	P74ParRead.Parameters[87].Index  := 16#202A;  (* CRP1 *)
	P74ParRead.Parameters[87].Subindex := 16#5C;

	P74ParRead.Parameters[88].Index  := 16#202A;  (* RTP1 *)
	P74ParRead.Parameters[88].Subindex := 16#3E;

	P74ParRead.Parameters[89].Index  := 16#202B;  (* OTP1 *)
	P74ParRead.Parameters[89].Subindex := 16#20;

	P74ParRead.Parameters[90].Index  := 16#202B;  (* TDP1 *)
	P74ParRead.Parameters[90].Subindex := 16#2A;

	P74ParRead.Parameters[91].Index  := 16#202B;  (* TJP1 *)
	P74ParRead.Parameters[91].Subindex := 16#34;

	P74ParRead.Parameters[92].Index  := 16#202B;  (* SFP1 *)
	P74ParRead.Parameters[92].Subindex := 16#3E;

	P74ParRead.Parameters[93].Index  := 16#202A;  (* DP2 *)
	P74ParRead.Parameters[93].Subindex := 16#3;

	P74ParRead.Parameters[94].Index  := 16#202A;  (* ULP2 *)
	P74ParRead.Parameters[94].Subindex := 16#49;

	P74ParRead.Parameters[95].Index  := 16#202A;  (* LCP2 *)
	P74ParRead.Parameters[95].Subindex := 16#2B;

	P74ParRead.Parameters[96].Index  := 16#202A;  (* RFP2 *)
	P74ParRead.Parameters[96].Subindex := 16#35;

	P74ParRead.Parameters[97].Index  := 16#202A;  (* THP2 *)
	P74ParRead.Parameters[97].Subindex := 16#53;

	P74ParRead.Parameters[98].Index  := 16#202A;  (* EP2 *)
	P74ParRead.Parameters[98].Subindex := 16#D;

	P74ParRead.Parameters[99].Index  := 16#202A;  (* IP2 *)
	P74ParRead.Parameters[99].Subindex := 16#17;

	P74ParRead.Parameters[100].Index  := 16#202A;  (* CMP2 *)
	P74ParRead.Parameters[100].Subindex := 16#21;

	P74ParRead.Parameters[101].Index  := 16#202A;  (* CRP2 *)
	P74ParRead.Parameters[101].Subindex := 16#5D;

	P74ParRead.Parameters[102].Index  := 16#202A;  (* RTP2 *)
	P74ParRead.Parameters[102].Subindex := 16#3F;

	P74ParRead.Parameters[103].Index  := 16#202B;  (* OTP2 *)
	P74ParRead.Parameters[103].Subindex := 16#21;

	P74ParRead.Parameters[104].Index  := 16#202B;  (* TDP2 *)
	P74ParRead.Parameters[104].Subindex := 16#2B;

	P74ParRead.Parameters[105].Index  := 16#202B;  (* TJP2 *)
	P74ParRead.Parameters[105].Subindex := 16#35;

	P74ParRead.Parameters[106].Index  := 16#202B;  (* SFP2 *)
	P74ParRead.Parameters[106].Subindex := 16#3F;

	P74ParRead.Parameters[107].Index  := 16#202A;  (* DP3 *)
	P74ParRead.Parameters[107].Subindex := 16#4;

	P74ParRead.Parameters[108].Index  := 16#202A;  (* ULP3 *)
	P74ParRead.Parameters[108].Subindex := 16#4A;

	P74ParRead.Parameters[109].Index  := 16#202A;  (* LCP3 *)
	P74ParRead.Parameters[109].Subindex := 16#2C;

	P74ParRead.Parameters[110].Index  := 16#202A;  (* RFP3 *)
	P74ParRead.Parameters[110].Subindex := 16#36;

	P74ParRead.Parameters[111].Index  := 16#202A;  (* THP3 *)
	P74ParRead.Parameters[111].Subindex := 16#54;

	P74ParRead.Parameters[112].Index  := 16#202A;  (* EP3 *)
	P74ParRead.Parameters[112].Subindex := 16#E;

	P74ParRead.Parameters[113].Index  := 16#202A;  (* IP3 *)
	P74ParRead.Parameters[113].Subindex := 16#18;

	P74ParRead.Parameters[114].Index  := 16#202A;  (* CMP3 *)
	P74ParRead.Parameters[114].Subindex := 16#22;

	P74ParRead.Parameters[115].Index  := 16#202A;  (* CRP3 *)
	P74ParRead.Parameters[115].Subindex := 16#5E;

	P74ParRead.Parameters[116].Index  := 16#202A;  (* RTP3 *)
	P74ParRead.Parameters[116].Subindex := 16#40;

	P74ParRead.Parameters[117].Index  := 16#202B;  (* OTP3 *)
	P74ParRead.Parameters[117].Subindex := 16#22;

	P74ParRead.Parameters[118].Index  := 16#202B;  (* TDP3 *)
	P74ParRead.Parameters[118].Subindex := 16#2C;

	P74ParRead.Parameters[119].Index  := 16#202B;  (* TJP3 *)
	P74ParRead.Parameters[119].Subindex := 16#36;

	P74ParRead.Parameters[120].Index  := 16#202B;  (* SFP3 *)
	P74ParRead.Parameters[120].Subindex := 16#40;

	P74ParRead.Parameters[121].Index  := 16#202A;  (* DP4 *)
	P74ParRead.Parameters[121].Subindex := 16#5;

	P74ParRead.Parameters[122].Index  := 16#202A;  (* ULP4 *)
	P74ParRead.Parameters[122].Subindex := 16#4B;

	P74ParRead.Parameters[123].Index  := 16#202A;  (* LCP4 *)
	P74ParRead.Parameters[123].Subindex := 16#2D;

	P74ParRead.Parameters[124].Index  := 16#202A;  (* RFP4 *)
	P74ParRead.Parameters[124].Subindex := 16#37;

	P74ParRead.Parameters[125].Index  := 16#202A;  (* THP4 *)
	P74ParRead.Parameters[125].Subindex := 16#55;

	P74ParRead.Parameters[126].Index  := 16#202A;  (* EP4 *)
	P74ParRead.Parameters[126].Subindex := 16#F;

	P74ParRead.Parameters[127].Index  := 16#202A;  (* IP4 *)
	P74ParRead.Parameters[127].Subindex := 16#19;

	P74ParRead.Parameters[128].Index  := 16#202A;  (* CMP4 *)
	P74ParRead.Parameters[128].Subindex := 16#23;

	P74ParRead.Parameters[129].Index  := 16#202A;  (* CRP4 *)
	P74ParRead.Parameters[129].Subindex := 16#5F;

	P74ParRead.Parameters[130].Index  := 16#202A;  (* RTP4 *)
	P74ParRead.Parameters[130].Subindex := 16#41;

	P74ParRead.Parameters[131].Index  := 16#202B;  (* OTP4 *)
	P74ParRead.Parameters[131].Subindex := 16#23;

	P74ParRead.Parameters[132].Index  := 16#202B;  (* TDP4 *)
	P74ParRead.Parameters[132].Subindex := 16#2D;

	P74ParRead.Parameters[133].Index  := 16#202B;  (* TJP4 *)
	P74ParRead.Parameters[133].Subindex := 16#37;

	P74ParRead.Parameters[134].Index  := 16#202B;  (* SFP4 *)
	P74ParRead.Parameters[134].Subindex := 16#41;

	P74ParRead.Parameters[135].Index  := 16#202A;  (* DP5 *)
	P74ParRead.Parameters[135].Subindex := 16#6;

	P74ParRead.Parameters[136].Index  := 16#202A;  (* ULP5 *)
	P74ParRead.Parameters[136].Subindex := 16#4C;

	P74ParRead.Parameters[137].Index  := 16#202A;  (* LCP5 *)
	P74ParRead.Parameters[137].Subindex := 16#2E;

	P74ParRead.Parameters[138].Index  := 16#202A;  (* RFP5 *)
	P74ParRead.Parameters[138].Subindex := 16#38;

	P74ParRead.Parameters[139].Index  := 16#202A;  (* THP5 *)
	P74ParRead.Parameters[139].Subindex := 16#56;

	P74ParRead.Parameters[140].Index  := 16#202A;  (* EP5 *)
	P74ParRead.Parameters[140].Subindex := 16#10;

	P74ParRead.Parameters[141].Index  := 16#202A;  (* IP5 *)
	P74ParRead.Parameters[141].Subindex := 16#1A;

	P74ParRead.Parameters[142].Index  := 16#202A;  (* CMP5 *)
	P74ParRead.Parameters[142].Subindex := 16#24;

	P74ParRead.Parameters[143].Index  := 16#202A;  (* CRP5 *)
	P74ParRead.Parameters[143].Subindex := 16#60;

	P74ParRead.Parameters[144].Index  := 16#202A;  (* RTP5 *)
	P74ParRead.Parameters[144].Subindex := 16#42;

	P74ParRead.Parameters[145].Index  := 16#202B;  (* OTP5 *)
	P74ParRead.Parameters[145].Subindex := 16#24;

	P74ParRead.Parameters[146].Index  := 16#202B;  (* TDP5 *)
	P74ParRead.Parameters[146].Subindex := 16#2E;

	P74ParRead.Parameters[147].Index  := 16#202B;  (* TJP5 *)
	P74ParRead.Parameters[147].Subindex := 16#38;

	P74ParRead.Parameters[148].Index  := 16#202B;  (* SFP5 *)
	P74ParRead.Parameters[148].Subindex := 16#42;

	P74ParRead.Parameters[149].Index  := 16#202A;  (* DP6 *)
	P74ParRead.Parameters[149].Subindex := 16#7;

	P74ParRead.Parameters[150].Index  := 16#202A;  (* ULP6 *)
	P74ParRead.Parameters[150].Subindex := 16#4D;

	P74ParRead.Parameters[151].Index  := 16#202A;  (* LCP6 *)
	P74ParRead.Parameters[151].Subindex := 16#2F;

	P74ParRead.Parameters[152].Index  := 16#202A;  (* RFP6 *)
	P74ParRead.Parameters[152].Subindex := 16#39;

	P74ParRead.Parameters[153].Index  := 16#202A;  (* THP6 *)
	P74ParRead.Parameters[153].Subindex := 16#57;

	P74ParRead.Parameters[154].Index  := 16#202A;  (* EP6 *)
	P74ParRead.Parameters[154].Subindex := 16#11;

	P74ParRead.Parameters[155].Index  := 16#202A;  (* IP6 *)
	P74ParRead.Parameters[155].Subindex := 16#1B;

	P74ParRead.Parameters[156].Index  := 16#202A;  (* CMP6 *)
	P74ParRead.Parameters[156].Subindex := 16#25;

	P74ParRead.Parameters[157].Index  := 16#202A;  (* CRP6 *)
	P74ParRead.Parameters[157].Subindex := 16#61;

	P74ParRead.Parameters[158].Index  := 16#202A;  (* RTP6 *)
	P74ParRead.Parameters[158].Subindex := 16#43;

	P74ParRead.Parameters[159].Index  := 16#202B;  (* OTP6 *)
	P74ParRead.Parameters[159].Subindex := 16#25;

	P74ParRead.Parameters[160].Index  := 16#202B;  (* TDP6 *)
	P74ParRead.Parameters[160].Subindex := 16#2F;

	P74ParRead.Parameters[161].Index  := 16#202B;  (* TJP6 *)
	P74ParRead.Parameters[161].Subindex := 16#39;

	P74ParRead.Parameters[162].Index  := 16#202B;  (* SFP6 *)
	P74ParRead.Parameters[162].Subindex := 16#43;

	P74ParRead.Parameters[163].Index  := 16#202A;  (* DP7 *)
	P74ParRead.Parameters[163].Subindex := 16#8;

	P74ParRead.Parameters[164].Index  := 16#202A;  (* ULP7 *)
	P74ParRead.Parameters[164].Subindex := 16#4E;

	P74ParRead.Parameters[165].Index  := 16#202A;  (* LCP7 *)
	P74ParRead.Parameters[165].Subindex := 16#30;

	P74ParRead.Parameters[166].Index  := 16#202A;  (* RFP7 *)
	P74ParRead.Parameters[166].Subindex := 16#3A;

	P74ParRead.Parameters[167].Index  := 16#202A;  (* THP7 *)
	P74ParRead.Parameters[167].Subindex := 16#58;

	P74ParRead.Parameters[168].Index  := 16#202A;  (* EP7 *)
	P74ParRead.Parameters[168].Subindex := 16#12;

	P74ParRead.Parameters[169].Index  := 16#202A;  (* IP7 *)
	P74ParRead.Parameters[169].Subindex := 16#1C;

	P74ParRead.Parameters[170].Index  := 16#202A;  (* CMP7 *)
	P74ParRead.Parameters[170].Subindex := 16#26;

	P74ParRead.Parameters[171].Index  := 16#202A;  (* CRP7 *)
	P74ParRead.Parameters[171].Subindex := 16#62;

	P74ParRead.Parameters[172].Index  := 16#202A;  (* RTP7 *)
	P74ParRead.Parameters[172].Subindex := 16#44;

	P74ParRead.Parameters[173].Index  := 16#202B;  (* OTP7 *)
	P74ParRead.Parameters[173].Subindex := 16#26;

	P74ParRead.Parameters[174].Index  := 16#202B;  (* TDP7 *)
	P74ParRead.Parameters[174].Subindex := 16#30;

	P74ParRead.Parameters[175].Index  := 16#202B;  (* TJP7 *)
	P74ParRead.Parameters[175].Subindex := 16#3A;

	P74ParRead.Parameters[176].Index  := 16#202B;  (* SFP7 *)
	P74ParRead.Parameters[176].Subindex := 16#44;

	P74ParRead.Parameters[177].Index  := 16#202A;  (* DP8 *)
	P74ParRead.Parameters[177].Subindex := 16#9;

	P74ParRead.Parameters[178].Index  := 16#202A;  (* ULP8 *)
	P74ParRead.Parameters[178].Subindex := 16#4F;

	P74ParRead.Parameters[179].Index  := 16#202A;  (* LCP8 *)
	P74ParRead.Parameters[179].Subindex := 16#31;

	P74ParRead.Parameters[180].Index  := 16#202A;  (* RFP8 *)
	P74ParRead.Parameters[180].Subindex := 16#3B;

	P74ParRead.Parameters[181].Index  := 16#202A;  (* THP8 *)
	P74ParRead.Parameters[181].Subindex := 16#59;

	P74ParRead.Parameters[182].Index  := 16#202A;  (* EP8 *)
	P74ParRead.Parameters[182].Subindex := 16#13;

	P74ParRead.Parameters[183].Index  := 16#202A;  (* IP8 *)
	P74ParRead.Parameters[183].Subindex := 16#1D;

	P74ParRead.Parameters[184].Index  := 16#202A;  (* CMP8 *)
	P74ParRead.Parameters[184].Subindex := 16#27;

	P74ParRead.Parameters[185].Index  := 16#202A;  (* CRP8 *)
	P74ParRead.Parameters[185].Subindex := 16#63;

	P74ParRead.Parameters[186].Index  := 16#202A;  (* RTP8 *)
	P74ParRead.Parameters[186].Subindex := 16#45;

	P74ParRead.Parameters[187].Index  := 16#202B;  (* OTP8 *)
	P74ParRead.Parameters[187].Subindex := 16#27;

	P74ParRead.Parameters[188].Index  := 16#202B;  (* TDP8 *)
	P74ParRead.Parameters[188].Subindex := 16#31;

	P74ParRead.Parameters[189].Index  := 16#202B;  (* TJP8 *)
	P74ParRead.Parameters[189].Subindex := 16#3B;

	P74ParRead.Parameters[190].Index  := 16#202B;  (* SFP8 *)
	P74ParRead.Parameters[190].Subindex := 16#45;

	P74ParRead.Parameters[191].Index  := 16#2000;  (* NCV *)
	P74ParRead.Parameters[191].Subindex := 16#C;

	P74ParRead.Parameters[192].Index  := 16#2000;  (* VCAL *)
	P74ParRead.Parameters[192].Subindex := 16#D;

	P74ParRead.Parameters[193].Index  := 16#2000;  (* INV *)
	P74ParRead.Parameters[193].Subindex := 16#12;

	P74ParRead.Parameters[194].Index  := 16#2003;  (* VDP *)
	P74ParRead.Parameters[194].Subindex := 16#3;

	P74ParRead.Parameters[195].Index  := 16#2003;  (* PAN0 *)
	P74ParRead.Parameters[195].Subindex := 16#29;

	P74ParRead.Parameters[196].Index  := 16#2003;  (* PAN1 *)
	P74ParRead.Parameters[196].Subindex := 16#2A;

	P74ParRead.Parameters[197].Index  := 16#2003;  (* PAN2 *)
	P74ParRead.Parameters[197].Subindex := 16#2B;

	P74ParRead.Parameters[198].Index  := 16#2003;  (* PAN3 *)
	P74ParRead.Parameters[198].Subindex := 16#2C;

	P74ParRead.Parameters[199].Index  := 16#2003;  (* PAN4 *)
	P74ParRead.Parameters[199].Subindex := 16#2D;

	P74ParRead.Parameters[200].Index  := 16#2003;  (* PAN5 *)
	P74ParRead.Parameters[200].Subindex := 16#2E;

	P74ParRead.Parameters[201].Index  := 16#2003;  (* PAN6 *)
	P74ParRead.Parameters[201].Subindex := 16#2F;

	P74ParRead.Parameters[202].Index  := 16#2003;  (* PAN7 *)
	P74ParRead.Parameters[202].Subindex := 16#30;

	P74ParRead.Parameters[203].Index  := 16#2061;  (* NC1 *)
	P74ParRead.Parameters[203].Subindex := 16#3E;

	P74ParRead.Parameters[204].Index  := 16#2061;  (* NC2 *)
	P74ParRead.Parameters[204].Subindex := 16#3F;

	P74ParRead.Parameters[205].Index  := 16#2061;  (* NC3 *)
	P74ParRead.Parameters[205].Subindex := 16#40;

	P74ParRead.Parameters[206].Index  := 16#2061;  (* NC4 *)
	P74ParRead.Parameters[206].Subindex := 16#41;

	P74ParRead.Parameters[207].Index  := 16#2061;  (* NC5 *)
	P74ParRead.Parameters[207].Subindex := 16#42;

	P74ParRead.Parameters[208].Index  := 16#2061;  (* NC6 *)
	P74ParRead.Parameters[208].Subindex := 16#43;

	P74ParRead.Parameters[209].Index  := 16#2061;  (* NC7 *)
	P74ParRead.Parameters[209].Subindex := 16#44;

	P74ParRead.Parameters[210].Index  := 16#2061;  (* NC8 *)
	P74ParRead.Parameters[210].Subindex := 16#45;

	P74ParRead.Parameters[211].Index  := 16#2061;  (* NM1 *)
	P74ParRead.Parameters[211].Subindex := 16#2A;

	P74ParRead.Parameters[212].Index  := 16#2061;  (* NM2 *)
	P74ParRead.Parameters[212].Subindex := 16#2B;

	P74ParRead.Parameters[213].Index  := 16#2061;  (* NM3 *)
	P74ParRead.Parameters[213].Subindex := 16#2C;

	P74ParRead.Parameters[214].Index  := 16#2061;  (* NM4 *)
	P74ParRead.Parameters[214].Subindex := 16#2D;

	P74ParRead.Parameters[215].Index  := 16#2061;  (* NM5 *)
	P74ParRead.Parameters[215].Subindex := 16#2E;

	P74ParRead.Parameters[216].Index  := 16#2061;  (* NM6 *)
	P74ParRead.Parameters[216].Subindex := 16#2F;

	P74ParRead.Parameters[217].Index  := 16#2061;  (* NM7 *)
	P74ParRead.Parameters[217].Subindex := 16#30;

	P74ParRead.Parameters[218].Index  := 16#2061;  (* NM8 *)
	P74ParRead.Parameters[218].Subindex := 16#31;

	P74ParRead.Parameters[219].Index  := 16#2038;  (* SMAL *)
	P74ParRead.Parameters[219].Subindex := 16#A;

	P74ParRead.Parameters[220].Index  := 16#2038;  (* SMIL *)
	P74ParRead.Parameters[220].Subindex := 16#8;

	P74ParRead.Parameters[221].Index  := 16#2038;  (* SPAL *)
	P74ParRead.Parameters[221].Subindex := 16#C;

	P74ParRead.Parameters[222].Index  := 16#2038;  (* SPAT *)
	P74ParRead.Parameters[222].Subindex := 16#E;

	P74ParRead.Parameters[223].Index  := 16#2038;  (* SPDL *)
	P74ParRead.Parameters[223].Subindex := 16#F;

	P74ParRead.Parameters[224].Index  := 16#2038;  (* SPDT *)
	P74ParRead.Parameters[224].Subindex := 16#11;

	P74ParRead.Parameters[225].Index  := 16#2038;  (* SPFN *)
	P74ParRead.Parameters[225].Subindex := 16#2B;

	P74ParRead.Parameters[226].Index  := 16#2038;  (* SPFD *)
	P74ParRead.Parameters[226].Subindex := 16#2C;

	P74ParRead.Parameters[227].Index  := 16#2038;  (* DOTD *)
	P74ParRead.Parameters[227].Subindex := 16#35;

	P74ParRead.Parameters[228].Index  := 16#2038;  (* QSTD *)
	P74ParRead.Parameters[228].Subindex := 16#34;

	P74ParRead.Parameters[229].Index  := 16#2032;  (* SCS *)
	P74ParRead.Parameters[229].Subindex := 16#2;

	P74ParRead.Parameters[230].Index  := 16#2032;  (* FCS *)
	P74ParRead.Parameters[230].Subindex := 16#3;

	P74ParRead.Parameters[231].Index  := 16#2000;  (* FRY *)
	P74ParRead.Parameters[231].Subindex := 16#17;

	P74ParRead.Parameters[232].Index  := 16#2063;  (* CHA1 *)
	P74ParRead.Parameters[232].Subindex := 16#3;

	P74ParRead.Parameters[233].Index  := 16#2063;  (* CHA2 *)
	P74ParRead.Parameters[233].Subindex := 16#4;

	P74ParRead.Parameters[234].Index  := 16#2063;  (* CFPS *)
	P74ParRead.Parameters[234].Subindex := 16#1;

	P74ParRead.Parameters[235].Index  := 16#2063;  (* VAL *)
	P74ParRead.Parameters[235].Subindex := 16#2;

	P74ParRead.Parameters[236].Index  := 16#2063;  (* AD01 *)
	P74ParRead.Parameters[236].Subindex := 16#C;

	P74ParRead.Parameters[237].Index  := 16#2063;  (* AD02 *)
	P74ParRead.Parameters[237].Subindex := 16#D;

	P74ParRead.Parameters[238].Index  := 16#2063;  (* AD03 *)
	P74ParRead.Parameters[238].Subindex := 16#E;

	P74ParRead.Parameters[239].Index  := 16#2063;  (* AD04 *)
	P74ParRead.Parameters[239].Subindex := 16#F;

	P74ParRead.Parameters[240].Index  := 16#2063;  (* AD05 *)
	P74ParRead.Parameters[240].Subindex := 16#10;

	P74ParRead.Parameters[241].Index  := 16#2063;  (* AD06 *)
	P74ParRead.Parameters[241].Subindex := 16#11;

	P74ParRead.Parameters[242].Index  := 16#2063;  (* AD07 *)
	P74ParRead.Parameters[242].Subindex := 16#12;

	P74ParRead.Parameters[243].Index  := 16#2063;  (* AD08 *)
	P74ParRead.Parameters[243].Subindex := 16#13;

	P74ParRead.Parameters[244].Index  := 16#2063;  (* AD09 *)
	P74ParRead.Parameters[244].Subindex := 16#14;

	P74ParRead.Parameters[245].Index  := 16#2063;  (* AD10 *)
	P74ParRead.Parameters[245].Subindex := 16#15;

	P74ParRead.Parameters[246].Index  := 16#2063;  (* AD11 *)
	P74ParRead.Parameters[246].Subindex := 16#16;

	P74ParRead.Parameters[247].Index  := 16#2063;  (* AD12 *)
	P74ParRead.Parameters[247].Subindex := 16#17;

	P74ParRead.Parameters[248].Index  := 16#2063;  (* AD13 *)
	P74ParRead.Parameters[248].Subindex := 16#18;

	P74ParRead.Parameters[249].Index  := 16#2063;  (* AD14 *)
	P74ParRead.Parameters[249].Subindex := 16#19;

	P74ParRead.Parameters[250].Index  := 16#2063;  (* AD15 *)
	P74ParRead.Parameters[250].Subindex := 16#1A;

	P74ParRead.Parameters[251].Index  := 16#2063;  (* S101 *)
	P74ParRead.Parameters[251].Subindex := 16#20;

	P74ParRead.Parameters[252].Index  := 16#2063;  (* S102 *)
	P74ParRead.Parameters[252].Subindex := 16#21;

	P74ParRead.Parameters[253].Index  := 16#2063;  (* S103 *)
	P74ParRead.Parameters[253].Subindex := 16#22;

	P74ParRead.Parameters[254].Index  := 16#2063;  (* S104 *)
	P74ParRead.Parameters[254].Subindex := 16#23;

	P74ParRead.Parameters[255].Index  := 16#2063;  (* S105 *)
	P74ParRead.Parameters[255].Subindex := 16#24;

	P74ParRead.Parameters[256].Index  := 16#2063;  (* S106 *)
	P74ParRead.Parameters[256].Subindex := 16#25;

	P74ParRead.Parameters[257].Index  := 16#2063;  (* S107 *)
	P74ParRead.Parameters[257].Subindex := 16#26;

	P74ParRead.Parameters[258].Index  := 16#2063;  (* S108 *)
	P74ParRead.Parameters[258].Subindex := 16#27;

	P74ParRead.Parameters[259].Index  := 16#2063;  (* S109 *)
	P74ParRead.Parameters[259].Subindex := 16#28;

	P74ParRead.Parameters[260].Index  := 16#2063;  (* S110 *)
	P74ParRead.Parameters[260].Subindex := 16#29;

	P74ParRead.Parameters[261].Index  := 16#2063;  (* S111 *)
	P74ParRead.Parameters[261].Subindex := 16#2A;

	P74ParRead.Parameters[262].Index  := 16#2063;  (* S112 *)
	P74ParRead.Parameters[262].Subindex := 16#2B;

	P74ParRead.Parameters[263].Index  := 16#2063;  (* S113 *)
	P74ParRead.Parameters[263].Subindex := 16#2C;

	P74ParRead.Parameters[264].Index  := 16#2063;  (* S114 *)
	P74ParRead.Parameters[264].Subindex := 16#2D;

	P74ParRead.Parameters[265].Index  := 16#2063;  (* S115 *)
	P74ParRead.Parameters[265].Subindex := 16#2E;

	P74ParRead.Parameters[266].Index  := 16#2063;  (* S201 *)
	P74ParRead.Parameters[266].Subindex := 16#34;

	P74ParRead.Parameters[267].Index  := 16#2063;  (* S202 *)
	P74ParRead.Parameters[267].Subindex := 16#35;

	P74ParRead.Parameters[268].Index  := 16#2063;  (* S203 *)
	P74ParRead.Parameters[268].Subindex := 16#36;

	P74ParRead.Parameters[269].Index  := 16#2063;  (* S204 *)
	P74ParRead.Parameters[269].Subindex := 16#37;

	P74ParRead.Parameters[270].Index  := 16#2063;  (* S205 *)
	P74ParRead.Parameters[270].Subindex := 16#38;

	P74ParRead.Parameters[271].Index  := 16#2063;  (* S206 *)
	P74ParRead.Parameters[271].Subindex := 16#39;

	P74ParRead.Parameters[272].Index  := 16#2063;  (* S207 *)
	P74ParRead.Parameters[272].Subindex := 16#3A;

	P74ParRead.Parameters[273].Index  := 16#2063;  (* S208 *)
	P74ParRead.Parameters[273].Subindex := 16#3B;

	P74ParRead.Parameters[274].Index  := 16#2063;  (* S209 *)
	P74ParRead.Parameters[274].Subindex := 16#3C;

	P74ParRead.Parameters[275].Index  := 16#2063;  (* S210 *)
	P74ParRead.Parameters[275].Subindex := 16#3D;

	P74ParRead.Parameters[276].Index  := 16#2063;  (* S211 *)
	P74ParRead.Parameters[276].Subindex := 16#3E;

	P74ParRead.Parameters[277].Index  := 16#2063;  (* S212 *)
	P74ParRead.Parameters[277].Subindex := 16#3F;

	P74ParRead.Parameters[278].Index  := 16#2063;  (* S213 *)
	P74ParRead.Parameters[278].Subindex := 16#40;

	P74ParRead.Parameters[279].Index  := 16#2063;  (* S214 *)
	P74ParRead.Parameters[279].Subindex := 16#41;

	P74ParRead.Parameters[280].Index  := 16#2063;  (* S215 *)
	P74ParRead.Parameters[280].Subindex := 16#42;

	P74ParRead.Parameters[281].Index  := 16#2063;  (* S301 *)
	P74ParRead.Parameters[281].Subindex := 16#48;

	P74ParRead.Parameters[282].Index  := 16#2063;  (* S302 *)
	P74ParRead.Parameters[282].Subindex := 16#49;

	P74ParRead.Parameters[283].Index  := 16#2063;  (* S303 *)
	P74ParRead.Parameters[283].Subindex := 16#4A;

	P74ParRead.Parameters[284].Index  := 16#2063;  (* S304 *)
	P74ParRead.Parameters[284].Subindex := 16#4B;

	P74ParRead.Parameters[285].Index  := 16#2063;  (* S305 *)
	P74ParRead.Parameters[285].Subindex := 16#4C;

	P74ParRead.Parameters[286].Index  := 16#2063;  (* S306 *)
	P74ParRead.Parameters[286].Subindex := 16#4D;

	P74ParRead.Parameters[287].Index  := 16#2063;  (* S307 *)
	P74ParRead.Parameters[287].Subindex := 16#4E;

	P74ParRead.Parameters[288].Index  := 16#2063;  (* S308 *)
	P74ParRead.Parameters[288].Subindex := 16#4F;

	P74ParRead.Parameters[289].Index  := 16#2063;  (* S309 *)
	P74ParRead.Parameters[289].Subindex := 16#50;

	P74ParRead.Parameters[290].Index  := 16#2063;  (* S310 *)
	P74ParRead.Parameters[290].Subindex := 16#51;

	P74ParRead.Parameters[291].Index  := 16#2063;  (* S311 *)
	P74ParRead.Parameters[291].Subindex := 16#52;

	P74ParRead.Parameters[292].Index  := 16#2063;  (* S312 *)
	P74ParRead.Parameters[292].Subindex := 16#53;

	P74ParRead.Parameters[293].Index  := 16#2063;  (* S313 *)
	P74ParRead.Parameters[293].Subindex := 16#54;

	P74ParRead.Parameters[294].Index  := 16#2063;  (* S314 *)
	P74ParRead.Parameters[294].Subindex := 16#55;

	P74ParRead.Parameters[295].Index  := 16#2063;  (* S315 *)
	P74ParRead.Parameters[295].Subindex := 16#56;

	P74ParRead.Parameters[296].Index  := 16#2000;  (* CFG *)
	P74ParRead.Parameters[296].Subindex := 16#35;

	P74ParRead.Parameters[297].Index  := 16#2000;  (* CCFG *)
	P74ParRead.Parameters[297].Subindex := 16#36;

	P74ParRead.Parameters[298].Index  := 16#2001;  (* LSP *)
	P74ParRead.Parameters[298].Subindex := 16#6;

	P74ParRead.Parameters[299].Index  := 16#2001;  (* HSP *)
	P74ParRead.Parameters[299].Subindex := 16#5;

	P74ParRead.Parameters[300].Index  := 16#2079;  (* HSP2 *)
	P74ParRead.Parameters[300].Subindex := 16#B;

	P74ParRead.Parameters[301].Index  := 16#2079;  (* HSP3 *)
	P74ParRead.Parameters[301].Subindex := 16#C;

	P74ParRead.Parameters[302].Index  := 16#2079;  (* HSP4 *)
	P74ParRead.Parameters[302].Subindex := 16#D;

	P74ParRead.Parameters[303].Index  := 16#2079;  (* SH2 *)
	P74ParRead.Parameters[303].Subindex := 16#2;

	P74ParRead.Parameters[304].Index  := 16#2079;  (* SH4 *)
	P74ParRead.Parameters[304].Subindex := 16#3;

	P74ParRead.Parameters[305].Index  := 16#2042;  (* ITH *)
	P74ParRead.Parameters[305].Subindex := 16#17;

	P74ParRead.Parameters[306].Index  := 16#203D;  (* SPG *)
	P74ParRead.Parameters[306].Subindex := 16#4;

	P74ParRead.Parameters[307].Index  := 16#2042;  (* SPGU *)
	P74ParRead.Parameters[307].Subindex := 16#1E;

	P74ParRead.Parameters[308].Index  := 16#203D;  (* SIT *)
	P74ParRead.Parameters[308].Subindex := 16#5;

	P74ParRead.Parameters[309].Index  := 16#203D;  (* SFC *)
	P74ParRead.Parameters[309].Subindex := 16#6;

	P74ParRead.Parameters[310].Index  := 16#203D;  (* FFH *)
	P74ParRead.Parameters[310].Subindex := 16#10;

	P74ParRead.Parameters[311].Index  := 16#203D;  (* CRTF *)
	P74ParRead.Parameters[311].Subindex := 16#11;

	P74ParRead.Parameters[312].Index  := 16#2050;  (* CTD *)
	P74ParRead.Parameters[312].Subindex := 16#2;

	P74ParRead.Parameters[313].Index  := 16#2050;  (* TTH *)
	P74ParRead.Parameters[313].Subindex := 16#11;

	P74ParRead.Parameters[314].Index  := 16#2050;  (* TTL *)
	P74ParRead.Parameters[314].Subindex := 16#10;

	P74ParRead.Parameters[315].Index  := 16#2074;  (* FQL *)
	P74ParRead.Parameters[315].Subindex := 16#A;

	P74ParRead.Parameters[316].Index  := 16#2050;  (* FTD *)
	P74ParRead.Parameters[316].Subindex := 16#4;

	P74ParRead.Parameters[317].Index  := 16#2050;  (* F2D *)
	P74ParRead.Parameters[317].Subindex := 16#5;

	P74ParRead.Parameters[318].Index  := 16#2053;  (* JF2 *)
	P74ParRead.Parameters[318].Subindex := 16#3;

	P74ParRead.Parameters[319].Index  := 16#2053;  (* JPF *)
	P74ParRead.Parameters[319].Subindex := 16#2;

	P74ParRead.Parameters[320].Index  := 16#2053;  (* JFH *)
	P74ParRead.Parameters[320].Subindex := 16#C;

	P74ParRead.Parameters[321].Index  := 16#2053;  (* JF3 *)
	P74ParRead.Parameters[321].Subindex := 16#4;

	P74ParRead.Parameters[322].Index  := 16#2000;  (* BFR *)
	P74ParRead.Parameters[322].Subindex := 16#10;

	P74ParRead.Parameters[323].Index  := 16#2042;  (* NPR *)
	P74ParRead.Parameters[323].Subindex := 16#E;

	P74ParRead.Parameters[324].Index  := 16#2042;  (* COS *)
	P74ParRead.Parameters[324].Subindex := 16#7;

	P74ParRead.Parameters[325].Index  := 16#2042;  (* UNS *)
	P74ParRead.Parameters[325].Subindex := 16#2;

	P74ParRead.Parameters[326].Index  := 16#2042;  (* NCR *)
	P74ParRead.Parameters[326].Subindex := 16#4;

	P74ParRead.Parameters[327].Index  := 16#2042;  (* FRS *)
	P74ParRead.Parameters[327].Subindex := 16#3;

	P74ParRead.Parameters[328].Index  := 16#2042;  (* NSP *)
	P74ParRead.Parameters[328].Subindex := 16#5;

	P74ParRead.Parameters[329].Index  := 16#2001;  (* TFR *)
	P74ParRead.Parameters[329].Subindex := 16#4;

	P74ParRead.Parameters[330].Index  := 16#2042;  (* TUN *)
	P74ParRead.Parameters[330].Subindex := 16#9;

	P74ParRead.Parameters[331].Index  := 16#2042;  (* AUT *)
	P74ParRead.Parameters[331].Subindex := 16#10;

	P74ParRead.Parameters[332].Index  := 16#2042;  (* TUS *)
	P74ParRead.Parameters[332].Subindex := 16#A;

	P74ParRead.Parameters[333].Index  := 16#2042;  (* CTT *)
	P74ParRead.Parameters[333].Subindex := 16#8;

	P74ParRead.Parameters[334].Index  := 16#205E;  (* U1 *)
	P74ParRead.Parameters[334].Subindex := 16#4;

	P74ParRead.Parameters[335].Index  := 16#205E;  (* F1 *)
	P74ParRead.Parameters[335].Subindex := 16#5;

	P74ParRead.Parameters[336].Index  := 16#205E;  (* U2 *)
	P74ParRead.Parameters[336].Subindex := 16#6;

	P74ParRead.Parameters[337].Index  := 16#205E;  (* F2 *)
	P74ParRead.Parameters[337].Subindex := 16#7;

	P74ParRead.Parameters[338].Index  := 16#205E;  (* U3 *)
	P74ParRead.Parameters[338].Subindex := 16#8;

	P74ParRead.Parameters[339].Index  := 16#205E;  (* F3 *)
	P74ParRead.Parameters[339].Subindex := 16#9;

	P74ParRead.Parameters[340].Index  := 16#205E;  (* U4 *)
	P74ParRead.Parameters[340].Subindex := 16#A;

	P74ParRead.Parameters[341].Index  := 16#205E;  (* F4 *)
	P74ParRead.Parameters[341].Subindex := 16#B;

	P74ParRead.Parameters[342].Index  := 16#205E;  (* U5 *)
	P74ParRead.Parameters[342].Subindex := 16#C;

	P74ParRead.Parameters[343].Index  := 16#205E;  (* F5 *)
	P74ParRead.Parameters[343].Subindex := 16#D;

	P74ParRead.Parameters[344].Index  := 16#2042;  (* NCRS *)
	P74ParRead.Parameters[344].Subindex := 16#47;

	P74ParRead.Parameters[345].Index  := 16#2042;  (* NSPS *)
	P74ParRead.Parameters[345].Subindex := 16#48;

	P74ParRead.Parameters[346].Index  := 16#2042;  (* PPNS *)
	P74ParRead.Parameters[346].Subindex := 16#49;

	P74ParRead.Parameters[347].Index  := 16#2042;  (* TQS *)
	P74ParRead.Parameters[347].Subindex := 16#55;

	P74ParRead.Parameters[348].Index  := 16#2042;  (* PHS *)
	P74ParRead.Parameters[348].Subindex := 16#4A;

	P74ParRead.Parameters[349].Index  := 16#2042;  (* LDS *)
	P74ParRead.Parameters[349].Subindex := 16#4B;

	P74ParRead.Parameters[350].Index  := 16#2042;  (* LQS *)
	P74ParRead.Parameters[350].Subindex := 16#4C;

	P74ParRead.Parameters[351].Index  := 16#2042;  (* RSAS *)
	P74ParRead.Parameters[351].Subindex := 16#53;

	P74ParRead.Parameters[352].Index  := 16#2042;  (* UFR *)
	P74ParRead.Parameters[352].Subindex := 16#18;

	P74ParRead.Parameters[353].Index  := 16#2042;  (* SLP *)
	P74ParRead.Parameters[353].Subindex := 16#1A;

	P74ParRead.Parameters[354].Index  := 16#2042;  (* PPN *)
	P74ParRead.Parameters[354].Subindex := 16#13;

	P74ParRead.Parameters[355].Index  := 16#2042;  (* RSA *)
	P74ParRead.Parameters[355].Subindex := 16#2B;

	P74ParRead.Parameters[356].Index  := 16#2042;  (* IDA *)
	P74ParRead.Parameters[356].Subindex := 16#35;

	P74ParRead.Parameters[357].Index  := 16#2042;  (* LFA *)
	P74ParRead.Parameters[357].Subindex := 16#3F;

	P74ParRead.Parameters[358].Index  := 16#2042;  (* TRA *)
	P74ParRead.Parameters[358].Subindex := 16#44;

	P74ParRead.Parameters[359].Index  := 16#2042;  (* FRSS *)
	P74ParRead.Parameters[359].Subindex := 16#50;

	P74ParRead.Parameters[360].Index  := 16#2001;  (* SFR *)
	P74ParRead.Parameters[360].Subindex := 16#3;

	P74ParRead.Parameters[361].Index  := 16#203E;  (* CLI *)
	P74ParRead.Parameters[361].Subindex := 16#2;

	P74ParRead.Parameters[362].Index  := 16#2001;  (* SFT *)
	P74ParRead.Parameters[362].Subindex := 16#2;

	P74ParRead.Parameters[363].Index  := 16#2001;  (* NRD *)
	P74ParRead.Parameters[363].Subindex := 16#8;

	P74ParRead.Parameters[364].Index  := 16#206D;  (* BOA *)
	P74ParRead.Parameters[364].Subindex := 16#B;

	P74ParRead.Parameters[365].Index  := 16#2060;  (* SVL *)
	P74ParRead.Parameters[365].Subindex := 16#2;

	P74ParRead.Parameters[366].Index  := 16#2060;  (* SOP *)
	P74ParRead.Parameters[366].Subindex := 16#3;

	P74ParRead.Parameters[367].Index  := 16#206F;  (* VBR *)
	P74ParRead.Parameters[367].Subindex := 16#2;

	P74ParRead.Parameters[368].Index  := 16#2071;  (* LBA *)
	P74ParRead.Parameters[368].Subindex := 16#2;

	P74ParRead.Parameters[369].Index  := 16#2071;  (* LBC *)
	P74ParRead.Parameters[369].Subindex := 16#3;

	P74ParRead.Parameters[370].Index  := 16#2071;  (* LBC1 *)
	P74ParRead.Parameters[370].Subindex := 16#4;

	P74ParRead.Parameters[371].Index  := 16#2071;  (* LBC2 *)
	P74ParRead.Parameters[371].Subindex := 16#5;

	P74ParRead.Parameters[372].Index  := 16#2071;  (* LBC3 *)
	P74ParRead.Parameters[372].Subindex := 16#6;

	P74ParRead.Parameters[373].Index  := 16#2071;  (* LBF *)
	P74ParRead.Parameters[373].Subindex := 16#7;

	P74ParRead.Parameters[374].Index  := 16#2001;  (* FFM *)
	P74ParRead.Parameters[374].Subindex := 16#1F;

	P74ParRead.Parameters[375].Index  := 16#2051;  (* TCC *)
	P74ParRead.Parameters[375].Subindex := 16#2;

	P74ParRead.Parameters[376].Index  := 16#2051;  (* TCT *)
	P74ParRead.Parameters[376].Subindex := 16#3;

	P74ParRead.Parameters[377].Index  := 16#2051;  (* RRS *)
	P74ParRead.Parameters[377].Subindex := 16#6;

	P74ParRead.Parameters[378].Index  := 16#2001;  (* BSP *)
	P74ParRead.Parameters[378].Subindex := 16#7;

	P74ParRead.Parameters[379].Index  := 16#200E;  (* AI1T *)
	P74ParRead.Parameters[379].Subindex := 16#3;

	P74ParRead.Parameters[380].Index  := 16#200E;  (* UIL1 *)
	P74ParRead.Parameters[380].Subindex := 16#D;

	P74ParRead.Parameters[381].Index  := 16#200E;  (* UIH1 *)
	P74ParRead.Parameters[381].Subindex := 16#17;

	P74ParRead.Parameters[382].Index  := 16#200E;  (* AI1F *)
	P74ParRead.Parameters[382].Subindex := 16#35;

	P74ParRead.Parameters[383].Index  := 16#200E;  (* AI1E *)
	P74ParRead.Parameters[383].Subindex := 16#3F;

	P74ParRead.Parameters[384].Index  := 16#200E;  (* AI1S *)
	P74ParRead.Parameters[384].Subindex := 16#49;

	P74ParRead.Parameters[385].Index  := 16#200E;  (* AI1L *)
	P74ParRead.Parameters[385].Subindex := 16#53;

	P74ParRead.Parameters[386].Index  := 16#200E;  (* AI2T *)
	P74ParRead.Parameters[386].Subindex := 16#4;

	P74ParRead.Parameters[387].Index  := 16#200E;  (* UIL2 *)
	P74ParRead.Parameters[387].Subindex := 16#E;

	P74ParRead.Parameters[388].Index  := 16#200E;  (* UIH2 *)
	P74ParRead.Parameters[388].Subindex := 16#18;

	P74ParRead.Parameters[389].Index  := 16#200E;  (* AI2F *)
	P74ParRead.Parameters[389].Subindex := 16#36;

	P74ParRead.Parameters[390].Index  := 16#200E;  (* AI2L *)
	P74ParRead.Parameters[390].Subindex := 16#54;

	P74ParRead.Parameters[391].Index  := 16#200E;  (* AI2E *)
	P74ParRead.Parameters[391].Subindex := 16#40;

	P74ParRead.Parameters[392].Index  := 16#200E;  (* AI2S *)
	P74ParRead.Parameters[392].Subindex := 16#4A;

	P74ParRead.Parameters[393].Index  := 16#200E;  (* AI3T *)
	P74ParRead.Parameters[393].Subindex := 16#5;

	P74ParRead.Parameters[394].Index  := 16#200E;  (* CRL3 *)
	P74ParRead.Parameters[394].Subindex := 16#23;

	P74ParRead.Parameters[395].Index  := 16#200E;  (* CRH3 *)
	P74ParRead.Parameters[395].Subindex := 16#2D;

	P74ParRead.Parameters[396].Index  := 16#200E;  (* AI3F *)
	P74ParRead.Parameters[396].Subindex := 16#37;

	P74ParRead.Parameters[397].Index  := 16#200E;  (* AI3L *)
	P74ParRead.Parameters[397].Subindex := 16#55;

	P74ParRead.Parameters[398].Index  := 16#200E;  (* AI3E *)
	P74ParRead.Parameters[398].Subindex := 16#41;

	P74ParRead.Parameters[399].Index  := 16#200E;  (* AI3S *)
	P74ParRead.Parameters[399].Subindex := 16#4B;

	P74ParRead.Parameters[400].Index  := 16#2067;  (* PIL *)
	P74ParRead.Parameters[400].Subindex := 16#3;

	P74ParRead.Parameters[401].Index  := 16#2067;  (* PFR *)
	P74ParRead.Parameters[401].Subindex := 16#4;

	P74ParRead.Parameters[402].Index  := 16#2067;  (* PFI *)
	P74ParRead.Parameters[402].Subindex := 16#5;

	P74ParRead.Parameters[403].Index  := 16#2014;  (* LO1 *)
	P74ParRead.Parameters[403].Subindex := 16#A;

	P74ParRead.Parameters[404].Index  := 16#200C;  (* LO1D *)
	P74ParRead.Parameters[404].Subindex := 16#32;

	P74ParRead.Parameters[405].Index  := 16#200C;  (* LO1S *)
	P74ParRead.Parameters[405].Subindex := 16#A;

	P74ParRead.Parameters[406].Index  := 16#200C;  (* LO1H *)
	P74ParRead.Parameters[406].Subindex := 16#1E;

	P74ParRead.Parameters[407].Index  := 16#2014;  (* DO1 *)
	P74ParRead.Parameters[407].Subindex := 16#20;

	P74ParRead.Parameters[408].Index  := 16#200C;  (* DO1D *)
	P74ParRead.Parameters[408].Subindex := 16#52;

	P74ParRead.Parameters[409].Index  := 16#200C;  (* DO1H *)
	P74ParRead.Parameters[409].Subindex := 16#48;

	P74ParRead.Parameters[410].Index  := 16#200C;  (* DO1S *)
	P74ParRead.Parameters[410].Subindex := 16#3E;

	P74ParRead.Parameters[411].Index  := 16#2014;  (* AO1 *)
	P74ParRead.Parameters[411].Subindex := 16#16;

	P74ParRead.Parameters[412].Index  := 16#2010;  (* AO1T *)
	P74ParRead.Parameters[412].Subindex := 16#2;

	P74ParRead.Parameters[413].Index  := 16#2010;  (* AOL1 *)
	P74ParRead.Parameters[413].Subindex := 16#2A;

	P74ParRead.Parameters[414].Index  := 16#2010;  (* AOH1 *)
	P74ParRead.Parameters[414].Subindex := 16#34;

	P74ParRead.Parameters[415].Index  := 16#2010;  (* UOL1 *)
	P74ParRead.Parameters[415].Subindex := 16#16;

	P74ParRead.Parameters[416].Index  := 16#2010;  (* UOH1 *)
	P74ParRead.Parameters[416].Subindex := 16#20;

	P74ParRead.Parameters[417].Index  := 16#2010;  (* ASL1 *)
	P74ParRead.Parameters[417].Subindex := 16#3E;

	P74ParRead.Parameters[418].Index  := 16#2010;  (* ASH1 *)
	P74ParRead.Parameters[418].Subindex := 16#48;

	P74ParRead.Parameters[419].Index  := 16#2010;  (* AO1F *)
	P74ParRead.Parameters[419].Subindex := 16#C;

	P74ParRead.Parameters[420].Index  := 16#2036;  (* FR1 *)
	P74ParRead.Parameters[420].Subindex := 16#E;

	P74ParRead.Parameters[421].Index  := 16#2001;  (* RIN *)
	P74ParRead.Parameters[421].Subindex := 16#9;

	P74ParRead.Parameters[422].Index  := 16#2036;  (* CHCF *)
	P74ParRead.Parameters[422].Subindex := 16#2;

	P74ParRead.Parameters[423].Index  := 16#2036;  (* CCS *)
	P74ParRead.Parameters[423].Subindex := 16#16;

	P74ParRead.Parameters[424].Index  := 16#2036;  (* CD1 *)
	P74ParRead.Parameters[424].Subindex := 16#18;

	P74ParRead.Parameters[425].Index  := 16#2036;  (* CD2 *)
	P74ParRead.Parameters[425].Subindex := 16#19;

	P74ParRead.Parameters[426].Index  := 16#2036;  (* RFC *)
	P74ParRead.Parameters[426].Subindex := 16#C;

	P74ParRead.Parameters[427].Index  := 16#2036;  (* FR2 *)
	P74ParRead.Parameters[427].Subindex := 16#F;

	P74ParRead.Parameters[428].Index  := 16#2036;  (* COP *)
	P74ParRead.Parameters[428].Subindex := 16#3;

	P74ParRead.Parameters[429].Index  := 16#2069;  (* FN1 *)
	P74ParRead.Parameters[429].Subindex := 16#2;

	P74ParRead.Parameters[430].Index  := 16#2069;  (* FN2 *)
	P74ParRead.Parameters[430].Subindex := 16#3;

	P74ParRead.Parameters[431].Index  := 16#2069;  (* FN3 *)
	P74ParRead.Parameters[431].Subindex := 16#4;

	P74ParRead.Parameters[432].Index  := 16#2069;  (* FN4 *)
	P74ParRead.Parameters[432].Subindex := 16#5;

	P74ParRead.Parameters[433].Index  := 16#2069;  (* BMP *)
	P74ParRead.Parameters[433].Subindex := 16#1E;

	P74ParRead.Parameters[434].Index  := 16#2036;  (* RCB *)
	P74ParRead.Parameters[434].Subindex := 16#D;

	P74ParRead.Parameters[435].Index  := 16#2036;  (* FR1B *)
	P74ParRead.Parameters[435].Subindex := 16#10;

	P74ParRead.Parameters[436].Index  := 16#2058;  (* SA2 *)
	P74ParRead.Parameters[436].Subindex := 16#2;

	P74ParRead.Parameters[437].Index  := 16#2058;  (* SA3 *)
	P74ParRead.Parameters[437].Subindex := 16#3;

	P74ParRead.Parameters[438].Index  := 16#2058;  (* DA2 *)
	P74ParRead.Parameters[438].Subindex := 16#C;

	P74ParRead.Parameters[439].Index  := 16#2058;  (* DA3 *)
	P74ParRead.Parameters[439].Subindex := 16#D;

	P74ParRead.Parameters[440].Index  := 16#2058;  (* MA2 *)
	P74ParRead.Parameters[440].Subindex := 16#16;

	P74ParRead.Parameters[441].Index  := 16#2058;  (* MA3 *)
	P74ParRead.Parameters[441].Subindex := 16#17;

	P74ParRead.Parameters[442].Index  := 16#203C;  (* RPT *)
	P74ParRead.Parameters[442].Subindex := 16#5;

	P74ParRead.Parameters[443].Index  := 16#203C;  (* INR *)
	P74ParRead.Parameters[443].Subindex := 16#15;

	P74ParRead.Parameters[444].Index  := 16#203C;  (* ACC *)
	P74ParRead.Parameters[444].Subindex := 16#2;

	P74ParRead.Parameters[445].Index  := 16#203C;  (* DEC *)
	P74ParRead.Parameters[445].Subindex := 16#3;

	P74ParRead.Parameters[446].Index  := 16#203C;  (* TA1 *)
	P74ParRead.Parameters[446].Subindex := 16#6;

	P74ParRead.Parameters[447].Index  := 16#203C;  (* TA2 *)
	P74ParRead.Parameters[447].Subindex := 16#7;

	P74ParRead.Parameters[448].Index  := 16#203C;  (* TA3 *)
	P74ParRead.Parameters[448].Subindex := 16#8;

	P74ParRead.Parameters[449].Index  := 16#203C;  (* TA4 *)
	P74ParRead.Parameters[449].Subindex := 16#9;

	P74ParRead.Parameters[450].Index  := 16#203C;  (* FRT *)
	P74ParRead.Parameters[450].Subindex := 16#C;

	P74ParRead.Parameters[451].Index  := 16#203C;  (* RPS *)
	P74ParRead.Parameters[451].Subindex := 16#B;

	P74ParRead.Parameters[452].Index  := 16#203C;  (* AC2 *)
	P74ParRead.Parameters[452].Subindex := 16#D;

	P74ParRead.Parameters[453].Index  := 16#203C;  (* DE2 *)
	P74ParRead.Parameters[453].Subindex := 16#E;

	P74ParRead.Parameters[454].Index  := 16#203C;  (* BRA *)
	P74ParRead.Parameters[454].Subindex := 16#4;

	P74ParRead.Parameters[455].Index  := 16#2052;  (* STT *)
	P74ParRead.Parameters[455].Subindex := 16#2;

	P74ParRead.Parameters[456].Index  := 16#2052;  (* FFT *)
	P74ParRead.Parameters[456].Subindex := 16#15;

	P74ParRead.Parameters[457].Index  := 16#2052;  (* NST *)
	P74ParRead.Parameters[457].Subindex := 16#3;

	P74ParRead.Parameters[458].Index  := 16#2052;  (* FST *)
	P74ParRead.Parameters[458].Subindex := 16#5;

	P74ParRead.Parameters[459].Index  := 16#2052;  (* DCF *)
	P74ParRead.Parameters[459].Subindex := 16#1F;

	P74ParRead.Parameters[460].Index  := 16#2052;  (* DCI *)
	P74ParRead.Parameters[460].Subindex := 16#4;

	P74ParRead.Parameters[461].Index  := 16#2052;  (* IDC *)
	P74ParRead.Parameters[461].Subindex := 16#B;

	P74ParRead.Parameters[462].Index  := 16#2052;  (* TDI *)
	P74ParRead.Parameters[462].Subindex := 16#E;

	P74ParRead.Parameters[463].Index  := 16#2052;  (* IDC2 *)
	P74ParRead.Parameters[463].Subindex := 16#D;

	P74ParRead.Parameters[464].Index  := 16#2052;  (* TDC *)
	P74ParRead.Parameters[464].Subindex := 16#C;

	P74ParRead.Parameters[465].Index  := 16#204A;  (* ADC *)
	P74ParRead.Parameters[465].Subindex := 16#2;

	P74ParRead.Parameters[466].Index  := 16#204A;  (* SDC1 *)
	P74ParRead.Parameters[466].Subindex := 16#4;

	P74ParRead.Parameters[467].Index  := 16#204A;  (* TDC1 *)
	P74ParRead.Parameters[467].Subindex := 16#3;

	P74ParRead.Parameters[468].Index  := 16#204A;  (* SDC2 *)
	P74ParRead.Parameters[468].Subindex := 16#6;

	P74ParRead.Parameters[469].Index  := 16#204A;  (* TDC2 *)
	P74ParRead.Parameters[469].Subindex := 16#5;

	P74ParRead.Parameters[470].Index  := 16#2051;  (* JOG *)
	P74ParRead.Parameters[470].Subindex := 16#B;

	P74ParRead.Parameters[471].Index  := 16#2051;  (* JGF *)
	P74ParRead.Parameters[471].Subindex := 16#C;

	P74ParRead.Parameters[472].Index  := 16#2051;  (* JGT *)
	P74ParRead.Parameters[472].Subindex := 16#D;

	P74ParRead.Parameters[473].Index  := 16#2054;  (* PS2 *)
	P74ParRead.Parameters[473].Subindex := 16#2;

	P74ParRead.Parameters[474].Index  := 16#2054;  (* PS4 *)
	P74ParRead.Parameters[474].Subindex := 16#3;

	P74ParRead.Parameters[475].Index  := 16#2054;  (* PS8 *)
	P74ParRead.Parameters[475].Subindex := 16#4;

	P74ParRead.Parameters[476].Index  := 16#2054;  (* PS16 *)
	P74ParRead.Parameters[476].Subindex := 16#5;

	P74ParRead.Parameters[477].Index  := 16#2054;  (* SP2 *)
	P74ParRead.Parameters[477].Subindex := 16#B;

	P74ParRead.Parameters[478].Index  := 16#2054;  (* SP3 *)
	P74ParRead.Parameters[478].Subindex := 16#C;

	P74ParRead.Parameters[479].Index  := 16#2054;  (* SP4 *)
	P74ParRead.Parameters[479].Subindex := 16#D;

	P74ParRead.Parameters[480].Index  := 16#2054;  (* SP5 *)
	P74ParRead.Parameters[480].Subindex := 16#E;

	P74ParRead.Parameters[481].Index  := 16#2054;  (* SP6 *)
	P74ParRead.Parameters[481].Subindex := 16#F;

	P74ParRead.Parameters[482].Index  := 16#2054;  (* SP7 *)
	P74ParRead.Parameters[482].Subindex := 16#10;

	P74ParRead.Parameters[483].Index  := 16#2054;  (* SP8 *)
	P74ParRead.Parameters[483].Subindex := 16#11;

	P74ParRead.Parameters[484].Index  := 16#2054;  (* SP9 *)
	P74ParRead.Parameters[484].Subindex := 16#12;

	P74ParRead.Parameters[485].Index  := 16#2054;  (* SP10 *)
	P74ParRead.Parameters[485].Subindex := 16#13;

	P74ParRead.Parameters[486].Index  := 16#2054;  (* SP11 *)
	P74ParRead.Parameters[486].Subindex := 16#14;

	P74ParRead.Parameters[487].Index  := 16#2054;  (* SP12 *)
	P74ParRead.Parameters[487].Subindex := 16#15;

	P74ParRead.Parameters[488].Index  := 16#2054;  (* SP13 *)
	P74ParRead.Parameters[488].Subindex := 16#16;

	P74ParRead.Parameters[489].Index  := 16#2054;  (* SP14 *)
	P74ParRead.Parameters[489].Subindex := 16#17;

	P74ParRead.Parameters[490].Index  := 16#2054;  (* SP15 *)
	P74ParRead.Parameters[490].Subindex := 16#18;

	P74ParRead.Parameters[491].Index  := 16#2054;  (* SP16 *)
	P74ParRead.Parameters[491].Subindex := 16#19;

	P74ParRead.Parameters[492].Index  := 16#2055;  (* USP *)
	P74ParRead.Parameters[492].Subindex := 16#2;

	P74ParRead.Parameters[493].Index  := 16#2055;  (* DSP *)
	P74ParRead.Parameters[493].Subindex := 16#3;

	P74ParRead.Parameters[494].Index  := 16#2055;  (* STR *)
	P74ParRead.Parameters[494].Subindex := 16#4;

	P74ParRead.Parameters[495].Index  := 16#2055;  (* USI *)
	P74ParRead.Parameters[495].Subindex := 16#15;

	P74ParRead.Parameters[496].Index  := 16#2055;  (* DSI *)
	P74ParRead.Parameters[496].Subindex := 16#16;

	P74ParRead.Parameters[497].Index  := 16#2055;  (* SRP *)
	P74ParRead.Parameters[497].Subindex := 16#6;

	P74ParRead.Parameters[498].Index  := 16#2036;  (* SPM *)
	P74ParRead.Parameters[498].Subindex := 16#5C;

	P74ParRead.Parameters[499].Index  := 16#206D;  (* FLU *)
	P74ParRead.Parameters[499].Subindex := 16#3;

	P74ParRead.Parameters[500].Index  := 16#206D;  (* FLI *)
	P74ParRead.Parameters[500].Subindex := 16#2;

	P74ParRead.Parameters[501].Index  := 16#206D;  (* AST *)
	P74ParRead.Parameters[501].Subindex := 16#1A;

	P74ParRead.Parameters[502].Index  := 16#207E;  (* HFI *)
	P74ParRead.Parameters[502].Subindex := 16#1;

	P74ParRead.Parameters[503].Index  := 16#207E;  (* HIR *)
	P74ParRead.Parameters[503].Subindex := 16#3;

	P74ParRead.Parameters[504].Index  := 16#207E;  (* SPB *)
	P74ParRead.Parameters[504].Subindex := 16#4;

	P74ParRead.Parameters[505].Index  := 16#207E;  (* ILR *)
	P74ParRead.Parameters[505].Subindex := 16#6;

	P74ParRead.Parameters[506].Index  := 16#207E;  (* SIR *)
	P74ParRead.Parameters[506].Subindex := 16#7;

	P74ParRead.Parameters[507].Index  := 16#207E;  (* MCR *)
	P74ParRead.Parameters[507].Subindex := 16#8;

	P74ParRead.Parameters[508].Index  := 16#207E;  (* PEC *)
	P74ParRead.Parameters[508].Subindex := 16#9;

	P74ParRead.Parameters[509].Index  := 16#2046;  (* BLC *)
	P74ParRead.Parameters[509].Subindex := 16#2;

	P74ParRead.Parameters[510].Index  := 16#2046;  (* BST *)
	P74ParRead.Parameters[510].Subindex := 16#9;

	P74ParRead.Parameters[511].Index  := 16#2046;  (* BCI *)
	P74ParRead.Parameters[511].Subindex := 16#A;

	P74ParRead.Parameters[512].Index  := 16#2046;  (* BIP *)
	P74ParRead.Parameters[512].Subindex := 16#8;

	P74ParRead.Parameters[513].Index  := 16#2046;  (* IBR *)
	P74ParRead.Parameters[513].Subindex := 16#7;

	P74ParRead.Parameters[514].Index  := 16#2046;  (* IRD *)
	P74ParRead.Parameters[514].Subindex := 16#C;

	P74ParRead.Parameters[515].Index  := 16#2046;  (* BRT *)
	P74ParRead.Parameters[515].Subindex := 16#5;

	P74ParRead.Parameters[516].Index  := 16#2046;  (* BIR *)
	P74ParRead.Parameters[516].Subindex := 16#D;

	P74ParRead.Parameters[517].Index  := 16#2046;  (* BEN *)
	P74ParRead.Parameters[517].Subindex := 16#4;

	P74ParRead.Parameters[518].Index  := 16#2046;  (* TBE *)
	P74ParRead.Parameters[518].Subindex := 16#B;

	P74ParRead.Parameters[519].Index  := 16#2046;  (* BET *)
	P74ParRead.Parameters[519].Subindex := 16#6;

	P74ParRead.Parameters[520].Index  := 16#2046;  (* BED *)
	P74ParRead.Parameters[520].Subindex := 16#15;

	P74ParRead.Parameters[521].Index  := 16#2046;  (* JDC *)
	P74ParRead.Parameters[521].Subindex := 16#E;

	P74ParRead.Parameters[522].Index  := 16#2046;  (* TTR *)
	P74ParRead.Parameters[522].Subindex := 16#17;

	P74ParRead.Parameters[523].Index  := 16#2046;  (* BRH *)
	P74ParRead.Parameters[523].Subindex := 16#33;

	P74ParRead.Parameters[524].Index  := 16#2046;  (* BRR *)
	P74ParRead.Parameters[524].Subindex := 16#10;

	P74ParRead.Parameters[525].Index  := 16#2046;  (* PES *)
	P74ParRead.Parameters[525].Subindex := 16#47;

	P74ParRead.Parameters[526].Index  := 16#2046;  (* LP1 *)
	P74ParRead.Parameters[526].Subindex := 16#48;

	P74ParRead.Parameters[527].Index  := 16#2046;  (* CP1 *)
	P74ParRead.Parameters[527].Subindex := 16#49;

	P74ParRead.Parameters[528].Index  := 16#2046;  (* LP2 *)
	P74ParRead.Parameters[528].Subindex := 16#4A;

	P74ParRead.Parameters[529].Index  := 16#2046;  (* CP2 *)
	P74ParRead.Parameters[529].Subindex := 16#4B;

	P74ParRead.Parameters[530].Index  := 16#2046;  (* IBRA *)
	P74ParRead.Parameters[530].Subindex := 16#4C;

	P74ParRead.Parameters[531].Index  := 16#205D;  (* HSO *)
	P74ParRead.Parameters[531].Subindex := 16#2;

	P74ParRead.Parameters[532].Index  := 16#205D;  (* COF *)
	P74ParRead.Parameters[532].Subindex := 16#4;

	P74ParRead.Parameters[533].Index  := 16#205D;  (* COR *)
	P74ParRead.Parameters[533].Subindex := 16#5;

	P74ParRead.Parameters[534].Index  := 16#205D;  (* TOS *)
	P74ParRead.Parameters[534].Subindex := 16#8;

	P74ParRead.Parameters[535].Index  := 16#205D;  (* OSP *)
	P74ParRead.Parameters[535].Subindex := 16#6;

	P74ParRead.Parameters[536].Index  := 16#205D;  (* CLO *)
	P74ParRead.Parameters[536].Subindex := 16#3;

	P74ParRead.Parameters[537].Index  := 16#205D;  (* SCL *)
	P74ParRead.Parameters[537].Subindex := 16#7;

	P74ParRead.Parameters[538].Index  := 16#205D;  (* RSD *)
	P74ParRead.Parameters[538].Subindex := 16#16;

	P74ParRead.Parameters[539].Index  := 16#205D;  (* RSTL *)
	P74ParRead.Parameters[539].Subindex := 16#17;

	P74ParRead.Parameters[540].Index  := 16#2059;  (* PIF *)
	P74ParRead.Parameters[540].Subindex := 16#2;

	P74ParRead.Parameters[541].Index  := 16#2059;  (* PIF1 *)
	P74ParRead.Parameters[541].Subindex := 16#5;

	P74ParRead.Parameters[542].Index  := 16#2059;  (* PIF2 *)
	P74ParRead.Parameters[542].Subindex := 16#6;

	P74ParRead.Parameters[543].Index  := 16#2059;  (* PIP1 *)
	P74ParRead.Parameters[543].Subindex := 16#7;

	P74ParRead.Parameters[544].Index  := 16#2059;  (* PIP2 *)
	P74ParRead.Parameters[544].Subindex := 16#8;

	P74ParRead.Parameters[545].Index  := 16#2059;  (* PII *)
	P74ParRead.Parameters[545].Subindex := 16#9;

	P74ParRead.Parameters[546].Index  := 16#2059;  (* RPI *)
	P74ParRead.Parameters[546].Subindex := 16#15;

	P74ParRead.Parameters[547].Index  := 16#2059;  (* RPG *)
	P74ParRead.Parameters[547].Subindex := 16#2A;

	P74ParRead.Parameters[548].Index  := 16#2059;  (* RIG *)
	P74ParRead.Parameters[548].Subindex := 16#2B;

	P74ParRead.Parameters[549].Index  := 16#2059;  (* RDG *)
	P74ParRead.Parameters[549].Subindex := 16#2C;

	P74ParRead.Parameters[550].Index  := 16#2059;  (* PRP *)
	P74ParRead.Parameters[550].Subindex := 16#55;

	P74ParRead.Parameters[551].Index  := 16#2059;  (* PIC *)
	P74ParRead.Parameters[551].Subindex := 16#29;

	P74ParRead.Parameters[552].Index  := 16#2059;  (* POL *)
	P74ParRead.Parameters[552].Subindex := 16#35;

	P74ParRead.Parameters[553].Index  := 16#2059;  (* POH *)
	P74ParRead.Parameters[553].Subindex := 16#36;

	P74ParRead.Parameters[554].Index  := 16#2059;  (* PAL *)
	P74ParRead.Parameters[554].Subindex := 16#3E;

	P74ParRead.Parameters[555].Index  := 16#2059;  (* PAH *)
	P74ParRead.Parameters[555].Subindex := 16#3F;

	P74ParRead.Parameters[556].Index  := 16#2059;  (* PER *)
	P74ParRead.Parameters[556].Subindex := 16#40;

	P74ParRead.Parameters[557].Index  := 16#2059;  (* PIS *)
	P74ParRead.Parameters[557].Subindex := 16#2D;

	P74ParRead.Parameters[558].Index  := 16#2059;  (* FPI *)
	P74ParRead.Parameters[558].Subindex := 16#33;

	P74ParRead.Parameters[559].Index  := 16#2059;  (* PSR *)
	P74ParRead.Parameters[559].Subindex := 16#34;

	P74ParRead.Parameters[560].Index  := 16#2059;  (* PAU *)
	P74ParRead.Parameters[560].Subindex := 16#47;

	P74ParRead.Parameters[561].Index  := 16#2059;  (* PIM *)
	P74ParRead.Parameters[561].Subindex := 16#37;

	P74ParRead.Parameters[562].Index  := 16#2057;  (* TLS *)
	P74ParRead.Parameters[562].Subindex := 16#2;

	P74ParRead.Parameters[563].Index  := 16#2059;  (* RSL *)
	P74ParRead.Parameters[563].Subindex := 16#3D;

	P74ParRead.Parameters[564].Index  := 16#2059;  (* PR2 *)
	P74ParRead.Parameters[564].Subindex := 16#A;

	P74ParRead.Parameters[565].Index  := 16#2059;  (* PR4 *)
	P74ParRead.Parameters[565].Subindex := 16#B;

	P74ParRead.Parameters[566].Index  := 16#2059;  (* RP2 *)
	P74ParRead.Parameters[566].Subindex := 16#16;

	P74ParRead.Parameters[567].Index  := 16#2059;  (* RP3 *)
	P74ParRead.Parameters[567].Subindex := 16#17;

	P74ParRead.Parameters[568].Index  := 16#2059;  (* RP4 *)
	P74ParRead.Parameters[568].Subindex := 16#18;

	P74ParRead.Parameters[569].Index  := 16#203E;  (* TLA *)
	P74ParRead.Parameters[569].Subindex := 16#B;

	P74ParRead.Parameters[570].Index  := 16#203E;  (* INTP *)
	P74ParRead.Parameters[570].Subindex := 16#10;

	P74ParRead.Parameters[571].Index  := 16#203E;  (* TLIM *)
	P74ParRead.Parameters[571].Subindex := 16#C;

	P74ParRead.Parameters[572].Index  := 16#203E;  (* TLIG *)
	P74ParRead.Parameters[572].Subindex := 16#D;

	P74ParRead.Parameters[573].Index  := 16#203E;  (* TAA *)
	P74ParRead.Parameters[573].Subindex := 16#F;

	P74ParRead.Parameters[574].Index  := 16#203E;  (* TLC *)
	P74ParRead.Parameters[574].Subindex := 16#E;

	P74ParRead.Parameters[575].Index  := 16#203E;  (* LC2 *)
	P74ParRead.Parameters[575].Subindex := 16#3;

	P74ParRead.Parameters[576].Index  := 16#203E;  (* CL2 *)
	P74ParRead.Parameters[576].Subindex := 16#4;

	P74ParRead.Parameters[577].Index  := 16#206A;  (* LLC *)
	P74ParRead.Parameters[577].Subindex := 16#3;

	P74ParRead.Parameters[578].Index  := 16#206A;  (* LES *)
	P74ParRead.Parameters[578].Subindex := 16#2;

	P74ParRead.Parameters[579].Index  := 16#206A;  (* LCT *)
	P74ParRead.Parameters[579].Subindex := 16#4;

	P74ParRead.Parameters[580].Index  := 16#2065;  (* OCC *)
	P74ParRead.Parameters[580].Subindex := 16#5;

	P74ParRead.Parameters[581].Index  := 16#2065;  (* RCA *)
	P74ParRead.Parameters[581].Subindex := 16#4;

	P74ParRead.Parameters[582].Index  := 16#2065;  (* DBS *)
	P74ParRead.Parameters[582].Subindex := 16#2;

	P74ParRead.Parameters[583].Index  := 16#2065;  (* DAS *)
	P74ParRead.Parameters[583].Subindex := 16#3;

	P74ParRead.Parameters[584].Index  := 16#205F;  (* SAF *)
	P74ParRead.Parameters[584].Subindex := 16#2;

	P74ParRead.Parameters[585].Index  := 16#205F;  (* SAR *)
	P74ParRead.Parameters[585].Subindex := 16#3;

	P74ParRead.Parameters[586].Index  := 16#205F;  (* SAL *)
	P74ParRead.Parameters[586].Subindex := 16#9;

	P74ParRead.Parameters[587].Index  := 16#205F;  (* DAF *)
	P74ParRead.Parameters[587].Subindex := 16#4;

	P74ParRead.Parameters[588].Index  := 16#205F;  (* DAR *)
	P74ParRead.Parameters[588].Subindex := 16#5;

	P74ParRead.Parameters[589].Index  := 16#205F;  (* DAL *)
	P74ParRead.Parameters[589].Subindex := 16#A;

	P74ParRead.Parameters[590].Index  := 16#205F;  (* CLS *)
	P74ParRead.Parameters[590].Subindex := 16#8;

	P74ParRead.Parameters[591].Index  := 16#205F;  (* PAS *)
	P74ParRead.Parameters[591].Subindex := 16#7;

	P74ParRead.Parameters[592].Index  := 16#205F;  (* DSF *)
	P74ParRead.Parameters[592].Subindex := 16#6;

	P74ParRead.Parameters[593].Index  := 16#205F;  (* STD *)
	P74ParRead.Parameters[593].Subindex := 16#16;

	P74ParRead.Parameters[594].Index  := 16#205F;  (* NLS *)
	P74ParRead.Parameters[594].Subindex := 16#C;

	P74ParRead.Parameters[595].Index  := 16#205F;  (* SFD *)
	P74ParRead.Parameters[595].Subindex := 16#17;

	P74ParRead.Parameters[596].Index  := 16#2032;  (* CHM *)
	P74ParRead.Parameters[596].Subindex := 16#1A;

	P74ParRead.Parameters[597].Index  := 16#2032;  (* CNF1 *)
	P74ParRead.Parameters[597].Subindex := 16#16;

	P74ParRead.Parameters[598].Index  := 16#2032;  (* CNF2 *)
	P74ParRead.Parameters[598].Subindex := 16#17;

	P74ParRead.Parameters[599].Index  := 16#2042;  (* TUL *)
	P74ParRead.Parameters[599].Subindex := 16#B;

	P74ParRead.Parameters[600].Index  := 16#205C;  (* TRC *)
	P74ParRead.Parameters[600].Subindex := 16#2;

	P74ParRead.Parameters[601].Index  := 16#205C;  (* TRH *)
	P74ParRead.Parameters[601].Subindex := 16#3;

	P74ParRead.Parameters[602].Index  := 16#205C;  (* TRL *)
	P74ParRead.Parameters[602].Subindex := 16#4;

	P74ParRead.Parameters[603].Index  := 16#205C;  (* QSH *)
	P74ParRead.Parameters[603].Subindex := 16#5;

	P74ParRead.Parameters[604].Index  := 16#205C;  (* QSL *)
	P74ParRead.Parameters[604].Subindex := 16#6;

	P74ParRead.Parameters[605].Index  := 16#205C;  (* TUP *)
	P74ParRead.Parameters[605].Subindex := 16#7;

	P74ParRead.Parameters[606].Index  := 16#205C;  (* TDN *)
	P74ParRead.Parameters[606].Subindex := 16#8;

	P74ParRead.Parameters[607].Index  := 16#205C;  (* TBO *)
	P74ParRead.Parameters[607].Subindex := 16#9;

	P74ParRead.Parameters[608].Index  := 16#205C;  (* EBO *)
	P74ParRead.Parameters[608].Subindex := 16#E;

	P74ParRead.Parameters[609].Index  := 16#205C;  (* SNC *)
	P74ParRead.Parameters[609].Subindex := 16#D;

	P74ParRead.Parameters[610].Index  := 16#205C;  (* TSY *)
	P74ParRead.Parameters[610].Subindex := 16#F;

	P74ParRead.Parameters[611].Index  := 16#205C;  (* DTF *)
	P74ParRead.Parameters[611].Subindex := 16#C;

	P74ParRead.Parameters[612].Index  := 16#205C;  (* RTR *)
	P74ParRead.Parameters[612].Subindex := 16#B;

	P74ParRead.Parameters[613].Index  := 16#2066;  (* PTCL *)
	P74ParRead.Parameters[613].Subindex := 16#4;

	P74ParRead.Parameters[614].Index  := 16#2029;  (* RSF *)
	P74ParRead.Parameters[614].Subindex := 16#19;

	P74ParRead.Parameters[615].Index  := 16#2029;  (* RP *)
	P74ParRead.Parameters[615].Subindex := 16#1D;

	P74ParRead.Parameters[616].Index  := 16#2029;  (* RPA *)
	P74ParRead.Parameters[616].Subindex := 16#1E;

	P74ParRead.Parameters[617].Index  := 16#2029;  (* ATR *)
	P74ParRead.Parameters[617].Subindex := 16#17;

	P74ParRead.Parameters[618].Index  := 16#2029;  (* TAR *)
	P74ParRead.Parameters[618].Subindex := 16#18;

	P74ParRead.Parameters[619].Index  := 16#2001;  (* FLR *)
	P74ParRead.Parameters[619].Subindex := 16#B;

	P74ParRead.Parameters[620].Index  := 16#2042;  (* THT *)
	P74ParRead.Parameters[620].Subindex := 16#D;

	P74ParRead.Parameters[621].Index  := 16#2050;  (* TTD *)
	P74ParRead.Parameters[621].Subindex := 16#3;

	P74ParRead.Parameters[622].Index  := 16#2050;  (* TTD2 *)
	P74ParRead.Parameters[622].Subindex := 16#7;

	P74ParRead.Parameters[623].Index  := 16#2050;  (* TTD3 *)
	P74ParRead.Parameters[623].Subindex := 16#8;

	P74ParRead.Parameters[624].Index  := 16#2028;  (* OLL *)
	P74ParRead.Parameters[624].Subindex := 16#A;

	P74ParRead.Parameters[625].Index  := 16#2042;  (* OPL *)
	P74ParRead.Parameters[625].Subindex := 16#C;

	P74ParRead.Parameters[626].Index  := 16#2028;  (* ODT *)
	P74ParRead.Parameters[626].Subindex := 16#52;

	P74ParRead.Parameters[627].Index  := 16#2028;  (* IPL *)
	P74ParRead.Parameters[627].Subindex := 16#3;

	P74ParRead.Parameters[628].Index  := 16#2028;  (* OHL *)
	P74ParRead.Parameters[628].Subindex := 16#9;

	P74ParRead.Parameters[629].Index  := 16#2050;  (* THA *)
	P74ParRead.Parameters[629].Subindex := 16#A;

	P74ParRead.Parameters[630].Index  := 16#2050;  (* SAT *)
	P74ParRead.Parameters[630].Subindex := 16#16;

	P74ParRead.Parameters[631].Index  := 16#2029;  (* ETF *)
	P74ParRead.Parameters[631].Subindex := 16#20;

	P74ParRead.Parameters[632].Index  := 16#2028;  (* LET *)
	P74ParRead.Parameters[632].Subindex := 16#5B;

	P74ParRead.Parameters[633].Index  := 16#2028;  (* EPL *)
	P74ParRead.Parameters[633].Subindex := 16#7;

	P74ParRead.Parameters[634].Index  := 16#206C;  (* USB *)
	P74ParRead.Parameters[634].Subindex := 16#4;

	P74ParRead.Parameters[635].Index  := 16#206C;  (* URES *)
	P74ParRead.Parameters[635].Subindex := 16#2;

	P74ParRead.Parameters[636].Index  := 16#206C;  (* USL *)
	P74ParRead.Parameters[636].Subindex := 16#3;

	P74ParRead.Parameters[637].Index  := 16#206C;  (* UST *)
	P74ParRead.Parameters[637].Subindex := 16#5;

	P74ParRead.Parameters[638].Index  := 16#2028;  (* STP *)
	P74ParRead.Parameters[638].Subindex := 16#5;

	P74ParRead.Parameters[639].Index  := 16#206C;  (* TSM *)
	P74ParRead.Parameters[639].Subindex := 16#E;

	P74ParRead.Parameters[640].Index  := 16#206C;  (* UPL *)
	P74ParRead.Parameters[640].Subindex := 16#C;

	P74ParRead.Parameters[641].Index  := 16#206C;  (* STM *)
	P74ParRead.Parameters[641].Subindex := 16#F;

	P74ParRead.Parameters[642].Index  := 16#206C;  (* TBS *)
	P74ParRead.Parameters[642].Subindex := 16#D;

	P74ParRead.Parameters[643].Index  := 16#2001;  (* STRT *)
	P74ParRead.Parameters[643].Subindex := 16#D;

	P74ParRead.Parameters[644].Index  := 16#2028;  (* LFL3 *)
	P74ParRead.Parameters[644].Subindex := 16#E;

	P74ParRead.Parameters[645].Index  := 16#2029;  (* INH *)
	P74ParRead.Parameters[645].Subindex := 16#1A;

	P74ParRead.Parameters[646].Index  := 16#2028;  (* CLL *)
	P74ParRead.Parameters[646].Subindex := 16#10;

	P74ParRead.Parameters[647].Index  := 16#2028;  (* COL *)
	P74ParRead.Parameters[647].Subindex := 16#C;

	P74ParRead.Parameters[648].Index  := 16#2028;  (* SLL *)
	P74ParRead.Parameters[648].Subindex := 16#B;

	P74ParRead.Parameters[649].Index  := 16#203E;  (* SSB *)
	P74ParRead.Parameters[649].Subindex := 16#29;

	P74ParRead.Parameters[650].Index  := 16#203E;  (* STO *)
	P74ParRead.Parameters[650].Subindex := 16#2A;

	P74ParRead.Parameters[651].Index  := 16#2028;  (* TNL *)
	P74ParRead.Parameters[651].Subindex := 16#D;

	P74ParRead.Parameters[652].Index  := 16#206E;  (* PPI *)
	P74ParRead.Parameters[652].Subindex := 16#2;

	P74ParRead.Parameters[653].Index  := 16#2028;  (* LFF *)
	P74ParRead.Parameters[653].Subindex := 16#51;

	P74ParRead.Parameters[654].Index  := 16#2016;  (* AIC2 *)
	P74ParRead.Parameters[654].Subindex := 16#55;

	P74ParRead.Parameters[655].Index  := 16#2074;  (* FQF *)
	P74ParRead.Parameters[655].Subindex := 16#2;

	P74ParRead.Parameters[656].Index  := 16#2074;  (* FQC *)
	P74ParRead.Parameters[656].Subindex := 16#3;

	P74ParRead.Parameters[657].Index  := 16#2074;  (* FQA *)
	P74ParRead.Parameters[657].Subindex := 16#5;

	P74ParRead.Parameters[658].Index  := 16#2074;  (* TDS *)
	P74ParRead.Parameters[658].Subindex := 16#6;

	P74ParRead.Parameters[659].Index  := 16#2074;  (* FDT *)
	P74ParRead.Parameters[659].Subindex := 16#7;

	P74ParRead.Parameters[660].Index  := 16#2074;  (* FQT *)
	P74ParRead.Parameters[660].Subindex := 16#8;

	P74ParRead.Parameters[661].Index  := 16#2074;  (* TQB *)
	P74ParRead.Parameters[661].Subindex := 16#9;

	P74ParRead.Parameters[662].Index  := 16#205D;  (* TLD *)
	P74ParRead.Parameters[662].Subindex := 16#D;

	P74ParRead.Parameters[663].Index  := 16#205D;  (* DLD *)
	P74ParRead.Parameters[663].Subindex := 16#C;

	P74ParRead.Parameters[664].Index  := 16#205D;  (* DLB *)
	P74ParRead.Parameters[664].Subindex := 16#E;

	P74ParRead.Parameters[665].Index  := 16#2061;  (* NCA1 *)
	P74ParRead.Parameters[665].Subindex := 16#16;

	P74ParRead.Parameters[666].Index  := 16#2061;  (* NCA2 *)
	P74ParRead.Parameters[666].Subindex := 16#17;

	P74ParRead.Parameters[667].Index  := 16#2061;  (* NCA3 *)
	P74ParRead.Parameters[667].Subindex := 16#18;

	P74ParRead.Parameters[668].Index  := 16#2061;  (* NCA4 *)
	P74ParRead.Parameters[668].Subindex := 16#19;

	P74ParRead.Parameters[669].Index  := 16#2061;  (* NCA5 *)
	P74ParRead.Parameters[669].Subindex := 16#1A;

	P74ParRead.Parameters[670].Index  := 16#2061;  (* NCA6 *)
	P74ParRead.Parameters[670].Subindex := 16#1B;

	P74ParRead.Parameters[671].Index  := 16#2061;  (* NCA7 *)
	P74ParRead.Parameters[671].Subindex := 16#1C;

	P74ParRead.Parameters[672].Index  := 16#2061;  (* NCA8 *)
	P74ParRead.Parameters[672].Subindex := 16#1D;

	P74ParRead.Parameters[673].Index  := 16#2061;  (* NMA1 *)
	P74ParRead.Parameters[673].Subindex := 16#2;

	P74ParRead.Parameters[674].Index  := 16#2061;  (* NMA2 *)
	P74ParRead.Parameters[674].Subindex := 16#3;

	P74ParRead.Parameters[675].Index  := 16#2061;  (* NMA3 *)
	P74ParRead.Parameters[675].Subindex := 16#4;

	P74ParRead.Parameters[676].Index  := 16#2061;  (* NMA4 *)
	P74ParRead.Parameters[676].Subindex := 16#5;

	P74ParRead.Parameters[677].Index  := 16#2061;  (* NMA5 *)
	P74ParRead.Parameters[677].Subindex := 16#6;

	P74ParRead.Parameters[678].Index  := 16#2061;  (* NMA6 *)
	P74ParRead.Parameters[678].Subindex := 16#7;

	P74ParRead.Parameters[679].Index  := 16#2061;  (* NMA7 *)
	P74ParRead.Parameters[679].Subindex := 16#8;

	P74ParRead.Parameters[680].Index  := 16#2061;  (* NMA8 *)
	P74ParRead.Parameters[680].Subindex := 16#9;

	P74ParRead.Parameters[681].Index  := 16#207C;  (* OMA1 *)
	P74ParRead.Parameters[681].Subindex := 16#2;

	P74ParRead.Parameters[682].Index  := 16#207C;  (* OMA2 *)
	P74ParRead.Parameters[682].Subindex := 16#3;

	P74ParRead.Parameters[683].Index  := 16#207C;  (* OMA3 *)
	P74ParRead.Parameters[683].Subindex := 16#4;

	P74ParRead.Parameters[684].Index  := 16#207C;  (* OMA4 *)
	P74ParRead.Parameters[684].Subindex := 16#5;

	P74ParRead.Parameters[685].Index  := 16#207C;  (* OMA5 *)
	P74ParRead.Parameters[685].Subindex := 16#6;

	P74ParRead.Parameters[686].Index  := 16#207C;  (* OMA6 *)
	P74ParRead.Parameters[686].Subindex := 16#7;

	P74ParRead.Parameters[687].Index  := 16#207C;  (* OCA1 *)
	P74ParRead.Parameters[687].Subindex := 16#16;

	P74ParRead.Parameters[688].Index  := 16#207C;  (* OCA2 *)
	P74ParRead.Parameters[688].Subindex := 16#17;

	P74ParRead.Parameters[689].Index  := 16#207C;  (* OCA3 *)
	P74ParRead.Parameters[689].Subindex := 16#18;

	P74ParRead.Parameters[690].Index  := 16#207C;  (* OCA4 *)
	P74ParRead.Parameters[690].Subindex := 16#19;

	P74ParRead.Parameters[691].Index  := 16#207C;  (* OCA5 *)
	P74ParRead.Parameters[691].Subindex := 16#1A;

	P74ParRead.Parameters[692].Index  := 16#207C;  (* OCA6 *)
	P74ParRead.Parameters[692].Subindex := 16#1B;

	P74ParRead.Parameters[693].Index  := 16#201E;  (* ADD *)
	P74ParRead.Parameters[693].Subindex := 16#2;

	P74ParRead.Parameters[694].Index  := 16#2024;  (* AMOC *)
	P74ParRead.Parameters[694].Subindex := 16#34;

	P74ParRead.Parameters[695].Index  := 16#201E;  (* TBR *)
	P74ParRead.Parameters[695].Subindex := 16#4;

	P74ParRead.Parameters[696].Index  := 16#201E;  (* TFO *)
	P74ParRead.Parameters[696].Subindex := 16#5;

	P74ParRead.Parameters[697].Index  := 16#201E;  (* TTO *)
	P74ParRead.Parameters[697].Subindex := 16#6;

	P74ParRead.Parameters[698].Index  := 16#201E;  (* ADCO *)
	P74ParRead.Parameters[698].Subindex := 16#34;

	P74ParRead.Parameters[699].Index  := 16#201E;  (* BDCO *)
	P74ParRead.Parameters[699].Subindex := 16#36;

	P74ParRead.Parameters[700].Index  := 16#201E;  (* ERCO *)
	P74ParRead.Parameters[700].Subindex := 16#39;

	P74ParRead.Parameters[701].Index  := 16#2036;  (* FLO *)
	P74ParRead.Parameters[701].Subindex := 16#20;

	P74ParRead.Parameters[702].Index  := 16#2036;  (* FLOC *)
	P74ParRead.Parameters[702].Subindex := 16#21;

	P74ParRead.Parameters[703].Index  := 16#2036;  (* FLOT *)
	P74ParRead.Parameters[703].Subindex := 16#22;

	P74ParRead.Parameters[704].Index  := 16#2024;  (* ADRC *)
	P74ParRead.Parameters[704].Subindex := 16#2;

	P74ParRead.Parameters[705].Index  := 16#2024;  (* PRFL *)
	P74ParRead.Parameters[705].Subindex := 16#42;

	P74ParRead.Parameters[706].Index  := 16#2024;  (* DPMA *)
	P74ParRead.Parameters[706].Subindex := 16#43;

	P74ParRead.Parameters[707].Index  := 16#2024;  (* CIOA *)
	P74ParRead.Parameters[707].Subindex := 16#44;

	P74ParRead.Parameters[708].Index  := 16#2024;  (* CIO2 *)
	P74ParRead.Parameters[708].Subindex := 16#45;

	P74ParRead.Parameters[709].Index  := 16#2024;  (* BTUA *)
	P74ParRead.Parameters[709].Subindex := 16#47;

	P74ParRead.Parameters[710].Index  := 16#2024;  (* BTUC *)
	P74ParRead.Parameters[710].Subindex := 16#48;

	P74ParRead.Parameters[711].Index  := 16#2024;  (* BTPI *)
	P74ParRead.Parameters[711].Subindex := 16#4A;

	P74ParRead.Parameters[712].Index  := 16#2024;  (* BDR *)
	P74ParRead.Parameters[712].Subindex := 16#4;

	P74ParRead.Parameters[713].Index  := 16#2024;  (* PRC *)
	P74ParRead.Parameters[713].Subindex := 16#7;

	P74ParRead.Parameters[714].Index  := 16#2024;  (* GLB *)
	P74ParRead.Parameters[714].Subindex := 16#8;

	P74ParRead.Parameters[715].Index  := 16#2024;  (* BDRU *)
	P74ParRead.Parameters[715].Subindex := 16#3D;

	P74ParRead.Parameters[716].Index  := 16#200A;  (* L1D *)
	P74ParRead.Parameters[716].Subindex := 16#2;

	P74ParRead.Parameters[717].Index  := 16#2014;  (* R1 *)
	P74ParRead.Parameters[717].Subindex := 16#2;

	P74ParRead.Parameters[718].Index  := 16#2014;  (* R2 *)
	P74ParRead.Parameters[718].Subindex := 16#3;

	P74ParRead.Parameters[719].Index  := 16#200A;  (* L2D *)
	P74ParRead.Parameters[719].Subindex := 16#3;

	P74ParRead.Parameters[720].Index  := 16#200C;  (* R1D *)
	P74ParRead.Parameters[720].Subindex := 16#2A;

	P74ParRead.Parameters[721].Index  := 16#200C;  (* R2D *)
	P74ParRead.Parameters[721].Subindex := 16#2B;

	P74ParRead.Parameters[722].Index  := 16#200A;  (* L3D *)
	P74ParRead.Parameters[722].Subindex := 16#4;

	P74ParRead.Parameters[723].Index  := 16#200C;  (* R1S *)
	P74ParRead.Parameters[723].Subindex := 16#2;

	P74ParRead.Parameters[724].Index  := 16#200C;  (* R2S *)
	P74ParRead.Parameters[724].Subindex := 16#3;

	P74ParRead.Parameters[725].Index  := 16#200A;  (* L4D *)
	P74ParRead.Parameters[725].Subindex := 16#5;

	P74ParRead.Parameters[726].Index  := 16#200C;  (* R1H *)
	P74ParRead.Parameters[726].Subindex := 16#16;

	P74ParRead.Parameters[727].Index  := 16#200C;  (* R2H *)
	P74ParRead.Parameters[727].Subindex := 16#17;

	P74ParRead.Parameters[728].Index  := 16#200A;  (* L5D *)
	P74ParRead.Parameters[728].Subindex := 16#6;

	P74ParRead.Parameters[729].Index  := 16#200A;  (* L6D *)
	P74ParRead.Parameters[729].Subindex := 16#7;

	P74ParRead.Parameters[730].Index  := 16#200A;  (* LA1D *)
	P74ParRead.Parameters[730].Subindex := 16#16;

	P74ParRead.Parameters[731].Index  := 16#200A;  (* LA2D *)
	P74ParRead.Parameters[731].Subindex := 16#17;

	P74ParRead.Parameters[732].Index  := 16#2002;  (* FRHT *)
	P74ParRead.Parameters[732].Subindex := 16#17;

	P74ParRead.Parameters[733].Index  := 16#2002;  (* SLCR *)
	P74ParRead.Parameters[733].Subindex := 16#19;

	P74ParRead.Parameters[734].Index  := 16#2002;  (* SRFR *)
	P74ParRead.Parameters[734].Subindex := 16#1A;

	P74ParRead.Parameters[735].Index  := 16#2002;  (* SOTR *)
	P74ParRead.Parameters[735].Subindex := 16#1B;

	P74ParRead.Parameters[736].Index  := 16#2002;  (* SULN *)
	P74ParRead.Parameters[736].Subindex := 16#1E;

	P74ParRead.Parameters[737].Index  := 16#2002;  (* SOPR *)
	P74ParRead.Parameters[737].Subindex := 16#5B;

	P74ParRead.Parameters[738].Index  := 16#2016;  (* SAI1 *)
	P74ParRead.Parameters[738].Subindex := 16#5C;

	P74ParRead.Parameters[739].Index  := 16#2016;  (* SAI2 *)
	P74ParRead.Parameters[739].Subindex := 16#5D;

	P74ParRead.Parameters[740].Index  := 16#2016;  (* SAI3 *)
	P74ParRead.Parameters[740].Subindex := 16#5E;

	P74ParRead.Parameters[741].Index  := 16#2016;  (* SAO1 *)
	P74ParRead.Parameters[741].Subindex := 16#60;

	P74ParRead.Parameters[742].Index  := 16#2072;  (* ULT *)
	P74ParRead.Parameters[742].Subindex := 16#C;

	P74ParRead.Parameters[743].Index  := 16#2072;  (* SRB *)
	P74ParRead.Parameters[743].Subindex := 16#2;

	P74ParRead.Parameters[744].Index  := 16#2072;  (* UDL *)
	P74ParRead.Parameters[744].Subindex := 16#D;

	P74ParRead.Parameters[745].Index  := 16#2072;  (* RMUD *)
	P74ParRead.Parameters[745].Subindex := 16#F;

	P74ParRead.Parameters[746].Index  := 16#2072;  (* LUL *)
	P74ParRead.Parameters[746].Subindex := 16#10;

	P74ParRead.Parameters[747].Index  := 16#2072;  (* LUN *)
	P74ParRead.Parameters[747].Subindex := 16#11;

	P74ParRead.Parameters[748].Index  := 16#2072;  (* TOL *)
	P74ParRead.Parameters[748].Subindex := 16#16;

	P74ParRead.Parameters[749].Index  := 16#2072;  (* ODL *)
	P74ParRead.Parameters[749].Subindex := 16#17;

	P74ParRead.Parameters[750].Index  := 16#2077;  (* FBST *)
	P74ParRead.Parameters[750].Subindex := 16#3D;

	P74ParRead.Parameters[751].Index  := 16#2077;  (* FBFT *)
	P74ParRead.Parameters[751].Subindex := 16#3E;

	P74ParRead.Parameters[752].Index  := 16#2077;  (* FBCD *)
	P74ParRead.Parameters[752].Subindex := 16#3F;

	P74ParRead.Parameters[753].Index  := 16#2077;  (* FBRM *)
	P74ParRead.Parameters[753].Subindex := 16#40;

	P74ParRead.Parameters[754].Index  := 16#2077;  (* FBSM *)
	P74ParRead.Parameters[754].Subindex := 16#41;

	P74ParRead.Parameters[755].Index  := 16#2077;  (* FBDF *)
	P74ParRead.Parameters[755].Subindex := 16#42;

	P74ParRead.Parameters[756].Index  := 16#2077;  (* IA01 *)
	P74ParRead.Parameters[756].Subindex := 16#1;

	P74ParRead.Parameters[757].Index  := 16#2077;  (* IA02 *)
	P74ParRead.Parameters[757].Subindex := 16#2;

	P74ParRead.Parameters[758].Index  := 16#2077;  (* IA03 *)
	P74ParRead.Parameters[758].Subindex := 16#3;

	P74ParRead.Parameters[759].Index  := 16#2077;  (* IA04 *)
	P74ParRead.Parameters[759].Subindex := 16#4;

	P74ParRead.Parameters[760].Index  := 16#2077;  (* IA05 *)
	P74ParRead.Parameters[760].Subindex := 16#5;

	P74ParRead.Parameters[761].Index  := 16#2077;  (* IA06 *)
	P74ParRead.Parameters[761].Subindex := 16#6;

	P74ParRead.Parameters[762].Index  := 16#2077;  (* IA07 *)
	P74ParRead.Parameters[762].Subindex := 16#7;

	P74ParRead.Parameters[763].Index  := 16#2077;  (* IA08 *)
	P74ParRead.Parameters[763].Subindex := 16#8;

	P74ParRead.Parameters[764].Index  := 16#2077;  (* IA09 *)
	P74ParRead.Parameters[764].Subindex := 16#9;

	P74ParRead.Parameters[765].Index  := 16#2077;  (* IA10 *)
	P74ParRead.Parameters[765].Subindex := 16#A;

	P74ParRead.Parameters[766].Index  := 16#2077;  (* IL01 *)
	P74ParRead.Parameters[766].Subindex := 16#15;

	P74ParRead.Parameters[767].Index  := 16#2077;  (* IL02 *)
	P74ParRead.Parameters[767].Subindex := 16#16;

	P74ParRead.Parameters[768].Index  := 16#2077;  (* IL03 *)
	P74ParRead.Parameters[768].Subindex := 16#17;

	P74ParRead.Parameters[769].Index  := 16#2077;  (* IL04 *)
	P74ParRead.Parameters[769].Subindex := 16#18;

	P74ParRead.Parameters[770].Index  := 16#2077;  (* IL05 *)
	P74ParRead.Parameters[770].Subindex := 16#19;

	P74ParRead.Parameters[771].Index  := 16#2077;  (* IL06 *)
	P74ParRead.Parameters[771].Subindex := 16#1A;

	P74ParRead.Parameters[772].Index  := 16#2077;  (* IL07 *)
	P74ParRead.Parameters[772].Subindex := 16#1B;

	P74ParRead.Parameters[773].Index  := 16#2077;  (* IL08 *)
	P74ParRead.Parameters[773].Subindex := 16#1C;

	P74ParRead.Parameters[774].Index  := 16#2077;  (* IL09 *)
	P74ParRead.Parameters[774].Subindex := 16#1D;

	P74ParRead.Parameters[775].Index  := 16#2077;  (* IL10 *)
	P74ParRead.Parameters[775].Subindex := 16#1E;

	P74ParRead.Parameters[776].Index  := 16#2077;  (* LA01 *)
	P74ParRead.Parameters[776].Subindex := 16#29;

	P74ParRead.Parameters[777].Index  := 16#2077;  (* LA02 *)
	P74ParRead.Parameters[777].Subindex := 16#2A;

	P74ParRead.Parameters[778].Index  := 16#2077;  (* LA03 *)
	P74ParRead.Parameters[778].Subindex := 16#2B;

	P74ParRead.Parameters[779].Index  := 16#2077;  (* LA04 *)
	P74ParRead.Parameters[779].Subindex := 16#2C;

	P74ParRead.Parameters[780].Index  := 16#2077;  (* LA05 *)
	P74ParRead.Parameters[780].Subindex := 16#2D;

	P74ParRead.Parameters[781].Index  := 16#2077;  (* LA06 *)
	P74ParRead.Parameters[781].Subindex := 16#2E;

	P74ParRead.Parameters[782].Index  := 16#2077;  (* LA07 *)
	P74ParRead.Parameters[782].Subindex := 16#2F;

	P74ParRead.Parameters[783].Index  := 16#2077;  (* LA08 *)
	P74ParRead.Parameters[783].Subindex := 16#30;

	P74ParRead.Parameters[784].Index  := 16#2077;  (* M001 *)
	P74ParRead.Parameters[784].Subindex := 16#47;

	P74ParRead.Parameters[785].Index  := 16#2077;  (* M002 *)
	P74ParRead.Parameters[785].Subindex := 16#48;

	P74ParRead.Parameters[786].Index  := 16#2077;  (* M003 *)
	P74ParRead.Parameters[786].Subindex := 16#49;

	P74ParRead.Parameters[787].Index  := 16#2077;  (* M004 *)
	P74ParRead.Parameters[787].Subindex := 16#4A;

	P74ParRead.Parameters[788].Index  := 16#2077;  (* M005 *)
	P74ParRead.Parameters[788].Subindex := 16#4B;

	P74ParRead.Parameters[789].Index  := 16#2077;  (* M006 *)
	P74ParRead.Parameters[789].Subindex := 16#4C;

	P74ParRead.Parameters[790].Index  := 16#2077;  (* M007 *)
	P74ParRead.Parameters[790].Subindex := 16#4D;

	P74ParRead.Parameters[791].Index  := 16#2077;  (* M008 *)
	P74ParRead.Parameters[791].Subindex := 16#4E;

	P74ParRead.Parameters[792].Index  := 16#2077;  (* S001 *)
	P74ParRead.Parameters[792].Subindex := 16#51;

	P74ParRead.Parameters[793].Index  := 16#2077;  (* S002 *)
	P74ParRead.Parameters[793].Subindex := 16#52;

	P74ParRead.Parameters[794].Index  := 16#2077;  (* S006 *)
	P74ParRead.Parameters[794].Subindex := 16#56;

	P74ParRead.Parameters[795].Index  := 16#2077;  (* BNV *)
	P74ParRead.Parameters[795].Subindex := 16#5B;

	P74ParRead.Parameters[796].Index  := 16#2077;  (* CTV *)
	P74ParRead.Parameters[796].Subindex := 16#5C;

	P74ParRead.Parameters[797].Index  := 16#2077;  (* BNS *)
	P74ParRead.Parameters[797].Subindex := 16#5D;

	P74ParRead.Parameters[798].Index  := 16#2077;  (* BVER *)
	P74ParRead.Parameters[798].Subindex := 16#5E;

	P74ParRead.Parameters[799].Index  := 16#207B;  (* SLSA *)
	P74ParRead.Parameters[799].Subindex := 16#1;

	P74ParRead.Parameters[800].Index  := 16#207B;  (* SLT *)
	P74ParRead.Parameters[800].Subindex := 16#2;

	P74ParRead.Parameters[801].Index  := 16#207B;  (* SLSP *)
	P74ParRead.Parameters[801].Subindex := 16#3;

	P74ParRead.Parameters[802].Index  := 16#207B;  (* SLTT *)
	P74ParRead.Parameters[802].Subindex := 16#4;

	P74ParRead.Parameters[803].Index  := 16#207B;  (* SLSS *)
	P74ParRead.Parameters[803].Subindex := 16#5;

	P74ParRead.Parameters[804].Index  := 16#207B;  (* SS1A *)
	P74ParRead.Parameters[804].Subindex := 16#B;

	P74ParRead.Parameters[805].Index  := 16#207B;  (* SSRT *)
	P74ParRead.Parameters[805].Subindex := 16#C;

	P74ParRead.Parameters[806].Index  := 16#207B;  (* SSRU *)
	P74ParRead.Parameters[806].Subindex := 16#D;

	P74ParRead.Parameters[807].Index  := 16#207B;  (* SSSL *)
	P74ParRead.Parameters[807].Subindex := 16#E;

	P74ParRead.Parameters[808].Index  := 16#207B;  (* SSTT *)
	P74ParRead.Parameters[808].Subindex := 16#F;

	P74ParRead.Parameters[809].Index  := 16#207B;  (* SS1S *)
	P74ParRead.Parameters[809].Subindex := 16#10;

	P74ParRead.Parameters[810].Index  := 16#207B;  (* STOA *)
	P74ParRead.Parameters[810].Subindex := 16#15;

	P74ParRead.Parameters[811].Index  := 16#207B;  (* PWRM *)
	P74ParRead.Parameters[811].Subindex := 16#16;

	P74ParRead.Parameters[812].Index  := 16#207B;  (* STOS *)
	P74ParRead.Parameters[812].Subindex := 16#17;

	P74ParRead.Parameters[813].Index  := 16#207B;  (* LIDT *)
	P74ParRead.Parameters[813].Subindex := 16#1F;

	P74ParRead.Parameters[814].Index  := 16#207B;  (* LIRT *)
	P74ParRead.Parameters[814].Subindex := 16#20;

	P74ParRead.Parameters[815].Index  := 16#207B;  (* SFTY *)
	P74ParRead.Parameters[815].Subindex := 16#2D;


  

END_PROGRAM

