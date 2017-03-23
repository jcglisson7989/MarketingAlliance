(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI object - Dropdown Menu located at the Upper Right side of the screen*)
(*########################################################################*)

TYPE
	paiHmiDropdownMenuRTEnums_typ : 
		(
		paiHMI_ENUM_MENU_ITEMS_RT := 10 (*Main menu - right side - number of buttons*)
		);
	paiHmiDropdwMenuRT_typ : 	STRUCT 
		iMenuIndexRT : INT;
		iMenuRTTimeout : REAL; (*Duration after which a dropdown menu is automaticaly hiden if not clicked *)
		oMenuIndexRT : INT; (*Main menu currently selected menu item - RT*)
		oMenuVisible : INT;
		oMenuVisibleItems : ARRAY[0..paiHMI_ENUM_MENU_ITEMS_RT]OF INT; (*1-items is not visible*)
		oMenuDisabledItems : ARRAY[0..paiHMI_ENUM_MENU_ITEMS_RT]OF BOOL; (*1-Item is disabled*)
		iMenuSelectItem : ARRAY[0..paiHMI_ENUM_MENU_ITEMS_RT]OF BOOL; (*an input array to select items from the code; first found 1 will be selected;*)
		oMenuSelectedItems : ARRAY[0..paiHMI_ENUM_MENU_ITEMS_RT]OF BOOL; (*1-Item is currently selected (indexRT)*)
		oMenuPressedItems : ARRAY[0..paiHMI_ENUM_MENU_ITEMS_RT]OF BOOL; (*1-an item that was pressed, single shot*)
		mMenuVisibleOld : INT;
		menuRTHideTimer : TON;
	END_STRUCT;
END_TYPE
