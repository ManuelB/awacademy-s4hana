*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 12.05.2022 at 15:25:22
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZGRP3_SWEETS....................................*
DATA:  BEGIN OF STATUS_ZGRP3_SWEETS                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_SWEETS                  .
CONTROLS: TCTRL_ZGRP3_SWEETS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZGRP3_SWEETS                  .
TABLES: ZGRP3_SWEETS                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
