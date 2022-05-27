*&---------------------------------------------------------------------*
*& Report Z_S11_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_deep_structure.

TYPES :

  BEGIN OF lty_s_roles,
    rolle(20)    TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,

  BEGIN OF lty_s_user,
    user_id(8) TYPE n,
    vname(16)  TYPE c,
    nname(16)  TYPE c,
    lt_roles   TYPE lty_t_roles,
  END OF lty_s_user
  .

DATA ls_user TYPE lty_s_user.
DATA lt_user TYPE STANDARD TABLE OF lty_s_user.

DATA ls_roles TYPE lty_s_roles.

ls_user-user_id = '1'.     "user 1
ls_user-vname = 'Albert'.
ls_user-nname = 'Albrecht'.
*
ls_roles-rolle = 'Albert_Role1'.
ls_roles-rol_desc = 'Druckberechtigungen' .
APPEND ls_roles TO ls_user-lt_roles.
*
*ls_user-lt_roles-rolle = 'Albert Role2'. "lt_roles and its fields can be accessed using this line only when lt_roles type lty_s_roles is (means a structure)
*ls_user-lt_roles-rol_desc = 'Lernen'.

ls_roles-rolle = 'Albert_Role2'.
ls_roles-rol_desc = 'Lernen'.
APPEND ls_roles TO ls_user-lt_roles.

APPEND ls_user TO lt_user.

*CLEAR ls_user-lt_roles.
*
*ls_user-user_id = '2'.     "user 2
*ls_user-vname = 'Tom'.
*ls_user-nname = 'Hanks'.
*
*ls_roles-rolle = 'Tom_Role1'.
*ls_roles-rol_desc = 'Teaching'.
*APPEND ls_roles TO ls_user-lt_roles.
*
*ls_roles-rolle = 'Tom_Role2'.
*ls_roles-rol_desc = 'Buch leihen'.
*APPEND ls_roles TO ls_user-lt_roles.
*APPEND ls_user TO lt_user.

*READ TABLE ls_user-lt_roles INTO ls_roles WITH KEY rolle = 'Buch leihen'.

*BREAK-POINT.
LOOP AT ls_user-lt_roles INTO ls_roles WHERE rolle = 'Albert_Role2'.
  IF sy-subrc NE 0.
    WRITE :/  'No user has this role '.
  ELSE.
    WRITE :/ |the user, { ls_user-vname }, has this role|.
  ENDIF.
ENDLOOP.


ULINE.
ULINE.
ULINE.

*READ TABLE lt_user INTO ls_user WITH KEY user_id = '1'.
LOOP AT lt_user INTO ls_user.
  WRITE / | 'id' { ls_user-user_id } 'User first name' { ls_user-vname }|.
  WRITE / 'Roles :'.
  LOOP AT ls_user-lt_roles INTO ls_roles.
    WRITE: sy-tabix, ls_roles-rolle.
  ENDLOOP.
ENDLOOP.
