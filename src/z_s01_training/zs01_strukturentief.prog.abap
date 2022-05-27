*&---------------------------------------------------------------------*
*& Report Z_S01_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_deep_structure.

*Verstanden.

*ls_user ist in diesem Fall eine tiefe Struktur.
**********************************************************************
* Typisierung einer tiefen Struktur. Struktur in Strukturen

*Strukturentyp erstellung.
TYPES:
  BEGIN OF lty_s_roles,
    rolle(20) TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

*Deklaration von table und typisierung auf obige Struktur mit Definition eines Schlüssels.
  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,

*Deklaration einer Struktur. Siehe Eine Tabelle ist in der Struktur.
  BEGIN OF lty_s_user,
    user_id(8)   TYPE n,
    vname(16) TYPE c,
    nname(16) TYPE c,
    lt_roles TYPE lty_t_roles,
  END OF lty_s_user
  .

*Deklaration von Struktur & typisierung.
DATA ls_user TYPE lty_s_user.
DATA ls_roles TYPE lty_s_roles.

*Füllen von ls_user.
ls_user-user_id = '1'.
ls_user-vname   = 'Albert'.
ls_user-nname   = 'Albrecht'.

*Füllen von ls_user-lt_roles, weil lt_roles in ls_user ist.
ls_roles-rolle    = 'ZSPOOL'.
ls_roles-rol_desc = 'Druckberechtigungen'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle    = 'ZBASIS'.
ls_roles-rol_desc = 'Basisadministrator'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle    = 'ZGUI'.
ls_roles-rol_desc = 'GUI Sonderrolle'.
APPEND ls_roles to ls_user-lt_roles.

*Überträgt alle Zeilen, die den Key Zgui als rolle haben in ls roles.
READ TABLE ls_user-lt_roles INTO ls_roles WITH KEY rolle = 'ZGUI'.
IF sy-subrc <> 0.
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' nicht zugeordnet!|.
else.
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } ist die Rolle 'ZGUI' zugeordnet!|.
ENDIF.

*Beschreibt wie viele ROllen einem User zugesprochen werden. und speichert die Info in rollenanzahl
DESCRIBE TABLE ls_user-lt_roles LINES DATA(lv_rollenanzahl).
WRITE: / |Dem User { ls_user-vname } { ls_user-nname } sind { lv_rollenanzahl } Rollen zugeordnet.|.


BREAK-POINT.
