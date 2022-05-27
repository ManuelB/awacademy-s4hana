*&---------------------------------------------------------------------*
*& Report Z_S06_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_CASE.

PARAMETERS p_zahl_1 TYPE p.
PARAMETERS p_op(1) TYPE c.
PARAMETERS p_zahl_2 TYPE p.

DATA lv_ergebnis TYPE p.

IF p_op CA '+/*-'.
* gehe weiter.
  ELSE.
    MESSAGE'Bitte geben Sie einen validen Rechenoperator an.' TYPE 'I'.
    RETURN. "Ablauflogik wird wieder beendet.
ENDIF.

CASE p_op.
  WHEN '+'.
    WRITE: / 'ADDITION'.
  lv_ergebnis = p_zahl_1 + p_zahl_2.
  WHEN '-'.
    WRITE: / 'SUBTRACTION'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.
    WHEN '*'.
      WRITE: / 'MULTIPLIKATION'.
     lv_ergebnis = p_zahl_1 * p_zahl_2.
      WHEN '/'.
        IF p_zahl_2 EQ 0.
WRITE: / 'DIVISION DURCH 0 NICHT'.
        ELSE.
        WRITE: / 'DIVISION'.
lv_ergebnis = p_zahl_1 / p_zahl_2.
  WHEN OTHERS.
    WRITE: 'Error'.
ENDCASE.


WRITE: / p_zahl_1, p_op, p_zahl_2, '=', lv_ergebnis.
