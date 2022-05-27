*&---------------------------------------------------------------------*
*& Report Z_S05_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_FELDSYMBOLE.

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

BREAK-POINT.
