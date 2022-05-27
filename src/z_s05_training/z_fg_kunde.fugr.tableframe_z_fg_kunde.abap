*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_Z_FG_KUNDE
*   generation date: 25.05.2022 at 13:42:23
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_Z_FG_KUNDE         .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
