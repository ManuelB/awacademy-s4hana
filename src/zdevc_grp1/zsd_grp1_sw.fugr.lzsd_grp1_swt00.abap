*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 21.04.2022 at 15:50:01
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSD_GRP1_SW.....................................*
DATA:  BEGIN OF STATUS_ZSD_GRP1_SW                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP1_SW                   .
CONTROLS: TCTRL_ZSD_GRP1_SW
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: *ZSD_GRP1_SW                   .
TABLES: ZSD_GRP1_SW                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
