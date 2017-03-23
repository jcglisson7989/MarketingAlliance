
TYPE
    MpRecipeErrorEnum : 
        ( (* Error numbers of library MpRecipe *)
        mpRECIPE_NO_ERROR := 0, (* No error *)
        mpRECIPE_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
        mpRECIPE_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
        mpRECIPE_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
        mpRECIPE_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
        mpRECIPE_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
        mpRECIPE_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
        mpRECIPE_ERR_CONFIG_INVALID := -1064239091, (* Invalid Configuration [Error: 13, 0xc091000d] *)
        mpRECIPE_ERR_SAVE_DATA := -1064140799, (* Error saving recipe [Error: 32769, 0xc0928001] *)
        mpRECIPE_ERR_LOAD_DATA := -1064140798, (* Error loading recipe [Error: 32770, 0xc0928002] *)
        mpRECIPE_ERR_INVALID_FILE_DEV := -1064140797, (* Invalid file device [Error: 32771, 0xc0928003] *)
        mpRECIPE_ERR_INVALID_FILE_NAME := -1064140796, (* Invalid filename [Error: 32772, 0xc0928004] *)
        mpRECIPE_ERR_CMD_IN_PROGRESS := -1064140795, (* Component currently executing command [Error: 32773, 0xc0928005] *)
        mpRECIPE_WRN_SAVE_WITH_WARN := -2137882618, (* Warnings while saving recipe [Warning: 32774, 0x80928006] *)
        mpRECIPE_WRN_LOAD_WITH_WARN := -2137882617, (* Warnings while loading recipe [Warning: 32775, 0x80928007] *)
        mpRECIPE_ERR_SAVE_WITH_ERRORS := -1064140792, (* An error occured while converting parameters to a recipe. No recipe file has been created. See logger for further details. [Error: 32776, 0xc0928008] *)
        mpRECIPE_ERR_LOAD_WITH_ERRORS := -1064140791, (* Error converting recipe to parameters [Error: 32777, 0xc0928009] *)
        mpRECIPE_ERR_MISSING_RECIPE := -1064140790, (* No connection to parent component [Error: 32778, 0xc092800a] *)
        mpRECIPE_ERR_MISSING_MPFILE := -1064140789, (* No connection to file manager [Error: 32779, 0xc092800b] *)
        mpRECIPE_ERR_INVALID_SORT_ORDER := -1064140788, (* Invalid sort order selected [Error: 32780, 0xc092800c] *)
        mpRECIPE_WRN_MISSING_UICONNECT := -2137882611, (* Invalid value for "UIConnect" [Warning: 32781, 0x8092800d] *)
        mpRECIPE_ERR_INVALID_PV_NAME := -1064140786, (* Invalid PV [Error: 32782, 0xc092800e] *)
        mpRECIPE_ERR_INVALID_LOAD_TYPE := -1064140785, (* Invalid LoadType [Error: 32783, 0xc092800f] *)
        mpRECIPE_ERR_LISTING_FILES := -1064140784, (* Error creating file list [Error: 32784, 0xc0928010] *)
        mpRECIPE_ERR_PV_NAME_NULL := -1064140783, (* PV name is NULL [Error: 32785, 0xc0928011] *)
        mpRECIPE_WRN_NO_PV_REGISTERED := -2137882606, (* No PV registered [Warning: 32786, 0x80928012] *)
        mpRECIPE_ERR_SYNC_SAVE_ACTIVE := -1064140781, (* Saving active [Error: 32787, 0xc0928013] *)
        mpRECIPE_ERR_DELETING_FILE := -1064140780, (* Error deleting recipe file [Error: 32788, 0xc0928014] *)
        mpRECIPE_WRN_EMPTY_RECIPE := -2137882603, (* Saving empty recipe file [Warning: 32789, 0x80928015] *)
        mpRECIPE_INF_WAIT_RECIPE_FB := 1083342870, (* Waiting for parent recipe component [Informational: 32790, 0x40928016] *)
        mpRECIPE_ERR_RENAMING_FILE := -1064140777 (* Error renaming recipe file [Error: 32791, 0xc0928017] *)
        );
END_TYPE