*&---------------------------------------------------------------------*
*& Report Z_S02_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_S02_deep_structure.


****
* Typisierung einer tiefen STruktur
TYPES:

  BEGIN OF lty_s_roles,
    rolle(20) TYPE c,
    rol_desc(20) TYPE c,

  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,  "

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
ls_user-vname = 'Alpert'.
ls_user-nname = 'Alpin'.


ls_roles-rolle = 'ZSOOL'.
ls_roles-rol_desc = 'Druckberechtigungen'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle = 'KafCh'.
ls_roles-rol_desc = 'Kaffemaschinenchef'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle = 'KloB'.
ls_roles-rol_desc = 'Klobesucher'.
APPEND ls_roles to ls_user-lt_roles.


READ TABLE ls_user-lt_roles INTO ls_roles WITH KEY rolle = 'Kaffeemaschinenchef'.
IF sy-subrc <> 0.
  WRITE: / | Dem Mitarbeiter { ls_user-vname } { ls_user-nname } ist die Rolle 'Kaffeemaschinechef' zugewiesen.|.
ELSE.
  WRITE: / | Dem Mitarbeiter { ls_user-vname } { ls_user-nname } ist die Rolle 'Kaffeemaschinechef' nicht zugewiesen.|.
ENDIF.

*Auslesen, wie viele Rollen da sind.
DESCRIBE TABLE ls_user-lt_roles LINES DATA(lv_rollenanzahl). " Inlinedeklaration lv_rollenanzahl.
WRITE: / | Dem Mitarbeiter { ls_user-vname } { ls_user-nname } sind { lv_rollenanzahl } Rollen zugewiesen.|.

BREAK-POINT.
