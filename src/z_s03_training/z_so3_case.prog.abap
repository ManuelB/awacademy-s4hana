*&---------------------------------------------------------------------*
*& Report Z_SO3_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_so3_case.

PARAMETERS p_zahl_1 TYPE p.
PARAMETERS p_op(1) TYPE c.
PARAMETERS p_zahl_2 TYPE p.

DATA lv_ergebnis TYPE p.

IF p_op CA '+-*/'.
ELSE.
  MESSAGE 'Bitte geben Sie einen validen Rechenoperatoren an.' TYPE 'S' DISPLAY LIKE 'E'.
  RETURN.
ENDIF.

CASE p_op.
  WHEN '+'.
    lv_ergebnis = p_zahl_1 + p_zahl_2.
    WRITE: / 'Addition',lv_ergebnis.


  WHEN '-'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.
    WRITE: / 'substraktion',lv_ergebnis.


  WHEN '*'.
    lv_ergebnis = p_zahl_1 * p_zahl_2.
    WRITE: / 'Multiplikation',lv_ergebnis.


  WHEN '/'.
    IF p_zahl_2 EQ 0.
      WRITE:/'Division durch 0 nicht möglich, Fehler'.
      EXIT.
    ELSE.

      lv_ergebnis = p_zahl_1 / p_zahl_2.
      WRITE: / 'Division',lv_ergebnis.

    ENDIF.
  WHEN OTHERS.
    WRITE: /'Fehler'.

ENDCASE.
