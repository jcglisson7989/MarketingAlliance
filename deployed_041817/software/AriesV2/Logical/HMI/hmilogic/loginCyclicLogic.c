#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

void loginLevelParameterEditControl(UDINT minLevel)
{
	//input form (i.e. common page) not visible for operator 
	//(i.e. loginlevel==0 > visibility set to 1 (not visible))
	/*gHmiParamTable.selValueFormVisible = (gHmi.prv.loginLevel >= minLevel) ? 0 : 1;*/
	gHmiParamTable.selValueFormVisible = 0;
}



//login level related logic
void	loginLevelLogicCyclic()
{
	static UINT loginLevelOld;
	
	//update visiblity flags that are associated with the current login level
	//note that current app support three login levels: 0-operator;1-supervisor;2-admin
//	if(gHmi.prv.loginLevel == 1){
//		gHmi.status.loginVisibleGE1 = 0;//visible
//		gHmi.status.loginVisibleGE2 = 1;//not visible
//		gHmi.status.loginVisibleGE3 = 1;//not visible
//	}else
//		if(gHmi.prv.loginLevel == 2){
//		gHmi.status.loginVisibleGE1 = 0;//visible
//		gHmi.status.loginVisibleGE2 = 0;//visible
//		gHmi.status.loginVisibleGE3 = 1;//not visible
//	}else
//		if(gHmi.prv.loginLevel == 3){
//		gHmi.status.loginVisibleGE1 = 0;//visible
//		gHmi.status.loginVisibleGE2 = 0;//visible
//		gHmi.status.loginVisibleGE3 = 0;//visible
//	}else{
//		gHmi.status.loginVisibleGE1 = 1;//not visible
//		gHmi.status.loginVisibleGE2 = 1;//not visible
//		gHmi.status.loginVisibleGE3 = 1;//not visible		
//	}		
	
	gHmi.status.loginVisibleGE1 = 0;//visible
	gHmi.status.loginVisibleGE2 = 0;//visible
	gHmi.status.loginVisibleGE3 = 0;//visible
	

	//operate login timeout timer
	//Timer for timed out operation of the access control

	bgTimerCyclic(&gHmi.prv.tmr3) ;
	
	//detect login level changes
	if(gHmi.prv.loginLevel != loginLevelOld){
		loginLevelOld = gHmi.prv.loginLevel;
		if(gHmi.prv.loginLevel){
			//when supervisor or admin logs in > start login timeout timer
			bgTimerStart(&gHmi.prv.tmr3, Tms(DEFINE_LOGIN_TO)); //login duration timer setting comes from current config [sec], convert to [ms]
		}else{
			//when loginLevel gets reset to 0, make sure to make the parametar input field invisible
			loginLevelParameterEditControl(1);
		}
	}

	//restart login timer if user touches the area of the ticking logout timer
	if(gHmi.keys.btnRestartLoginTimer){
		gHmi.keys.btnRestartLoginTimer = 0;
		bgTimerStart(&gHmi.prv.tmr3, Tms(DEFINE_LOGIN_TO));
	}
	
	//change page to login is user touches the area of the login icon
	if(gHmi.keys.btnLoginIcon){
		gHmi.keys.btnLoginIcon = 0;
		if(!gHmi.prv.loginLevel){
			gHmi.prv.changePage = HMI_LOGIN_40_MAIN;
		}
	}
		
	//timer based logout > if loginLeve higher then 0, reset it after timer expires
	if(gHmi.prv.loginLevel && bgTimerIsTimeOut(&gHmi.prv.tmr3)){
		gHmi.prv.loginLevel = 0;
	}
		
	//calculate remaining login time [min:sec] from remaining timer time [ms]
	gHmi.prv.tmr3RemainingTimeSec = (bgTimerTimeRemaining(&gHmi.prv.tmr3)/1000) % 60;
	gHmi.prv.tmr3RemainingTimeMin = (bgTimerTimeRemaining(&gHmi.prv.tmr3)/1000) / 60;
	
}
