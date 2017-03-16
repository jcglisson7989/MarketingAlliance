(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: ConfigAndRecipes
 * File: Config.typ
 * Author: goran_2
 * Created: August 06, 2011
 ********************************************************************
 * Data types of package ConfigAndRecipes
 ********************************************************************)
(*==================================================================*)
(*Config related structures that shall not be changed.*)
(*==================================================================*)

TYPE
	cfgConfig_enums : 
		(
		ENUM_APPCFG_INFO_TEXT_LEN := 127,
		ENUM_APPCFG_PATHNAME_MAXLEN := 64,
		ENUM_APPCFG_PWD_MAXLEN := 15,
		ENUM_APPCFG_DEFECT_MAXINDEX := 11,
		ENUM_APPCFG_DEFECT_TXTMAXLEN := 31,
		ENUM_APPCFG_MAGIC_NUMBER := 16#55555555 (*Magic word (010101...) sequence (to detect battery backed up memory alterations)*)
		);
	cfgConfig_typ : 	STRUCT  (*Machine configuration includes settings for timers and settings for servo drives.*)
		cfgDefault : cfgMachineConfig_typ; (*The hardcoded defaults from the various application tasks.  This config should not be written to in the application code.  \todo  maintain a separate config that is the factory default config?*)
		machine : cfgMachineConfig_typ; (*The machine-level config.  Any item not set as product-level will use the value from this config.  When a different product is activated, this config will be copied to the active config first.*)
		recipe : cfgMachineConfig_typ; (*A holding space for a non-active recipe, i.e. product, config.  Possibly not needed or better located in the HMI package.  Would be used to support HMI editing of a product config that is not the active config.*)
		active : cfgMachineConfig_typ; (*The config used for current machine operation.  This will be the machine config*)
	END_STRUCT;
END_TYPE
