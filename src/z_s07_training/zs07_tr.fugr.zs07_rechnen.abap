FUNCTION ZS07_RECHNEN.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS07Z_TY_BETRAG OPTIONAL
*"     REFERENCE(I_OP) TYPE  ZS07Z_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS07Z_TY_BETRAG
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  ZS07Z_TY_BETRAG
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"----------------------------------------------------------------------
CASE i_op.
  WHEN '+'.
*    WRITE:/ 'ADDITION'.
    e_res = i_a + i_b.

  WHEN '-'.
*    WRITE:/ 'SUBTRAKTION'.
    e_res = i_a - i_b.

  WHEN '*'.
*    WRITE:/ 'MULTIPLIKATION'.
    e_res = i_a * i_b.

  WHEN '/'.
      IF i_b <> 0.
        e_res = i_a / i_b.
      ELSE.
        RAISE zero_divide.
        "WRITE: / 'Division durch Null' COLOR COL_NEGATIVE.
      ENDIF.
*
    WHEN OTHERS.
      RAISE wrong_operator.
      "WRITE: / 'Falscher Operator' COLOR COL_GROUP.
  ENDCASE.



ENDFUNCTION.
