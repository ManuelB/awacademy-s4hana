*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 23.05.2022 at 15:52:09
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZISU_FP_WECHSEL.................................*
DATA:  BEGIN OF STATUS_ZISU_FP_WECHSEL               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZISU_FP_WECHSEL               .
CONTROLS: TCTRL_ZISU_FP_WECHSEL
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZISU_FP_WECHSEL               .
TABLES: ZISU_FP_WECHSEL                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
