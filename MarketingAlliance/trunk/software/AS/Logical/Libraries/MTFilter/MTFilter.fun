
{REDUND_OK} FUNCTION_BLOCK MTFilterBandPass (*Band-pass filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Type : MTFilterTypeEnum; (*Filter type. Valid value range: mtBESSEL, mtBUTTERWORTH*)
		Order : USINT; (*Filter order. Valid value range: {1,2}.*)
		CenterFrequency : REAL; (*Center frequency. Unit: [Hz]. Valid value range: 0 < CenterFrequency < Sampling frequency/2. Sampling frequency = 1/task cycle time.*)
		Bandwidth : REAL; (*Bandwidth. Unit: [Hz]. Valid value range: 0 < Bandwidth < 2·CenterFrequency.*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is working.*)
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
		SystemReference : {REDUND_UNREPLICABLE} UDINT; (*System reference.*)
	END_VAR
	VAR
		Internal : MTFilterBandPassInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTFilterBandStop (*Band-stop filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Type : MTFilterTypeEnum; (*Filter type. Valid value range: mtBESSEL, mtBUTTERWORTH*)
		Order : USINT; (*Filter order. Valid value range: {1,2}.*)
		CenterFrequency : REAL; (*Center frequency. Unit: [Hz]. Valid value range: 0 < CenterFrequency < Sampling frequency/2. Sampling frequency = 1/task cycle time.*)
		Bandwidth : REAL; (*Bandwidth. Unit: [Hz]. Valid value range: 0 < Bandwidth < 2·CenterFrequency.*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is working.*)
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
		SystemReference : {REDUND_UNREPLICABLE} UDINT; (*System reference.*)
	END_VAR
	VAR
		Internal : MTFilterBandStopInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTFilterBiQuad (*Biquad filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		CenterFrequencyNum : REAL; (*Filter frequency numerator. Unit: [Hz]. Valid value range: 0 < FrequencyNumerator < 0.5·Sampling frequency. Sampling frequency = 1/task cycle time.*)
		DampingRatioNum : REAL; (*Damping numerator. Valid value range: 0 = DampingRatioNumerator = 1.*)
		CenterFrequencyDen : REAL; (*Filter frequency denominator. Unit: [Hz]. Valid value range: 0 < FrequencyDenominator <  0.5·Sampling frequency. Sampling frequency = 1/task cycle time.*)
		DampingRatioDen : REAL; (*Damping denominator. Valid value range: 0 = DampingRatioDenominator = 1*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is working.*)
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
		SystemReference : {REDUND_UNREPLICABLE} UDINT; (*System reference.*)
	END_VAR
	VAR
		Internal : MTFilterBiQuadInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTFilterHighPass (*High-pass filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Type : MTFilterTypeEnum; (*Filter type. Valid value range: mtBESSEL, mtBUTTERWORTH*)
		Order : USINT; (*Filter order. Valid value range: {1,2,..,5}.*)
		CutOffFrequency : REAL; (*Cut-off frequency. Unit: [Hz]. Valid value range: 0 < CutOffFrequency < Sampling frequency/2. Sampling frequency = 1/task cycle time.*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is working.*)
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
		SystemReference : {REDUND_UNREPLICABLE} UDINT; (*System reference.*)
	END_VAR
	VAR
		Internal : MTFilterHighPassInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTFilterLowPass (*Low-pass filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Type : MTFilterTypeEnum; (*Filter type. Valid value range: mtBESSEL, mtBUTTERWORTH*)
		Order : USINT; (*Filter order. Valid value range: {1,2,..,5}.*)
		CutOffFrequency : REAL; (*Cut-off frequency. Unit: [Hz]. Valid value range: 0 < CutOffFrequency < Sampling frequency/2. Sampling frequency = 1/task cycle time.*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is working.*)
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
		SystemReference : {REDUND_UNREPLICABLE} UDINT; (*System reference.*)
	END_VAR
	VAR
		Internal : MTFilterLowPassInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_CONTEXT} FUNCTION_BLOCK MTFilterMovingAverage (*Moving average filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		WindowLength : UINT; (*Length of the moving view window. Numbers of values to be averaged Valid value range: 0 < WindowLength < 10000.*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Floating average value.*)
	END_VAR
	VAR
		Internal : MTFilterMovingAvgInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTFilterNotch (*Notch filter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		CenterFrequency : REAL; (*Center frequency. Unit: [Hz]. Valid value range: 0 < CenterFrequency < Sampling frequency/2. Sampling frequency = 1/task cycle time.*)
		Bandwidth : REAL; (*Bandwidth. Unit: [Hz]. Valid value range: 0 < Bandwidth < 2·CenterFrequency.*)
		Update : BOOL; (*Updates the parameters listed above on rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is working.*)
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
		SystemReference : {REDUND_UNREPLICABLE} UDINT; (*System reference.*)
	END_VAR
	VAR
		Internal : MTFilterNotchInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK
