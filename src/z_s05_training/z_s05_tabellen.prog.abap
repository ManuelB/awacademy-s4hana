*&---------------------------------------------------------------------*
*& Report Z_S05_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_TABELLEN.

TYPES: BEGIN OF lty_s_user,
      vname(20) TYPE c,
      nname(20) TYPE c,
      alter     TYPE i,
      urlaub(2)    TYPE c ,
  END OF lty_s_user.

  DATA ls_user TYPE lty_s_user.
  DATA lt_user TYPE TABLE OF lty_s_user.
  "DATA lt_user TYPE STANDARD TABLE OF lty_s_user.

*******************************************
*Befühlung der Tabelle
*******************************

  ls_user-vname = 'Heinz'.
  ls_user-nname = 'Kriete'.
  ls_user-alter = 66.
APPEND ls_user TO lt_user.

ls_user-vname = |Max|.
ls_user-nname = |Mustermann|.
ls_user-alter = 25.
APPEND ls_user TO lt_user.

ls_user-vname = |Petra|.
ls_user-nname = |Berger|.
ls_user-alter = 36.
APPEND ls_user TO lt_user.

ls_user-vname = |Julia|.
ls_user-nname = |Berger|.
ls_user-alter = 64.
APPEND ls_user TO lt_user.

"Vorsicht, gleicher Daten.

ls_user-vname = |Julia|.
ls_user-nname = |Berger|.
ls_user-alter = 64.
APPEND ls_user TO lt_user.

ls_user-vname = |Julia|.
ls_user-nname = |Berger|.
ls_user-alter = 64.
APPEND ls_user TO lt_user.


ls_user-vname = |Paul|.
ls_user-nname = |Washington|.
ls_user-alter = 19.
APPEND ls_user TO lt_user.

ls_user-vname = |Manuel|.
ls_user-nname = |Muster|.
ls_user-alter = 40.
APPEND ls_user TO lt_user.

*******************************************
*Auslesen der Tabelle
********************************

CLEAR: ls_user.


SORT lt_user BY nname alter DESCENDING.

DELETE ADJACENT DUPLICATES FROM lt_user. "Vorsicht, Tabelle vorher sprtieren"



  LOOP AT lt_user INTO ls_user.

    If ls_user-alter GE 35.
      ls_user-urlaub = 32.
      ELSE.
      ls_user-urlaub = 30.
      ENDIF.

MODIFY lt_user from ls_user INDEX sy-tabix.

CLEAR ls_user.

READ TABLE lt_user INDEX sy-tabix INTO ls_user.
IF sy-subrc <> 0.
  MESSAGE: |Fehler bei Auslessen der Nutzerwerte. RC:{ sy-subrc }| TYPE 'E'.
  ENDIF.


WRITE:/ ls_user-nname,  'Urlaub: ', ls_user-urlaub.

      ULINE.
      ENDLOOP.




"+LOOP AT lt_user INTO ls_user WHERE alter GE 35.
  "WRITE:/ 'Nachname: ', ls_user-nname.
  "ENDLOOP.

  WRITE: / 'Urlaubstage für Mitarbeiter bis 40'.

  LOOP AT lt_user INTO ls_user WHERE alter LT 40.
    ls_user-urlaub = '28'.
    MODIFY lt_user index sy-tabix from ls_user-urlaub.
  WRITE:/ ls_user-nname,  'Urlaub: ', ls_user-urlaub.
  ENDLOOP.

CLEAR: ls_user.

"DEÖETE lt_user INDEX sy-tabix.

ULINE.

WRITE: / 'Urlaubstage für Mitarbeiter ab 40'.

   LOOP AT lt_user INTO ls_user WHERE alter GE 40.
     ls_user-urlaub = '30'.
    MODIFY lt_user index sy-tabix from ls_user-urlaub.
  WRITE:/ ls_user-nname,  'Urlaub: ', ls_user-urlaub.
  ENDLOOP.

  CLEAR: ls_user.


  """Richtig
