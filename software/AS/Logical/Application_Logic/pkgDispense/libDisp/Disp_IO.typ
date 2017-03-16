
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
	END_STRUCT;
	HERNON_Inline_Dispense_Item_typ : 	STRUCT 
		iValveReady : BOOL;
		oDispTrigger : BOOL;
		EdgeGen : X20DS4389_Edgegen_typ;
	END_STRUCT;
	HERNON_Inline_Dispense_IO_typ : 	STRUCT 
		Projectile : HERNON_Inline_Dispense_Item_typ;
		Primer : HERNON_Inline_Dispense_Item_typ;
		iEdgeDetectError : BOOL;
		oQuitEdgeDetectError : BOOL;
	END_STRUCT;
END_TYPE
