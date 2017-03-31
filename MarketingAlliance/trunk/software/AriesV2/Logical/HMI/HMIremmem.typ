(********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Package: HMI
 * File: HMIperm.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI object - Remanent PV-s*)
(*########################################################################*)

TYPE
	hmiRemanent_typ : 	STRUCT 
		magicNumber : UDINT; (*magic number to detect failure of the rem mem (i.e. drained battery)*)
	END_STRUCT;
	cfgRemanentData_typ : 	STRUCT  (*Configuration and recipe related data stored in remanent (battery backed) memory*)
		magicPrefix : UDINT; (*Set to 0x55555555 (MAGIC_NUMBER) to detect when/if battery backed memory changes*)
		magicPosfix : UDINT; (*Set to 0x55555555 (MAGIC_NUMBER) to detect when/if battery backed memory changes*)
	END_STRUCT;
END_TYPE
