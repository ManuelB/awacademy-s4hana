*&---------------------------------------------------------------------*
*& Report Z_AW07_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_RECHNER.

Data lv_zahl Type p DECIMALS 2.

Data lv_ergebnis Type p DECIMALS 2.


INITIALIZATION.   "Programm wird initialisiert'




Selection-screen begin of block b0 with frame.

  selection-screen begin of block b1 with frame.

PARAMETERS p_zahl_1 LIKE lv_zahl.
PARAMETERS p_zahl_2 LIKE lv_zahl.

selection-screen end of block b1.

selection-screen begin of block b2 with frame.
PARAMETERS p_add RADIOBUTTON GROUP rl.
PARAMETERS p_sub RADIOBUTTON GROUP rl.
PARAMETERS p_mult RADIOBUTTON GROUP rl.
PARAMETERS p_div RADIOBUTTON GROUP rl.
selection-screen end of block b2.

selection-screen end of block b0.



p_zahl_1 = 6.
p_zahl_2 = 3.

START-OF-SELECTION.

IF p_add EQ abap_true. " Addition abap_true ist gleich bedeuten wie X
  WRITE: / 'Addition!'.
  lv_ergebnis = p_zahl_1 + p_zahl_2.

  ELSEIF p_sub = 'X'.
  WRITE: / 'Subtraktion!'.
  lv_ergebnis = p_zahl_1 - p_zahl_2.

ELSEIF p_mult = 'X'.
  WRITE: / 'Multiplikation!'.

  lv_ergebnis = p_zahl_1 * p_zahl_2.

ELSEIF p_div = 'X'.
  WRITE: / 'Division!'.
  IF p_zahl_2 EQ 0.
    WRITE: 'Fehler! Division durch 0 nicht zulässig!'.
  ELSE.
    lv_ergebnis = p_zahl_1 / p_zahl_2.
  ENDIF.
ELSE.
  WRITE: / 'Fehler! Keine korrekte Verrechnugsoperation gewählt'.
ENDIF.

IF lv_ergebnis IS NOT INITIAL.
  WRITE: / lv_ergebnis.
  ELSE.
    WRITE: / 'Fehler: Ergebnismenge leer!'.
ENDIF.
