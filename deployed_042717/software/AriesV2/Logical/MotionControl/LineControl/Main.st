
PROGRAM _INIT

END_PROGRAM

PROGRAM _CYCLIC
	//Rather than re-map all of the VC mappings, this task is in the same spot as the old VC mappings so it automatically finds them without remapping.
	pAxisControl ACCESS ADR(AxisControl);
	pAxisPar ACCESS ADR(AxisPar);
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

