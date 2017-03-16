
ACTION Action_Reset_FBK: 
	gSafety.prv.FBK.RemoteControl.Execute := FALSE;
	gSafety.prv.FBK.DownloadApplication.Execute := FALSE;
	gSafety.prv.FBK.UDID_High.enable := FALSE;
	gSafety.prv.FBK.UDID_Low.enable := FALSE;
END_ACTION
