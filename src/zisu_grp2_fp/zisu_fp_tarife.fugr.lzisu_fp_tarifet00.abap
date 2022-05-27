*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 05/23/2022 at 12:15:04
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZISU_FP_TARIFE..................................*
DATA:  BEGIN OF STATUS_ZISU_FP_TARIFE                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZISU_FP_TARIFE                .
CONTROLS: TCTRL_ZISU_FP_TARIFE
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZISU_FP_TARIFE                .
TABLES: ZISU_FP_TARIFE                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
