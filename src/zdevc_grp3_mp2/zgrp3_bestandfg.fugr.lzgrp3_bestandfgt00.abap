*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 14.05.2022 at 08:21:41
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZGRP3_BESTAND...................................*
DATA:  BEGIN OF STATUS_ZGRP3_BESTAND                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_BESTAND                 .
CONTROLS: TCTRL_ZGRP3_BESTAND
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZGRP3_BESTAND                 .
TABLES: ZGRP3_BESTAND                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
