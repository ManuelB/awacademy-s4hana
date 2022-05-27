*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 23.05.2022 at 10:15:02
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZISU_FP_KUNDEN..................................*
DATA:  BEGIN OF STATUS_ZISU_FP_KUNDEN                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZISU_FP_KUNDEN                .
CONTROLS: TCTRL_ZISU_FP_KUNDEN
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZISU_FP_KUNDEN                .
TABLES: ZISU_FP_KUNDEN                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
