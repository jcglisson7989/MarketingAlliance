(********************************************************************
 * COPYRIGHT (C) BERNECKER + RAINER, AUSTRIA, A-5142 EGGELSBERG
 ********************************************************************
 * Library: TRF_LIB
 * File: TRF_LIB.fun
 ********************************************************************
 * Functions and function blocks of library TRF_LIB
 ********************************************************************)
FUNCTION TRF_init_instance    : UDINT (*initialization of all the stuff*)
    VAR_INPUT
        addr_var_name : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_generic          : UDINT (*generic function*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        cmd_code      : UDINT ;
        in_data       : UDINT ;
        out_data      : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_direct           : UDINT (*direct transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_direct2          : UDINT (*another type of direct transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_inverse          : UDINT (*inverse transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_inverse2         : UDINT (*another type of inverse transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_get_joints_pos   : UDINT (*positions of joints*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_get_size         : UDINT (*size of mechanical system in zero position*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_get_mode         : UDINT (*mode*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_direct3          : UDINT (*another type of direct transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_inverse3         : UDINT (*another type of inverse transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION






