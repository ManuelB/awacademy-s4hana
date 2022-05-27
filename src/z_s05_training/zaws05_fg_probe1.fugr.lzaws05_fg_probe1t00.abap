*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/28/2022 at 17:40:29
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAWS05_PROBE1...................................*
DATA:  BEGIN OF STATUS_ZAWS05_PROBE1                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAWS05_PROBE1                 .
CONTROLS: TCTRL_ZAWS05_PROBE1
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAWS05_PROBE1                 .
TABLES: ZAWS05_PROBE1                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
