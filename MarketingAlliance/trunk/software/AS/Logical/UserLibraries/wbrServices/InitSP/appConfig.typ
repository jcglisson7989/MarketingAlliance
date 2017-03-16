(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: ConfigAndRecipes
 * File: appConfig.typ
 * Author: goran_2
 * Created: August 06, 2011
 ********************************************************************
 * Data types of package ConfigAndRecipes
 ********************************************************************)
(*Insert your comment here.*)

TYPE
	cfgMachineConfig_typ : 	STRUCT  (*Machine configuration includes settings for timers and settings for servo drives.*)
		cfgFile : cfgFileInfo_typ;
		cfgCompile : cfgCompileVersionInfo_typ;
		wbrMemService : wbrMemSvcStoredConfig_typ;
	END_STRUCT;
END_TYPE
