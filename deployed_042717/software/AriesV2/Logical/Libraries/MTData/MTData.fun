
{REDUND_OK} FUNCTION_BLOCK MTDataStdDeviation (*Standard deviation calculation.*)
	VAR_INPUT
		Enable : BOOL; (*Enable function block.*)
		In : REAL; (*Input value.*)
		Reset : BOOL; (*Reset output. New start of output calculation.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTDataStdDeviationInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTDataVariance (*Variance calculation.*)
	VAR_INPUT
		Enable : BOOL; (*Enable function block.*)
		In : REAL; (*Input value.*)
		Reset : BOOL; (*Reset output. New start of output calculation.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTDataVarianceInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTDataRMS (*Root mean square calculation.*)
	VAR_INPUT
		Enable : BOOL; (*Enable function block.*)
		In : REAL; (*Input value.*)
		Reset : BOOL; (*Reset output. New start of output calculation.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTDataRMSInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTDataMean (*Mean calculation.*)
	VAR_INPUT
		Enable : BOOL; (*Enable function block.*)
		In : REAL; (*Input value.*)
		Reset : BOOL; (*Reset output. New start of output calculation.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTDataMeanInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_OK} FUNCTION_BLOCK MTDataMinMax (*Minimum/Maximum calculation.*)
	VAR_INPUT
		Enable : BOOL; (*Enable function block.*)
		In : REAL; (*Input value.*)
		Reset : BOOL; (*Reset output. New start of output calculation.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		MinValue : REAL; (*Minimum value.*)
		IndexMinValue : UDINT; (*Index of minimum value.*)
		MaxValue : REAL; (*Maximum value.*)
		IndexMaxValue : UDINT; (*Index of maximum value.*)
	END_VAR
	VAR
		Internal : MTDataMinMaxInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MTDataStatistics (*Statistics calculation.*)
	VAR_INPUT
		Enable : BOOL; (*Enable function block.*)
		MovingWindowLength : UDINT; (*Length of moving window.*)
		Update : BOOL; (*Update parameter.*)
		In : REAL; (*Input value.*)
		Reset : BOOL; (*Reset output. New start of output calculation.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : DINT; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		MinValue : REAL; (*Minimum value.*)
		IndexMinValue : UDINT; (*Index of minimum value.*)
		MaxValue : REAL; (*Maximum value.*)
		IndexMaxValue : UDINT; (*Index of maximum value.*)
		Mean : REAL; (*Mean value.*)
		RMS : REAL; (*RMS value.*)
		Variance : REAL; (*Variance value.*)
		StdDeviation : REAL; (*Standard deviation value.*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MTDataStatisticsInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK
