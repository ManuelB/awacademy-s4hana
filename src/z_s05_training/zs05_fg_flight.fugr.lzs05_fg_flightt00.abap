*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/28/2022 at 17:49:29
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAWS05_FLIGHT...................................*
DATA:  BEGIN OF STATUS_ZAWS05_FLIGHT                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAWS05_FLIGHT                 .
CONTROLS: TCTRL_ZAWS05_FLIGHT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAWS05_FLIGHT                 .
TABLES: ZAWS05_FLIGHT                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
