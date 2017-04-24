(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiConfigAndRecipes
 * File: appConfig.typ
 * Author: goran_2
 * Created: August 06, 2011
 ********************************************************************
 * Data types of package ConfigAndRecipes
 ********************************************************************)
(*==================================================================*)
(*Application recipe structure. Do not change the type name! Change content as needed.*)
(*==================================================================*)

TYPE
	cfgMachineRecipe_typ : 	STRUCT  (*Recipe structure*)
		name : STRING[126]; (*Recipe name*)
		author : STRING[31];
		dateLastSaved : STRING[31];
	END_STRUCT;
END_TYPE

(*######################################################*)
(*Below define type paiRecipeApp_typ MUST BE PRESENT!*)
(*ADD APPLICATION SPECIFIC MEMBERS AS NEEDED*)
(*######################################################*)

TYPE
	paiRecipeApp_typ : 	STRUCT  (*Recipe strucuture. DO NOT CHANGE.*)
		info : cfgMachineRecipe_typ; (*Active recipe*)
	END_STRUCT;
END_TYPE
