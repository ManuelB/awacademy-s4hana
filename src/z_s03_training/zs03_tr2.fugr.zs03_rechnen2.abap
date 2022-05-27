FUNCTION ZS03_RECHNEN2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  Z03CB_TY_BETRAG
*"     REFERENCE(I_OP) TYPE  FOPERATOR
*"     REFERENCE(I_B) TYPE  Z03CB_TY_BETRAG
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  Z03CB_TY_BETRAG
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"----------------------------------------------------------------------
  "----------------------------------------------------------------------
  "*"Lokale Schnittstelle:
  "  IMPORTING
  "     REFERENCE(I_A) TYPE  I
  "     REFERENCE(I_OP) TYPE  C
  "     REFERENCE(I_B) TYPE  I
  "  EXPORTING
  "     REFERENCE(E_RES) TYPE  I
  "  EXCEPTIONS
  "      ZERO_DIVIDE
  "      WRONG_OPERATOR
  "----------------------------------------------------------------------

  CASE i_op.
    WHEN '+'. e_res = i_a + i_b.
    WHEN '-'. e_res = i_a - i_b.
    WHEN '*'. e_res = i_a * i_b.
    WHEN '/'.
      IF i_b <> 0.
        e_res = i_a / i_b.
      ELSE.
 RAISE zero_divide.
        WRITE: / 'Division durch null' COLOR COL_NEGATIVE.
      ENDIF.
      WHEN OTHERS.
 RAISE wrong_operator.
        WRITE: / 'Falscher Operator' COLOR COL_GROUP.

  ENDCASE.

ENDFUNCTION.
