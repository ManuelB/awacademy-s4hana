*&---------------------------------------------------------------------*
*& Report Z_S09_TABELLEN_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_tabellen_sorted.

TYPES: BEGIN OF lty_s_benutzer,
         id(8)     TYPE c,
         vname(10) TYPE c,
         nname(10) TYPE c,
       END OF lty_s_benutzer,

       lty_t_benutzer TYPE SORTED TABLE OF lty_s_benutzer.

"DATA lt_benutzer TYPE lty_t_benutzer.

DATA ls_benutzer TYPE lty_s_benutzer.
DATA lt_benutzer TYPE SORTED TABLE OF lty_s_benutzer WITH UNIQUE KEY id. "Schlüsselfelder müssen bei sortierten Tabellen angegeben werden!"


"Das ist unser Datenbestand"

ls_benutzer-id =  'ID000001'.
ls_benutzer-vname = |Max|.    "ls, local struktur"
ls_benutzer-nname = |Mustermann|.


APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id =  'ID000002'.
ls_benutzer-vname = |Erika|.
ls_benutzer-nname = |Sonnenschein|.

APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id =  'ID000003'.
ls_benutzer-vname = |Hans|.
ls_benutzer-nname = |Imglück|.

APPEND ls_benutzer TO lt_benutzer.

CLEAR ls_benutzer.

"---------------------------------------"
"Neuen Nutzer hinzufügen:"

"READ TABLE lt_benutzer INTO ls_benutzer WITH TABLE KEY id. "TRANSPORTING NO FIELDS

DATA: lv_new_id TYPE i.
DATA: lv_max_id TYPE i.
DATA: lv_max_id_c(6) TYPE n.
DATA: dummy TYPE string.
DATA: lv_zeilenanzahl TYPE i.


ls_benutzer-id =  'ID000002'.
ls_benutzer-vname = |Erika|.
ls_benutzer-nname = |Sonnenschein|.


LOOP AT lt_benutzer INTO ls_benutzer WHERE id EQ ls_benutzer-id.
  "Springt in den Loop wenn eine BenutzerID schon vorhanden ist"

ENDLOOP.

IF sy-subrc <> 0.
  APPEND ls_benutzer TO lt_benutzer.

ELSE.

  WRITE:  |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben! (LOOP)|.
  MESSAGE: |Benutzer mit der ID: { ls_benutzer-id } ist schon vergeben! (LOOP)| TYPE 'S' DISPLAY LIKE 'E'.

"Annahme der Namenskonvention für Bentuzer: ID<laufende Nummer>.



  DESCRIBE TABLE lt_benutzer LINES lv_zeilenanzahl.
  READ TABLE lt_benutzer INDEX lv_zeilenanzahl INTO ls_benutzer.

  SPLIT ls_benutzer AT 'ID' INTO dummy lv_max_id_c.

  ADD 1 TO lv_max_id_c.

  ls_benutzer-id = |ID{ lv_max_id_c }|.
  WRITE: / | Die nächste freie ID wäre: { ls_benutzer-id }|.



ENDIF.

APPEND ls_benutzer TO lt_benutzer.


"BREAK-POINT.
