*&---------------------------------------------------------------------*
*& Report Z_AW07_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_CASE.

PARAMETERS p_zahl_1 TYPE p DEFAULT 5.
PARAMETERS p_op(1)  TYPE c.
PARAMETERS p_zahl_2 TYPE p DEFAULT 17.

DATA lv_ergebnis TYPE p.

IF p_op CA '+-*/'.
*gehe weiter.
ELSE.
*  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S'.
  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN. "Ablauflogik wird wieder beendet
ENDIF.


CASE p_op.
  WHEN '+'.
    WRITE:/ 'ADDITION'.
    lv_ergebnis = p_zahl_1 + p_zahl_2.

  WHEN '-'.
    WRITE:/ 'SUBTRAKTION'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.

  WHEN '*'.
    WRITE:/ 'MULTIPLIKATION'.
    lv_ergebnis = p_zahl_1 * p_zahl_2.

  WHEN '/'.
    IF p_zahl_2 EQ 0.
      WRITE: / 'Fehler: Division durch 0 nicht möglich'.
    ELSE.
      WRITE:/ 'DIVISION'.
      lv_ergebnis = p_zahl_1 / p_zahl_2.
    ENDIF.

  WHEN OTHERS.
    WRITE: 'FEHLER'.
ENDCASE.


WRITE: / p_zahl_1, p_op, p_zahl_2, '=', lv_ergebnis.


*IF p_zahl_1 BETWEEN 1 AND 18.
*
*ENDIF.
