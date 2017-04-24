
TYPE
    MpFileErrorEnum : 
        ( (* Error numbers of library MpFile *)
        mpFILE_NO_ERROR := 0, (* No error *)
        mpFILE_ERR_ACTIVATION := -1064239103, (* The component could not be created and will not be activated [Error: 1, 0xc0910001] *)
        mpFILE_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL [Error: 2, 0xc0910002] *)
        mpFILE_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection is not allowed [Error: 3, 0xc0910003] *)
        mpFILE_ERR_MPLINK_CHANGED := -1064239100, (* MpLink was changed while the component was enabled [Error: 4, 0xc0910004] *)
        mpFILE_ERR_MPLINK_CORRUPT := -1064239099, (* MpLink memory is corrupted [Error: 5, 0xc0910005] *)
        mpFILE_ERR_MPLINK_IN_USE := -1064239098, (* MpLink is already being used by another component [Error: 6, 0xc0910006] *)
        mpFILE_ERR_CONFIG_INVALID := -1064239091, (* Configuration could not be read when creating the component. See the log for further details [Error: 13, 0xc091000d] *)
        mpFILE_ERR_MISSING_UICONNECT := -1064165376, (* UIConnect is NULL [Error: 8192, 0xc0922000] *)
        mpFILE_ERR_CMD_NOT_ALLOWED := -1064165375, (* This command is not allowed in multi select mode [Error: 8193, 0xc0922001] *)
        mpFILE_ERR_NOTHING_TO_PASTE := -1064165374, (* Nothing available to be pasted [Error: 8194, 0xc0922002] *)
        mpFILE_ERR_NOTHING_SELECTED := -1064165373, (* Nothing selected in multi select mode [Error: 8195, 0xc0922003] *)
        mpFILE_ERR_DIR_ALREADY_EXISTS := -1064165372, (* Directory already exists [Error: 8196, 0xc0922004] *)
        mpFILE_ERR_INVALID_FILE_DEV := -1064165371, (* The specified file device is not valid [Error: 8197, 0xc0922005] *)
        mpFILE_ERR_NAME_EMPTY := -1064165370, (* File or folder name is empty [Error: 8198, 0xc0922006] *)
        mpFILE_ERR_INVALID_NAME := -1064165369, (* Invaild file or folder name [Error: 8199, 0xc0922007] *)
        mpFILE_ERR_PASTE_NOT_ALLOWED := -1064165368 (* Paste is not allowed in current directory [Error: 8200, 0xc0922008] *)
        );
END_TYPE
