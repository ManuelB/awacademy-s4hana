*&---------------------------------------------------------------------*
*& Report Z_S04_TABELLEN_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_tabellen_sorted.

TYPES: BEGIN OF lty_s_benutzer,
         id(6)     TYPE n,
         vname(10) TYPE c,
         nname(10) TYPE c,
       END OF lty_s_benutzer,

       lty_t_benutzer TYPE SORTED TABLE OF lty_s_benutzer.

"DATA lt_benutzer TYPE lty_s_benutzer.

DATA ls_benutzer TYPE lty_s_benutzer.
DATA lt_benutzer TYPE SORTED TABLE OF lty_s_benutzer WITH UNIQUE KEY id.

"Datenbestand

ls_benutzer-id = '00000001'.
ls_benutzer-vname = 'Horst'.
ls_benutzer-nname = 'Hubertus'.
APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id = '00000002'.
ls_benutzer-vname = 'Mira'.
ls_benutzer-nname = 'Müller'.
APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id = '00000003'.
ls_benutzer-vname = 'Scott'.
ls_benutzer-nname = 'Calvin'.
APPEND ls_benutzer TO lt_benutzer.

CLEAR ls_benutzer.


**********************************************************************
*Neuen Nutzer hinzufügen:
**********************************************************************


ls_benutzer-id = '00000002'.
ls_benutzer-vname = 'Max'.
ls_benutzer-nname = 'Mustermann'.



***Variante der Abfrage auf ID über READ TABLE.
*READ TABLE lt_benutzer WITH TABLE KEY id = ls_benutzer TRANSPORTING NO FIELDS.
*IF sy-subrc EQ 0.
*  WRITE: |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben!|.
*ENDIF.



*Variante der Abfrage auf ID über LOOP.
LOOP AT lt_benutzer INTO ls_benutzer WHERE id EQ ls_benutzer-id.
ENDLOOP.


IF sy-subrc <> 0.
  APPEND ls_benutzer TO lt_benutzer.
ELSE.
  WRITE: / |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben!|.
  MESSAGE: |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben!| TYPE 'S' DISPLAY LIKE 'E'.


  LOOP AT lt_benutzer INTO ls_benutzer.
  ENDLOOP.


  ADD 1 TO ls_benutzer-id.
  WRITE: |Nächste mögliche ID: { ls_benutzer-id }|.

ENDIF.







*BREAK-POINT.
