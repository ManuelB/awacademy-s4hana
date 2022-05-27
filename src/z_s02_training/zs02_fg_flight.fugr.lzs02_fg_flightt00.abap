*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/29/2022 at 15:46:38
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS02_FLIGHT.....................................*
DATA:  BEGIN OF STATUS_ZS02_FLIGHT                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS02_FLIGHT                   .
CONTROLS: TCTRL_ZS02_FLIGHT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZS02_FLIGHT                   .
TABLES: ZS02_FLIGHT                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
