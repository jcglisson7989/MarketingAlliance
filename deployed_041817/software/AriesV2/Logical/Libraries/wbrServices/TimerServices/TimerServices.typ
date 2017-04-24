(********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Package: TimerServices
 * File: TimerServices.typ
 * Author: Blanton Radford
 * Created: December 05, 2014
 ********************************************************************
 * Data types of package TimerServices
 ********************************************************************)

TYPE
	msTimerHourMeter_typ : 	STRUCT 
		enable : BOOL;
		count : UDINT;
	END_STRUCT;
	msTimer_typ : 	STRUCT 
		clock_ms : UDINT; (*System ms counter.  Not resettable.  Used to keep C1ms from missing counts if task class runs into its tolerance  TODO:  \todo*)
		diff_ms : UDINT; (*Difference from one scan to the next of the msTimeSvc task*)
		C1ms : UDINT; (*Rolls over after 4294920000U to keep other Cxx counters accurate.  Can also be reset.*)
		C10ms : UDINT;
		C100ms : UDINT;
		C1s : UDINT;
		C10s : UDINT;
		C60s : UDINT;
		C60sAbs : UDINT;
		F100ms : BOOL;
		F500ms : BOOL;
		F1s : BOOL;
		F2s : BOOL;
		F10s : BOOL;
		pulse01Hz100ms : BOOL;
		pulse1day100ms : BOOL;
		_old60s : UDINT;
	END_STRUCT;
END_TYPE
