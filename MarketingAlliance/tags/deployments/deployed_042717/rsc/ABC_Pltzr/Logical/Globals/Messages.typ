(********************************************************************

 * COPYRIGHT -- Piedmont Automation Inc.

 ********************************************************************

 * File: Alarms.typ

 * Author: goran

 * Created: Jun 1, 2015

 ********************************************************************

 * Data types for project : Alarms

 ********************************************************************)

TYPE
	applicationMessages_enums : 
		(
		APP_MSG_READY := 0,
		APP_MSG_RUNAUTO,
		APP_MSG_RUNDRYCYCLE,
		APP_MSG_ZEROREQUIRED,
		APS_MSG_LOWONPALLETS,
		APP_MSG_ZERO_CASETURNER,
		APP_MSG_ZERO_ROWPUSHER,
		APP_MSG_ZERO_BLADESTOP,
		APP_MSG_ZERO_TABLE,
		APP_MSG_ZERO_ELEVATOR,
		APP_MSG_ZERO_PALLETELIFT,
		APP_MSG_ZERO_RETAINERBAR,
		APP_MSG_ZERO_SQUARING,
		APP_MSG_PALLETE_COMPLETE,
		APP_MSG_DISCHARGE_BLOCKED,
		APP_MSG_STOP_BLOCK_RT,
		APP_MSG_STOP_BLOCK_LF,
		APP_MSG_PALLETE_EXITING,
		APP_MSG_ZERO_MSG18,
		APP_MSG_ZERO_MSG19,
		APP_MSG_LAST := 50
		);
END_TYPE

(*########################################################################*)
(*Application object - Message Object*)
(*########################################################################*)

TYPE
	applicationMessages_typ : 	STRUCT 
		oIsMsgActive : BOOL; (*1-if alarm present*)
		msgActive : ARRAY[0..APP_MSG_LAST]OF BOOL; (*Alarms matrix. (see Visual Components Alarm System)*)
	END_STRUCT;
END_TYPE
