FUNCTION Set_Default_Config_Values
	
	pCfg.HMI.passwordSetup := '1111';
	pCfg.HMI.passwordEngineer := '2222';
	pCfg.HMI.passwordFactory := '3333';
	
	pCfg.Creaser.FeedAxisAccel := 10;
	pCfg.Creaser.FeedAxisDecel := 10;

	
	Set_Default_Config_Values := 0;
END_FUNCTION