
ACTION Action_Manage_Update_Total_Runtime: 
	
	IF bgTimerIsTimeOut(Timer_Total_Runtime) THEN
		gStatistics.total_runtime := gStatistics.total_runtime + 1;
		bgTimerStart(Timer_Total_Runtime, 1000);
		
		gStatistics.runtime_h := gStatistics.total_runtime / 3600;
		gStatistics.runtime_m := (gStatistics.total_runtime/60) MOD 60;
		gStatistics.runtime_s := gStatistics.total_runtime MOD 60;
	END_IF;
	
	bgTimerCyclic(Timer_Total_Runtime);

END_ACTION
