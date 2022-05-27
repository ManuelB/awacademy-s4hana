FUNCTION ZS07_RECHNEN2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  CACSMAPFACTOR OPTIONAL
*"     REFERENCE(I_OP) TYPE  /SAPAPO/OPERATOR
*"     REFERENCE(I_B) TYPE  CACSMAPFACTOR
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  CACSMAPFACTOR
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      N_ARGU
*"----------------------------------------------------------------------
CASE i_op.
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
