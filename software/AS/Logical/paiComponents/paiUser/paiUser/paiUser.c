
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif


/*
###############################################################################
PAI_CONFIGURATION_SECTION
Code below allows configuration for:
User access
###############################################################################
*/
#warning "pai Configuration: User Access"


//=============================================================================
//User Login support
//=============================================================================
static void paiUserInitGroups()
{
	int ii;
	int groupIndex;
	
	
	gPaiUserConfig.loginTime_sec = 60.0 * 30.0;//30 minutes

	
	groupIndex = 0;
	brsstrcpy((UDINT)gPaiUserConfig.listGroups[groupIndex].Name, (UDINT)"NotLogged");
	gPaiUserConfig.listGroups[groupIndex].Level = 0;
	gPaiUserConfig.listGroups[groupIndex].Admin = 0;
	for(ii=0; ii<=paiUSER_RIGHTSMAXIDX;ii++){
		gPaiUserConfig.listGroups[groupIndex].AccessRights[ii] = mpUSER_ACCESS_UNDEFINED;
	}
	
	groupIndex = 1;
	brsstrcpy((UDINT)gPaiUserConfig.listGroups[groupIndex].Name, (UDINT)"Operator");
	gPaiUserConfig.listGroups[groupIndex].Level = 10;
	gPaiUserConfig.listGroups[groupIndex].Admin = 0;
	for(ii=0; ii<=paiUSER_RIGHTSMAXIDX;ii++){
		gPaiUserConfig.listGroups[groupIndex].AccessRights[ii] = mpUSER_ACCESS_FULL;
	}
		
	groupIndex = 2;
	brsstrcpy((UDINT)gPaiUserConfig.listGroups[groupIndex].Name, (UDINT)"Maintenance");
	gPaiUserConfig.listGroups[groupIndex].Level = 20;
	gPaiUserConfig.listGroups[groupIndex].Admin = 0;
	for(ii=0; ii<=paiUSER_RIGHTSMAXIDX;ii++){
		gPaiUserConfig.listGroups[groupIndex].AccessRights[ii] = mpUSER_ACCESS_FULL;
	}
	

	groupIndex = 3;
	brsstrcpy((UDINT)gPaiUserConfig.listGroups[groupIndex].Name, (UDINT)"Supervisor");
	gPaiUserConfig.listGroups[groupIndex].Level = 30;
	gPaiUserConfig.listGroups[groupIndex].Admin = 0;
	for(ii=0; ii<=paiUSER_RIGHTSMAXIDX;ii++){
		gPaiUserConfig.listGroups[groupIndex].AccessRights[ii] = mpUSER_ACCESS_FULL;
	}

	

	groupIndex = 4;
	brsstrcpy((UDINT)gPaiUserConfig.listGroups[groupIndex].Name, (UDINT)"Manufacturer");
	gPaiUserConfig.listGroups[groupIndex].Level = 100;
	gPaiUserConfig.listGroups[groupIndex].Admin = 1;
	for(ii=0; ii<=paiUSER_RIGHTSMAXIDX;ii++){
		gPaiUserConfig.listGroups[groupIndex].AccessRights[ii] = mpUSER_ACCESS_FULL;
	}
	
	
}

static void paiUserUpdatePWDUI()
{
	int ii;
	
	brsstrcpy((UDINT)gPaiUserMgr.userMgr.UIConnect.listUserNames[0]  ,(UDINT)"n.a.");
	brsstrcpy((UDINT)gPaiUserMgr.userMgr.UIConnect.listUserPasswords[0], (UDINT)"not used PIN");
	for(ii = 1; ii <=(paiUSER_USERSMAXIDX+1); ii++){
		brsstrcpy((UDINT)gPaiUserMgr.userMgr.UIConnect.listUserNames[ii]  ,(UDINT)gPaiUserConfig.listUsers[ii-1].UserName);
		brsitoa((UDINT)gPaiUserConfig.listUsers[ii-1].PIN, (UDINT)gPaiUserMgr.userMgr.UIConnect.listUserPasswords[ii] );
	}
	
}

static void paiUserInitUsers()
{
	int userIndex;
	
	userIndex = 0;
	brsstrcpy((UDINT)gPaiUserConfig.listUsers[userIndex].UserName, (UDINT)"Operator");
	brsstrcpy((UDINT)gPaiUserConfig.listUsers[userIndex].UserFullName, (UDINT)"Mach. Operator");
	gPaiUserConfig.listUsers[userIndex].PIN = 24025;
	gPaiUserConfig.listUsers[userIndex].GroupIndex = 1;
	
	
	userIndex = 1;
	brsstrcpy((UDINT)gPaiUserConfig.listUsers[userIndex].UserName, (UDINT)"Maintenance");
	brsstrcpy((UDINT)gPaiUserConfig.listUsers[userIndex].UserFullName, (UDINT)"Mach. Maintenance");
	//gPaiUserConfig.listUsers[userIndex].PIN = 9375144;
	gPaiUserConfig.listUsers[userIndex].PIN = 4858418;//changed on 9/21/2016, request from customer
	gPaiUserConfig.listUsers[userIndex].GroupIndex = 2;

	
	userIndex = 2;
	brsstrcpy((UDINT)gPaiUserConfig.listUsers[userIndex].UserName, (UDINT)"ABC Service");
	brsstrcpy((UDINT)gPaiUserConfig.listUsers[userIndex].UserFullName, (UDINT)"ABC Pckg.");
	gPaiUserConfig.listUsers[userIndex].PIN = 81134689;
	gPaiUserConfig.listUsers[userIndex].GroupIndex = 4;

//	userIndex = 3;
//	brsstrcpy(gPaiUserConfig.listUsers[userIndex].UserName, "user4");
//	brsstrcpy(gPaiUserConfig.listUsers[userIndex].UserFullName, "User Four");
//	gPaiUserConfig.listUsers[userIndex].PIN = 4444;
//	gPaiUserConfig.listUsers[userIndex].GroupIndex = 4;
	
	gPaiUserMgr.userMgr.UIConnect.userIndex = 0;
	gPaiUserMgr.userMgr.UIConnect.userIndexMax = userIndex;	
	
	paiUserUpdatePWDUI();		
}

static void	paiUserMgrInit()
{
	gPaiUserMgr.pUserConfig = &gPaiUserConfig;
	
	gPaiUserMgr.userMgr.UIConnect.pwdLevel = 0;
	gPaiUserMgr.userMgr.UIConnect.pwdLevelOld = 0;
	gPaiUserMgr.userMgr.UIConnect.visibleNotLogged = 0;//visible
	gPaiUserMgr.userMgr.UIConnect.visibleLogged = 1;//not visible
	gPaiUserMgr.userMgr.UIConnect.loggedIndex = 0;
	gPaiUserMgr.userMgr.UIConnect.isUserLogged = 0;
	
	brsmemcpy((UDINT)&gPaiUserMgr.currentGroup, (UDINT)&gPaiUserConfig.listGroups[0], sizeof(gPaiUserMgr.currentGroup));
	brsmemset((UDINT)&gPaiUserMgr.currentUser, 0, sizeof(gPaiUserMgr.currentUser));
	brsstrcpy((UDINT)gPaiUserMgr.currentUser.UserName  ,(UDINT)"n.a.");
	brsstrcpy((UDINT)gPaiUserMgr.currentUser.UserFullName, (UDINT)"n.a.");
	
}


static void paiUserMgrCyclic()
{

	//user login activity from the login screen
	if(gPaiUserMgr.userMgr.UIConnect.pwdLevel != gPaiUserMgr.userMgr.UIConnect.pwdLevelOld){
		if(gPaiUserMgr.userMgr.UIConnect.pwdLevel == (gPaiUserMgr.userMgr.UIConnect.userIndex + 1) ){
			//user login success!
			gPaiUserMgr.userMgr.UIConnect.isUserLogged = 1;
			
			gPaiUserMgr.userMgr.UIConnect.loggedIndex = gPaiUserMgr.userMgr.UIConnect.userIndex;
			if(gPaiUserMgr.userMgr.UIConnect.loggedIndex > paiUSER_USERSMAXIDX){
				gPaiUserMgr.userMgr.UIConnect.loggedIndex = paiUSER_USERSMAXIDX;
			}
			
			gPaiUserMgr.userMgr.UIConnect.visibleNotLogged = 1;//not visible
			gPaiUserMgr.userMgr.UIConnect.visibleLogged = 0;//visible visible
			
			//define current user
			brsmemcpy((UDINT)&gPaiUserMgr.currentUser, (UDINT)&gPaiUserConfig.listUsers[gPaiUserMgr.userMgr.UIConnect.loggedIndex], sizeof(gPaiUserMgr.currentUser));
			
			//define current group
			if(gPaiUserMgr.currentUser.GroupIndex > paiUSER_GROUPMAXIDX){
				gPaiUserMgr.currentUser.GroupIndex = paiUSER_GROUPMAXIDX;
			}
			brsmemcpy((UDINT)&gPaiUserMgr.currentGroup, (UDINT)&gPaiUserConfig.listGroups[gPaiUserMgr.currentUser.GroupIndex], sizeof(gPaiUserMgr.currentGroup));
			
			//start timeout timer
			bgTimerStart(&gPaiUserMgr.userMgr.loginTimer, 1000 * gPaiUserMgr.pUserConfig->loginTime_sec);
		}else{
			paiUserMgrInit();
		}
	}
	gPaiUserMgr.userMgr.UIConnect.pwdLevelOld = gPaiUserMgr.userMgr.UIConnect.pwdLevel;
	
	//login timer expired?
	if(gPaiUserMgr.userMgr.UIConnect.isUserLogged && bgTimerIsTimeOut(&gPaiUserMgr.userMgr.loginTimer) ){
		paiUserMgrInit();
	}
	
	//restart login timer button pressed?
	if(gPaiUserMgr.userMgr.UIConnect.btnRestartLoginTimer){
		gPaiUserMgr.userMgr.UIConnect.btnRestartLoginTimer = 0;
		bgTimerStart(&gPaiUserMgr.userMgr.loginTimer, 1000 * gPaiUserMgr.pUserConfig->loginTime_sec);
	}
	
	//login button pressed?
	if(gPaiUserMgr.userMgr.UIConnect.btnToggleLogin){
		gPaiUserMgr.userMgr.UIConnect.btnToggleLogin = 0;
		if(gPaiUserMgr.userMgr.UIConnect.isUserLogged){
			paiUserMgrInit();		
		}else{
			//TODO: jump to login page
			gPaiHmiMain.runtime.pageChange = 70;//login page			
		}
	}
	
	//operate login timer
	bgTimerCyclic(&gPaiUserMgr.userMgr.loginTimer);
	
	//calculate remaining login time [min:sec] from remaining timer time [ms]
	gPaiUserMgr.userMgr.UIConnect.remainingLoginTime_sec = 	( bgTimerTimeRemaining(&gPaiUserMgr.userMgr.loginTimer) / 1000 ) % 60;
	gPaiUserMgr.userMgr.UIConnect.remainingLoginTime_min = 	( bgTimerTimeRemaining(&gPaiUserMgr.userMgr.loginTimer) / 1000 ) / 60;	
}


//=============================================================================

void _INIT paiUserInit(void)
{
	paiUserInitGroups();
	paiUserInitUsers();
	paiUserMgrInit();
	
}

void _CYCLIC paiUserCyclic(void)
{
	paiUserMgrCyclic();	
}
//EOF



