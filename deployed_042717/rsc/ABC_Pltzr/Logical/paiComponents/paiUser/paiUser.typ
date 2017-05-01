(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: paiTemplate
 * File: paiUser.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package paiUser
 ********************************************************************)
(*########################################################################*)
(*pai specific defines for user access logic*)
(*########################################################################*)

TYPE
	paiUserAccessMaxEnums : 
		(
		paiUSER_RIGHTSMAXIDX := 19, (*Access rights max index*)
		paiUSER_USERSMAXIDX := 9, (*Users max index*)
		paiUSER_GROUPMAXIDX := 5 (*Groups max index*)
		);
	paiUserAccessRightsIndex : 
		(
		paiUSER_ACCESS_MFG := 0, (*Access right index*)
		paiUSER_ACCESS_ADMIN := 1, (*Access right index*)
		paiUSER_ACCESS_MAINT := 2, (*Access right index*)
		paiUSER_ACCESS_NONE := 3 (*Access right index*)
		);
	paiMpUserAccessRightEnum : 
		(
		mpUSER_ACCESS_UNDEFINED := 0, (*Access right undefined*)
		mpUSER_ACCESS_NONE := 1, (*No access rights*)
		mpUSER_ACCESS_VIEW := 2, (*Read access*)
		mpUSER_ACCESS_ACTUATE := 3, (*Processes can be started/stopped but not edited*)
		mpUSER_ACCESS_FULL := 4 (*Full access (read-write access)*)
		);
	paiMpUserMgrUIGroupInfoType : 	STRUCT 
		Name : STRING[20]; (*Name of the user group*)
		Index : UINT; (*Index of the user group*)
		Level : DINT; (*Level of the user group*)
		Admin : BOOL; (*Indicates whether this group has administrator rights*)
		AccessRights : ARRAY[0..19]OF paiMpUserAccessRightEnum; (*List with the access rights for individual actions*)
	END_STRUCT;
	paiUserInfo_typ : 	STRUCT 
		UserName : STRING[20];
		UserFullName : STRING[100];
		Password : STRING[20];
		PIN : UDINT;
		GroupIndex : UDINT;
	END_STRUCT;
	paiUserMgrUIConnect_typ : 	STRUCT 
		groupIndex : UDINT;
		groupIndexMax : UDINT;
		userIndex : UDINT;
		userIndexMax : UDINT;
		loggedIndex : UDINT;
		isUserLogged : UDINT;
		visibleLogged : UDINT;
		visibleNotLogged : UDINT;
		btnRestartLoginTimer : UDINT;
		btnToggleLogin : UDINT;
		remainingLoginTime_min : UDINT;
		remainingLoginTime_sec : UDINT;
		pwdLevel : UDINT;
		pwdLevelOld : UDINT;
		pwdLevelCompletion : UDINT;
		listUserNames : ARRAY[0..11]OF STRING[20];
		listUserPasswords : ARRAY[0..11]OF STRING[20];
	END_STRUCT;
	paiUserMgrPrivate_typ : 	STRUCT 
		UIConnect : paiUserMgrUIConnect_typ;
		loginTimer : TON;
	END_STRUCT;
	paiUserConfiguration_typ : 	STRUCT 
		listGroups : ARRAY[0..5]OF paiMpUserMgrUIGroupInfoType; (*table colum: id-s*)
		listUsers : ARRAY[0..9]OF paiUserInfo_typ;
		loginTime_sec : REAL;
		New_Member : USINT;
	END_STRUCT;
	paiUserMgr_typ : 	STRUCT 
		currentGroup : paiMpUserMgrUIGroupInfoType;
		currentUser : paiUserInfo_typ;
		pUserConfig : REFERENCE TO paiUserConfiguration_typ;
		userMgr : paiUserMgrPrivate_typ;
	END_STRUCT;
END_TYPE
