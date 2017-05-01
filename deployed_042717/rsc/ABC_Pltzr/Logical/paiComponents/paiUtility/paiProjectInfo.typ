(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiComponents
 * File: paiBRHW.typ
 * Author: goran
 * Created: June 23, 2015
 ********************************************************************
 * Data types of package paiTelnet
 ********************************************************************)

TYPE
	paiProjectInfo_typ : 	STRUCT 
		ProjectDate : STRING[31];
		ProjectVersion : STRING[31];
		ASVersion : STRING[31];
		Company : STRING[79];
		Address : STRING[79];
		CompanyWeb : STRING[79];
		ContactPhone : STRING[79];
		ProjectAbout : STRING[79];
		ProjectInfo : STRING[79];
		ProjectComments : STRING[79];
	END_STRUCT;
END_TYPE
