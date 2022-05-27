*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 25.05.2022 at 13:42:23
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZS05_KUNDE_DEMO.................................*
DATA:  BEGIN OF STATUS_ZS05_KUNDE_DEMO               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZS05_KUNDE_DEMO               .
CONTROLS: TCTRL_ZS05_KUNDE_DEMO
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZS05_KUNDE_DEMO               .
TABLES: ZS05_KUNDE_DEMO                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
