*&---------------------------------------------------------------------*
*& Report Z_S03_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_ARITHMETIK.

DATA lv_zahl_1 TYPE p VALUE IS INITIAL.
DATA lv_zahl_2 TYPE p.
DATA lv_ergebnis TYPE p DECIMALS 2.

lv_zahl_1 = 14.
lv_zahl_2 = 9.

lv_ergebnis = lv_zahl_1 * lv_zahl_2.




WRITE: / 'Zahl 1', lv_zahl_1.
WRITE: / 'Zahl 2', lv_zahl_2.
WRITE: / 'Ergebnis (*):', lv_ergebnis.
ULINE.


lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'Ergebnis (+):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'Ergebnis (-):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'Ergebnis (DIV):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
WRITE: / 'Ergebnis (MOD):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'Ergebnis (**):', lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE: / 'Multiplikation ohne Klammer: zahl_1 + zahl_2 * 10', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE: / 'Multiplikation ohne Klammer: ( zahl_1 + zahl_2 ) * 10', lv_ergebnis.
