(********************************************************************
 * COPYRIGHT -- belgor
 ********************************************************************
 * Library: bglibas
 * File: bglibas.typ
 * Author: admin
 * Created: March 07, 2012
 ********************************************************************
 * Data types of library bglibas
 ********************************************************************)

TYPE
	BGWBR_TIMER_CONSTANT : 
		( (*Included to support legacy bgTimer.h constants*)
		BG_TIMERTIME_1SEC := 1000,
		BG_TIMERTIME_1MIN := 60000,
		BG_TIMERTIME_1HOUR := 3600000
		);
	BGSSM_CONST_XYZ : 
		(
		BGSSM_FLAG_COUNT := 5,
		BGSSM_EVENT_COUNT := 5,
		BGSSM_COUNTER_COUNT := 5,
		BGSSM_TIMER_COUNT := 5,
		BGSSM_REGISTER_COUNT := 5,
		BGSSM_SUBROUTINE_COUNT := 5,
		BGSSM_MAX_LOG_ENTRY_INDEX := 31,
		BGSSM_LOG_ENTRIES,
		BGSSM_TEXT_LENGTH := 31,
		BGSSM_MESSAGE_LENGTH_IEC := 127,
		BGSSM_MESSAGE_LENGTH_C
		);
	bgFIFO_typ : 	STRUCT 
		iPtrPushData : UDINT;
		cfgEntrySize : UDINT;
		cfgMaxEntries : UDINT;
		oPtrPullData : UDINT;
		oFIFOCount : UDINT;
		oFIFOFull : UDINT;
		oPushIdx : UDINT;
		oPullIdx : UDINT;
		prvFIFOMemory : UDINT;
	END_STRUCT;
	bgSSMScanLimit_typ : 	STRUCT 
		breakpoint : BOOL;
		breakpointPrev : BOOL;
		active : BOOL;
		triggerNextScan : BOOL;
		limit : UDINT;
		count : UDINT;
	END_STRUCT;
	bgSSMMessage_typ : 	STRUCT 
		log : STRING[BGSSM_MESSAGE_LENGTH_IEC];
		err : STRING[BGSSM_MESSAGE_LENGTH_IEC];
		sts : STRING[BGSSM_MESSAGE_LENGTH_IEC];
	END_STRUCT;
	bgSSMLog_typ : 	STRUCT 
		view : ARRAY[0..BGSSM_MAX_LOG_ENTRY_INDEX]OF STRING[BGSSM_MESSAGE_LENGTH_IEC]; (*View window into the log*)
		str : wbrListSvcStringList_typ;
	END_STRUCT;
	bgSSM_typ : 	STRUCT 
		scanLimit : bgSSMScanLimit_typ; (*Limits state machine to the number of scans set in .limit member.  Also supports adding breakpoints to the SM.*)
		log : bgSSMLog_typ;
		state : UDINT;
		stateNext : UDINT;
		stateAfterSubIndex : UDINT; (*Index for stateAfterSub below*)
		stateAfterSub : ARRAY[0..BGSSM_SUBROUTINE_COUNT]OF UDINT; (*State to return to after running one or more states defined as a subroutine.  Array allows for subroutine nesting.*)
		stateRet : UDINT;
		stateOld : UDINT;
		stateText : STRING[BGSSM_TEXT_LENGTH];
		pfunInitState : UDINT; (*WBR:*)
		pfunInterrupt : UDINT; (*WBR:*)
		pfunGetStateName : UDINT;
		pfunCyclicCallback : UDINT;
		stateInit : BOOL;
		error : UDINT;
		errorText : STRING[BGSSM_TEXT_LENGTH];
		message : STRING[BGSSM_MESSAGE_LENGTH_IEC]; (*Preformatted state change text for logging.  Can be used for other purposes, but gets written to upon each stateInit.*)
		msg : bgSSMMessage_typ; (*WBR:*)
		event : ARRAY[0..BGSSM_EVENT_COUNT]OF BOOL;
		flag : ARRAY[0..BGSSM_FLAG_COUNT]OF BOOL;
		counter : ARRAY[0..BGSSM_COUNTER_COUNT]OF UDINT;
		value : ARRAY[0..BGSSM_REGISTER_COUNT]OF UDINT;
		timer_x1ms : ARRAY[0..BGSSM_TIMER_COUNT]OF TON;
		dlytimer_x1ms : TON;
		wdogTimer_x1ms : TON;
		dlyCycles : UDINT;
	END_STRUCT;
END_TYPE
