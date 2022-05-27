*&---------------------------------------------------------------------*
*& Report Z_S09_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_ARITHMETIK.

Data lv_zahl_1 TYPE p DECIMALS 2 VALUE IS INITIAL.
Data lv_zahl_2 TYPE p .
Data lv_ergebnis TYPE p DECIMALS 2.

lv_zahl_1 = 2.
lv_zahl_2 = 4.



WRITE: / 'Zahl 1', lv_zahl_1.
WRITE: / 'Zahl_2', lv_zahl_2.
ULINE.

lv_ergebnis = lv_zahl_1 * lv_zahl_2.

WRITE: / 'Ergebnis (*):', lv_ergebnis.


lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'Ergebnis (+):', lv_ergebnis.


lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'Ergebnis (-):', lv_ergebnis.


lv_ergebnis = lv_zahl_1 / lv_zahl_2.
WRITE: / 'Ergebnis (/):', lv_ergebnis.


lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'Ergebnis (DIV):', lv_ergebnis.


lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
WRITE: / 'Ergebnis (MOD):', lv_ergebnis.


lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'Ergebnis (**):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE: / 'Multiplization ohne Klammer: Zahl_1 + Zahl 2 * 10', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10. "Klammern sind wichtig Stichwort Klammerung"
WRITE: / 'Multiplization ohne Klammer: Zahl_1 + Zahl 2 * 10', lv_ergebnis.
