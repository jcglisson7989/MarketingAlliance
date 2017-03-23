(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: P84param
 * File: P84paramCyclic.st
 * Author: scoccimaroj
 * Created: July 14, 2010
 ********************************************************************
 * Implementation of program P84param
 ********************************************************************)

PROGRAM _CYCLIC


(* State machine *)
CASE State OF
	
	(* Wait for a start command *)
	0:
		IF (cmdStart = 1) THEN
  			cmdStart := 0;
			i := 0;
			State := 1;
				
		END_IF	
	
	
	
	(* Read a parameter from the drive *)
	1:
		eplRead.enable := 1;
		eplRead.index := P84ParRead.Parameters[i].Index; 		(* CANOpen Index from the Parameter list *)
		eplRead.subindex := P84ParRead.Parameters[i].Subindex; 			(* CANOpen Sub-Index from the Parameter list *)
		eplRead.node := P84ParRead.NodeNr;
		eplRead.pData := ADR(P84ParRead.Parameters[i].Data);
		eplRead.datalen := SIZEOF(P84ParRead.Parameters[i].Data);
	
		(* Read was successful *)
		IF (eplRead.status = 0) THEN
  				eplRead.enable := 0;
				State := 2;	
			
	
		ELSIF (eplRead.status = ERR_FUB_ENABLE_FALSE) OR (eplRead.status = ERR_FUB_BUSY) THEN
			(* Do nothing here *)
		
		(* an error occured - so skip that parameter *)
		ELSE
			eplRead.enable := 0;
			cmdStart := 0;
			State := 2;	
	
		END_IF	
	
		
	2:	
		(* increment loop counter *)
		i := i + 1;	
		
		(* all the parameters have been read *)
		IF (i >= NUM_OF_P84PAR) THEN
			eplRead.enable := 0;
			State := 3; (* start writing the csv file. *)
			
		(* return to read state *)	
		ELSE
			State := 1;	
			
		END_IF
	
	(* Do a csv search to allocate memory for the csv file. *)	
	3:	
		csvSearch.pStructName := csvInit.pStructName;
		csvSearch.NumOfStructs := csvInit.NumOfStructs;
		csvSearch.pStructMem := csvInit.pStructMem;
		csvSearch.MemLen := csvInit.MemCounter;
		csvSearch.FullNameLenght := 0;
		csvSearch.Separator := 44; (* ascii code for , *)
		csvSearch.Options := 0;
		csvSearch.FileHeader := HEADER;
		csvSearch.pMaschineNo := ADR('machine 1');
  		csvSearch.pComment := ADR('P84 parameter read file');
  		csvSearch.pVersion := ADR('v0.01');
  		csvSearch();
		
		(* successfully created the file for writing *)
		IF (csvSearch.status = 0) THEN						
			State := 4;
		
		(* Error occured to abort the process *)
		ELSIF (csvSearch.status <> 0) AND (csvSearch.status <> 65535) THEN
			State := 0;
			
		END_IF
		
	
	(* Write the data to the csv file *)
	4:
		csvWrite.pFileName := ADR(P84ParRead.CsvFileName);
  		csvWrite.pDevice := ADR(P84ParRead.FileDevice);
  		csvWrite.pPath := ADR(P84ParRead.FilePath);
  		csvWrite.pStructMem := csvInit.pStructMem;
		csvWrite.MemLen := csvSearch.FileLen;
		csvWrite.Mode := FILE_OW;
		csvWrite();
		
		(* Write completed successfully *)
		IF (csvWrite.status = 0) THEN
  			State := 0;
			
		ELSIF (csvWrite.status <> 0) AND (csvWrite.status <> 65535) THEN	
			State := 0;
			
		END_IF
	
	
	(* Error occured *)	
	255:
		
				 
	
END_CASE



eplRead();


END_PROGRAM
