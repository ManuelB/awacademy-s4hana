*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZS05_MINIDEMO
*   generation date: 23.04.2022 at 08:32:24
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZS05_MINIDEMO      .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
