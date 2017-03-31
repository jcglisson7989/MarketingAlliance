(********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Library: wbrFltUtil
 * File: wbrFltUtil.fun
 * Author: Blanton Radford
 * Created: August 18, 2015
 ********************************************************************
 * Functions and function blocks of library wbrFltUtil
 ********************************************************************)

FUNCTION wbrDoubleInRange : BOOL (*Checks that the double v1 is between lo and hi*)
	VAR_INPUT
		lo : LREAL;
		v1 : LREAL;
		hi : LREAL;
	END_VAR
END_FUNCTION

FUNCTION wbrDoubleCompare : BOOL (*Compares two doubles ()v1, v2)  to see if they are within the tolerance value (tol)*)
	VAR_INPUT
		v1 : LREAL;
		v2 : LREAL;
		tol : LREAL;
	END_VAR
END_FUNCTION
