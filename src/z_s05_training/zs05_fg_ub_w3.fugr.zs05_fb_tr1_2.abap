FUNCTION ZS05_FB_TR1_2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(P_ZAHL1) TYPE  Z05WW_PZAHL
*"     REFERENCE(P_OP) TYPE  Z05WW_OPER
*"     REFERENCE(P_ZAHL2) TYPE  Z05WW_PZAHL
*"  EXPORTING
*"     REFERENCE(ERGEBNIS) TYPE  Z05WW_PZAHL
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      NEGATIVE
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
    WRITE: 'Quadratwurzel'.
    ENDIF.
    WHEN 'r' OR 'R'.
      if p_zahl1 < 0.
RAISE NEGATIVE.
ELSE.
    ergebnis = sqrt( p_zahl1 ).
    ENDIF.
WHEN '%'.
         IF p_zahl2 EQ 0.
RAISE ZERO_DIVIDE.
ELSEIF p_zahl1 > p_zahl2.
   ergebnis =  p_zahl1 * ( p_zahl2  / 100 ).
      ELSE.
  ergebnis =  p_zahl1 / ( p_zahl2  / 100 ).
  WRITE: 'Prozent'.
  ENDIF.
      WHEN OTHERS.
RAISE WRONG_OPERATOR.
ENDCASE.


ENDFUNCTION.
