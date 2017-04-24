(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: S44param
 * File: S44paramCyclic.st
 * Author: scoccimaroj
 * Created: July 15, 2010
 ********************************************************************
 * Implementation of program S44param
 ********************************************************************)

PROGRAM _CYCLIC


CASE State OF

	(* Wait for a start command *)
	0:


		IF (cmdStart) THEN
			cmdStart :=	0;
			i := 0;
			State := 1;
		END_IF



	(* Reads the X64 parameter *)
	1:
		AsIOAccRead_0.enable :=	1;
		AsIOAccRead_0.pChannelName := ADR(S44ParRead.Parameters[i].ChannelName);
			
		(* If the status = 0, then the read was successful.  Store the value read. *)
		IF (AsIOAccRead_0.status = 0) THEN
			S44ParRead.Parameters[i].Data := AsIOAccRead_0.value;
			AsIOAccRead_0.enable :=	0;
			State := 2;			

		(* Remain until the Read FUB is completed *)
		ELSIF (AsIOAccRead_0.status = ERR_FUB_BUSY) OR (AsIOAccRead_0.status = ERR_FUB_ENABLE_FALSE) THEN
			State := 1;

		(* If a FUB error occurs go to the next parameter *)
		ELSE
			AsIOAccRead_0.enable :=	0;
			State := 2;
		END_IF
		
	2:
		(* all the parameters have been read *)
		IF (i >= NUM_OF_S44PAR) THEN
  			i := 0;
			State := 3;
		
		(* read the next parameter in the list *)
		ELSE 
			i := i + 1;
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
  		csvSearch.pComment := ADR('S44 parameter read file');
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
		csvWrite.pFileName := ADR(S44ParRead.CsvFileName);
  		csvWrite.pDevice := ADR(S44ParRead.FileDevice);
  		csvWrite.pPath := ADR(S44ParRead.FilePath);
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



END_CASE

(* Function Block Calls *)
AsIOAccRead_0();


END_PROGRAM
