(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: MTBasics
 * File: MTBasics.fun
 * Author: B&R
 ********************************************************************
 * Functions and function blocks of library MTBasics
 ********************************************************************)

FUNCTION_BLOCK MTBasicsPID (*PID controller.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Parameter : MTBasicsPIDParameterType; (*PID parameters.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		SetValue : REAL; (*Set value (reference variable).*)
		ActValue : REAL; (*Actual value (controlled variable).*)
		IntegrationPartPresetValue : REAL; (*Preset value for the integral component IntegrationPart.*)
		SetIntegrationPart : BOOL; (*A positive edge on SetIntegrationPart sets the integral component IntegrationPart of the PID controller to IntegrationPartPresetValue.*)
		HoldOut : BOOL; (*Freezes the function block.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Controller output. Value range: MinOut <= Out <= MaxOut.*)
		ControlError : REAL; (*Control error.*)
		ProportionalPart : REAL; (*Proportional component.*)
		IntegrationPart : REAL; (*Integral component.*)
		DerivativePart : REAL; (*Derivative component.*)
	END_VAR
	VAR
		Internal : MTBasicsPIDInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsOscillationTuning (*Oscillation tuning for PID.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		SetValue : REAL; (*Reference variable (setpoint).*)
		MinOut : REAL; (*Lower manipulated variable limit. Valid value range: MinOut < MaxOut.*)
		MaxOut : REAL; (*Upper manipulated variable limit. Valid value range: MaxOut > MinOut.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		ActValue : REAL; (*Actual measured value.*)
		Start : BOOL; (*Starts the tuning (on positive edge).*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value (manipulated variable). Value range: MinOut <= Out <= MaxOut.*)
		TuningDone : BOOL; (*Tuning completed.*)
		Gain : REAL; (*Calculated proportional gain.*)
		IntegrationTime : REAL; (*Calculated integral action time of the integration component. Unit: [s].*)
		DerivativeTime : REAL; (*Calculated derivative action time constant of the derivative component. Unit: [s].*)
		FilterTime : REAL; (*Calculated filter time constant of the D component. Unit: [s].*)
		Quality : REAL; (*Quality of the oscillation test. Unit: [%]. Value range: 0 (low) ... 100 (high).*)
	END_VAR
	VAR
		Internal : MTBasicsOscTuningInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsLevelController (*Level controller.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Parameter : MTBasicsLevelCtrlParaType; (*3-step controller parameters.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsLevelCtrlInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsPT1 (*First-order delay element.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Gain : REAL; (*Gain factor.*)
		TimeConstant : REAL; (*Time constant. Unit: [s]. Valid value range: TimeConstant >= 0.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsPT1InternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsPT2 (*Second-order delay element.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Gain : REAL; (*Gain.*)
		TimeConstant1 : REAL; (*Time constant. Unit: [s]. Valid value range: TimeConstant1 >= 0.*)
		TimeConstant2 : REAL; (*Time constant. Unit: [s]. Valid value range: TimeConstant2 >= 0.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsPT2InternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsDT1 (*First-order derivative action element.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Gain : REAL; (*Gain factor.*)
		TimeConstant : REAL; (*Time constant. Unit: [s]. Valid value range: TimeConstant >= 0.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsDT1InternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsDT2 (*Second-order derivative action element.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Gain : REAL; (*Gain factor.*)
		TimeConstant1 : REAL; (*Time constant. Unit: [s]. Valid value range: TimeConstant1 >= 0.*)
		TimeConstant2 : REAL; (*Time constant. Unit: [s]. Valid value range: TimeConstant2 >= 0.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsDT2InternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsIntegrator (*Integrator.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Gain : REAL; (*Gain factor. Valid value range: Gain >= 0.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
		HoldOut : BOOL; (*Freezes the function block.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsIntegratorInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsTimeDelay (*Delay element.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		DelayTime : REAL; (*Delay time. Unit: [s]. Valid value range: 0 <= DelayTime <= "10000 · task cycle time".*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsTimeDelayInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsLimiter (*Limiter.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		MinOut : REAL; (*Lower output variable limit. Valid value range: MinOut < MaxOut.*)
		MaxOut : REAL; (*Upper output variable limit. Valid value range: MaxOut > MinOut.*)
		MaxPosSlewRate : REAL; (*Maximum output variable ramp for ramp-up. Unit: [1/s]. Valid value range: MaxPosSlewRate >= 0.*)
		MaxNegSlewRate : REAL; (*Maximum output variable ramp for the ramp-down. Unit: [1/s]. Valid value range: MaxNegSlewRate >= 0.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsLimiterInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsTransferFcn (*General continuous transfer function.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Order : USINT; (*Order of the continuous transfer function. Valid value range: 0 <= Order <= 5.*)
		Numerator : ARRAY[0..5] OF REAL; (*Numerator coefficients.*)
		Denominator : ARRAY[0..5] OF REAL; (*Denominator coefficients.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsTransFcnInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsDiscreteTransferFcn (*General discrete transfer function.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Order : USINT; (*Order of the discrete transfer function. Valid value range: 0 <= Order <= 5.*)
		Numerator : ARRAY[0..5] OF REAL; (*Numerator coefficients.*)
		Denominator : ARRAY[0..5] OF REAL; (*Denominator coefficients.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		In : REAL; (*Input value.*)
		OutPresetValue : REAL; (*Preset value for Out output.*)
		SetOut : BOOL; (*Sets Out to OutPresetValue on rising edge.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : REAL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsDiscrTransFcnInternType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsPWM (*Pulse width modulator.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		Mode : MTBasicsPWMModeEnum; (*Pulse mode.*)
		MinPulseWidth : REAL; (*Minimum duration of the output actuator pulses and pauses. Unit: [s]. Valid value range: MinPulseWidth < Period.*)
		Period : REAL; (*Period for the output actuator pulses. Unit: [s]. Valid value range: Period > task cycle time.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		DutyCycle : REAL; (*Input value. Unit: [%]. Valid value range: 0 <= DutyCycle <= 100.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : BOOL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsPWMInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MTBasicsPFM (*Pulse frequency modulator.*)
	VAR_INPUT
		Enable : BOOL; (*Enables/Disables the function block.*)
		PulseWidth : REAL; (*Pulse width at the output. Unit: [s]. Valid value range: PulseWidth >= task cycle time.*)
		MinPause : REAL; (*Minimum pause between the pulses at the output. Unit: [s]. Valid value range: MinPause >= task cycle time.*)
		Update : BOOL; (*Updates the parameters listed above on a rising edge.*)
		DutyCycle : REAL; (*Input value.*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is active.*)
		Error : BOOL; (*Indicates an error.*)
		StatusID : MTBasicsStatusEnum; (*Status information.*)
		UpdateDone : BOOL; (*Update is done.*)
		Out : BOOL; (*Output value.*)
	END_VAR
	VAR
		Internal : MTBasicsPFMInternalType; (*Data for internal use.*)
	END_VAR
END_FUNCTION_BLOCK
