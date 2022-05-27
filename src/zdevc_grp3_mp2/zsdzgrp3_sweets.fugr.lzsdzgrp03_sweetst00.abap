*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 23.04.2022 at 15:17:56
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZGRP03_SWEETS...................................*
DATA:  BEGIN OF STATUS_ZGRP03_SWEETS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP03_SWEETS                 .
CONTROLS: TCTRL_ZGRP03_SWEETS
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: *ZGRP03_SWEETS                 .
TABLES: ZGRP03_SWEETS                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
