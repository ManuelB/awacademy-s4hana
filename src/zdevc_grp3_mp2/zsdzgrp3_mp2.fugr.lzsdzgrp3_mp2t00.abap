*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 12.05.2022 at 15:21:10
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZGRP3_BEWEGUNGEN................................*
DATA:  BEGIN OF STATUS_ZGRP3_BEWEGUNGEN              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_BEWEGUNGEN              .
CONTROLS: TCTRL_ZGRP3_BEWEGUNGEN
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZGRP3_FILSTAMM..................................*
DATA:  BEGIN OF STATUS_ZGRP3_FILSTAMM                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_FILSTAMM                .
CONTROLS: TCTRL_ZGRP3_FILSTAMM
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZGRP3_BEWEGUNGEN              .
TABLES: *ZGRP3_FILSTAMM                .
TABLES: ZGRP3_BEWEGUNGEN               .
TABLES: ZGRP3_FILSTAMM                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
