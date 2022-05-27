*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZAWS11_CUSTOMERS
*   generation date: 03/28/2022 at 21:54:26
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZAWS11_CUSTOMERS   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
