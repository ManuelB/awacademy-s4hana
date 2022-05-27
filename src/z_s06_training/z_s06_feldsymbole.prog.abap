*&---------------------------------------------------------------------*
*& Report Z_S06_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_feldsymbole.

"<BeispielFeldsymbol> ist ein zeiger.zeigt of speicher berreich ein zb variable usw.It mirrors a assigned value and changes when value changes.
"must be assigned.

DATA lv_zahl TYPE i.

"decleration of Fieldsymbol
FIELD-SYMBOLS <zahl> TYPE i.

lv_zahl = 23.

"zuordnung des Feldsymbols zum speicherbereich der variable.
ASSIGN lv_zahl TO <zahl>.

<zahl> = 17. "by giving the fieldsymbol a value, it will change the value of the variable. thereby sort of mirroring in both directions.

**********************************************************************

TYPES: BEGIN OF lty_user,
         id        TYPE i,
         vname(15) TYPE c,
         nname(15) TYPE c,
       END OF lty_user.

DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.

FIELD-SYMBOLS <user> TYPE lty_user.

ls_user-id    = 1.
ls_user-vname = 'Paul'.
ls_user-nname = 'Fischer'.
APPEND ls_user TO lt_user.

"es ist moglich wahren eines loop der aktuellen zeile der tabelle ein feldsymbol zuzuordnen.
"damin konnnen die daten der zeile direkt angepasst werden. hier das nuztwert!

LOOP AT lt_user ASSIGNING <user>."hiermit kannst du dir  zb"read table" sparen.
  <user>-nname  = 'Reuter'.

ENDLOOP.
