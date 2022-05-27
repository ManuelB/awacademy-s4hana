FUNCTION Z_S07_UEBUNG_R_E.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  I DEFAULT 5
*"     REFERENCE(I_OP) TYPE  C
*"     REFERENCE(I_B) TYPE  I
*"  EXPORTING
*"     REFERENCE(LV_ERG) TYPE  CACSMAPFACTOR
*"  EXCEPTIONS
*"      FALSCHER_OPERATOR
*"      DIVISION_NICHT_MOEGLICH
*"----------------------------------------------------------------------

IF I_op CA '/*-+'.
  else.
    MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN.

ENDIF.


CASE i_op.

  WHEN '+'.
    WRITE:/ 'Addieren'.
    lv_erg = i_a + i_b.

  WHEN '-'.
    WRITE:/ 'Subtrahieren'.
    lv_erg = i_a - i_b.

  WHEN '*'.
    WRITE:/ 'Multiplizieren'.
    lv_erg = i_a * i_b.


  WHEN '/'.
    IF i_b = 0.
*RAISE DIVISION_NICHT_MOEGLICH.
    MESSAGE 'Dividieren durch 0 nicht möglich.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN.
endif.
      WRITE:/ 'DIVISION'.
      lv_erg = i_a / i_b.


  WHEN OTHERS.
    WRITE: 'FEHLER'.
ENDCASE.








ENDFUNCTION.
