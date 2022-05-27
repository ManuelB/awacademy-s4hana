*&---------------------------------------------------------------------*
*& Report Z_S01_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S01_ARITHMETIK.

*Hier alles verständlich.

Data lv_zahl_1 TYPE i VALUE IS INITIAL. "Is initial gibt Initialwert ein. So werden variablen deklariert."
Data lv_zahl_2 TYPE i.
Data lv_ergebnis TYPE p DECIMALS 2.

lv_zahl_1 = 14. "So werden variablen definiert."
lv_zahl_2 = 9.



WRITE: /,/ 'Zahl 1:', lv_zahl_1. "Druckt angegebenes objekt. Wichtig: Kombination aus Text & Zahl wird mit einem Komma zusammengefügt.
WRITE: / 'Zahl 2:', lv_zahl_2.
ULINE. "Trennlinie wird gezogen"


*Arithmetrische Operationen

lv_ergebnis = lv_zahl_1 + lv_zahl_2.
WRITE: / 'Ergebnis (+):', lv_ergebnis. ""

ULINE.

lv_ergebnis = lv_zahl_1 - lv_zahl_2.
WRITE: / 'Ergebnis (-):', lv_ergebnis.

ULINE.

lv_ergebnis = lv_zahl_1 * lv_zahl_2.
WRITE: / 'Ergebnis (*):', lv_ergebnis.

ULINE.

lv_ergebnis = lv_zahl_1 / lv_zahl_2.
WRITE: / 'Ergebnis (/):', lv_ergebnis.

ULINE.

lv_ergebnis = lv_zahl_1 DIV lv_zahl_2.
WRITE: / 'Ergebnis (DIV):', lv_ergebnis.

ULINE.

lv_ergebnis = lv_zahl_1 MOD lv_zahl_2. "Gibt die Rest-dezimalstellen der Divsision zurück."
WRITE: / 'Ergebnis (MOD):', lv_ergebnis.

ULINE.

lv_ergebnis = lv_zahl_1 ** lv_zahl_2.
WRITE: / 'Ergebnis (**):', lv_ergebnis. "Potenzieren des linken mit dem rechten Operanden."

ULINE.

lv_ergebnis = lv_zahl_1 + lv_zahl_2 * 10.
WRITE: / 'Multiplization ohne Klammer: Zahl_1 + Zahl_2 * 10', lv_ergebnis.

ULINE.

lv_ergebnis = ( lv_zahl_1 + lv_zahl_2 ) * 10.
WRITE: / 'Multiplization ohne Klammer: ( Zahl_1 + Zahl_2 ) * 10', lv_ergebnis.

ULINE.
