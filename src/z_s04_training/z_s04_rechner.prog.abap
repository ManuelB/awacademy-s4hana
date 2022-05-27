*&---------------------------------------------------------------------*
*& Report Z_S04_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_rechner.

DATA lv_zahl TYPE i.
DATA lv_zeichen(1) TYPE c.
DATA lv_ergebnis TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE f.


INITIALIZATION.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
    PARAMETERS p_zahl_1 LIKE lv_zahl.
    PARAMETERS p_zahl_2 LIKE lv_zahl.
  SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
    PARAMETERS p_add RADIOBUTTON GROUP rb_1.
    PARAMETERS p_sub RADIOBUTTON GROUP rb_1.
    PARAMETERS p_mul RADIOBUTTON GROUP rb_1.
    PARAMETERS p_div RADIOBUTTON GROUP rb_1.
  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF BLOCK b1.


IF p_zahl_1 EQ p_zahl_2.

  WRITE: p_zahl_2.

ENDIF.

START-OF-SELECTION.

IF p_add EQ 'X'. " EQ ist gleichbedeutend mit = | ABAP_TRUE ist eine Konstante für X
  WRITE: / 'Addition'.
  lv_ergebnis = p_zahl_1 + p_zahl_2.

ELSEIF p_sub = 'X'.
  WRITE: / 'Substraktion'.
  ULINE.
  lv_ergebnis = p_zahl_1 - p_zahl_2.

ELSEIF p_mul = 'X'.
  WRITE: / 'Multiplikation'.
  ULINE.
  lv_ergebnis = p_zahl_1 * p_zahl_2.

ELSEIF p_div = 'X'.
  WRITE: / 'Division'.
  ULINE.
  IF p_zahl_2 EQ 0.
    WRITE: / 'Fehler! Division durch "0" nicht möglich!'.
    EXIT.
  ELSE.
    lv_ergebnis = p_zahl_1 / p_zahl_2.
  ENDIF.
ELSE.
  WRITE: / 'Fehler! Keine Verrechnungsoperation gewählt!'.
ENDIF.


IF lv_ergebnis IS NOT INITIAL.
  WRITE: / lv_ergebnis.
ELSE.
  WRITE: / 'Fehler! Ergebnismenge leer!'.
ENDIF.
