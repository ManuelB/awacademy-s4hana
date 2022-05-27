*&---------------------------------------------------------------------*
*& Report Z_S06_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_deep_structure.

TYPES:

  BEGIN OF lty_s_roles,
    rollen(20)   TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,

  BEGIN OF lty_s_user,
    user_id(10) TYPE n,
    vname(16)   TYPE c,
    nname(16)   TYPE c,
    lt_roles    TYPE lty_t_roles,
  END OF lty_s_user
  .

DATA ls_user TYPE lty_s_user.
DATA ls_roles TYPE lty_s_roles.

ls_user-user_id = '1'.
ls_user-vname = 'Alebert'.
ls_user-nname = 'Albrecht'.

ls_roles-rollen = 'ZSpool'.
ls_roles-rol_desc = 'Druckberechtigung'.
APPEND ls_roles TO ls_user-lt_roles."lt_roles is a table

ls_roles-rollen = 'User'.
ls_roles-rol_desc = 'User role'.
APPEND ls_roles TO ls_user-lt_roles.

ls_roles-rollen = 'Admin'.
ls_roles-rol_desc = 'Adminrole'.
APPEND ls_roles TO ls_user-lt_roles.

READ TABLE ls_user-lt_roles INTO ls_roles WITH  KEY rollen = 'Admin'.
IF sy-subrc <> 0.
  WRITE: |User { ls_user-vname } '-' { ls_user-nname }|.
ENDIF.

BREAK-POINT.
