*&---------------------------------------------------------------------*
*& Report Z_S06_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_ARITHMETIK.

DATA lv_zahl_1 TYPE i VALUE IS INITIAL.
DATA lv_zahl_2 TYPE i.
DATA lv_ergebnis TYPE p DECIMALS 2.

lv_zahl_1 = 14.
lv_zahl_2 = 9.




   Write: /,/'Zahl 1:', lv_zahl_1.
   Write: /'Zahl 1:', lv_zahl_2.
   ULINE.

   lv_ergebnis = lv_zahl_1 * lv_zahl_2.
   Write: /'Ergebnis (*):', lv_ergebnis.

   lv_ergebnis = lv_zahl_1 + lv_zahl_2.
   Write: /'Ergebnis (+):', lv_ergebnis.

   lv_ergebnis = lv_zahl_1 - lv_zahl_2.
   Write: /'Ergebnis (-):', lv_ergebnis.

   lv_ergebnis = lv_zahl_1 / lv_zahl_2.
   Write: /'Ergebnis (/):', lv_ergebnis.

   lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
   Write: /'Ergebnis (DIV):', lv_ergebnis.

   lv_ergebnis = lv_zahl_1 MOD lv_zahl_2.
   Write: /'Ergebnis (MOD):', lv_ergebnis.

   lv_ergebnis = lv_1zahl_1 + lv_zahl_2.
   Write: /'Ergebnis (**):', lv_ergebnis.

   lv_ergebnis = lv_1zahl_1 + lv_zahl_2 * 10.
   WRITE: / 'Multiplization ohne Klammer:  ( zahl_1 + zahl_2 ) * 10', lv_ergibnis.

   ULINE.
