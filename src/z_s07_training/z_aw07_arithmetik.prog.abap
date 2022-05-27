*&---------------------------------------------------------------------*
*& Report Z_AW07_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_ARITHMETIK.

Data lv_zahl_1 TYPE i VALUE is initial.
Data lv_zahl_2 TYPE i.
DATA lv_ergebnis TYPE p DECIMALS 2.
lv_zahl_1 = 14.
lv_zahl_2 = 9.

lv_ergebnis = lv_zahl_1 * lv_zahl_2.


WRITE: / 'Zahl 1', lv_zahl_1.
WRITE: / 'Zahl 2', lv_zahl_2.
uline.

lv_ergebnis = lv_zahl_1 * lv_zahl_2.
WRITE: / 'ergebnis (*):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'ergebnis (-):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'ergebnis (+):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 / lv_zahl_2.
WRITE: / 'ergebnis (/):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'ergebnis (DIV):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
WRITE: / 'ergebnis (MOD):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'ergebnis (**):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE: / 'Multiplikatio ohne Klammer: Zahl_1 + Zahl_2 * 10', lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
