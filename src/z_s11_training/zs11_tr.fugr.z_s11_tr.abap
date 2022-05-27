FUNCTION Z_S11_TR.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  Z11SZ_TY_ZAHL
*"     REFERENCE(I_B) TYPE  Z11SZ_TY_ZAHL
*"     REFERENCE(I_OP) TYPE  Z11SZ_TY_OPERATOR
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  Z11SZ_TY_ZAHL
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      NEGATIVE_ARGUMENT
*"      WRONG_OPERATOR
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
