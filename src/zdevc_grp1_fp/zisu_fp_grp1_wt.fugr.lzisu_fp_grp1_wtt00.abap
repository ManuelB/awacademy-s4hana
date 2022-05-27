*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 24.05.2022 at 14:21:37
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSD_GRP1_FP_KS..................................*
DATA:  BEGIN OF STATUS_ZSD_GRP1_FP_KS                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP1_FP_KS                .
CONTROLS: TCTRL_ZSD_GRP1_FP_KS
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZSD_GRP1_FP_WT..................................*
DATA:  BEGIN OF STATUS_ZSD_GRP1_FP_WT                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP1_FP_WT                .
CONTROLS: TCTRL_ZSD_GRP1_FP_WT
            TYPE TABLEVIEW USING SCREEN '0003'.
*.........table declarations:.................................*
TABLES: *ZSD_GRP1_FP_KS                .
TABLES: *ZSD_GRP1_FP_WT                .
TABLES: ZSD_GRP1_FP_KS                 .
TABLES: ZSD_GRP1_FP_WT                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
