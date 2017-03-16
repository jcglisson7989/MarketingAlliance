
TYPE
	ClientInfo : 	STRUCT 
		IpAddress : WSTRING[64];
		UserId : WSTRING[64];
		ActivityCount : UDINT;
		LanguageId : STRING[2];
		MeasurementSystemId : WSTRING[32];
		ConnectionDateTime : DATE_AND_TIME;
		ScreenResolution : WSTRING[16];
		BrowserResolution : WSTRING[16];
		UserAgent : WSTRING[256];
		CookieEnabled : BOOL;
		SlotId : USINT;
		IsValid : BOOL;
	END_STRUCT;
END_TYPE
