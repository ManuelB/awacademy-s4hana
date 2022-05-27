*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 27.05.2022 at 08:17:40
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZGRP3_KUNDE.....................................*
DATA:  BEGIN OF STATUS_ZGRP3_KUNDE                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_KUNDE                   .
CONTROLS: TCTRL_ZGRP3_KUNDE
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZGRP3_LIEFWE....................................*
DATA:  BEGIN OF STATUS_ZGRP3_LIEFWE                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_LIEFWE                  .
CONTROLS: TCTRL_ZGRP3_LIEFWE
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZGRP3_STRANB....................................*
DATA:  BEGIN OF STATUS_ZGRP3_STRANB                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_STRANB                  .
CONTROLS: TCTRL_ZGRP3_STRANB
            TYPE TABLEVIEW USING SCREEN '0009'.
*...processing: ZGRP3_TARIFE....................................*
DATA:  BEGIN OF STATUS_ZGRP3_TARIFE                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_TARIFE                  .
CONTROLS: TCTRL_ZGRP3_TARIFE
            TYPE TABLEVIEW USING SCREEN '0007'.
*...processing: ZGRP3_TSTATUS...................................*
DATA:  BEGIN OF STATUS_ZGRP3_TSTATUS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZGRP3_TSTATUS                 .
CONTROLS: TCTRL_ZGRP3_TSTATUS
            TYPE TABLEVIEW USING SCREEN '0005'.
*.........table declarations:.................................*
TABLES: *ZGRP3_KUNDE                   .
TABLES: *ZGRP3_LIEFWE                  .
TABLES: *ZGRP3_STRANB                  .
TABLES: *ZGRP3_TARIFE                  .
TABLES: *ZGRP3_TSTATUS                 .
TABLES: ZGRP3_KUNDE                    .
TABLES: ZGRP3_LIEFWE                   .
TABLES: ZGRP3_STRANB                   .
TABLES: ZGRP3_TARIFE                   .
TABLES: ZGRP3_TSTATUS                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
