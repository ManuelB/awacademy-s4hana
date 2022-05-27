*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZS06_FG_FLIGHTS
*   generation date: 03/28/2022 at 14:28:17
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZS06_FG_FLIGHTS    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
