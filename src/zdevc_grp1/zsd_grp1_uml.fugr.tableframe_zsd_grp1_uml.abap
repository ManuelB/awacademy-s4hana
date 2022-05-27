*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZSD_GRP1_UML
*   generation date: 15.05.2022 at 11:08:45
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZSD_GRP1_UML       .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
