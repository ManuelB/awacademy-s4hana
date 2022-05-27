*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/28/2022 at 14:28:17
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS06_FLIGHTS....................................*
DATA:  BEGIN OF STATUS_ZS06_FLIGHTS                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS06_FLIGHTS                  .
CONTROLS: TCTRL_ZS06_FLIGHTS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZS06_FLIGHTS                  .
TABLES: ZS06_FLIGHTS                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
