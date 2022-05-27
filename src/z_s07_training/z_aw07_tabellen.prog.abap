*&---------------------------------------------------------------------*
*& Report Z_AW07_TABELLEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_TABELLEN.

TYPES: BEGIN OF lty_s_usher,
  vname(20) TYPE c,
  nname(20) TYPE c,
  alter     TYPE i,
  urlaub    TYPE i,
  END OF lty_s_usher.

 DATA ls_user TYPE lty_s_usher.
 DATA lt_user TYPE TABLE OF lty_s_usher.
* DATA ls_user TYPE lty_s_usher.

 ls_user-vname = 'Heinz'.
 ls_user-nname = 'Kriete'.
 ls_user-alter = '66'.
 ls_user-urlaub = '24'.
APPEND ls_user to lt_user.

ls_user-vname = 'Michael'.
 ls_user-nname = 'Müller'.
 ls_user-alter = '34'.
 ls_user-urlaub = '24'.
 APPEND ls_user to lt_user.

 ls_user-vname = 'Franz'.
 ls_user-nname = 'Kaiser'.
 ls_user-alter = '59'.
 ls_user-urlaub = '24'.
 APPEND ls_user to lt_user.

 ls_user-vname = 'Mika'.
 ls_user-nname = 'Maier'.
 ls_user-alter = '33'.
 ls_user-urlaub = '24'.
 APPEND ls_user to lt_user.

 ls_user-vname = 'Maria'.
 ls_user-nname = 'Schiller'.
 ls_user-alter = '39'.
 ls_user-urlaub = '24'.
 APPEND ls_user to lt_user.

 DATA lv_descr(13) TYPE c.

 clear: ls_user.

 sort lt_user by nname DESCENDING
  alter DESCENDING.

*                                   *where und GE wird aussurtiert

*HK CODE
LOOP at lt_user into ls_user WHERE alter ge 40.
 add  2 to ls_user-urlaub.
 Write: / 'Nachname', ls_user-nname.
Write: / 'Urlaub', ls_user-urlaub.

   ENDLOOP.
ULINE.

LOOP at lt_user into ls_user.
  IF ls_user-alter GE 35.
    ls_user-urlaub = 32.
    else.
      ls_user-urlaub = 30.

ENDIF.

MODIFY lt_user from ls_user INDEX sy-tabix.

lv_descr = |Vorname:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-vname  ALIGN = left }|.
  lv_descr = |Nachname:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-nname  ALIGN = left }|.
  lv_descr = |Alter:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-alter  ALIGN = left }|.
  lv_descr = |Urlaubstage:|.
  WRITE: / |{ lv_descr WIDTH = 13 ALIGN = RIGHT } { ls_user-urlaub ALIGN = left }|.
ULINE.
ENDLOOP.





*   über 40 2 urlaubstage mehr
