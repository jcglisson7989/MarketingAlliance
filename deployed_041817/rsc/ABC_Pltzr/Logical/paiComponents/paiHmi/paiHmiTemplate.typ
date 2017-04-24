(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: HMI
 * File: cfgPaiHmiTemplate.typ
 * Author: goran
 * Created: October 15, 2014
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI key assinged PV-s (i.e. page navigation, save btns, etc)*)
(*########################################################################*)

TYPE
	paiHmiTemplateEnums_typ : 
		(
		paiHMI_ENUM_MENU_ITEMS_LT := 10, (*Main menu - left side - number of buttons*)
		paiHMI_ENUM_TABS_MAXIDX := 10, (*Max number of tab keys per page*)
		paiHMI_ENUM_TG_TEXT_MAXIDX := 127, (*Max number of lines in the Text Group for Page Navigation*)
		paiHMI_ENUM_TG_TEXT_MAXLEN := 31, (*Max number of lines in the Text Group for Page Navigation*)
		paiHMI_PWD_LEVELS := 5, (*Number of password levels (0-operator;1-supervisor;2-admin;3-maintenance;4-factory)*)
		paiHMI_PWD_MAXLEN := 15 (*Max pwd len*)
		);
END_TYPE

(*########################################################################*)
(*HMI key assinged PV-s (i.e. menu, tabs, etc)*)
(*########################################################################*)

TYPE
	paiHmiTemplateKeys_typ : 	STRUCT 
		menuKeyTopLT : INT; (*Menu key press top LF*)
		menuKeyTopRT : INT; (*Mom keys connected to menu items RT*)
		currentMenuLF : INT;
		currentMenuRT : INT;
		tabKeysRadioDataPoint : INT; (*DP that tab button are writing to in order to create radio buttons/tab view effect*)
		tabKeysRadioDataPointOld : INT; (*DP that tab button are writing to in order to create radio buttons/tab view effect*)
		tabKeysRadioArray : ARRAY[0..paiHMI_ENUM_TABS_MAXIDX]OF INT;
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI related status control PV-s (i.e. visibility, locking, etc)*)
(*########################################################################*)

TYPE
	paiHmiTemplateStatus_typ : 	STRUCT 
		menuVisibleLT : UINT; (*Main menu LF visibility control *)
		menuIndexLT : UINT; (*Main menu currently selected menu item - LF*)
		loginVisibleGE1 : USINT; (*Visibility control for login level related stuff - set to visible (0) if login level >= 1; othervise set to 1 (i.e. loginLevel < 1)*)
		loginVisibleGE2 : USINT; (*Visibility control for login level related stuff - set to visible (0) if login level >= 2; othervise set to 1 (i.e. loginLevel < 2)*)
		menuLFHideTimer : TON; (*timer of automaticaly hiding LF dropdown menu*)
		unusedItemInvisible : UDINT; (*used for VC items that are not used (hidden)*)
		passwordStrings : ARRAY[0..paiHMI_PWD_LEVELS]OF STRING[paiHMI_PWD_MAXLEN]; (*Password strings used for loginLevel control*)
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI related timer settings*)
(*########################################################################*)

TYPE
	paiHmiTemplateTimerSettings_typ : 	STRUCT 
		loginTimeout : REAL; (*Login timeout timer setting*)
		dialogBoxTimeout : REAL; (*Dialog box (i.e. save data? yes/no) timeout for waiting on input*)
		splashScreenTimeout : REAL; (*Duration of the initial screen (i.e. manufacturer logo) *)
		dropdwMenuLFTimeout : REAL; (*Duration after which a dropdown menu is automaticaly hiden if not clicked *)
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI pwd settings*)
(*########################################################################*)

TYPE
	paiHmiTemplatePwdSettings_typ : 	STRUCT 
		passwordAdmin : STRING[paiHMI_PWD_MAXLEN]; (*Login timeout timer setting*)
		passwordMaint : STRING[paiHMI_PWD_MAXLEN]; (*Login timeout timer setting*)
		passwordSupervisor : STRING[paiHMI_PWD_MAXLEN]; (*Login timeout timer setting*)
		passwordFactory : STRING[paiHMI_PWD_MAXLEN]; (*Login timeout timer setting*)
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI related PV-s connected to VC runtime (see VC runtime settings)*)
(*########################################################################*)

TYPE
	paiHmiTemplateVCRuntime_typ : 	STRUCT 
		wheelCount : INT;
		wheelEnter : INT;
		keyLevelChange : INT;
		keyLevelCurrent : INT;
		languageChange : INT;
		languageCurrent : INT;
		keyMatrix : ARRAY[0..63]OF INT;
		LEDMatrix : ARRAY[0..63]OF INT;
		pageChange : INT;
		pageCurrent : INT;
		lifeSign : INT;
		IPAddress : STRING[31];
		focusControl : INT;
		helpControl : INT;
		touchCalibration : INT;
		touchCalibrationState : INT;
		screenSaverTimeout_sec : INT;
		screenSaverPage : INT;
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI related config file settings*)
(*########################################################################*)

TYPE
	paiHmiTemplateConfig_typ : 	STRUCT 
		pwdSettings : paiHmiTemplatePwdSettings_typ;
		timerSettings : paiHmiTemplateTimerSettings_typ;
	END_STRUCT;
END_TYPE

(*########################################################################*)
(*HMI control logic private PV-s*)
(*########################################################################*)

TYPE
	paiHmiTemplateItem_typ : 	STRUCT 
		itemText : STRING[31];
		itemVisible : UINT;
		itemDisabled : UINT;
		jumpPageId : UINT;
	END_STRUCT;
	paiHmiTemplateSubmenuItem_typ : 	STRUCT 
		button : paiHmiTemplateItem_typ;
		tabs : ARRAY[0..paiHMI_ENUM_TABS_MAXIDX]OF paiHmiTemplateItem_typ;
	END_STRUCT;
	paiHmiTemplatePrivate_typ : 	STRUCT 
		initDone : BOOL;
		state : INT;
		vcHandle : UDINT;
		index : UDINT;
		indexButton : UDINT;
		indexTab : UDINT;
		TG_id : UDINT;
		text : STRING[paiHMI_ENUM_TG_TEXT_MAXLEN];
		parseErrorText : STRING[127];
		textLen : UINT;
		textLines : ARRAY[0..paiHMI_ENUM_TG_TEXT_MAXIDX]OF STRING[paiHMI_ENUM_TG_TEXT_MAXLEN];
		activeTabs : ARRAY[0..paiHMI_ENUM_TABS_MAXIDX]OF paiHmiTemplateItem_typ;
		menuLF : ARRAY[0..paiHMI_ENUM_MENU_ITEMS_LT]OF paiHmiTemplateSubmenuItem_typ;
		pageSetByLFMenu : INT;
		pageCurrent : UDINT;
		pagePrev : UDINT;
		pageInit : BOOL;
		pageExit : BOOL;
	END_STRUCT;
	paiHmiTemplate_typ : 	STRUCT 
		runtime : paiHmiTemplateVCRuntime_typ; (*VC runtime Datapoint PV-s. Assigned to different VC control points.*)
		status : paiHmiTemplateStatus_typ;
		keys : paiHmiTemplateKeys_typ;
		timerSettings : paiHmiTemplateTimerSettings_typ;
		activeTabs : ARRAY[0..paiHMI_ENUM_TABS_MAXIDX]OF paiHmiTemplateItem_typ;
		activeTopMenuLF : paiHmiTemplateItem_typ;
		currentMenuLF : INT;
		currentTab : INT;
		prv : paiHmiTemplatePrivate_typ;
	END_STRUCT;
END_TYPE
