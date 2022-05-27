*&---------------------------------------------------------------------*
*& Report Z_S11_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_tabellen.

TYPES : BEGIN OF lty_s_user,
          vname(20) TYPE c,
          nname(20) TYPE c,
          alter     TYPE i,
          urlaub    TYPE p,
        END OF lty_s_user.

DATA ls_user TYPE lty_s_user.
DATA lt_user TYPE TABLE OF lty_s_user. "with header line. when it is used, with index is skipped in read table statement
*  Data lt_user type STANDARD TABLE OF lty_s_user.

ls_user-vname = 'Heinz'.
ls_user-nname = 'kriete'.
ls_user-alter = '66'.
APPEND ls_user TO lt_user.

ls_user-vname = 'Tom'.
ls_user-nname = 'Weinert'.
ls_user-alter = '40'.
APPEND ls_user TO lt_user.

ls_user-vname = |Emil|.
ls_user-nname = |Gales|.
ls_user-alter = |15|.
APPEND ls_user TO lt_user.

ls_user-vname = 'Sara'.
ls_user-nname = 'Blüh'.
ls_user-alter = '35'.
APPEND ls_user TO lt_user.

ls_user-vname = |Emil|.
ls_user-nname = |Gales|.
ls_user-alter = |15|.
APPEND ls_user TO lt_user.


WRITE:/ 'Table with Original no. of holidays'.
LOOP AT lt_user INTO ls_user.
  ls_user-urlaub = 30.
  MODIFY lt_user FROM ls_user.

* APPEND ls_user TO lt_user. "Threw runtime error(Resource bottleneck)

  WRITE :/ ls_user-vname, ls_user-nname, ls_user-alter, ls_user-urlaub.
ENDLOOP.

*WRITE :/ 'two less holidays for employees older than 20 years'.
*LOOP AT lt_user INTO ls_user WHERE alter GE 20.
*  ls_user-urlaub = 28.
*  MODIFY lt_user FROM ls_user.
*ENDLOOP.
*
*LOOP AT lt_user INTO ls_user.
*  WRITE :/ ls_user-vname, ls_user-nname, ls_user-alter, ls_user-urlaub.
*ENDLOOP.

WRITE :/ 'two less holidays for employees older than 20 years'.
LOOP AT lt_user INTO ls_user.
  IF ls_user-alter GE 20.
    ls_user-urlaub = 28.
    MODIFY lt_user FROM ls_user.
  ENDIF.
  WRITE :/ ls_user-vname, ls_user-nname, ls_user-alter, ls_user-urlaub.
ENDLOOP.


*Robins code.....

*DATA lv_descr(13) TYPE c.
*
**CLEAR: ls_user.
*
*SORT lt_user BY nname DESCENDING.
*
*DELETE ADJACENT DUPLICATES FROM lt_user. "Vorsicht, tabelle vorher sortieren.
*
*LOOP AT lt_user INTO ls_user.
*
*  IF ls_user-alter GE 35.
*    ls_user-urlaub = 32.
*  ELSE.
*    ls_user-urlaub = 30.
*  ENDIF.
*
*  MODIFY lt_user FROM ls_user. "INDEX sy-tabix.
*
**  CLEAR ls_user.
*
*  READ TABLE lt_user INDEX sy-tabix  TRANSPORTING  NO FIELDS.  "into ls_user.
*
*  IF sy-subrc <> 0.
*    MESSAGE: |Fehler bei auslesen der Nutzererte RC : { sy-subrc }| TYPE 'E'.
*  ENDIF.
*
*
*
*  lv_descr = |Vorname :|.
*  WRITE :/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-vname ALIGN = LEFT }|.
*  lv_descr = |Nachname:|.
*  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-nname ALIGN = LEFT }|.
*  lv_descr = |Alter:|.
*  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-alter ALIGN = LEFT }|.
*  lv_descr = |Urlaubstage:|.
*  WRITE:/ |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-urlaub ALIGN = LEFT }|.
*
*
*ENDLOOP.
