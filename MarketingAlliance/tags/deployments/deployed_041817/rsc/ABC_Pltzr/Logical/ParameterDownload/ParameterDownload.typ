(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: S44param
 * File: S44param.typ
 * Author: scoccimaroj
 * Created: July 15, 2010
 ********************************************************************
 * Local data types of program S44param
 ********************************************************************)

TYPE
	X64ParamRead_typ : 	STRUCT 
		pDevice : STRING[30]; (*Device string of the inverter*)
		FileDevice : STRING[20]; (*Device string for writing the csv file.*)
		FilePath : STRING[30]; (*CSV File path*)
		CsvFileName : STRING[50]; (*name of the csv file*)
		Parameters : ARRAY[0..NUM_OF_X64PAR]OF ASIOACCPar_typ;
	END_STRUCT;
	S44ParamRead_typ : 	STRUCT 
		pDevice : STRING[30]; (*Device string of the inverter*)
		FileDevice : STRING[20]; (*Device string for writing the csv file.*)
		FilePath : STRING[30]; (*CSV File path*)
		CsvFileName : STRING[50]; (*name of the csv file*)
		Parameters : ARRAY[0..NUM_OF_S44PAR]OF ASIOACCPar_typ;
	END_STRUCT;
	ASIOACCPar_typ : 	STRUCT 
		ChannelName : STRING[15]; (*Device string of the inverter*)
		Data : UDINT;
	END_STRUCT;
	P84ParamRead_typ : 	STRUCT 
		pDevice : STRING[30]; (*Device string of the inverter*)
		FileDevice : STRING[20]; (*Device string for writing the csv file.*)
		FilePath : STRING[30]; (*CSV File path*)
		CsvFileName : STRING[50]; (*name of the csv file*)
		NodeNr : USINT; (*node number of the inverter on the EPL network*)
		Parameters : ARRAY[0..NUM_OF_P84PAR]OF EPLPar_typ;
	END_STRUCT;
	EPLPar_typ : 	STRUCT 
		Index : UINT;
		Subindex : USINT;
		Data : UDINT;
		Code : STRING[5];
	END_STRUCT;
	P74ParamRead_typ : 	STRUCT 
		pDevice : STRING[30]; (*Device string of the inverter*)
		FileDevice : STRING[20]; (*Device string for writing the csv file.*)
		FilePath : STRING[30]; (*CSV File path*)
		CsvFileName : STRING[50]; (*name of the csv file*)
		NodeNr : USINT; (*node number of the inverter on the EPL network*)
		Parameters : ARRAY[0..NUM_OF_P74PAR]OF EPLPar_typ;
	END_STRUCT;
END_TYPE
