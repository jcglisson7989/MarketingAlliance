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
	mstpPERIOD_enum : 
		(
		per00100 := 0,
		per00200,
		per00500,
		per01000,
		per02000,
		per05000,
		per10000,
		perLAST
		);
	mstpFREQUENCY_enum : 
		(
		freq010Hz := 0,
		freq005Hz,
		freq002Hz,
		freq001Hz,
		freq0p5Hz,
		freq0p2Hz,
		freq0p1Hz,
		freqLAST
		);
	mstpDUTY_CYCLE_enum : 
		(
		duty01 := 0,
		duty10,
		duty20,
		duty25,
		duty50,
		dutyLAST
		);
	mstpDURATION_enum : 
		(
		dur001ms := 0,
		dur010ms,
		dur020ms,
		durLAST
		);
	msTimerHourMeter_typ : 	STRUCT 
		enable : BOOL;
		count : UDINT;
	END_STRUCT;
	msTmPulseSOS_typ : 	STRUCT 
		codeSignal : BOOL;
		msgEnable : BOOL;
		shortEnable : BOOL;
		longEnable : BOOL;
		shortPulse : BOOL;
		longPulse : BOOL;
	END_STRUCT;
	msTmPulsePeriodDutyInOut_typ : 	STRUCT 
		iPeriodValue : UDINT;
		iDutyValue : REAL;
		oPulse : BOOL;
	END_STRUCT;
	msTmPulseFreqDutyInOut_typ : 	STRUCT 
		iFreqValue : REAL;
		iDutyValue : REAL;
		oPulse : BOOL;
	END_STRUCT;
	mstpPerDutyDurTableElements_typ : 	STRUCT 
		duty : {REDUND_UNREPLICABLE} ARRAY[0..dutyLAST]OF BOOL;
		duration : {REDUND_UNREPLICABLE} ARRAY[0..durLAST]OF BOOL;
	END_STRUCT;
	msTimerPulse_typ : 	STRUCT 
		periodDutyDurationTable : {REDUND_UNREPLICABLE} ARRAY[0..perLAST]OF mstpPerDutyDurTableElements_typ;
		periodLength : USINT;
		sos : msTmPulseSOS_typ;
	END_STRUCT;
	msTimer_typ : 	STRUCT 
		pulse : msTimerPulse_typ; (*Various pulses calculated with ms precision (when allowed to by task class timing)*)
		initVal : UDINT; (*Initial value of clock_ms*)
		rolloverVal : UDINT;
		clock_ms : UDINT; (*System ms counter.  Not resettable.  Used to keep C1ms from missing counts if task class runs into its tolerance  TODO:  \todo*)
		diff_ms : UDINT; (*Difference from one scan to the next of the msTimeSvc task*)
		C1ms : UDINT; (*Rolls over after 4294920000U to keep other Cxx counters accurate.  Can also be reset.*)
		C10ms : UDINT;
		C100ms : UDINT;
		C1s : UDINT;
		C10s : UDINT;
		C60s : UDINT;
		C01sAbs : UDINT;
		C60sAbs : UDINT;
		F100ms : BOOL;
		F500ms : BOOL;
		F1s : BOOL;
		F2s : BOOL;
		F10s : BOOL;
		pulse01Hz100ms : BOOL;
		pulse1day100ms : BOOL;
		prev60s : UDINT;
		prev01s : UDINT;
	END_STRUCT;
END_TYPE
