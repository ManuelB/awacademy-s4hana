*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 11.05.2022 at 14:27:22
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSD_GRP1_BES....................................*
DATA:  BEGIN OF STATUS_ZSD_GRP1_BES                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP1_BES                  .
CONTROLS: TCTRL_ZSD_GRP1_BES
            TYPE TABLEVIEW USING SCREEN '0005'.
*...processing: ZSD_GRP1_FS.....................................*
DATA:  BEGIN OF STATUS_ZSD_GRP1_FS                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP1_FS                   .
CONTROLS: TCTRL_ZSD_GRP1_FS
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: *ZSD_GRP1_BES                  .
TABLES: *ZSD_GRP1_FS                   .
TABLES: ZSD_GRP1_BES                   .
TABLES: ZSD_GRP1_FS                    .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
