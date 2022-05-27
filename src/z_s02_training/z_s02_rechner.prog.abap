*&---------------------------------------------------------------------*
*& Report Z_S02_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_rechner.

DATA lv_zahl TYPE p DECIMALS 2.


DATA lv_ergebnis TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE f.

*DATA lv_zahl_1 TYPE i.
*DATA lv_zahl_2 TYPE i.
*DATA lv_zeichen(1) TYPE c.
*
*
*lv_zahl_1 = 1.
*lv_zahl_2 = 1.

*IF lv_zahl_1 EQ lv_zahl_2 .
*
*  WRITE: lv_zahl_2.
*
*ENDIF.



INITIALIZATION.


SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

    PARAMETERS p_zahl_1 LIKE lv_zahl.
    PARAMETERS p_zahl_2 LIKE lv_zahl DEFAULT 2.

  SELECTION-SCREEN END OF BLOCK b1.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

    PARAMETERS p_add RADIOBUTTON GROUP r1 DEFAULT 'X'.
    PARAMETERS p_sub RADIOBUTTON GROUP r1.
    PARAMETERS p_mult RADIOBUTTON GROUP r1.
    PARAMETERS p_div RADIOBUTTON GROUP r1.

  SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF BLOCK b0.

p_zahl_1 = 1.

START-OF-SELECTION.



IF p_add EQ abap_true. " Addition | EQ ist gleichbedeutend mit = | ABAP_TRUE ist eine Konstante für 'X'.
  WRITE: / 'Addition'.
  lv_ergebnis = p_zahl_1 + p_zahl_2.

ELSEIF p_sub = 'X'.
  WRITE: / 'Subtraktion'.
  lv_ergebnis = p_zahl_1 - p_zahl_2.

ELSEIF p_mult = 'X'.
  WRITE: / 'Multiplikation'.

  lv_ergebnis = p_zahl_1 * p_zahl_2.

ELSEIF p_div = 'X'.
  WRITE: / 'Division'.
  IF p_zahl_2 EQ 0.
    WRITE: 'Fehler! Division durch 0 nicht zulässig!'.
    EXIT.
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
