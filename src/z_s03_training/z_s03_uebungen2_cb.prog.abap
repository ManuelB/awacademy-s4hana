*&---------------------------------------------------------------------*
*& Report Z_S03_UEBUNGEN2_CB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_UEBUNGEN2_CB.

TYPES:
BEGIN OF lty_s_user,
  id(4) TYPE c,
  vname(10) TYPE c,
  nname(10) TYPE c,
  END OF lty_s_user,

  lty_t_user TYPE SORTED TABLE OF lty_s_user with UNIQUE KEY id.

  DATA ls_user TYPE lty_s_user.
  DATA lt_user TYPE lty_t_user.

  ls_user-id = |ID01|.
  ls_user-vname = |Chris|.
  ls_user-nname = |Brown|.
APPEND ls_user to lt_user.

  ls_user-id = |ID02|.
  ls_user-vname = |Joe|.
  ls_user-nname = |Cocker|.
  APPEND ls_user to lt_user.

  ls_user-id = |ID03|.
  ls_user-vname = |Ben|.
  ls_user-nname = |Affleck|.
  APPEND ls_user to lt_user.



  ls_user-id = |ID02|.
  ls_user-vname = |Lady|.
  ls_user-nname = |Gaga|.


*  Loop at lt_user INTO ls_user WHERE id EQ ls_user-id.
*    if sy-subrc <> 0.
*      APPEND ls_user to lt_user.
*      ELSE.
*        MESSAGE: |ID { ls_user-id } schon vergeben!| TYPE 'S' DISPLAY LIKE 'E'.
*        ENDIF.
*        ENDLOOP.

DATA lv_maxId(2) TYPE n.
DATA dummy TYPE string.
DATA lv_Zeilenanzahl TYPE i.



LOOP at lt_user INTO ls_user WHERE id = ls_user-id.
  ENDLOOP.
if sy-subrc <> 0.
  APPEND ls_user TO lt_user.
  ELSE.
    write: / | ID { ls_user-id } schon vergeben |.

    DESCRIBE TABLE lt_user lines lv_zeilenanzahl.

    READ TABLE lt_user INDEX lv_zeilenanzahl INTO ls_user.
    SPLIT ls_user-id at 'ID' INTO dummy lv_maxid.
add 1 to lv_maxid.

ls_user-id = |ID{ lv_maxid }|.
    WRITE: / |die nächste freie ID ist { ls_user-id }|.
    ENDIF.
