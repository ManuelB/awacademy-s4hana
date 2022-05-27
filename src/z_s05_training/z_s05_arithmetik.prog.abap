*&---------------------------------------------------------------------*
*& Report Z_S05_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_ARITHMETIK.

DATA lv_zahl_1(10) TYPE i VALUE IS INITIAL.
DATA lv_zahl_2(10) TYPE i.
DATA lv_ergebnis(16) TYPE p DECIMALS 2.

lv_zahl_1 = 14.
lv_zahl_2 = 9.


WRITE: / 'Zahl 1', lv_zahl_1.
WRITE: / 'Zahl 2', lv_zahl_2.
ULINE.


lv_ergebnis = lv_zahl_1 * lv_zahl_2.

WRITE: / 'Ergebnis (*)', lv_ergebnis.


lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'Ergebnis (+) ', lv_ergebnis.


lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'Ergebnis (-) ', lv_ergebnis.


lv_ergebnis = lv_zahl_1 / lv_zahl_2.
WRITE: / 'Ergebnis (/) ', lv_ergebnis.


lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
WRITE: / 'Ergebnis (MOD) ', lv_ergebnis.


lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'Ergebnis (DIV) ', lv_ergebnis.


lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'Ergebnis (**) ', lv_ergebnis.

lv_ergebnis =  lv_zahl_1 + lv_zahl_2  * 10.

WRITE: / 'Multipliztation ohne Klammer: Zahl_1 + Zahl_2 * 10', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE: / 'Multipliztation mit Klammer: (Zahl_1 + Zahl_2) * 10', lv_ergebnis.
