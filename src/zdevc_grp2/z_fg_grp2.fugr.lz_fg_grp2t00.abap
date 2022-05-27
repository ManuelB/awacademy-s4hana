*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 15.05.2022 at 10:41:19
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSD_GRP2_ARST...................................*
DATA:  BEGIN OF STATUS_ZSD_GRP2_ARST                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP2_ARST                 .
CONTROLS: TCTRL_ZSD_GRP2_ARST
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZSD_GRP2_BES....................................*
DATA:  BEGIN OF STATUS_ZSD_GRP2_BES                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP2_BES                  .
CONTROLS: TCTRL_ZSD_GRP2_BES
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZSD_GRP2_FILBEST................................*
DATA:  BEGIN OF STATUS_ZSD_GRP2_FILBEST              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP2_FILBEST              .
CONTROLS: TCTRL_ZSD_GRP2_FILBEST
            TYPE TABLEVIEW USING SCREEN '0007'.
*...processing: ZSD_GRP2_UMLAG..................................*
DATA:  BEGIN OF STATUS_ZSD_GRP2_UMLAG                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP2_UMLAG                .
CONTROLS: TCTRL_ZSD_GRP2_UMLAG
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: *ZSD_GRP2_ARST                 .
TABLES: *ZSD_GRP2_BES                  .
TABLES: *ZSD_GRP2_FILBEST              .
TABLES: *ZSD_GRP2_UMLAG                .
TABLES: ZSD_GRP2_ARST                  .
TABLES: ZSD_GRP2_BES                   .
TABLES: ZSD_GRP2_FILBEST               .
TABLES: ZSD_GRP2_UMLAG                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
