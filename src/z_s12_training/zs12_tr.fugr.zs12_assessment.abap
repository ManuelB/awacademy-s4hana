FUNCTION ZS12_ASSESSMENT.
*"--------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS12_ZAHL
*"     REFERENCE(I_OP) TYPE  ZS12_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS12_ZAHL
*"  EXPORTING
*"     REFERENCE(EX_ERG) TYPE  ZS12_ZAHL
*"  EXCEPTIONS
*"      WRONG_OPERATOR
*"      DIVISION_ZERO
*"      NEGATIVE_ROOT
*"--------------------------------------------------------------------
CASE i_op.
  WHEN '+'.
    ex_erg = i_a + i_b.
  WHEN '-'.
    ex_erg = i_a - i_b.
      WHEN '*'.
    ex_erg = i_a * i_b.
      WHEN '/'.
        IF i_b = 0.
          raise division_zero.
          else.
            ex_erg = i_a / i_b.
        ENDIF.
      WHEN '**'.
    ex_erg = i_a ** i_b.
      WHEN 'r'.
        IF i_a < 0.
          Raise negative_root.
          else.
            ex_erg = sqrt( i_a ).
        ENDIF.
  WHEN OTHERS.
    raise wrong_operator.
ENDCASE.




ENDFUNCTION.
