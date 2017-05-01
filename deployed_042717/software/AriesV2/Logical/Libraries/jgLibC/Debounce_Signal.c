#include <bur/plctypes.h>

#include <jgLibC.h>
#include <bglibasWBR.h>

/* TODO: Add your comment here */
void Debounce_Signal(struct Debounce_Signal* p)
{
	
	if(p && p->pConfigVals){
	
		p->Ton.PT = Tms(p->pConfigVals->Timer_On);
		p->Tof.PT = Tms(p->pConfigVals->Timer_Off);
	
		p->Ton.IN = p->input;
		bgTimerCyclic(&p->Ton);
		p->Tof.IN = p->Ton.Q;
		bgTimerOffCyclic(&p->Tof);
		p->Signal_Debounced = p->Tof.Q;
	}
}
