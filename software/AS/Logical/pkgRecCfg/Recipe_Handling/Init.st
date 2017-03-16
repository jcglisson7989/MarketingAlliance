

PROGRAM _INIT
	IF gRecCfg.active.Cfg.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX OR gRecCfg.save.Cfg.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX 
		OR gRecCfg.active.Cfg.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX OR gRecCfg.save.Cfg.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX THEN
		
		brsmemset(ADR(gRecCfg.save.Cfg), 0, SIZEOF(Global_Cfg_typ));
		brsmemset(ADR(gRecCfg.active.Cfg), 0, SIZEOF(Global_Cfg_typ));
		
		gRecCfg.active.Cfg.MagicPrefix := DEFINE_CONSTANT_MAGIC_PREFIX;
		gRecCfg.save.Cfg.MagicPrefix:= DEFINE_CONSTANT_MAGIC_PREFIX;
		
		gRecCfg.active.Cfg.MagicSuffix := DEFINE_CONSTANT_MAGIC_SUFFIX;
		gRecCfg.save.Cfg.MagicSuffix:= DEFINE_CONSTANT_MAGIC_SUFFIX;
		//		
//		brsmemset(ADR(gLinePermData), 0, SIZEOF(Line_Permanent_Variables_typ));
//		brsmemset(ADR(gStatistics), 0, SIZEOF(Global_Statistics_typ));
//		brsmemset(ADR(Axis_Line_Par), 0, SIZEOF(MpAxisBasicParType));
//		brsmemset(ADR(Axis_Blank_Par), 0, SIZEOF(MpAxisBasicParType));
//		brsmemset(ADR(Axis_Coupling_Master_Line_Par), 0, SIZEOF(MpAxisCouplingParType));
//		
//		Set_Default_Config_Values(pCfg := ADR(gRecCfg.defaultvals.Cfg), MachineType := gMachineType);
//		Set_Default_Config_Values(pCfg := ADR(gRecCfg.save.Cfg), MachineType := gMachineType);
//		Set_Default_Config_Values(pCfg := ADR(gRecCfg.active.Cfg), MachineType := gMachineType);
//
//		gRecipeName := 'No Config';
//		
//		gAlarms.RecCfg.Default_Cfg_Set := TRUE;
		
//		SYSreset(1, 1);
	END_IF;
	
	IF gRecCfg.active.Rec.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX OR gRecCfg.save.Rec.MagicPrefix <> DEFINE_CONSTANT_MAGIC_PREFIX 
		OR gRecCfg.active.Rec.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX OR gRecCfg.save.Rec.MagicSuffix <> DEFINE_CONSTANT_MAGIC_SUFFIX THEN
		
		brsmemset(ADR(gRecCfg.save.Rec), 0, SIZEOF(Global_Rec_typ));
		brsmemset(ADR(gRecCfg.active.Rec), 0, SIZEOF(Global_Rec_typ));
		
		gRecCfg.active.Rec.MagicPrefix := DEFINE_CONSTANT_MAGIC_PREFIX;
		gRecCfg.save.Rec.MagicPrefix:= DEFINE_CONSTANT_MAGIC_PREFIX;
		
		gRecCfg.active.Rec.MagicSuffix := DEFINE_CONSTANT_MAGIC_SUFFIX;
		gRecCfg.save.Rec.MagicSuffix:= DEFINE_CONSTANT_MAGIC_SUFFIX;
		//		
//		brsmemset(ADR(gLinePermData), 0, SIZEOF(Line_Permanent_Variables_typ));
//		brsmemset(ADR(gStatistics), 0, SIZEOF(Global_Statistics_typ));
//		brsmemset(ADR(Axis_Line_Par), 0, SIZEOF(MpAxisBasicParType));
//		brsmemset(ADR(Axis_Blank_Par), 0, SIZEOF(MpAxisBasicParType));
//		brsmemset(ADR(Axis_Coupling_Master_Line_Par), 0, SIZEOF(MpAxisCouplingParType));
//		
//		Set_Default_Recipe_Values(pRec := ADR(gRecCfg.defaultvals.Rec), MachineType := gMachineType);
//		Set_Default_Recipe_Values(pRec := ADR(gRecCfg.save.Rec), MachineType := gMachineType);
//		Set_Default_Recipe_Values(pRec := ADR(gRecCfg.active.Rec), MachineType := gMachineType);
//		
//		gRecipeName := 'No Recipe';
//		
//		gAlarms.RecCfg.Default_Rec_Set := TRUE;
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
	
END_PROGRAM