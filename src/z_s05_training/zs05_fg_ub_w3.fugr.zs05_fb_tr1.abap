FUNCTION ZS05_FB_TR1.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(P_ZAHL1) TYPE  Z05WW_TYPE
*"     REFERENCE(P_OP) TYPE  Z05WW_PAR
*"     REFERENCE(P_ZAHL2) TYPE  Z05WW_TYPE
*"  EXPORTING
*"     REFERENCE(ERGEBNIS) TYPE  Z05WW_TYPE
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"----------------------------------------------------------------------

CASE p_op.
  WHEN '+'.
    ergebnis = p_zahl1 + p_zahl2.
    WRITE: 'Addition'.
  WHEN '-'.
 ergebnis = p_zahl1 - p_zahl2.
    WRITE: 'Subtraction'.
     WHEN '*'.
 ergebnis = p_zahl1 * p_zahl2.
    WRITE: 'Multiplication'.
     WHEN '/'.
       IF p_zahl2 EQ 0.
RAISE ZERO_DIVIDE.
      ELSE.
 ergebnis = p_zahl1 / p_zahl2.
    WRITE: 'Division'.
    ENDIF.
    WHEN OTHERS.
RAISE WRONG_OPERATOR.

ENDCASE.


ENDFUNCTION.
