FUNCTION ZS05_RECHNEN.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  Z05WW_TYPE
*"     REFERENCE(I_OP) TYPE  Z05WW_PAR
*"     REFERENCE(I_B) TYPE  Z05WW_TYPE
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  Z05WW_TYPE
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      N_ARGU
*"----------------------------------------------------------------------

CASE i_OP.
  WHEN '+'. e_RES = i_A + i_B.
  WHEN '-'. e_RES = i_A - i_B.
  WHEN '*'. e_RES = i_A * i_B.
  WHEN '/'.
  if i_B <> 0.
    e_res = i_a / i_b.
    ELSEIF i_B EQ 0.
      RAISE ZERO_DIVIDE.
      "WRITE: / 'DIVISION DURCH 0' COLOR COL_NEGATIVE.
      endif.
      when 'r' or 'R'. "square root
        if i_a < 0.
RAISE N_ARGU.
          else.
      e_res = sqrt( i_a ).
      endif.
      WHEN OTHERS.

        WRITE: / 'Falscher Operator' COLOR COL_GROUP.
     ENDCASE.


ENDFUNCTION.
