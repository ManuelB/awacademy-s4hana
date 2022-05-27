*&---------------------------------------------------------------------*
*& Report Z_S06_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_tabellen.

TYPES: BEGIN OF lty_s_user,
         vname(20) TYPE c,
         nname(20) TYPE c,
         alter     TYPE i,
         urlaub    TYPE i,
       END OF lty_s_user
       .
**********************************************************************       .
DATA ls_user TYPE lty_s_user.
DATA lt_user TYPE TABLE OF lty_s_user.
"DATA lt_user TYPE STANDARD TABLE OF lty_s_user.
**********************************************************************
ls_user-vname = 'Heinz'.
ls_user-nname = 'Kriete'.
ls_user-alter = 66.
ls_user-urlaub = 21.
APPEND ls_user TO lt_user.

ls_user-vname = 'Peter'.
ls_user-nname = 'Reuter'.
ls_user-alter = 49.
ls_user-urlaub = 21.
APPEND ls_user TO lt_user.

ls_user-vname = 'Christian'.
ls_user-nname = 'Schmidt'.
ls_user-alter = 25.
ls_user-urlaub = 21.
APPEND ls_user TO lt_user.

ls_user-vname = 'Louis'.
ls_user-nname = 'Wagner'.
ls_user-alter = 27.
ls_user-urlaub = 21.
APPEND ls_user TO lt_user.

ls_user-vname = 'David'.
ls_user-nname = 'Schpielvogel'.
ls_user-alter = 48.
ls_user-urlaub = 21.

"Vorsicht, duppelte datensatz.
ls_user-vname = 'David'.
ls_user-nname = 'Schpielvogel'.
ls_user-alter = 48.
ls_user-urlaub = 21.

APPEND ls_user TO lt_user.

**********************************************************************
DATA lv_descr(13) TYPE c.

CLEAR: ls_user.

SORT lt_user BY nname DESCENDING alter DESCENDING.

DELETE ADJACENT DUPLICATES FROM lt_user. "Vorsicht, Tabelle vorher Sortieren!

LOOP AT lt_user INTO ls_user.
  IF ls_user-alter GE 35.
    ls_user-urlaub = 32.
  ELSE.
    ls_user-urlaub = 30.
  ENDIF.

  MODIFY lt_user FROM ls_user INDEX sy-tabix.

  READ TABLE lt_user INDEX sy-tabix INTO ls_user.

  IF sy-subrc <> 0.
    MESSAGE: |Fehler bei Auslesen der Nutzerwerte. RC: { sy-subrc }| TYPE 'E'.
  ENDIF.
  "Ausgabe der Benutzerdaten.**********************************************************************
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
