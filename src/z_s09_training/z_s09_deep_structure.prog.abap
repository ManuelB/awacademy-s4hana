*&---------------------------------------------------------------------*
*& Report Z_S09_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_deep_structure.


"Typisierung einer tiefen Struktur
TYPES:


  BEGIN OF  lty_s_roles,
    rollen(20)   TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,


  BEGIN OF lty_s_user,

    user_id   TYPE n,
    vname(16) TYPE c,
    nname(16) TYPE c,
    roles     TYPE lty_t_roles,

  END OF lty_s_user.

DATA ls_user TYPE lty_s_user.
DATA ls_roles TYPE lty_s_roles.


ls_user-user_id = '1'.
ls_user-vname = 'Albert'.
ls_user-nname = 'Albrecht'.

ls_roles-rolle = 'ZSPOOL'.
ls_roles-rol_desc = 'Druckberechtigungen'.

APPEND ls_roles TO ls_user-roles.

ls_roles_rolle = 'ZRolle 2'.
ls_roles-rol_desc = 'Rolle2'.

APPEND ls_roles TO ls_user-roles.

ls_roles-rolle = 'ZRolle 3'.
ls_roles-rol_desc = 'Rolle3'.

APPEND ls_roles TO ls_user-roles.

READ TABLE ls_user-lt_roles TRANSPORTING ls_roles WITH KEY rolle = 'ZGUI'.

IF sy-subrc <> 0.

  WRITE: |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' nicht zugeordnet!.|.
ELSE.
  WRITE: |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' zugeordnet!.|.
  ENDDIF.

  DESCRIBE TABLE ls_user-lt_roles LINES DATA { lv_rollenanzahl } { ls_user-nname } sind { lv_rollenanzahl } Rollen zugeordnet.|.
