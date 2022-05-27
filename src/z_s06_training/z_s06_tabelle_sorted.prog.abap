*&---------------------------------------------------------------------*
*& Report Z_S06_TABELLE_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_tabelle_sorted.

TYPES: BEGIN OF lty_s_user," type structure
         id(8)     TYPE c,
         vname(10) TYPE c,
         nname(10) TYPE c, "local types, exist only during run time
       END OF lty_s_user,

       lty_t_user TYPE SORTED TABLE OF lty_s_user. "type table

DATA ls_user TYPE lty_s_user.
DATA lt_user TYPE SORTED TABLE OF lty_s_user WITH UNIQUE KEY id.
DATA lv_zeilenanzahl TYPE i.
"Datenbestand
ls_user-id = 'ID000001'.
ls_user-vname = 'Heinz'.
ls_user-nname = 'Kriete'.
APPEND ls_user TO lt_user.

ls_user-id = 'ID000002'.
ls_user-vname = 'Peter'.
ls_user-nname = 'Reuter'.
APPEND ls_user TO lt_user.

ls_user-id = 'ID000003'.
ls_user-vname = 'Christian'.
ls_user-nname = 'Schmidt'.
APPEND ls_user TO lt_user.

ls_user-id = 'ID000004'.
ls_user-vname = 'Louis'.
ls_user-nname = 'Wagner'.
APPEND ls_user TO lt_user.

ls_user-id = 'ID000005'.
ls_user-vname = 'David'.
ls_user-nname = 'Schpielvogel'.
APPEND ls_user TO lt_user.

CLEAR ls_user.

**********************************************************************
"Neuen Nutzer Hinzufugen:

"READ TABLE lt_user TRANSPORTING NO FIELDS WITH TABLE KEY id.


ls_user-id = 'ID000005'.
ls_user-vname = 'Moritz'.
ls_user-nname = 'Zink'.

"Varianteder Abgfrtage auf ID über READ TABLE.
LOOP AT lt_user INTO ls_user WHERE id EQ ls_user-id.

ENDLOOP.
"Variante der Abrage ID über LOOP.
IF  sy-subrc <> 0.
  APPEND ls_user TO lt_user.
ELSE.
  MESSAGE: | User mit der ID: { ls_user-id } ist schon vergeben! | TYPE 'E'.

"Annahme der Namenskonvention für Benutzer: ID<Laufende Nummer>.

LOOP AT lt_user INTO ls_user.
ENDLOOP.
DESCRIBE TABLE lt_user LINES lv_zeilenanzahl.
READ TABLE lt_user INDEX lv_zeilenanzahl into ls_user-id.


 ls_user-id + 1.s
ENDIF.
APPEND ls_user TO lt_user.
