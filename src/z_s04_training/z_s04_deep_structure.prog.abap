*&---------------------------------------------------------------------*
*& Report Z_S04_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_deep_structure.

TYPES:
  BEGIN OF lty_s_roles,
    rolle(20)   TYPE c,
    rol_desc(20) TYPE c,
  END OF lty_s_roles,

  lty_t_roles TYPE STANDARD TABLE OF lty_s_roles WITH DEFAULT KEY,

  BEGIN OF lty_s_user,
    user_id(8) TYPE n,
    vname(20)  TYPE c,
    nname(20)  TYPE c,
    lt_roles      TYPE lty_t_roles,
  END OF lty_s_user.


DATA ls_user TYPE lty_s_user.
DATA ls_roles TYPE lty_s_roles.

ls_user-user_id = '1'.
ls_user-vname = 'Albert'.
ls_user-nname = 'Albrecht'.


ls_roles-rolle = 'ZSPOOL'.
ls_roles-rol_desc = 'Druckberechtigung'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle = 'ZWRITE'.
ls_roles-rol_desc = 'Schreibberechtigung'.
APPEND ls_roles to ls_user-lt_roles.

ls_roles-rolle = 'ZREAD'.
ls_roles-rol_desc = 'Leseberechtigung'.
APPEND ls_roles to ls_user-lt_roles.

READ TABLE ls_user-lt_roles WITH KEY rolle = ls_roles INTO ls_roles.

WRITE: / |Dem Mitarbeiter "{ ls_user-nname }, { ls_user-vname }" ist die Rolle "{ ls_roles-rol_desc }" zugeteilt.|.


*LOOP AT ls_user-lt_roles INTO ls_roles USING KEY rolle.
*GROUP BY(key1 = rolle, key2 = rol-desc, index = GROUP INDEX, size = GROUP SIZE)WITHOUT MEMBERS INTO DATA(keysplus).
*ENDLOOP.

"BREAK-POINT.
