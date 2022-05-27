*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZS07_FG_FLIGHT
*   generation date: 03/28/2022 at 14:13:49
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZS07_FG_FLIGHT     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
