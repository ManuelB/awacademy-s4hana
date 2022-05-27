*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZGRP3_BESTANDFG
*   generation date: 14.05.2022 at 08:21:41
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZGRP3_BESTANDFG    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
