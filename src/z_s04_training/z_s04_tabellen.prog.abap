*&---------------------------------------------------------------------*
*& Report Z_S04_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_tabellen.

TYPES: BEGIN OF lty_s_user,
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user.

DATA ls_user TYPE lty_s_user.
DATA lt_user TYPE TABLE OF lty_s_user.
"DATA lt_user TYPE STANDARD TABLE OF lty_s_user.


**********************************************************************
*Befüllen der Tabelle:

ls_user-vname = 'Horst'.
ls_user-nname = 'Hubertus'.
ls_user-alter = 66.
APPEND ls_user TO lt_user.

ls_user-vname = 'Mira'.
ls_user-nname = 'Müller'.
ls_user-alter = 32.
APPEND ls_user TO lt_user.

ls_user-vname = 'Kevin'.
ls_user-nname = 'Calvin'.
ls_user-alter = 54.
APPEND ls_user TO lt_user.

ls_user-vname = 'Chantal'.
ls_user-nname = 'Meier'.
ls_user-alter = 28.
APPEND ls_user TO lt_user.

ls_user-vname = 'Gandalf-Merlin'.
ls_user-nname = 'Huber'.
ls_user-alter = 18.
APPEND ls_user TO lt_user.

ls_user-vname = 'Johann'.
ls_user-nname = 'Huber'.
ls_user-alter = 48.
APPEND ls_user TO lt_user.

*Doppelter Datensatz
ls_user-vname = 'Mira'.
ls_user-nname = 'Müller'.
ls_user-alter = 32.
APPEND ls_user TO lt_user.



**********************************************************************
*Auslesen der Tabelle:


DATA lv_descr(13) TYPE c.

CLEAR ls_user.

SORT lt_user BY nname DESCENDING alter ASCENDING. "Sortiert nach nname absteigend, alter aufsteigend.


DELETE ADJACENT DUPLICATES FROM lt_user. "Löscht doppelte Sätze, Vorsicht! Tabelle vorher sortieren!


LOOP AT lt_user INTO ls_user. " WHERE alter GE 35.

  IF ls_user-alter GE 35.
    ls_user-urlaub = 32.
  ELSE.
    ls_user-urlaub = 30.
  ENDIF.

  MODIFY lt_user FROM ls_user INDEX sy-tabix.


  CLEAR ls_user.

  READ TABLE lt_user INDEX sy-tabix INTO ls_user. "TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    MESSAGE: |Fehler bei Auslesen der Nutzerwerte. RC:{ sy-subrc }| TYPE 'E'.
  ENDIF.



**********************************************************************
*Ausgabe der Benutzerdaten:

  lv_descr = |Vorname:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-vname ALIGN = LEFT }|.
  lv_descr = |Nachname:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-nname ALIGN = LEFT }|.
  lv_descr = |Alter:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-alter ALIGN = LEFT }|.
  lv_descr = |Urlaubstage:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-urlaub ALIGN = LEFT }|.

  ULINE.
ENDLOOP.


*BREAK-POINT.
