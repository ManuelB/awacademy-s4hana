*&---------------------------------------------------------------------*
*& Report Z_S12_TABELLEN_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_tabellen_sorted.


TYPES: BEGIN OF lty_s_benutzer,
         id(8)     TYPE c,
         vname(10) TYPE c,
         nname(10) TYPE c,

       END OF lty_s_benutzer,

       lty_t_benutzer TYPE SORTED TABLE OF lty_s_benutzer.

*DATA lt_benutzer TYPE table lty_s_benutzer.

*DATA ls_benutzerid TYPE i.
*DATA lv_neueID(8) TYPE c.
*ls_benutzerid = ls_benutzer-id.
*data lv_benutzer-nutzerid type c.
*CONCATENATE ls_benutzer-num ls_benutzer-id '.' INTO lv_benutzer-nutzerid SEPARATED BY ':'.
DATA ls_benutzer TYPE lty_s_benutzer.
DATA lt_benutzer TYPE SORTED TABLE OF lty_s_benutzer WITH UNIQUE KEY id.
"Sortierte Tabellen Schlüsselfelder müssen bei der Typsisierung angegeben werden
"ID wird zum Schlüssel

ls_benutzer-id = |ID000001|.
ls_benutzer-vname = |Heinz|.
ls_benutzer-nname = |Wurst|.
APPEND ls_benutzer TO lt_benutzer. "Die Struktur ls_benutzer wird lt_benutzer angehängt

ls_benutzer-id = |ID000002|.
ls_benutzer-vname = |Gisela|.
ls_benutzer-nname = |Stein|.
APPEND ls_benutzer TO lt_benutzer.

ls_benutzer-id = |ID000003|.
ls_benutzer-vname = |Hansi|.
ls_benutzer-nname = |Horstl|.
APPEND ls_benutzer TO lt_benutzer.

CLEAR ls_benutzer.

*****************************************************************************************************************
*Neuen Benutzer hinzufügen
*READ table lt_benutzer into ls_benutzer WITH TABLE KEY id. "TRANSPORTING NO FIELDS.
ls_benutzer-id = |ID000003|.
ls_benutzer-vname = |Max|.
ls_benutzer-nname = |Mustermann|.
*APPEND ls_benutzer TO lt_benutzer.
"Nutzerdaten dürfen vorher nicht angehängt werden
DATA lv_nutzerid TYPE string.
DATA lv_new_id TYPE i.
DATA lv_max_id TYPE i.
DATA lv_max_id_c(6) TYPE n. "Typnumchar --> behält später die Nullen
DATA dummy TYPE string.
DATA lv_zeilenanzahl TYPE i.


*SORT lt_benutzer by id ASCENDING.
LOOP AT lt_benutzer INTO ls_benutzer WHERE id EQ ls_benutzer-id.
  "Springt in den Loop wenn eine BenutzerID schon vorhanden ist



ENDLOOP.
IF sy-subrc <> 0. "Ungleich 0
  APPEND ls_benutzer TO lt_benutzer.
ELSE.
*  message: |Benutzer mit dieser ID ist bereits vorhanden: { ls_benutzer-id }| type 'E'.
  "Fehlermeldung vom Typ E
*  lv_nutzerid = ls_benutzer-id + 2.
*  CONCATENATE ls_benutzer-id ls_benutzer-id+2 INTO lv_nutzerid.
*    WRITE: / |ls_benutzer-id|.

*********************************************************************************************************************
*Lösung
*Letzte Zeile der NutzerID finden
  LOOP AT lt_benutzer INTO ls_benutzer.
  ENDLOOP.
  "Alternative
  DESCRIBE TABLE lt_benutzer LINES lv_zeilenanzahl.
  READ TABLE lt_benutzer INDEX lv_zeilenanzahl INTO ls_benutzer.
  SPLIT ls_benutzer-id AT 'ID' INTO dummy lv_max_id_c.
  ADD 1 TO lv_max_id_c.

 ls_benutzer-id = |ID { lv_max_id_c }|.
  MESSAGE: |BenutzerID bereits Vorhanden! Die nächste freie BenutzerID wäre: { ls_benutzer-id }| TYPE 'I'.

ENDIF.



BREAK-POINT.
