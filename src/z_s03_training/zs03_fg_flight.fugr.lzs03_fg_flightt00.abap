*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/28/2022 at 14:13:20
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS03_FLIGHT.....................................*
DATA:  BEGIN OF STATUS_ZS03_FLIGHT                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS03_FLIGHT                   .
CONTROLS: TCTRL_ZS03_FLIGHT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZS03_FLIGHT                   .
TABLES: ZS03_FLIGHT                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
