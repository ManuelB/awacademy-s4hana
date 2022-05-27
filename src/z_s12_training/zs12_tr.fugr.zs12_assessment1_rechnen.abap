FUNCTION ZS12_ASSESSMENT1_RECHNEN.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS12_ZAHL
*"     REFERENCE(I_OP) TYPE  ZS12_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS12_ZAHL
*"     REFERENCE(I_ERG) TYPE  ZS12_ZAHL
*"  EXCEPTIONS
*"      WRONG_OPERATOR
*"      DIVISION_ZERO
*"      NEGATIVE_ROOT
*"----------------------------------------------------------------------
CASE i_op.
  WHEN '+'.
    i_erg = i_a + i_b.
  WHEN '-'.
    i_erg = i_a - i_b.
      WHEN '*'.
   i_erg = i_a * i_b.
      WHEN '/'.
        IF i_b = 0.
          raise division_zero.
          else.
            i_erg = i_a / i_b.
        ENDIF.
      WHEN '**'.
    ex_erg = i_a ** i_b.
      WHEN 'r'.
        IF i_a < 0.
          Raise negative_root.
          else.
            i_erg = sqrt( i_a ).
        ENDIF.
  WHEN OTHERS.
    raise wrong_operator.
ENDCASE.




ENDFUNCTION.
