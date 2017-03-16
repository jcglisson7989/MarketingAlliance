
FUNCTION Register_Log_PV : BOOL (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pDesc : REFERENCE TO STRING[80]; (*pRegParBlock : REFERENCE TO MpDataRegPar;*)
		pPVName : REFERENCE TO STRING[80];
		pIterator : REFERENCE TO DINT;
		pMpLink : REFERENCE TO MpComIdentType;
	END_VAR
END_FUNCTION
