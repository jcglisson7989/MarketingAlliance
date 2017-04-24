FUNCTION_BLOCK CSV_CheckFile
VAR
		statusInternal	:UINT;	
		fileVersionStr	:STRING[255];	
		cntSizesFound	:USINT;	
		ixCmp	:USINT;	
		pSize	: REFERENCE TO UDINT;	
		SizesFound	:ARRAY [0..254] OF UDINT;	
		fileOffset	:UDINT;	
		sizeSignificationStr	:STRING[255];	
		lineBuf	:STRING[255];	
		versionFound	:BOOL;	
		maxLenLine	:UINT;	
		ixLine	:UDINT;	
		ixLineMax	:UDINT;	
		lineCnt	:UDINT;	
		FClose	:FileClose;	
		fileIdent	:UDINT;	
		pChar	: REFERENCE TO USINT;	
		FOpen	:FileOpen;	
		FRead	:FileRead;	
		verSignificationStr	:STRING[255];	
		R_TRIG_0	:R_TRIG;	
		fileCheckStep	:UINT;	
		CharPerCyclic	:USINT;	
	END_VAR
	VAR_INPUT
		enable	:BOOL;	
		pFileName	:UDINT;	
		pDevice	:UDINT;	
		pStructSizes	:UDINT;	
		NumOfStruct	:USINT;	
		pVersion	:UDINT;	
		pFileBuffer	:UDINT;	
		FileBufferSize	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		fileError	:UINT;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK CSV_InitCheckFile
VAR
		AsMemPartAlloc_0	:AsMemPartAlloc;	
		AsMemPartCreate_0	:AsMemPartCreate;	
	END_VAR
	VAR_INPUT
		enable	:BOOL;	
		MemCounter	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		pFileBuffer	:UDINT;	
		FileBufferSize	:UDINT;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK CSV_Search
VAR
		Internal	:_csv_search_internal;	
		zzDTGetTime00000	:DTGetTime;	
		SearchChar	: REFERENCE TO USINT;	
		Dyn_Bool	: REFERENCE TO BOOL;	
		Dyn_Usint	: REFERENCE TO USINT;	
		Dyn_Sint	: REFERENCE TO SINT;	
		Dyn_Uint	: REFERENCE TO UINT;	
		Dyn_Int	: REFERENCE TO INT;	
		Dyn_Udint	: REFERENCE TO UDINT;	
		Dyn_Dint	: REFERENCE TO DINT;	
		Dyn_Real	: REFERENCE TO REAL;	
		Dyn_Date_and_Time	: REFERENCE TO DATE_AND_TIME;	
		Dyn_Time	: REFERENCE TO TIME;	
		OnlyOneVar	:BOOL;	
	END_VAR
	VAR_INPUT
		pStructName	:UDINT;	
		NumOfStructs	:USINT;	
		pStructMem	:UDINT;	
		MemLen	:UDINT;	
		Options	:UDINT;	
		FullNameLenght	:BOOL;	
		FileHeader	:BOOL;	
		Separator	:USINT;	
		pMaschineNo	:UDINT;	
		pComment	:UDINT;	
		pVersion	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		ErrorName	:USINT;	
		FileLen	:UDINT;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK CSV_Init
VAR
		Internal	:_csv_init_Internal;	
		SearchChar	: REFERENCE TO USINT;	
		Dyn_Usint	: REFERENCE TO USINT;	
		Dyn_Sint	: REFERENCE TO SINT;	
		Dyn_Int	: REFERENCE TO INT;	
		Dyn_Dint	: REFERENCE TO DINT;	
		Dyn_Uint	: REFERENCE TO UINT;	
		Dyn_Udint	: REFERENCE TO UDINT;	
		Dyn_Real	: REFERENCE TO REAL;	
		Dyn_Date_and_Time	: REFERENCE TO DATE_AND_TIME;	
		Dyn_Time	: REFERENCE TO TIME;	
		OnlyOneVar	:BOOL;	
	END_VAR
	VAR_INPUT
		pStructName	:UDINT;	
		NumOfStructs	:USINT;	
		FullNameLenght	:BOOL;	
		Options	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		ErrorName	:USINT;	
		pStructMem	:UDINT;	
		MemCounter	:UDINT;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK CSV_ListFile
VAR
		DirRead_01	:DirRead;	
		DirInfo_01	:DirInfo;	
		TmpString	:ARRAY [0..50] OF USINT;	
		Step	:USINT;	
		i	:UINT;	
		TmpExtension	:STRING[4];	
		FileInfo	:fiDIR_READ_DATA;	
		result1	:DINT;	
		result2	:DINT;	
		FileNumAct	:UINT;	
		FileNumOnDisk	:UINT;	
		Offset	:UDINT;	
		pActName	:UDINT;	
		dateandtime	:DTStructure;	
		UpLines	:UINT;	
		DownLines	:UINT;	
		PosFirstLine	:UINT;	
		OptionStruct	: REFERENCE TO CSV_ListFileOption_typ;	
	END_VAR
	VAR_INPUT
		pStringArray	:UDINT;	
		SizeStringArray	:UDINT;	
		ArrayNum	:UINT;	
		NumListboxLines	:UINT;	
		pFileDevice	:UDINT;	
		pPath	:UDINT;	
		MaxNameLenght	:USINT;	
		SetFocusPos	:UINT;	
		command	:USINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		CSV_FileNum	:UINT;	
		ListboxFocusPos	:UINT;	
		ScrollUp	:BOOL;	
		ScrollDown	:BOOL;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK SearchFileName
VAR
		step	:USINT;	
		FileName	:STRING[40];	
		i	:USINT;	
		FileOpen_01	:FileOpen;	
		FileClose_01	:FileClose;	
		SearchChar	: REFERENCE TO USINT;	
	END_VAR
	VAR_INPUT
		pFileName	:UDINT;	
		pDevice	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK CSV_ReadFile
VAR
		FileOpen_CSV	:FileOpen;	
		FileRead_CSV	:FileRead;	
		FileClose_CSV	:FileClose;	
		Internal	:_csv_read_internal;	
		Dyn_Usint	: REFERENCE TO USINT;	
		SearchChar	: REFERENCE TO USINT;	
		Dyn_Bool	: REFERENCE TO BOOL;	
		Dyn_Sint	: REFERENCE TO SINT;	
		Dyn_Uint	: REFERENCE TO UINT;	
		Dyn_Int	: REFERENCE TO INT;	
		Dyn_Udint	: REFERENCE TO UDINT;	
		Dyn_Dint	: REFERENCE TO DINT;	
		Dyn_String	: REFERENCE TO STRING[80];	
		Dyn_Real	: REFERENCE TO REAL;	
		Dyn_Date_and_Time	: REFERENCE TO DATE_AND_TIME;	
		Dyn_Time	: REFERENCE TO TIME;	
		Part	:BOOL;	
		TestUsint	:USINT;	
		temp_status	:UINT;	
	END_VAR
	VAR_INPUT
		pFileName	:UDINT;	
		pDevice	:UDINT;	
		pPath	:UDINT;	
		No_DatatypControl	:BOOL;	
		Separator	:USINT;	
		IgnoreError	:BOOL;	
		Options	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		LineCnt	:UDINT;	
		VarCnt	:UDINT;	
		ErrorLine	:UDINT;	
		ErrorNumber	:UINT;	
		ErrorCnt	:UDINT;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK ExListFile
VAR
		Internal	:_csv_exfilelist_internal;	
		DirInfo_CSV	:DirInfo;	
		DirRead_CSV	:DirRead;	
		FileOpen_CSV	:FileOpen;	
		FileRead_CSV	:FileRead;	
		FileClose_CSV	:FileClose;	
		DynUsint	: REFERENCE TO USINT;	
	END_VAR
	VAR_INPUT
		pStringArray	:UDINT;	
		SizeStringArray	:UDINT;	
		NumListboxLines	:UINT;	
		ArrayNum	:UINT;	
		pFileDevice	:UDINT;	
		MaxNameLenght	:USINT;	
		SetFocusPos	:UINT;	
		command	:USINT;	
		pOptions	:UDINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
		CSV_FileNum	:UINT;	
		ListboxFocusPos	:UINT;	
		ScrollUp	:BOOL;	
		ScrollDown	:BOOL;	
	END_VAR
END_FUNCTION_BLOCK
FUNCTION_BLOCK CSV_WriteFile
VAR
		Step	:USINT;	
		FileCreate_CSV	:FileCreate;	
		FileWrite_CSV	:FileWrite;	
		FileDelete_CSV	:FileDelete;	
		FileClose_CSV	:FileClose;	
		FileName	:STRING[80];	
		i	:USINT;	
		Dyn_Usint	: REFERENCE TO USINT;	
		DevMemInfo_CSV	:DevMemInfo;	
		Path	:STRING[100];	
	END_VAR
	VAR_INPUT
		pFileName	:UDINT;	
		pDevice	:UDINT;	
		pPath	:UDINT;	
		pStructMem	:UDINT;	
		MemLen	:UDINT;	
		Mode	:USINT;	
	END_VAR
	VAR_OUTPUT
		status	:UINT;	
	END_VAR
END_FUNCTION_BLOCK
