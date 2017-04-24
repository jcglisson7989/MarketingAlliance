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
	applicationAlarms_enums : 
		(
		APP_ALARM_HWMODULE := 0,
		APP_ALARM_DS1,
		APP_ALARM_DS2,
		APP_ALARM_DS3,
		APP_ALARM_DS4,
		APP_ALARM_DS5,
		APP_ALARM_DS6,
		APP_ALARM_ESTOP1,
		APP_ALARM_ESTOP2,
		APP_ALARM_ESTOP3,
		APP_ALARM_ESTOP4,
		APP_ALARM_ESTOP5,
		APP_ALARM_ESTOP6,
		APP_ALARM_MOTOROL,
		APP_ALARM_MCR,
		APP_ALARM_AIRPRESSURE,
		APP_ALARM_ELEV_CHAINSLACK_LF,
		APP_ALARM_ELEV_CHAINSLACK_RT,
		APP_ALARM_ELEV_PALLETDISPENS,
		APP_ALARM_VFD,
		APP_ALARM_LIGHT_CURTAIN_OSSD1,
		APP_ALARM_LIGHT_CURTAIN_OSSD2,
		APP_ALARM_INFEED_JAM,
		APP_ALARM_ROW_FORMING_JAM,
		APP_ALARM_ROW_TOO_LONG,
		APP_ALARM_INVALID_PROGRAM,
		APP_ALARM_PALLET_EXIT_TIMEOUT,
		APP_ALARM_INFEED_CASE_COUNT,
		APP_ALARM_LASTTOCHECK := 48,
		APP_ALARM_ALARMACKNEEDED := 49,
		APP_ALARM_LAST := 50
		);
END_TYPE

(*########################################################################*)
(*Application object - Alarm Object*)
(*########################################################################*)

TYPE
	applicationAlarms_typ : 	STRUCT 
		oIsAlarmActiveCount : UDINT; (*1-if alarm present*)
		oIsAlarmNotAckCount : UDINT; (*1-if not ack alarm present*)
		oIsAlarmActive : BOOL; (*1-if alarm present*)
		oIsAlarmNotAck : BOOL; (*1-if not ack alarm present*)
		alarmActive : ARRAY[0..APP_ALARM_LAST]OF BOOL; (*Alarms matrix. (see Visual Components Alarm System)*)
		alarmAck : ARRAY[0..APP_ALARM_LAST]OF BOOL; (*Alarms ack matrix. (see Visual Components Alarm System)*)
	END_STRUCT;
END_TYPE
