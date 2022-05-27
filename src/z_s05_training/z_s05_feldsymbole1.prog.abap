*&---------------------------------------------------------------------*
*& Report Z_S05_FELDSYMBOLE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_FELDSYMBOLE1.


*<BeispielFeldsymbol>
*speichert auf einem Speicherplatz ein ABAP Objekt z.B Variable..
*z.B Variable Name -  lv_zahl // V-Wert - 23 // <Feldsymbol> = 23 -->statt 23 ein Feldnummer z.B

DATA lv_zahl TYPE i.

*Deklaration des Feldysmbols <zahl>.
FIELD-SYMBOLS <zahl> TYPE i.

lv_zahl = 23.

*Zuordnung des Feldsymbols zum Speicherbereich der Variable.
ASSIGN lv_zahl TO <zahl>.

<zahl> = 17.
*DATA lv_zahl TYPE i.


TYPES: BEGIN OF lty_user,
  id TYPE i,
  vname(15) TYPE c,
  nname(15) TYPE c,
   END OF lty_user.

   DATA ls_user type lty_user.
   DATA lt_user TYPE TABLE OF lty_user.

FIELD-SYMBOLS <user> TYPE lty_user.

   ls_user-id = 1.
   ls_user-vname = 'Paul'.
   ls_user-nname = 'Fischer'.
   APPEND ls_user TO lt_user.

     ls_user-id = 2.
   ls_user-vname = 'Rob'.
   ls_user-nname = 'Fischer'.
   APPEND ls_user TO lt_user.

*Es ist möglich ähren eines Loops der aktuellen Ziele der Tabelle ein Feldsymbol zurordnen .
*Damit können diw Daten der Zeile direkt verändert werden.
   LOOP AT lt_user ASSIGNING <user> WHERE vname = 'Paul'.
     ASSIGN lv_zahl TO <zahl>.
      <user>-nname = 'Konstanz'.



   ENDLOOP.

   BREAK-POINT.
