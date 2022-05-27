*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 23.04.2022 at 08:32:25
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS05_MINIDEMO...................................*
DATA:  BEGIN OF STATUS_ZS05_MINIDEMO                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS05_MINIDEMO                 .
CONTROLS: TCTRL_ZS05_MINIDEMO
            TYPE TABLEVIEW USING SCREEN '0005'.
*.........table declarations:.................................*
TABLES: *ZS05_MINIDEMO                 .
TABLES: ZS05_MINIDEMO                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
