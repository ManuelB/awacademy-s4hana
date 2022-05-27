FUNCTION z_s01_rechnen.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  BRUTEIL
*"     REFERENCE(I_OP) TYPE  ZRK02_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  BRUTEIL OPTIONAL
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  BRUTEIL
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      NEGATIVE_ARGUMENT
*"----------------------------------------------------------------------

*Funktionsbausteine.

  CASE i_op.
    WHEN '+'. e_res =  I_a + I_b.
    WHEN '-'. e_res =  I_a - I_b.
    WHEN '*'. e_res =  I_a * I_b.
    WHEN '/'.
      IF i_B <> 0.
        e_res =  I_a / I_b.
      ELSE.
        RAISE zero_divide.
*        WRITE:/ |Divison durch 0 nicht möglich| COLOR COL_NEGATIVE.
      ENDIF.
    WHEN 'r' OR 'R'. " für Wurzel
      IF i_a < 0.
        RAISE negative_argument.
      ELSE.
        e_res = sqrt( i_a ).
      ENDIF.
    WHEN OTHERS.
      RAISE wrong_operator.
  ENDCASE.

ENDFUNCTION.
