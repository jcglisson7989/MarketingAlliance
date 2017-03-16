
TYPE
    MpDeltaErrorEnum : 
        ( (* Error numbers of library MpDelta *)
        mpDELTA_NO_ERROR := 0, (* No error *)
        mpDELTA_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpDELTA_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpDELTA_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpDELTA_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpDELTA_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpDELTA_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpDELTA_ERR_PAR_NULL := -1064239097, (* Parameters structure is a null pointer [Error: 7, 0xc0910007] *)
        mpDELTA_ERR_CONFIG_NULL := -1064239096, (* Configuration structure is null pointer [Error: 8, 0xc0910008] *)
        mpDELTA_ERR_CONFIG_NO_PV := -1064239095, (* Configuration pointer not PV [Error: 9, 0xc0910009] *)
        mpDELTA_ERR_CONFIG_LOAD := -1064239094, (* Error loading configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 10, 0xc091000a] *)
        mpDELTA_WRN_CONFIG_LOAD := -2137980917, (* Warning loading configuration [Warning: 11, 0x8091000b] *)
        mpDELTA_ERR_CONFIG_SAVE := -1064239092, (* Error saving configuration {2:ConfigName} (ErrorCause: {1:ErrorNumber}) [Error: 12, 0xc091000c] *)
        mpDELTA_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpDELTA_ERR_TRANSFORMATION := -1064091136, (* Error in robot transformation function [Error: 16896, 0xc0934200] *)
        mpDELTA_ERR_AXES_GROUP := -1064091135, (* Error in the axes group. (ErrorSource: {2:PLCopenFBName}, ErrorCause: {1:ErrorNumber}) [Error: 16897, 0xc0934201] *)
        mpDELTA_WRN_CMD_NOT_ALLOWED := -2137832958, (* {2:Command} not allowed when robot is {3:Condition} [Warning: 16898, 0x80934202] *)
        mpDELTA_INF_NOT_ENOUGH_AXES := 1083392515, (* Not enough axes components found, wait until all linked axes components output Active = TRUE [Informational: 16899, 0x40934203] *)
        mpDELTA_ERR_AXES_GROUP_NULL := -1064091132, (* Invalid axes group [Error: 16900, 0xc0934204] *)
        mpDELTA_ERR_WS_CREATE := -1064091131, (* Failed to create workspace monitoring object (ErrorCause: {1:ErrorNumber}) [Error: 16901, 0xc0934205] *)
        mpDELTA_WRN_OVR_OUT_OF_RANGE := -2137832954, (* Override value {2:Value} out of expected range 0..100% [Warning: 16902, 0x80934206] *)
        mpDELTA_ERR_INVALID_COORD := -1064091129, (* Invalid CoordSystem parameter for selected Jog.Coord parameter, expecting {2:ExpCoord} [Error: 16903, 0xc0934207] *)
        mpDELTA_ERR_WS_NOT_DEFINED := -1064091128 (* Workspace Monitoring not defined, Workspace Monitoring cannot be activated [Error: 16904, 0xc0934208] *)
        );
END_TYPE
