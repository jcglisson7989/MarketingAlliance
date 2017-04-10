
ACTION Action_AxisControl_Mgmt:
	
	IF EDGEPOS(iMachineErrorReset) THEN
		AxisControl.ErrorReset := TRUE;
	ELSIF EDGENEG(iMachineErrorReset)  THEN
		AxisControl.ErrorReset := FALSE;
	END_IF;
	
	IF AxisControl.ErrorReset AND NOT AxisControl.Error THEN //FBK errors only reset on + edge of error reset signal -> Clear reset signal when there are no errors!
		AxisControl.ErrorReset := FALSE;
	END_IF;
	
	Axis1; //Reference the PV cyclically to ensure it registers as being included in the program!
	AxisControl();//Call the function block responsible for executing the axis commands

END_ACTION
