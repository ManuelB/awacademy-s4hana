*&---------------------------------------------------------------------*
*& Report Z_S04_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_feldsymbole.

DATA lv_zahl TYPE i.

*Deklaration des Feldsymbols <zahl>
FIELD-SYMBOLS <zahl> TYPE i.


lv_zahl = 23.

*Zurordnung des Feldsymbols zum Speicherbereich der Variable
ASSIGN lv_zahl TO <zahl>.

<zahl> = 17.


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


LOOP AT lt_user ASSIGNING <user>.
  <user>-nname = 'Konstanz'.
ENDLOOP.
