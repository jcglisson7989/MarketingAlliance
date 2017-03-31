

PROGRAM _INIT
	IF gRecCfg.active.Cfg.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX OR gRecCfg.save.Cfg.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX OR gRecCfg.defaultvals.Cfg.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX
		OR gRecCfg.active.Cfg.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX OR gRecCfg.save.Cfg.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX OR gRecCfg.defaultvals.Cfg.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX 
		OR gRecCfg.active.Rec.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX OR gRecCfg.save.Rec.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX OR gRecCfg.defaultvals.Rec.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX
		OR gRecCfg.active.Rec.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX OR gRecCfg.save.Rec.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX OR gRecCfg.defaultvals.Rec.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX
		THEN
		
		brsmemset(ADR(gRecCfg.defaultvals.Cfg), 0, SIZEOF(Global_Cfg_typ));
		brsmemset(ADR(gRecCfg.save.Cfg), 0, SIZEOF(Global_Cfg_typ));
		brsmemset(ADR(gRecCfg.active.Cfg), 0, SIZEOF(Global_Cfg_typ));
		
		brsmemset(ADR(gRecCfg.defaultvals.Rec), 0, SIZEOF(Global_Rec_typ));
		brsmemset(ADR(gRecCfg.save.Rec), 0, SIZEOF(Global_Rec_typ));
		brsmemset(ADR(gRecCfg.active.Rec), 0, SIZEOF(Global_Rec_typ));
		
		brsmemset(ADR(gStatistics), 0, SIZEOF(AS3500HS_Stats_typ));
		
		gRecCfg.active.Cfg.MagicPrefix := DEFINE_CONSTANT_MAGIC_PREFIX;
		gRecCfg.save.Cfg.MagicPrefix:= DEFINE_CONSTANT_MAGIC_PREFIX;
		gRecCfg.defaultvals.Cfg.MagicPrefix:= DEFINE_CONSTANT_MAGIC_PREFIX;
		
		gRecCfg.active.Cfg.MagicSuffix := DEFINE_CONSTANT_MAGIC_SUFFIX;
		gRecCfg.save.Cfg.MagicSuffix:= DEFINE_CONSTANT_MAGIC_SUFFIX;
		gRecCfg.defaultvals.Cfg.MagicSuffix:= DEFINE_CONSTANT_MAGIC_SUFFIX;
		
		gRecCfg.active.Rec.MagicPrefix := DEFINE_CONSTANT_MAGIC_PREFIX;
		gRecCfg.save.Rec.MagicPrefix:= DEFINE_CONSTANT_MAGIC_PREFIX;
		gRecCfg.defaultvals.Rec.MagicPrefix:= DEFINE_CONSTANT_MAGIC_PREFIX;
		
		gRecCfg.active.Rec.MagicSuffix := DEFINE_CONSTANT_MAGIC_SUFFIX;
		gRecCfg.save.Rec.MagicSuffix:= DEFINE_CONSTANT_MAGIC_SUFFIX;
		gRecCfg.defaultvals.Rec.MagicSuffix:= DEFINE_CONSTANT_MAGIC_SUFFIX;
		
		Set_Default_Config_Values(pCfg := ADR(gRecCfg.defaultvals.Cfg));
		Set_Default_Config_Values(pCfg := ADR(gRecCfg.save.Cfg));
		Set_Default_Config_Values(pCfg := ADR(gRecCfg.active.Cfg));

		gConfigName := 'No Config';
		
		Set_Default_Recipe_Values(pRec := ADR(gRecCfg.defaultvals.Rec));
		Set_Default_Recipe_Values(pRec := ADR(gRecCfg.save.Rec));
		Set_Default_Recipe_Values(pRec := ADR(gRecCfg.active.Rec));
		
		gRecipeName := 'No Recipe';
		
//		gAlarms.RecCfg.Default_Rec_Set := TRUE;
		
//		gAlarms.RecCfg.Default_Cfg_Set := TRUE;
		
//		SYSreset(1, 1);
	END_IF;

	gRecCfg.IO.Rec.I.FileName := 'rec1';
	gRecCfg.IO.Cfg.I.FileName := 'cfg1';
	
	Recipe_CSV_Control.MpLink := ADR(Recipe_CSV_MpLink);
	Recipe_CSV_Control.Enable := TRUE;
	Recipe_CSV_Control.DeviceName := ADR('Recipe');
	Recipe_CSV_Control.FileName := ADR(gRecCfg.IO.Rec.I.FileName);
	Recipe_CSV_Control.Category := ADR('Recipe');
	Recipe_CSV_Control.Header := ADR(Recipe_CSV_Header);
	
	Config_CSV_Control.MpLink := ADR(Config_CSV_MpLink);
	Config_CSV_Control.Enable := TRUE;
	Config_CSV_Control.DeviceName := ADR('Config');
	Config_CSV_Control.FileName := ADR(gRecCfg.IO.Cfg.I.FileName);
	Config_CSV_Control.Category := ADR('Config');
	Config_CSV_Control.Header := ADR(Config_CSV_Header);

	Recipe_CSV_RegPar.MpLink := ADR(Recipe_CSV_MpLink);
	Recipe_CSV_RegPar.Enable := TRUE;
	Recipe_CSV_RegPar.PVName := ADR('gRecCfg.save.Rec');
	Recipe_CSV_RegPar.Category := ADR('Recipe');

	Config_CSV_RegPar.MpLink := ADR(Config_CSV_MpLink);
	Config_CSV_RegPar.Enable := TRUE;
	Config_CSV_RegPar.PVName := ADR('gRecCfg.save.Cfg');
	Config_CSV_RegPar.Category := ADR('Config');
	
	Recipe_CSV_UI.MpLink := ADR(Recipe_CSV_MpLink);
	Recipe_CSV_UI.Enable := TRUE;
	Recipe_CSV_UI.UIConnect := ADR(gRecipe_CSV_UIConnect);
	
	Config_CSV_UI.MpLink := ADR(Config_CSV_MpLink);
	Config_CSV_UI.Enable := TRUE;
	Config_CSV_UI.UIConnect := ADR(gConfig_CSV_UIConnect);
	
	Recipe_CSV_UI.UISetup.RecipeListSize := 20;
	Recipe_CSV_UI.UISetup.RecipeListScrollWindow := 1;
	Recipe_CSV_UI.UISetup.Confirmation.RecipeCreate := TRUE;
	Recipe_CSV_UI.UISetup.Confirmation.RecipeLoad := TRUE;
	Recipe_CSV_UI.UISetup.Confirmation.RecipeSave := TRUE;
	Recipe_CSV_UI.UISetup.Confirmation.RecipeDelete := TRUE;
	
	Config_CSV_UI.UISetup.RecipeListSize := 20;
	Config_CSV_UI.UISetup.RecipeListScrollWindow := 1;
	Config_CSV_UI.UISetup.Confirmation.RecipeCreate := TRUE;
	Config_CSV_UI.UISetup.Confirmation.RecipeLoad := TRUE;
	Config_CSV_UI.UISetup.Confirmation.RecipeSave := TRUE;
	Config_CSV_UI.UISetup.Confirmation.RecipeDelete := TRUE;
	
	pRecCfgUIConnect ACCESS ADR(gRecipe_CSV_UIConnect);
	pCmd ACCESS ADR(loc.Rec.HMI);
	
	gRecipe_CSV_UIConnect.New.FileName := 'Rec_Name';
	gConfig_CSV_UIConnect.New.FileName := 'Cfg_Name';
	
	Recipe_CSV_Control;
	Recipe_CSV_RegPar;
	Recipe_CSV_UI;
	
	Config_CSV_Control;
	Config_CSV_RegPar;
	Config_CSV_UI;
	
	Alarm_Recipe_UI.MpLink := ADR(Recipe_CSV_MpLink);
	Alarm_Recipe_UI.Enable := TRUE;
	Alarm_Recipe_UI.Mode := mpALARM_BASIC_UI_MODE_ALL;
	
	Alarm_Recipe_UI.UISetup.ImageSize := 20;
	Alarm_Recipe_UI.UISetup.AlarmImage := ADR(Alarm_Recipe.AlarmImage[0]);
	Alarm_Recipe_UI.UISetup.AcknowledgeImage := ADR(Alarm_Recipe.AcknowledgeImage[0]);
	Alarm_Recipe_UI.UISetup.AddInfoStringSize := 100;
	Alarm_Recipe_UI.UISetup.AddInfo := ADR(Alarm_Recipe.AddInfo[0]);
	
	Alarm_Recipe;
	Alarm_Recipe_UI();
	
	Alarm_Config_UI.MpLink := ADR(Config_CSV_MpLink);
	Alarm_Config_UI.Enable := TRUE;
	Alarm_Config_UI.Mode := mpALARM_BASIC_UI_MODE_ALL;
	
	Alarm_Config_UI.UISetup.ImageSize := 20;
	Alarm_Config_UI.UISetup.AlarmImage := ADR(Alarm_Config.AlarmImage[0]);
	Alarm_Config_UI.UISetup.AcknowledgeImage := ADR(Alarm_Config.AcknowledgeImage[0]);
	Alarm_Config_UI.UISetup.AddInfoStringSize := 100;
	Alarm_Config_UI.UISetup.AddInfo := ADR(Alarm_Config.AddInfo[0]);
	
	Alarm_Config;
	Alarm_Config_UI();
END_PROGRAM