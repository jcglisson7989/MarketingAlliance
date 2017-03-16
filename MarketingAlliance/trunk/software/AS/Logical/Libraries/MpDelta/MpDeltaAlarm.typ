
TYPE
    MpDeltaAlarmEnum : 
        ( (* Alarms of MpDelta Library *)
        mpDELTA_ALM_SYSTEM_ERROR := 0, (* General error in the robot system *)
        mpDELTA_ALM_INITIALIZATION := 1, (* Initialization failed *)
        mpDELTA_ALM_END_OF_WORKSPACE := 2, (* Robot reached end of workspace *)
        mpDELTA_ALM_VIOLATE_WORKSPACE := 3, (* Robot program violates workspace (+ ErrorCode as add.Info) *)
        mpDELTA_ALM_PROGRAM_SYNTAX := 4, (* Syntax errors in robot program (+ ErrorCode as add.Info) *)
        mpDELTA_ALM_PROGRAM_MISSING := 5, (* Robot program does not exist *)
        mpDELTA_ALM_PATH_VEL_MISSING := 6 (* Path velocity not defined for a block movement in robot program *)
    );
END_TYPE
