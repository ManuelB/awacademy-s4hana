FUNCTION Z_S02_RECHNEN_3.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS02C_TY_BETRAG
*"     REFERENCE(I_OP) TYPE  ZS02C_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS02C_TY_BETRAG
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  ZS02C_TY_BETRAG
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
*      e_res = i_a / i_b.
      IF i_b <> 0.
        e_res = i_a / i_b.
      ELSE.
        RAISE zero_divide.
        WRITE: / 'Division durch Null!' COLOR COL_NEGATIVE. "Roter Hintergrund der Meldung.
      ENDIF.
    WHEN 'r' OR 'R'. "square root
      IF i_a < 0.     " operation nicht erlaubt
        RAISE negative_argument.
      ELSE.
        e_res = sqrt( i_a ).
      ENDIF.
    WHEN 'e' OR 'E'.
      e_res = i_a ** i_b.
    WHEN OTHERS.
      WRITE: / 'Falscher Operator.' COLOR COL_GROUP. "Oranger Hintergrund der Meldung.
  ENDCASE.




ENDFUNCTION.
