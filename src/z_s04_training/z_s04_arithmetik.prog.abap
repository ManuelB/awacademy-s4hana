*&---------------------------------------------------------------------*
*& Report Z_S04_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_arithmetik.

DATA lv_zahl_1 TYPE p VALUE IS INITIAL.
DATA lv_zahl_2 TYPE p.
DATA lv_ergebnis TYPE p DECIMALS 2.

lv_zahl_1 = 14.
lv_zahl_2 = 9.



WRITE: / 'Zahl 1', lv_zahl_1.
WRITE: / 'Zahl 2', lv_zahl_2.
ULINE.

lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'Ergebnis (+)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'Ergebnis (-)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 * lv_zahl_2.
WRITE: / 'Ergebnis (*)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 / lv_zahl_2.
WRITE: / 'Ergebnis (/)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'Ergebnis (DIV)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
WRITE: / 'Ergebnis (MOD)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'Ergebnis (**)', lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE: / 'Multiplikation ohne Klammer: Zahl 1 + Zahl 2 * 10', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE: / 'Multiplikation mit Klammer: (Zahl 1 + Zahl 2) * 10', lv_ergebnis.

DO. ENDDO. WRITE: 'fetig'.
