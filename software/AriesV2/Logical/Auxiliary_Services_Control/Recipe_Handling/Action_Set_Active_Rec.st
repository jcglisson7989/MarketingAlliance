
ACTION Action_Set_Active_Rec: 

	gRecipe_CSV_UIConnect.Recipe.List.SelectedIndex := 0;
	
	FOR ii_recipes := 0 TO MAX_IDX_TOTAL_RECIPES BY 1 DO
		IF (brsstrcmp(ADR(gRecipe_CSV_UIConnect.Recipe.List.Names[gRecipe_CSV_UIConnect.Recipe.List.SelectedIndex]), ADR(gRecipeName)) = 0) THEN
			EXIT;
		ELSE
			gRecipe_CSV_UIConnect.Recipe.List.StepDown := 1;
			Recipe_CSV_UI();
		END_IF;
	END_FOR;
	
END_ACTION
