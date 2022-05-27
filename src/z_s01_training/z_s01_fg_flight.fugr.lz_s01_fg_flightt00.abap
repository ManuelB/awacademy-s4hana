*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03/30/2022 at 09:40:06
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS01_FLIGHT.....................................*
DATA:  BEGIN OF STATUS_ZS01_FLIGHT                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS01_FLIGHT                   .
CONTROLS: TCTRL_ZS01_FLIGHT
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZS01_VPF_PFLIGHT................................*
TABLES: ZS01_VPF_PFLIGHT, *ZS01_VPF_PFLIGHT. "view work areas
CONTROLS: TCTRL_ZS01_VPF_PFLIGHT
TYPE TABLEVIEW USING SCREEN '0003'.
DATA: BEGIN OF STATUS_ZS01_VPF_PFLIGHT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZS01_VPF_PFLIGHT.
* Table for entries selected to show on screen
DATA: BEGIN OF ZS01_VPF_PFLIGHT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZS01_VPF_PFLIGHT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZS01_VPF_PFLIGHT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZS01_VPF_PFLIGHT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZS01_VPF_PFLIGHT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZS01_VPF_PFLIGHT_TOTAL.

*.........table declarations:.................................*
TABLES: *ZS01_FLIGHT                   .
TABLES: ZS01_FLIGHT                    .
TABLES: ZS01_SCARR                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
