
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include <MAPPSuppor.h>
#include <wbrsprintf.h>
/* TODO: Add your comment here */
void FBK_Init_Logbook(struct FBK_Init_Logbook* p)
{
//	return;
	
	if(!p->Enable) return;
	
	p->ii_init_calls = 0;
	
	wbrsnprintf(p->Logbook.name, sizeof(p->Logbook.name), p->Name);
	
	do {
		getLogbookInfo(&p->Logbook);
		p->ii_init_calls++;
	} while(p->Logbook.status == 0xFFFF && p->ii_init_calls <= MAX_CALLS_INIT_LOGBOOK);
	
	if(p->Logbook.status == arlogERR_NOTEXISTING){
		p->ii_init_calls = 0;
		do {
			createNewLogbook(&p->Logbook);
			p->ii_init_calls++;
		} while(p->Logbook.status == 0xFFFF && p->ii_init_calls <= MAX_CALLS_INIT_LOGBOOK);
		
		
		if(!p->Logbook.status){
			requestMessageToLog((UDINT) "Logbook Created", p->Logbook.ident, arlogLEVEL_INFO, 0, 0, 0);	
		}
		else{
			requestMessageToLog((UDINT) "Logbook Creation Failed", arlogBASE_USER_LOG_IDENT, arlogLEVEL_INFO, (UDINT) p->Logbook.status, 0, 0);
		}
		
	}
	
	p->pLog = p->Logbook.ident;
		
	return;
	
		
}
