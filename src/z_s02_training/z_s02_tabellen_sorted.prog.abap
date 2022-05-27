*&---------------------------------------------------------------------*
*& Report Z_S02_TABELLEN_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_TABELLEN_SORTED.



TYPES: BEGIN OF lty_s_benutzer,
  id(8) TYPE c,
  vname(10) TYPE c,
  nname(19) TYPE c,
  END OF lty_s_benutzer,    "Kettensatz



  lty_t_benutzer TYPE SORTED TABLE OF lty_s_benutzer.

  DATA ls_benutzer TYPE lty_s_benutzer.

  DATA lt_benutzer TYPE SORTED TABLE OF lty_s_benutzer WITH UNIQUE KEY id.  " im code muss man angeben, wo die Schlüsselfelder sind.

  DATA lv_zeilenanzahl TYPE i.
  DATA dummy TYPE c.
  DATA lv_max_id_c TYPE i.

CLEAR ls_benutzer.

****
* Datenbestand
****

  ls_benutzer-id = 'ID000001'.
  ls_benutzer-vname = 'Heinz'.
  ls_benutzer-nname = 'Kriete'.
APPEND ls_benutzer TO lt_benutzer.

  ls_benutzer-id = 'ID000002'.
  ls_benutzer-vname = 'Max'.
  ls_benutzer-nname = 'Mustermann'.
APPEND ls_benutzer TO lt_benutzer.

  ls_benutzer-id = 'ID000003'.
  ls_benutzer-vname = 'Freddy'.
  ls_benutzer-nname = 'Krüger'.
APPEND ls_benutzer TO lt_benutzer.


**************
* neuen Nutzer hinzufügen: - wie überprüfen, ob es den schon gibt?

*READ TABLE lt_benutzer INTO ls_benutzer WITH KEY id.

  ls_benutzer-id = 'ID000002'.
  ls_benutzer-vname = 'Max'.
  ls_benutzer-nname = 'Mustermann'.

LOOP AT lt_benutzer INTO ls_benutzer WHERE id EQ ls_benutzer-id. "
ENDLOOP.

IF sy-subrc <> 0.
  APPEND ls_benutzer TO lt_benutzer.
  ELSE.
    MESSAGE: |Benutzer mit der ID: { ls_benutzer-id } schon vergeben!| TYPE 'S'. " Type S bricht nichth hart ab wie Type E.


*LOOP AT lt_benutzer INTO ls_benutzer.
*ENDLOOP.

*DESCRIBE TABLE lt_benutzer LINES lv_zeilenanzahl.
READ TABLE lt_benutzer INDEX lv_zeilenanzahl INTO ls_benutzer.

SPLIT ls_benutzer-id AT 'ID' INTO dummy lv_max_id_c. " wenn man splittet, muss man immer  zwei Zielveriablen angeben.
ADD 1 TO lv_max_id_c.

ls_benutzer-id = |ID{ lv_max_id_c }|.
WRITE / | Die nächste freie ID wäre: {ls_benutzer-id }|.



ENDIF.

APPEND ls_benutzer TO lt_benutzer.


*BREAK-POINT.


* Praxisproblem: wie rausfinden, welches die nächste zu vergebende ID ist?
* Aufgabe: ich möchte die nächste BenutzerID. Schritt 1: letzte Zeile finden. Schritt 2: Letzte Zeile +1 = nächste ID.


*READ TABLE lt_benutzer SEARCH FKGE
*
*IF ls_benutzer-id > .
*
*ENDIF..
*
*ENDLOOP.




****
* Robins Lösung
****

* Letzte Zeile finden:
