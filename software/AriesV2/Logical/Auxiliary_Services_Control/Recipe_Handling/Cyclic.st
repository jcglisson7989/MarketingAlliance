
PROGRAM _CYCLIC

	gRecCfg;
	
	CASE gHmi.prv.currentPage OF
		HMI_RECIPE_20_SELECT:
			pRecCfgUIConnect ACCESS ADR(gRecipe_CSV_UIConnect);
			pCmd ACCESS ADR(loc.Rec.HMI);
		HMI_RECIPE_21_PVLIST:
			pRecCfgUIConnect ACCESS ADR(gRecipe_CSV_UIConnect);
			pCmd ACCESS ADR(loc.Rec.HMI);
		HMI_CONFIG_30_SELECT:
			pRecCfgUIConnect ACCESS ADR(gConfig_CSV_UIConnect);
			pCmd ACCESS ADR(loc.Cfg.HMI);
		HMI_CONFIG_31_PVLIST:
			pRecCfgUIConnect ACCESS ADR(gConfig_CSV_UIConnect);
			pCmd ACCESS ADR(loc.Cfg.HMI);
		HMI_LOGIN_43_ENGINEER:
			pRecCfgUIConnect ACCESS ADR(gConfig_CSV_UIConnect);
			pCmd ACCESS ADR(loc.Cfg.HMI);
	END_CASE;
	
	
	IF EDGENEG(gHmi.prv.currentPage = HMI_RECIPE_20_SELECT) THEN
		locFindActiveRecipe := 1;
	END_IF;
	
	IF EDGENEG(gHmi.prv.currentPage = HMI_CONFIG_30_SELECT) THEN
		locFindActiveRecipe := 1;
	END_IF;

	IF loc.Rec.cmd.Copy_default_to_save = 1 THEN
		gRecCfg.save.Rec := gRecCfg.defaultvals.Rec;
	END_IF;
	
	IF loc.Rec.cmd.Copy_default_to_active = 1 THEN
		gRecCfg.active.Rec := gRecCfg.defaultvals.Rec;
	END_IF;
	
	IF loc.Rec.cmd.Copy_save_to_active = 1 THEN
		gRecCfg.active.Rec := gRecCfg.save.Rec;
	END_IF;
	
	IF loc.Rec.cmd.Copy_save_to_default = 1 THEN
		gRecCfg.defaultvals.Rec := gRecCfg.save.Rec;
	END_IF;
	
	IF loc.Rec.cmd.Copy_active_to_save = 1 THEN
		gRecCfg.save.Rec := gRecCfg.active.Rec;
	END_IF;
	
	IF loc.Rec.cmd.Copy_active_to_default = 1 THEN
		gRecCfg.defaultvals.Rec := gRecCfg.active.Rec;
	END_IF;
	
	IF loc.Rec.cmd.Copy_internal_to_default = 1 THEN
//		Set_Default_Rec;
	END_IF;
	
	loc.Cfg.status.save_differs_from_active := BOOL_TO_USINT(brsmemcmp(ADR(gRecCfg.save.Cfg),ADR(gRecCfg.active.Cfg), SIZEOF(Global_Cfg_typ)) <> 0);
	loc.Cfg.status.default_differs_from_save := BOOL_TO_USINT(brsmemcmp(ADR(gRecCfg.defaultvals.Cfg),ADR(gRecCfg.save.Cfg), SIZEOF(Global_Cfg_typ)) <> 0);
	loc.Cfg.status.active_differs_from_default := BOOL_TO_USINT(brsmemcmp(ADR(gRecCfg.active.Cfg),ADR(gRecCfg.defaultvals.Cfg), SIZEOF(Global_Cfg_typ)) <> 0);
	
//	loc.Cfg.status.Invalid := NOT Fcn_Config_Valid(pCfg := ADR(gRecCfg.active.Cfg), pAlarms := ADR(gAlarms));
	
	loc.Rec.status.save_differs_from_active := BOOL_TO_USINT(brsmemcmp(ADR(gRecCfg.save.Rec),ADR(gRecCfg.active.Rec), SIZEOF(Global_Rec_typ)) <> 0);
	loc.Rec.status.default_differs_from_save := BOOL_TO_USINT(brsmemcmp(ADR(gRecCfg.defaultvals.Rec),ADR(gRecCfg.save.Rec), SIZEOF(Global_Rec_typ)) <> 0);
	loc.Rec.status.active_differs_from_default := BOOL_TO_USINT(brsmemcmp(ADR(gRecCfg.active.Rec),ADR(gRecCfg.defaultvals.Rec), SIZEOF(Global_Rec_typ)) <> 0);
	
//	loc.Rec.status.Invalid := NOT Fcn_Recipe_Valid(pRec := ADR(gRecCfg.active.Rec), pAlarms := ADR(gAlarms));
	
	locCurrentlySelectedRecIsActive := (brsstrcmp(ADR(gRecipe_CSV_UIConnect.Recipe.List.Names[gRecipe_CSV_UIConnect.Recipe.List.SelectedIndex]), ADR(gRecipeName)) = 0);
	locCurrentlySelectedCfgIsActive := (brsstrcmp(ADR(gConfig_CSV_UIConnect.Recipe.List.Names[gConfig_CSV_UIConnect.Recipe.List.SelectedIndex]), ADR(gConfigName)) = 0);

	CASE pRecCfgUIConnect.MessageBox.Type OF
		mpRECIPE_UI_MSG_CONFIRM_LOAD:
			
		mpRECIPE_UI_MSG_CONFIRM_SAVE:
			
			IF EDGEPOS(pRecCfgUIConnect.MessageBox.Confirm) THEN
				CASE gHmi.prv.currentPage OF
					HMI_RECIPE_20_SELECT:
						gRecCfg.save.Rec := gRecCfg.active.Rec;
					HMI_CONFIG_30_SELECT:
						gRecCfg.save.Cfg := gRecCfg.active.Cfg;
				END_CASE;
			END_IF;
		mpRECIPE_UI_MSG_CONFIRM_CREATE:
			
		mpRECIPE_UI_MSG_CONFIRM_DELETE:
			CASE gHmi.prv.currentPage OF
				HMI_RECIPE_20_SELECT:
					IF EDGEPOS(gRecipe_CSV_UIConnect.MessageBox.Confirm) THEN
						IF (brsstrcmp(ADR(gRecipe_CSV_UIConnect.Recipe.List.Names[gRecipe_CSV_UIConnect.Recipe.List.SelectedIndex]), ADR(gRecipeName)) = 0) THEN
							gRecipe_CSV_UIConnect.MessageBox.Confirm := FALSE; //can't delete active recipe
							gRecipe_CSV_UIConnect.MessageBox.Cancel := TRUE;
						END_IF;
					END_IF;
				HMI_CONFIG_30_SELECT:
					IF EDGEPOS(gConfig_CSV_UIConnect.MessageBox.Confirm) THEN
						IF (brsstrcmp(ADR(gConfig_CSV_UIConnect.Recipe.List.Names[gConfig_CSV_UIConnect.Recipe.List.SelectedIndex]), ADR(gConfigName)) = 0) THEN
							gConfig_CSV_UIConnect.MessageBox.Confirm := FALSE; //can't delete active recipe
							gConfig_CSV_UIConnect.MessageBox.Cancel := TRUE;
						END_IF;
					END_IF;
			END_CASE;
	END_CASE;
	//
	IF loc.Rec.HMI.Refresh.DP = 1 THEN
		gRecipe_CSV_UIConnect.Recipe.Refresh := 1;
	END_IF;
	
	IF loc.Cfg.HMI.Refresh.DP = 1 THEN
		gConfig_CSV_UIConnect.Recipe.Refresh := 1;
	END_IF;

	loc.Rec.HMI.Refresh.DP := 0;
	loc.Rec.HMI.Refresh.Status := DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Rec.HMI.Refresh.Lock := 0;
	
	loc.Cfg.HMI.Refresh.DP := 0;
	//
	IF loc.Rec.HMI.Save.DP = 1 THEN
		
		//Make sure listbox selected recipe name is the active one when you are trying to save from a page other than the Rec/Cfg control page (Saving on PVListView page)
		Action_Set_Active_Rec;
		
		gRecipe_CSV_UIConnect.Recipe.Save := 1;
	END_IF;
	
	IF loc.Cfg.HMI.Save.DP = 1 THEN
		gConfig_CSV_UIConnect.Recipe.Save := 1;
	END_IF;
	//
	loc.Rec.HMI.Save.DP := 0;
	loc.Rec.HMI.Save.Status := NOT (loc.Rec.status.save_differs_from_active = 1) OR ((NOT (locCurrentlySelectedRecIsActive = 1)) AND gHmi.prv.currentPage = HMI_RECIPE_21_PVLIST) OR DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Rec.HMI.Save.Lock := 0;
	
	loc.Cfg.HMI.Save.DP := 0;
	
	//
	IF loc.Rec.HMI.Load.DP = 1 THEN
		gRecipe_CSV_UIConnect.Recipe.Load := 1;
	END_IF;
	
	IF loc.Cfg.HMI.Load.DP = 1 THEN
		gConfig_CSV_UIConnect.Recipe.Load := 1;
	END_IF;
	//
	loc.Rec.HMI.Load.DP := 0;
	loc.Rec.HMI.Load.Status :=  DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Rec.HMI.Load.Lock := 0;
	
	loc.Cfg.HMI.Load.DP := 0;
	//
	IF loc.Rec.HMI.Delete.DP = 1 THEN
		gRecipe_CSV_UIConnect.Recipe.Delete := 1;
	END_IF;
	
	IF loc.Cfg.HMI.Delete.DP = 1 THEN
		gConfig_CSV_UIConnect.Recipe.Delete := 1;
	END_IF;
	//
	loc.Rec.HMI.Delete.DP := 0;
	loc.Rec.HMI.Delete.Status := locCurrentlySelectedRecIsActive OR DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Rec.HMI.Delete.Lock := 0;
	
	loc.Cfg.HMI.Delete.DP := 0;
	//
	IF loc.Rec.HMI.Overwrite.DP = 1 THEN
		gRecCfg.IO.Rec.I.FileName := gRecipe_CSV_UIConnect.Recipe.List.Names[gRecipe_CSV_UIConnect.Recipe.List.SelectedIndex];
		Recipe_CSV_Control.Save := TRUE;
	END_IF;

	IF loc.Cfg.HMI.Overwrite.DP = 1 THEN
		gRecCfg.IO.Cfg.I.FileName := gConfig_CSV_UIConnect.Recipe.List.Names[gConfig_CSV_UIConnect.Recipe.List.SelectedIndex];
		Config_CSV_Control.Save := TRUE;
	END_IF;
	//
	loc.Rec.HMI.Overwrite.DP := 0;
	//	loc.Rec.HMI.Overwrite.Status := locCurrentlySelectedRecIsActive OR DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Rec.HMI.Overwrite.Status := 1;
	loc.Rec.HMI.Overwrite.Lock := 0;
	
	IF loc.Rec.HMI.Copy.DP = 1 THEN
		locDTGetTime.enable := 1;
		locDTGetTime();
		locTimeString := '';
		ascDT(locDTGetTime.DT1, ADR(locTimeString), 255);
		gRecCfg.IO.Rec.I.FileName := '';
		gRecCfg.IO.Rec.I.FileName := gRecipeName;
		brsmemset(ADR(gRecCfg.IO.Rec.I.FileName) + brsstrlen(ADR(gRecCfg.IO.Rec.I.FileName)) - 4, 0,1);
		brsstrcat(ADR(gRecCfg.IO.Rec.I.FileName), ADR('_cpy_'));
		brsstrcat(ADR(gRecCfg.IO.Rec.I.FileName), ADR(locTimeString));
		brsstrcat(ADR(gRecCfg.IO.Rec.I.FileName), ADR('.csv'));
		FOR ii_char := 0 TO brsstrlen(ADR(gRecCfg.IO.Rec.I.FileName)) BY 1 DO
			IF brsmemcmp(ADR(gRecCfg.IO.Rec.I.FileName) + ii_char, ADR(':'), 1) = 0 OR brsmemcmp(ADR(gRecCfg.IO.Rec.I.FileName) + ii_char, ADR(' '), 1) = 0 THEN
				brsmemset(ADR(gRecCfg.IO.Rec.I.FileName) + ii_char, 95, 1);
			END_IF;
		END_FOR;
		Recipe_CSV_Control.Save := 1;
	END_IF;

	loc.Rec.HMI.Copy.DP := 0;
	loc.Rec.HMI.Copy.Status := NOT (locCurrentlySelectedRecIsActive = 1) OR DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Rec.HMI.Copy.Lock := 0;
	
	loc.Cfg.HMI.Refresh.Status := DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Cfg.HMI.Save.Status := DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Cfg.HMI.Load.Status := DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Cfg.HMI.Delete.Status := DINT_TO_BOOL(gHmiParamTable.selValueFormVisible = 1);
	loc.Cfg.HMI.Overwrite.Status := 1;
	loc.Cfg.HMI.Copy.Status := 1;
	
	locRefreshBeforeCall := gRecipe_CSV_UIConnect.Recipe.Refresh;

	Recipe_CSV_Control;
	Recipe_CSV_RegPar;
	Recipe_CSV_UI;
	pRecCfgUIConnect;
	gRecipe_CSV_UIConnect;
	
	Config_CSV_Control;
	Config_CSV_RegPar;
	Config_CSV_UI;
	gConfig_CSV_UIConnect;
	
	IF (NOT gRecipe_CSV_UIConnect.Recipe.Refresh AND locRefreshBeforeCall) OR locFindActiveRecipe = 1 THEN
		bgTimerStart(loc_Timer_Find_Active, Tms(2));
		locFindActiveRecipe := 0;
	END_IF;
	
//	IF EDGEPOS(bgTimerIsTimeOut(loc_Timer_Find_Active)) THEN
//		FOR ii_recipes := 0 TO 19 BY 1 DO
//			IF (brsstrcmp(ADR(gRecipe_CSV_UIConnect.Recipe.List.Names[ii_recipes]), ADR(gRecipeName)) = 0) THEN
//				gRecipe_CSV_UIConnect.Recipe.List.SelectedIndex := ii_recipes;
//			END_IF;			
//		END_FOR;
	//	END_IF;
	
	IF EDGEPOS(bgTimerIsTimeOut(loc_Timer_Find_Active)) THEN
		Action_Set_Active_Rec;
	END_IF;
	//
	IF Recipe_CSV_Control.CommandDone AND (Recipe_CSV_Control.Save OR Recipe_CSV_Control.Load) THEN
		Recipe_CSV_Control.Save := FALSE;
		Recipe_CSV_Control.Load := FALSE;
		gRecipe_CSV_UIConnect.Recipe.Refresh := 1;
	END_IF;
	
	IF EDGENEG(gRecipe_CSV_UIConnect.Status = mpRECIPE_UI_STATUS_SAVE) THEN
//		gRecipeName := Recipe_CSV_Control.Info.LastLoadedRecipe;
		gRecCfg.save.Rec := gRecCfg.active.Rec;
	END_IF;
	
	IF EDGENEG(gRecipe_CSV_UIConnect.Status = mpRECIPE_UI_STATUS_LOAD) THEN
		gRecipeName := Recipe_CSV_Control.Info.LastLoadedRecipe;
		gRecCfg.active.Rec := gRecCfg.save.Rec;
	END_IF;
	
	loc.Rec.cmd.Copy_default_to_save := FALSE;
	loc.Rec.cmd.Copy_default_to_active := FALSE;
	loc.Rec.cmd.Copy_save_to_active := FALSE;
	loc.Rec.cmd.Copy_save_to_default := FALSE;
	loc.Rec.cmd.Copy_active_to_save := FALSE;
	loc.Rec.cmd.Copy_active_to_default := FALSE;
	loc.Rec.cmd.Copy_internal_to_default := FALSE;
	
	bgTimerCyclic(loc_Timer_Find_Active);
	//
	
	IF Config_CSV_Control.CommandDone AND (Config_CSV_Control.Save OR Config_CSV_Control.Load) THEN
		Config_CSV_Control.Save := FALSE;
		Config_CSV_Control.Load := FALSE;
		gConfig_CSV_UIConnect.Recipe.Refresh := 1;
	END_IF;
	
	IF EDGENEG(gConfig_CSV_UIConnect.Status = mpRECIPE_UI_STATUS_SAVE) THEN
//		gConfigName := Config_CSV_Control.Info.LastLoadedRecipe;
		gRecCfg.save.Cfg := gRecCfg.active.Cfg;
	END_IF;
	
	IF EDGENEG(gConfig_CSV_UIConnect.Status = mpRECIPE_UI_STATUS_LOAD) THEN
		gConfigName := Config_CSV_Control.Info.LastLoadedRecipe;
		gRecCfg.active.Cfg := gRecCfg.save.Cfg;
	END_IF;
	
	loc.Cfg.cmd.Copy_default_to_save := FALSE;
	loc.Cfg.cmd.Copy_default_to_active := FALSE;
	loc.Cfg.cmd.Copy_save_to_active := FALSE;
	loc.Cfg.cmd.Copy_save_to_default := FALSE;
	loc.Cfg.cmd.Copy_active_to_save := FALSE;
	loc.Cfg.cmd.Copy_active_to_default := FALSE;
	loc.Cfg.cmd.Copy_internal_to_default := FALSE;
	//
END_PROGRAM




