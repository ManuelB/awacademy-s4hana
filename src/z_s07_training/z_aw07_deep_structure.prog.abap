*&---------------------------------------------------------------------*
*& Report Z_AW07_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_DEEP_STRUCTURE.

*********************************************************************
* Typisierung einer tiefen Struktur
TYPES:
  BEGIN OF lty_s_roles,
    rolle(20) TYPE c,
    rol_desc(20) TYPE c,

  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,

   BEGIN OF lty_s_user,
    user_id(8)   TYPE n,
    vname(16) TYPE c,
    nname(16) TYPE c,
    lt_roles TYPE lty_t_roles,
  END OF lty_s_user
  .


DATA ls_user TYPE lty_s_user.
DATA ls_roles TYPE lty_s_roles.

ls_user-user_id = '1'.
ls_user-vname   = 'Albert'.
ls_user-nname   = 'Albrecht'.

ls_roles-rolle    = 'ZSPOOL'.
ls_roles-rol_desc = 'Druckberechtigungen'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle    = 'ZBASIS'.
ls_roles-rol_desc = 'Basisadministrator'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle    = 'ZGUI'.
ls_roles-rol_desc = 'GUI Sonderrolle'.
APPEND ls_roles to ls_user-lt_roles.

READ TABLE ls_user-lt_roles INTO ls_roles WITH KEY rolle = 'ZGUI'.
IF sy-subrc <> 0.
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' nicht zugeordnet!|.
else.
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' zugeordnet!|.
ENDIF.


DESCRIBE TABLE ls_user-lt_roles LINES DATA(lv_rollenanzahl).
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } sind { lv_rollenanzahl } Rollen zugeordnet.|.



**********************************************************************
*INLINEDEKLARATION
DATA LV_TESTTEXT TYPE STRING VALUE 'TESTTEXT'.

DATA lv_results TYPE MATCH_RESULT.

FIND 'T' IN lv_testtext RESULTS lv_results.
IF sy-subrc <> 0.
*
ENDIF.

BREAK-POINT.

*BREAK-POINT.
