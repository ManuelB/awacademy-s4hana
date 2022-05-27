*&---------------------------------------------------------------------*
*& Report Z_S11_ARITHMETIK2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ARITHMETIK2.

Data lv_zahl_1 type p  value is initial.
Data lv_zahl_2 type p.
Data lv_ergebnis type p DECIMALS 2.

lv_zahl_1 = 2.
lv_zahl_2 = 4.
lv_ergebnis = lv_zahl_1 * lv_zahl_2.

write : /'Zahl 1', lv_zahl_1.
write : /'Zahl 2', lv_zahl_2.
write : /'The (*) of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2.
write : /'The sum of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_2 - lv_zahl_1.
write : /'The (-) of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_1 / lv_zahl_2.
write : /'The (/) of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_1 div lv_zahl_2.
write : /'The div of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_1 mod lv_zahl_2.
write : /'The mod of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
write : /'The ** of', lv_zahl_2, 'und',lv_zahl_1,'is',lv_ergebnis.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE : /' Multiplication ohne klammer', lv_ergebnis.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE : /' Multiplication mit klammer', lv_ergebnis.
