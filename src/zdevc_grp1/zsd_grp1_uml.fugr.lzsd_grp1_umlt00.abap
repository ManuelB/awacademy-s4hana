*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 15.05.2022 at 11:08:45
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSD_GRP1_UML....................................*
DATA:  BEGIN OF STATUS_ZSD_GRP1_UML                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSD_GRP1_UML                  .
CONTROLS: TCTRL_ZSD_GRP1_UML
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZSD_GRP1_UML                  .
TABLES: ZSD_GRP1_UML                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
