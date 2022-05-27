*&---------------------------------------------------------------------*
*& Report Z_AW07_UEBUNGEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_UEBUNGEN.



PARAMETERS p_a TYPE i DEFAULT 5.
PARAMETERS p_op  TYPE Z_S07_RECHNER DEFAULT '/'.
PARAMETERS p_b TYPE i DEFAULT 17.

DATA lv_erg TYPE p DECIMALS 3.

IF p_op CA '/*-+PR'.
  else.
    MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN.

ENDIF.

CASE p_op.
  WHEN '+'.
    WRITE:/ 'Addieren'.
    lv_erg = p_a + p_b.

  WHEN '-'.
    WRITE:/ 'Subtrahieren'.
    lv_erg = p_a - p_b.

  WHEN '*'.
    WRITE:/ 'Multiplizieren'.
    lv_erg = p_a * p_b.



  WHEN '/'.
    IF p_b = 0.

    MESSAGE 'Dividieren durch 0 nicht möglich.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN.
endif.
      WRITE:/ 'DIVISION'.
      lv_erg = p_a / p_b.
  WHEN OTHERS.
    WRITE: 'FEHLER'.
ENDCASE.


WRITE: / p_a, p_op, p_b, '=', lv_erg.
