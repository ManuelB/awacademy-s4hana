*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZSDZGRP3_MP2
*   generation date: 11.05.2022 at 14:09:22
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZSDZGRP3_MP2       .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
