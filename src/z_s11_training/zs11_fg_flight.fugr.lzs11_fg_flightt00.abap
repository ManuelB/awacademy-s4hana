*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/30/2022 at 09:40:02
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS11_FLIGHT.....................................*
DATA:  BEGIN OF STATUS_ZS11_FLIGHT                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS11_FLIGHT                   .
CONTROLS: TCTRL_ZS11_FLIGHT
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZS11_V_PF_FLIGHT................................*
TABLES: ZS11_V_PF_FLIGHT, *ZS11_V_PF_FLIGHT. "view work areas
CONTROLS: TCTRL_ZS11_V_PF_FLIGHT
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_ZS11_V_PF_FLIGHT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZS11_V_PF_FLIGHT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZS11_V_PF_FLIGHT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZS11_V_PF_FLIGHT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZS11_V_PF_FLIGHT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZS11_V_PF_FLIGHT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZS11_V_PF_FLIGHT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZS11_V_PF_FLIGHT_TOTAL.

*.........table declarations:.................................*
TABLES: *ZS11_FLIGHT                   .
TABLES: ZS11_FLIGHT                    .
TABLES: ZS11_SCARR                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
