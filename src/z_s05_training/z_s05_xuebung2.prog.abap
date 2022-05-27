*&---------------------------------------------------------------------*
*& Report Z_S05_XUEBUNG1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XUEBUNG2.

*******************************************************
*Übung 1 Taschenrechner Basic*
PARAMETERS:

p_zahl1 TYPE p LENGTH 7 DECIMALS 2 DEFAULT  '2',
p_op TYPE C DEFAULT '+',
p_zahl2 TYPE p  LENGTH 7 DECIMALS 2 DEFAULT '3'.

DATA: ergebnis TYPE P LENGTH 7 DECIMALS 2.

IF p_op CA '+-*/'.
  "Programm geht weiter
  ELSE.
    MESSAGE: 'Das ist leider eine Falsche Eingabe, geben sie bitte einen valieden Rechenoperator an.' TYPE 'E' DISPLAY LIKE 'I'.
    return.
    ENDIF.


PERFORM rechnen USING p_zahl1 p_op p_zahl2 CHANGING ergebnis.
PERFORM ausgabe USING p_zahl1 p_op p_zahl2 ergebnis.

FORM rechnen USING zahl1 op zahl2 CHANGING erg.
CASE p_op.
  WHEN '+'.
    ergebnis = p_zahl1 + p_zahl2.
    WRITE: 'Addition'. " { p_zahl1 }{ p_op }{ p_zahl2 } = { ergebnis } |.
  WHEN '-'.
 ergebnis = p_zahl1 - p_zahl2.
    WRITE: 'Subtraction'.
     WHEN '*'.
 ergebnis = p_zahl1 * p_zahl2.
    WRITE: 'Multiplication'.
     WHEN '/'.
       IF p_zahl2 EQ 0.
      MESSAGE: 'Division durch 0 nicht Erlaubt!.' TYPE 'E'.
RETURN.
      ELSE.
 ergebnis = p_zahl1 / p_zahl2.
    WRITE: 'Division'.
    ENDIF.
    WHEN OTHERS.
      MESSAGE: 'Das ist leider eine Falsche Eingabe.' type 'E'.
      return.

     ENDCASE.
     ENDFORM.

     FORM ausgabe USING p_zahl1 p_op p_zahl2 ergebnis.
ULINE /.
write: / | { p_zahl1 } { p_op } { p_zahl2 }  =  { ergebnis } |.
endform.
