*&---------------------------------------------------------------------*
*& Report Z_S12_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_deep_structure.

**************************************************************************************
* Typisierung einer tiefen Struktur

TYPES:
  BEGIN OF lty_s_roles,
    rolle(20)    TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,

  BEGIN OF lty_s_user,
    user_id(8) TYPE n,
    vname(16)  TYPE c,
    nname(16)  TYPE c,
    lt_roles TYPE lty_t_roles,
  END OF lty_s_user
  .

DATA ls_user TYPE lty_s_user.
DATA ls_roles TYPE lty_s_roles. "Fügt der Tabelle eine Struktur hinzu - Nested Table in diesem Fall

ls_user-user_id   = |1|.
ls_user-vname     = |Albert|.
ls_user-nname     = |Albrecht|.

ls_roles-rolle    = |ZSPOOL|.
ls_roles-rol_desc = |Druckberechtigungen|.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle    = |ZSPaper|.
ls_roles-rol_desc = |Papierauffüllberechtigung|.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle    = |ZSToner|.
ls_roles-rol_desc = |Druckpatronenauffüllberechtigung|.

APPEND ls_roles TO ls_user-lt_roles. "Hängt die Rollen an die "Struktur Rollen" der Benutzer an
*SORT lt_roles ASCENDING.
READ TABLE ls_user-lt_roles INTO ls_roles with key rol_desc = |Papierauffüllberechtigung|.
IF sy-subrc <> 0.
  write: / |Dem Benutzer sind die folgenden Rollen zugeordnet:{ ls_roles-rolle } mit den folgenden Beschreibungen: { ls_roles-rol_desc }|.
ELSE.
  write: / |'Dem Benutzer sind keine Rollen zugeordnet'|.

ENDIF.

DESCRIBE TABLE ls_user-lt_roles LINES DATA(lv_rollenanzahl)."Inlinedeklaration der Variable
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } sind { lv_rollenanzahl } Rollen zugeordnet.|.

*******************************************************************************************************************************
*Inline Deklaration
data lv_testtext type string value 'TESTEXT'.
data lv_results type match_result.
find 'T' in lv_testtext RESULTS lv_results.
IF sy-subrc <> 0.

ENDIF.

*BREAK-POINT.
