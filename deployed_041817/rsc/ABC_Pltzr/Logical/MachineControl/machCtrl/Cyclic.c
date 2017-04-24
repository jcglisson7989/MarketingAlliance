
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../../paiComponents/paiHmi/paiHmiMsgScrolling.h"


#if 1
#include <../../paiComponents/bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 30	//max number of log entries
#define LOG_ENTRY_LENGTH  200//max length of individual log message. Longer msg are truncated
_LOCAL STRING log[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
//static bgPVLogger_typ lgr;	//PV logger object
#else
#define DBG(format, args...) ;
#define DBGINIT(args...) ;
#endif

/*
###############################################################################
Alarms & Messages
###############################################################################
*/
static void machCtrlAlarms()
{
	int ii;
	//auxiliary service - scan all alarms
	gAlarms.oIsAlarmActive = 0;
	gAlarms.oIsAlarmActiveCount = 0;	
	gAlarms.oIsAlarmNotAckCount = 0;	
	for(ii=0; ii<=APP_ALARM_LASTTOCHECK; ii++){
		if(gAlarms.alarmActive[ii]){
			gAlarms.oIsAlarmActiveCount++;
			gAlarms.oIsAlarmActive = 1;
		}
	}
	gAlarms.oIsAlarmNotAck = 0;
	for(ii=0; ii<=APP_ALARM_LASTTOCHECK; ii++){
		if(gAlarms.alarmAck[ii]){
			gAlarms.oIsAlarmNotAckCount++;
			gAlarms.oIsAlarmNotAck = 1;
		}		
	}
	
	
	for(ii=0; ii<=APP_ALARM_LASTTOCHECK; ii++){
		if((gAlarms.alarmActive[ii] || gAlarms.alarmAck[ii]) && (ii != APP_ALARM_AIRPRESSURE) ){
			gAlarmsFiltered.alarmActive[ii] = 1;
		}else{
			gAlarmsFiltered.alarmActive[ii] = 0;		
		}		
	}
	
	if((gAlarms.oIsAlarmNotAckCount <= 1) && (gAlarms.alarmActive[APP_ALARM_AIRPRESSURE])){
		gAlarmsFiltered.alarmActive[APP_ALARM_AIRPRESSURE] = 1;
	}
	
	
	//messages (yellow information box) are enabled only if alarms are not active
	//gMsgScroll.iEnable = gAlarms.oIsAlarmActive ? 0 : 1;
	gMsgScroll.iEnable = 1;
	paiHmiMsgScrollingCyclic(&gMsgScroll);
	
	
	//keep looking for a missing module alarm
	gAlarms.alarmActive[APP_ALARM_HWMODULE] = 0;
	for(ii=1; ii<APP_HWMODULE_IDXLAST; ii++){
		if( !gHWModules[ii].ModuleOk ){
			gAlarms.alarmActive[APP_ALARM_HWMODULE] = 1;
		}	
	}

}
/*
###############################################################################
Init, Cyclic, Exit
###############################################################################
*/
void _INIT machCtrlInit(void)
{
	/* TODO: Add code here */
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);

	gMachineIO.din.AuxVFDsOk = 0;
	gHWModules[0].ModuleOk = 0;
	gMachineVFD[0].appID = 0;
	gMachineVFD[6].appID = 6;//USED DON'T CHANGED IT!!!
	
	brsstrcpy((UDINT)gProjectInfo.ProjectComments, (UDINT)"gb comment");
	
	
	//Message scrolling support - init
	gMsgScroll.iEnable = 1;
	paiHmiMsgScrollingInit(&gMsgScroll, (UDINT)&gMessages.msgActive[0], APP_MSG_LAST + 1, 2000);
	
	
}

void _CYCLIC machCtrlCyclic(void)
{
	machCtrlAlarms();
}
