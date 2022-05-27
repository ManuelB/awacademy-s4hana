*&---------------------------------------------------------------------*
*& Report Z_S02_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_tabellen.


"Schritt 1: Struktur erzeugen

TYPES: BEGIN OF lty_s_user,
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user
       .
******************
*Tabell befüllen (unten dann Auslesen
********************


DATA ls_user TYPE lty_s_user.

" Schritt2: Tabelle aus der Struktur erzeugen.
DATA lt_user TYPE TABLE OF lty_s_user.
*DATA lt_user TYPE STANDARD TABLE OF lty_s_user. "Equivalent

ls_user-vname = 'Heini'.
ls_user-nname = 'Müller'.
ls_user-alter = 66.

"hänge die Struktur der Tabelle an.
APPEND ls_user TO lt_user.


ls_user-vname = 'Freddy'.
ls_user-nname = 'Krüger'.
ls_user-alter = 24.
APPEND ls_user TO lt_user.

ls_user-vname = 'Benjamin'.
ls_user-nname = 'Blümchen'.
ls_user-alter = 15.
APPEND ls_user TO lt_user.

ls_user-vname = 'Jolante'.
ls_user-nname = 'Hauser'.
ls_user-alter = 43.
APPEND ls_user TO lt_user.

*Achtung, zwei gleiche Datensätze folgen. Es gibt doppelte Werte, das ist Scheissendreck.
* Lösung ELETE ADJACENT DUPLICATES FROM lt_user. *Dupplikate, die hintereinander stehen, löschen.
ls_user-vname = 'Johanna'.
ls_user-nname = 'Bach'.
ls_user-alter = 89.
APPEND ls_user TO lt_user.

ls_user-vname = 'Johanna'.
ls_user-nname = 'Bach'.
ls_user-alter = 89.
APPEND ls_user TO lt_user.

*****************
* Tabelle auslesen. Normal hat man eine Quelle der Daten, darum auslesen und in die Struktur schreiben.
*******************


*CLEAR: ls_user.

LOOP AT lt_user INTO ls_user WHERE alter GE 30. "Where = Bedingung, bestimmte Spalte der Tabelle
  WRITE: / 'Nachname: ', ls_user-nname.
ENDLOOP.



*ls_user-vname = 'Felix'.
*ls_user-nname = 'Penix'.
*ls_user-alter = 33.
*ls_user-urlaub = ls_user-alter * 2.
*APPEND ls_user TO lt_user.
*
*WRITE: / ls_user-urlaub.
*
*
**BREAK-POINT.
*
*
*DATA lv_descr(13) TYPE c.
*
*CLEAR: ls_user.
*
*LOOP AT lt_user INTO ls_user. "WHERE Alter GE 35.
*
*ENDLOOP.



*****************
*Lösung Robin
******************

*CLEAR ls_user.
*
*SORT lt_user BY nname ASCENDING alter DESCENDING. "Tabelle Sortieren nach Nachname und nach Alter.
*DELETE ADJACENT DUPLICATES FROM lt_user. "Dupplikate, die hintereinander stehen, löschen.
*
*
*
*loop at lt_user into ls_user. "WHERE alter GE 35 AND ( urlaub LE 24 or nname EQ 'KRIETE' ).
*
*IF ls_user-alter GE 35.
*  ls_user-urlaub = 32.
*ELSE.
*  ls_user-urlaub = 30.
*ENDIF.
*
*MODIFY lt_user FROM ls_user INDEX sy-tabix. "zur Laufzeit der Schleife ist die STruktur sy-tabix (system Tabellenindex. Steht auch im Debugger oben
*
*
*CLEAR ls_user.
*
*READ TABLE lt_user INDEX sy-tabix INTO ls_user.
*IF sy-subrc <> 0.
*  MESSAGE: |Fehler bei Auslesen der Nutzerwerte. RC:{ sy-subrc }| TYPE 'E'. "Fall irgendwo kein Wert drin wäre, käme eine Fehlermeldung.
*ENDIF.
*
*
** Ausgabe der Benutzerdaten. *****************************************
*
*WRITE: / 'Nachname', ls_user-vname.
*WRITE: / 'Alter', ls_user-alter.
*WRITE: / 'Urlaub', ls_user-urlaub.
*
*ULINE.
*ENDLOOP.
