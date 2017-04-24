
TYPE
	paiBnRX64ParamItem_typ : 	STRUCT 
		oValue : UDINT;
		iValueWR : UDINT;
		iChannelNameRD : STRING[15];
		iChannelNameWR : STRING[15];
		oStatusRD : UDINT;
		oStatusWR : UDINT;
		iMode : UDINT;
		mState : UDINT;
	END_STRUCT;
	paiBnRX64Station_typ : 	STRUCT 
		iDeviceName : STRING[31]; (*VFD Device Name (see AsIOAcc library)*)
		iDescription : STRING[31];
		iPtrModuleOk : UDINT; (*ptr to Module OK signal from the drive*)
		mState : UDINT;
		mCurrentEntry : UDINT;
		mMaxValidEntry : UDINT;
		mX64Params : ARRAY[0..paiBnRVFDX64ParamIdxMax]OF paiBnRX64ParamItem_typ; (*list of x64 parameters*)
	END_STRUCT;
	paiBnRVFDX64RWMgr_typ : 	STRUCT 
		mState : UDINT;
		mCurrentEntry : UDINT;
		mX64VFDs : ARRAY[0..paiBnRVFDX64DriveIdxMax]OF paiBnRX64Station_typ; (*list of x64 parameters*)
		mAsIOAccRd : AsIOAccRead;
		mAsIOAccWr : AsIOAccWrite;
	END_STRUCT;
END_TYPE
