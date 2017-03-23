(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: HMI
 * File: cfgPaiArSystem.typ
 * Author: goran
 * Created: October 15, 2014
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)

TYPE
	paiARNetworkAddress_typ : 	STRUCT  (*AR (Automation Runtime) related network settings*)
		ethDevice : STRING[31];
		hostname : STRING[31];
		ipAddr : STRING[15];
		netMask : STRING[15];
		broadcast : STRING[15];
		gateway : STRING[15];
	END_STRUCT;
	paiARSystem_typ : 	STRUCT 
		ethernet : paiARNetworkAddress_typ;
	END_STRUCT;
END_TYPE
