*&---------------------------------------------------------------------*
*& Report Z_S02_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_ARITHMETIK.

Data lv_zahl_1 TYPE p VALUE IS INITIAL. "Beim DAtentyp p muss man die Anzahl Nachkommastellen angeben
Data lv_zahl_2 TYPE p.
Data lv_ergebnis TYPE p DECIMALS 2.

lv_zahl_1 = 7.
lv_zahl_2 = 8.


lv_ergebnis = lv_zahl_1 * lv_zahl_2.

WRITE: / 'zahl 1', lv_zahl_1.
WRITE: / 'zahl 2', lv_zahl_2.
WRITE: / 'Ergebnis Multiplikation', lv_ergebnis.


"Addition
lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'Ergebnis Addition', lv_ergebnis.

"Subtraktion
lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'Ergebnis Subtraktion', lv_ergebnis.

"Division
lv_ergebnis = lv_zahl_1 / lv_zahl_2.
WRITE: / 'Ergebnis Division', lv_ergebnis.

"Div_Rest
lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'Ergebnis Div_Rest', lv_ergebnis.

"Modulation
lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
WRITE: / 'Ergebnis Modulation', lv_ergebnis.

"Potenzierung
lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'Ergebnis Potenzierung', lv_ergebnis.


"Klammerung
lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE: / 'Mulitplikation ohne Klammer: Zahl_1 + Zahl_2 * 10', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE: / 'Mulitplikation mit Klammer: Zahl_1 + Zahl_2 * 10', lv_ergebnis.
