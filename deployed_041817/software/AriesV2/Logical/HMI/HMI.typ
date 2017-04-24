(********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI key assinged PV-s (i.e. page navigation, save btns, etc)*)
(*########################################################################*)

TYPE
	hmiControlLogicKeys_typ : 	STRUCT 
		btnRestartLoginTimer : USINT; (*1-means that login timer restart is requested*)
		btnLoginIcon : USINT; (*1-means that login logo (icon) is pressed*)
		menuKeyPressLT : ARRAY[0..HMI_ENUM_MENU_ITEMS_LT]OF BOOL; (*Mom keys connected to menu items LF*)
		menuKeyPressRT : ARRAY[0..HMI_ENUM_MENU_ITEMS_RT]OF BOOL; (*Mom keys connected to menu items RT*)
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI navigation PV-s (i.e. PV-s assigned to required VC PV-s such as currentPage, etc)*)
(*########################################################################*)

TYPE
	hmiNavigationLogic_typ : 	STRUCT 
		changePage : USINT;
		currentPage : USINT;
		htmlCurrentURL : STRING[127];
		htmlChangeURL : STRING[127];
		currentPageText : STRING[31];
		prevPage : USINT;
		nextPage : USINT;
		pageInit : BOOL;
		pageExit : BOOL;
		state : USINT;
		currentStateText : STRING[31];
		statePrev : USINT;
		stateNext : USINT;
		loginLevel : UDINT;
		stateInit : BOOL;
		tmr1 : TON; (*Alert message control timer*)
		tmr2 : TON; (*Unack alarms message alert blinking timer*)
		tmr3 : TON; (*Password level reset timer*)
		tmr3RemainingTimeSec : UDINT;
		tmr3RemainingTimeMin : UDINT;
		tmr4 : TON;
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI related status control PV-s (i.e. visibility, locking, etc)*)
(*########################################################################*)

TYPE
	hmiControlLogicStatus_typ : 	STRUCT 
		visibleSaveCfg : UINT;
		menuVisibleLT : UINT; (*Main menu LF visibility control *)
		menuVisibleRT : UINT; (*Main menu RT visibility control *)
		menuVisibleRTItems : ARRAY[0..HMI_ENUM_MENU_ITEMS_RT]OF UINT; (*Main menu items RT visibility control - for buttons stacked on top of each other in the upper, rt *)
		menuIndexLT : UINT; (*Main menu currently selected menu item - LF*)
		show_motion_tab : USINT;
		show_Aux_tab : USINT;
		show_io_tab : UINT;
		menuIndexRT : UINT; (*Main menu currently selected menu item - RT*)
		loginVisibleGE1 : USINT; (*Visibility control for login level related stuff - set to visible (0) if login level >= 1; othervise set to 1 (i.e. loginLevel < 1)*)
		loginVisibleGE2 : USINT; (*Visibility control for login level related stuff - set to visible (0) if login level >= 2; othervise set to 1 (i.e. loginLevel < 2)*)
		loginVisibleGE3 : USINT; (*Visibility control for login level related stuff - set to visible (0) if login level >= 2; othervise set to 1 (i.e. loginLevel < 2)*)
		menuLFHideTimer : TON; (*timer of automaticaly hiding LF dropdown menu*)
		menuRTHideTimer : TON; (*timer of automaticaly hiding RT dropdown menu*)
		tabKeysRadioDataPoint : USINT; (*DP that tab button are writing to in order to create radio buttons/tab view effect*)
		tabKeysRadioArray : ARRAY[0..HMI_ENUM_TAB_KEYS_MAX]OF USINT;
		tabKeysToggle : ARRAY[0..HMI_ENUM_MENU_ITEMS_LT]OF USINT;
		passwordStrings : ARRAY[0..HMI_PWD_LEVELS]OF STRING[HMI_PWD_MAXLEN]; (*Password strings used for loginLevel control*)
	END_STRUCT;
END_TYPE

(*=============================================================================*)
(*Recipe related HMI logic.*)
(*=============================================================================*)

TYPE
	hmiRecipeLogic_typ : 	STRUCT 
		recVisible : USINT; (*Recipe related visibility control*)
		recSelectIdx : UINT; (*Recipe list index*)
		recSelectIdxMax : UINT; (*Recipe list index*)
		recSaveAsIdx : UINT; (*Recipe index for SaveAs action*)
		recSelectName : STRING[80]; (*Name of the currently selected recipe from the recipe list*)
		btnLockedActivate : USINT; (*Button lock control*)
		btnLockedNew : USINT; (*Button lock control*)
		btnLockedDelete : USINT; (*Button lock control*)
		btnLockedSaveAs : USINT; (*Button lock control*)
		btnActivate : BOOL; (*mom btn to Activate a recipe*)
		btnNew : BOOL; (*mom btn to New a recipe*)
		btnDelete : BOOL; (*mom btn to Delete a recipe*)
		btnSaveAs : BOOL; (*mom btn to SaveAs a recipe*)
		stateRecipes : UDINT;
	END_STRUCT;
END_TYPE

(*=============================================================================*)
(*Fileio Items*)
(*=============================================================================*)
(*=============================================================================*)
(*Tabs Control*)
(*=============================================================================*)
(*=============================================================================*)
(*HMI related navigation and control logic.*)
(*=============================================================================*)
(*Insert your comment here.*)
(*Insert your comment here.*)

TYPE
	hmiTableTrigger_typ : 	STRUCT 
		Rec : BOOL;
		Cfg : BOOL;
	END_STRUCT;
	hmiTableLoad_typ : 	STRUCT 
		Trigger : BOOL;
	END_STRUCT;
	hmiTables_typ : 	STRUCT 
		Trigger : hmiTableTrigger_typ;
		Load : hmiTableLoad_typ;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	hmiControlLogic_typ : 	STRUCT 
		status : hmiControlLogicStatus_typ;
		keys : hmiControlLogicKeys_typ;
		prv : hmiNavigationLogic_typ; (*Hmi (panel) private data for handling screen navigation and hmi logic. Used only wihin HMI.*)
		recipes : hmiRecipeLogic_typ;
		alertMsg : hmiAlert_typ;
		dialogMsg : hmiDialog_typ;
		tables : hmiTables_typ;
	END_STRUCT;
END_TYPE
