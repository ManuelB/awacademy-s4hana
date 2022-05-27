*&---------------------------------------------------------------------*
*& Report Z_S08_CASEJM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S08_CASEJM.

REPORT Z_t04_CASE.


PARAMETERS p_zahl_1 TYPE p.
PARAMETERS p_op(1) TYPE c.
PARAMETERS p_zahl_2 TYPE p.

DATA lv_ergebnis TYPE p.

CASE p_op.
  WHEN '+'.
    WRITE:/ 'SUBSTRAKTION'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.

  WHEN '-'.
    WRITE:/ 'Addition'

  WHEN OTHERS.
ENDCASE.
