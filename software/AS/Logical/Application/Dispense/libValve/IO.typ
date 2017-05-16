
TYPE
	X20DS4389_Edgegen_typ : 	STRUCT 
		iEdgeMasterTime : DINT;
		iReadOutputStatus : BOOL;
		oEnableEdgeGen : BOOL;
		iEdgeGenReadbackEnabled : BOOL;
		oEdgeGenSequence : SINT;
		iEdgegenSequenceReadback : SINT;
		oEdgeGenTimestamp : DINT;
		iEdgeGenError : BOOL;
		oQuitEdgeGenError : BOOL;
		iEdgeGenWarning : BOOL;
		oQuitEdgeGenWarning : BOOL;
		iDiffTime : ARRAY[0..1]OF DINT;
		oEdgeGenOffset : UDINT;
	END_STRUCT;
	HERNON_Valve_IOPoint_typ : 	STRUCT 
		iValveReady : BOOL;
		oDispTrigger : BOOL;
		EdgeGen : X20DS4389_Edgegen_typ;
	END_STRUCT;
END_TYPE
