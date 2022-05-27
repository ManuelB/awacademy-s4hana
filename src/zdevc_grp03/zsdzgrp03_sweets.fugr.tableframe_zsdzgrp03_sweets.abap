*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZSDZGRP03_SWEETS
*   generation date: 23.04.2022 at 15:17:55
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZSDZGRP03_SWEETS   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
