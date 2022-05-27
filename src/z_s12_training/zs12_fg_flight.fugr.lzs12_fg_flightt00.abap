*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/30/2022 at 09:40:45
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS12_FLIGHT.....................................*
DATA:  BEGIN OF STATUS_ZS12_FLIGHT                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS12_FLIGHT                   .
CONTROLS: TCTRL_ZS12_FLIGHT
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZS12_V_PF_FLIGHT................................*
TABLES: ZS12_V_PF_FLIGHT, *ZS12_V_PF_FLIGHT. "view work areas
CONTROLS: TCTRL_ZS12_V_PF_FLIGHT
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_ZS12_V_PF_FLIGHT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZS12_V_PF_FLIGHT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZS12_V_PF_FLIGHT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZS12_V_PF_FLIGHT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZS12_V_PF_FLIGHT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZS12_V_PF_FLIGHT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZS12_V_PF_FLIGHT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZS12_V_PF_FLIGHT_TOTAL.

*.........table declarations:.................................*
TABLES: *ZS12_FLIGHT                   .
TABLES: ZS12_FLIGHT                    .
TABLES: ZS12_SCARR                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
