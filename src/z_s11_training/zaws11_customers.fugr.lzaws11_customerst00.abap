*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/28/2022 at 21:54:26
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAWS11_CUSTOMERS................................*
DATA:  BEGIN OF STATUS_ZAWS11_CUSTOMERS              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAWS11_CUSTOMERS              .
CONTROLS: TCTRL_ZAWS11_CUSTOMERS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAWS11_CUSTOMERS              .
TABLES: ZAWS11_CUSTOMERS               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
