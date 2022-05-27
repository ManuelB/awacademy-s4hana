*&---------------------------------------------------------------------*
*& Report Z_S12_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_arithmetik.

DATA lv_zahl_1 TYPE p VALUE IS INITIAL.
DATA lv_zahl_2 TYPE p.
DATA lv_zahl_3 TYPE p.
DATA lv_zahl_4 TYPE p.
DATA lv_ergebnis TYPE p DECIMALS 2.


lv_zahl_1 = 2.
lv_zahl_2 = 4.
lv_zahl_3 = 8.
lv_zahl_4 = 5.
WRITE: /,/ 'zahl_1', lv_zahl_1.
WRITE: / 'zahl_2', lv_zahl_2.
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
WRITE: / 'Multiplikation ohne Klammer: zahl_1 + zahl_2 * 10', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE: / 'Multiplikation mit Klammer: ( zahl_1 + zahl_2 ) * 10', lv_ergebnis.
