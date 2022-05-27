*&---------------------------------------------------------------------*
*& Report Z_S12_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_tabellen.

TYPES: BEGIN OF lty_s_user, "Strukturtyp
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user
       .

DATA ls_user TYPE lty_s_user. "lokale Struktur _ user
DATA lt_user TYPE TABLE OF lty_s_user. "Interne Tabelle des Types unseres Strukturtypes #deutsch
*DATA lt_user TYPE STANDARD TABLE OF lty_s_user "Ist Equivalent zum obrigen Code

***************************************************************************************************************
*Befüllung der Tabelle
***************************************************************************************************************


ls_user-vname = |Heinz|.
ls_user-nname = |Wurst|.
ls_user-alter = 78.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt

ls_user-vname = |Gisela|.
ls_user-nname = |Stein|.
ls_user-alter = 45.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt

ls_user-vname = |Hansi|.
ls_user-nname = |Horstl|.
ls_user-alter = 56.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt

ls_user-vname = |Franziska|.
ls_user-nname = |Bier|.
ls_user-alter = 34.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt

ls_user-vname = |Uschi|.
ls_user-nname = |Glas|.
ls_user-alter = 66.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt

ls_user-vname = |Julia|.
ls_user-nname = |Gerlitz|.
ls_user-alter = 35.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt

*Vorsicht gleicher Datensatz
ls_user-vname = |Julia|.
ls_user-nname = |Gerlitz|.
ls_user-alter = 35.
APPEND ls_user TO lt_user. "Die Struktur ls_user wird lt_user angehängt
"APPEND fügt eine neue Zeile hinzu

***************************************************************************************************************
*Auslesen der Tabelle
***************************************************************************************************************
CLEAR: ls_user.
*Schleife in der lokalen Tabelle_user und überträgt diese in die lokale Struktur_user
DATA lv_descr(13) TYPE c.
*LOOP AT lt_user INTO ls_user WHERE alter GE 50. "bestimmte Zeile in der Tabelle auf welche XY zutrifft
*  WRITE: / |Nachname:| , ls_user-nname.
*  IF ls_user-alter GE 50.
*    ls_user-urlaub = lv_urlaub + 2.
*  ELSE.
*    ls_user-urlaub = lv_urlaub.
*  ENDIF.
*  WRITE: / |Urlaubstage:| , ls_user-urlaub.
*
*ENDLOOP.
*WRITE: / |Nachname:| , ls_user-nname.
*WRITE: / |Urlaubstage:| , ls_user-urlaub.
ULINE.
WRITE: / | Lösung: |.
SORT lt_user BY nname DESCENDING alter DESCENDING.

delete ADJACENT DUPLICATES FROM lt_user. "Muss vorher sortiert worden sein, damit das Kommando funktioniert, damit diese benachbart sind
LOOP AT lt_user INTO ls_user.
  IF ls_user-alter GE 50.
    ls_user-urlaub = 32.
  ELSE.
    ls_user-urlaub = 30.

  ENDIF.
  MODIFY lt_user FROM ls_user INDEX sy-tabix. "lokaleTabelle muss modifiziert werden von loaklenUser bei INDEX --> sy-tabix
  "welche Daten sollen modifiziert werden und wo sollen sie hin
  "normale Systemfelder --> sy-index
  CLEAR ls_user.
  "DELETE lt_user INDEX sy-tabix. "Löscht aktuellen Eintrag aus der Tabelle
  READ TABLE lt_user INDEX sy-tabix INTO ls_user."liest lokaleTabelle und befüllt die lokaleStruktur mit unseren akutellen Zeilen-Werten
  IF sy-subrc <> 0.
    MESSAGE: |Fehler bei Auslesen der Nutzerwerte. RC: { sy-subrc }| TYPE 'E'.
  ENDIF.
  uline.
  lv_descr = |Vorname:|.
  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-vname ALIGN = LEFT }|.
  lv_descr = |Nachname:|.
  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-nname ALIGN = LEFT }|.
  lv_descr = |Alter:|.
  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-alter ALIGN = LEFT }|.
  lv_descr = |Urlaubstage:|.
  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-urlaub ALIGN = LEFT }|.


ENDLOOP.

*BREAK-POINT.
