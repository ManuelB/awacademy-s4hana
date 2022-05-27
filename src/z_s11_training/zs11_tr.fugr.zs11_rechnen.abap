FUNCTION zs11_rechnen.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZRK02_TY_BETRAG
*"     REFERENCE(I_OP) TYPE  ZRK02_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  ZRK02_TY_BETRAG
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  ZRK02_TY_BETRAG
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
