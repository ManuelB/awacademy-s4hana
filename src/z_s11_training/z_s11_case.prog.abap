*&---------------------------------------------------------------------*
*& Report Z_S11_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_case.

DATA lv_ergebnis TYPE i.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  PARAMETERS p_zahl_1 TYPE p DEFAULT 25.
  PARAMETERS p_zahl_2 TYPE p default 50.
  PARAMETERS p_op(1) TYPE c DEFAULT '*'.

SELECTION-SCREEN END OF BLOCK b1.

IF p_op CA '+-*/'.
*  gebe weiter.
ELSE.
  MESSAGE 'Please give a valid operator' TYPE 'S' DISPLAY LIKE 'E'.
  RETURN. "Ablauflogik wieder beendet.
ENDIF.



CASE p_op.
WHEN `+`.
  lv_ergebnis = p_zahl_1 + p_zahl_2.
  WRITE :/ 'The result is :', lv_ergebnis.
WHEN '-'.
  lv_ergebnis = p_zahl_1 - p_zahl_2.
  WRITE :/ 'The result is :', lv_ergebnis.
WHEN '*'.
  lv_ergebnis = p_zahl_1 * p_zahl_2.
  WRITE :/ 'The result is :', lv_ergebnis.
WHEN '/'.
  IF p_zahl_2 NE 0.
    lv_ergebnis = p_zahl_1 / p_zahl_2.
    WRITE :/ 'The result is :', lv_ergebnis.
  ELSE.
    WRITE :/ 'Division by zero is not possible'.
  ENDIF.
*WHEN OTHERS.
*  WRITE :/ 'Operand not valid'.
ENDCASE.

WRITE :/ | { p_zahl_1 } { p_op } { p_zahl_2 }  =  { lv_ergebnis }|.
