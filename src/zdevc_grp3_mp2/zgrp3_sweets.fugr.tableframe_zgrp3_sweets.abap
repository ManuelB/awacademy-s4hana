*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZGRP3_SWEETS
*   generation date: 12.05.2022 at 15:25:21
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZGRP3_SWEETS       .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
