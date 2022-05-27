*&---------------------------------------------------------------------*
*& Report Z_S04_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_case.

PARAMETERS p_zahl_1 TYPE p DEFAULT 5.
PARAMETERS p_op(1) TYPE c DEFAULT '+'.
PARAMETERS p_zahl_2 TYPE p DEFAULT 17.

DATA lv_ergebnis TYPE p DECIMALS 2.

IF p_op CA '+-*/'.
*gehe weiter
ELSE.
  MESSAGE 'Bitte geben Sie einen validen Rechenoperator an!' TYPE 'I' DISPLAY LIKE 'E'.
  RETURN. "Ablauflogik wird wieder beendet
ENDIF.


CASE p_op.
  WHEN '+'.
    WRITE: / 'Addition!'.
    lv_ergebnis = p_zahl_1 + p_zahl_2.

  WHEN '-'.
    WRITE: / 'Subtraktion!'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.

  WHEN '*'.
    WRITE: / 'Multiplikation!'.
    lv_ergebnis = p_zahl_1 * p_zahl_2.

  WHEN '/'.
    WRITE: / 'Division!'.
    IF p_zahl_2 = 0.
      WRITE: / 'Fehler! Division durch "0" nicht möglich!'.
      EXIT.
    ELSE.
      lv_ergebnis = p_zahl_1 / p_zahl_2.
    ENDIF.

  WHEN OTHERS.
    WRITE: 'Fehler!'.
ENDCASE.

WRITE: / p_zahl_1, p_op, p_zahl_2, '=', lv_ergebnis.
