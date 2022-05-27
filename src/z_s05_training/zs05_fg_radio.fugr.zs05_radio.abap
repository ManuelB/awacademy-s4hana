FUNCTION ZS05_RADIO.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(P_ADD) TYPE  C OPTIONAL
*"     REFERENCE(P_SUB) TYPE  C OPTIONAL
*"     REFERENCE(P_MULT) TYPE  C OPTIONAL
*"     REFERENCE(P_DIV) TYPE  C OPTIONAL
*"     REFERENCE(P_ZAHL1) TYPE  I
*"     REFERENCE(P_ZAHL2) TYPE  I
*"  EXPORTING
*"     REFERENCE(LV_ERGEBNIS) TYPE  I
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"----------------------------------------------------------------------
CASE 'X'.
  WHEN p_add.
    WRITE: / 'Addition'.
     lv_ergebnis = p_zahl1 + p_zahl2.
     "WRITE: / lv_ergebnis.
       WHEN p_sub.
    WRITE: / 'Subtraction'.
     lv_ergebnis = p_zahl1 - p_zahl2.
    " WRITE: / lv_ergebnis.
       WHEN p_mult.
    WRITE: / 'Multiplication'.
     lv_ergebnis = p_zahl1 * p_zahl2.
   "  WRITE: / lv_ergebnis.
WHEN p_div.
    WRITE: / 'Division'.
  if p_zahl2 <> 0.
    lv_ergebnis = p_zahl1 / p_zahl2.
   " WRITE: / lv_ergebnis.
else.
RAISE ZERO_DIVIDE.
   " WRITE 'Fehler! Die Division durch 0 ist nicht erlaubt '.
endif.
when others.
  RAISE WRONG_OPERATOR.
  "WRITE: / 'Fehler! Keine korrekte Verrechnungsoperation gewält'.
endcase.



ENDFUNCTION.
