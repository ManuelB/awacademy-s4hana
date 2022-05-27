FUNCTION zs01_rechnen.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(F_OP) TYPE  FOPERATOR
*"     REFERENCE(F_1ZAHL) TYPE  OPERAND_VALUE
*"     REFERENCE(F_2ZAHL) TYPE  OPERAND_VALUE OPTIONAL
*"  EXPORTING
*"     REFERENCE(F_LV_RESULT) TYPE  OPERAND_VALUE
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      NEGATIVE_ARGUMENT
*"----------------------------------------------------------------------

  IF f_op CA '+-*/PpRr'.
    CASE f_op.
      WHEN '+'. f_lv_result = f_1zahl + f_2zahl.
      WHEN '-'. f_lv_result = f_1zahl - f_2zahl.
      WHEN '*'. f_lv_result = f_1zahl * f_2zahl.
      WHEN '/'.
        IF f_2zahl <> 0 .
          f_lv_result = f_1zahl / f_2zahl.
        ELSE.
          RAISE zero_divide.

        ENDIF.

      WHEN 'R' OR 'r'.
        IF  f_1zahl < 0.
          RAISE Negative_ARGUMENT.
        ELSE.
          f_lv_result = sqrt( f_1zahl ).
        ENDIF.

      WHEN 'P' OR 'p'.
        f_lv_result = f_1zahl / f_2zahl.

    ENDCASE.

  ELSE.

    RAISE wrong_operator.
  ENDIF.



ENDFUNCTION.
