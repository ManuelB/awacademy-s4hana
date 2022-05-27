FUNCTION ZS11_RECHNEN2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZDL_FUBA
*"     REFERENCE(I_OP) TYPE  /SAPAPO/OPERATOR
*"     REFERENCE(I_B) TYPE  ZDL_FUBA
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  ZDL_FUBA
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      NEGATIVE_ARGUMENT
*"----------------------------------------------------------------------

  CASE i_op.
    WHEN '+'.
      e_res = i_a + i_b.
    WHEN '-'.
      e_res = i_a - i_b.
    WHEN '*'.
      e_res = i_a * i_b.
    WHEN '/'.
      IF i_b NE 0.
        e_res = i_a / i_b.
      ELSE.
*           write :/ 'division durch 0' color col_negative.
        RAISE zero_divide.
      ENDIF.

    WHEN 'r' OR 'R'.
      IF i_a > 0.
        e_res = sqrt( i_a ).
      ELSE.
        RAISE negative_argument.
      ENDIF.
    WHEN OTHERS.
      RAISE wrong_operator.
      WRITE :/ 'Falscher operator' COLOR COL_GROUP.

  ENDCASE.



ENDFUNCTION.
