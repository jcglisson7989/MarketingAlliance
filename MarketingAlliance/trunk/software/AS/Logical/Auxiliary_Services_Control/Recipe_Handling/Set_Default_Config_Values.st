FUNCTION Set_Default_Config_Values
	
	pCfg.HMI.passwordSetup := '1111';
	pCfg.HMI.passwordEngineer := '2222';
	pCfg.HMI.passwordFactory := '3333';

	pCfg.Control.N_Encoder_Bits_SingleTurn := 12;
	pCfg.Control.Encoder_Position_Home := 0;
	
	
	pCfg.Control.Debounce_PiP.Timer_On := 0.02;
	pCfg.Control.Debounce_PiP.Timer_Off := 0.02;
	
	pCfg.Control.Threshold_AccelDecel_Trans_RPM := 0.05;
	pCfg.Control.T_Exit_Decel_Automatically := 9999;
	pCfg.Control.Target_Present_Pulse_Time_S := 0.05;
	
	pCfg.Control.Sim_Encoder := 0;
	pCfg.Control.Sim_Encoder_Cycles := 1;
	pCfg.Control.Sim_Encoder_Counts := 2;
	
	pCfg.Dispense[0].Disable := FALSE;
	pCfg.Dispense[1].Disable := FALSE;
	
	Set_Default_Config_Values := 0;
END_FUNCTION