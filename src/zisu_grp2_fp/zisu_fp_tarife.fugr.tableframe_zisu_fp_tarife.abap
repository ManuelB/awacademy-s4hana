*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZISU_FP_TARIFE
*   generation date: 05/23/2022 at 12:15:03
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZISU_FP_TARIFE     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
