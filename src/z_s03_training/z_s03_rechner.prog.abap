*&---------------------------------------------------------------------*
*& Report Z_S03_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_rechner.

*DATA lv_Zahl TYPE p DECIMALS 2.
*
**DATA lv_ergebnis TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE f.
*
*SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.
*
*  PARAMETERS p_zahl_1 LIKE lv_zahl.
*  PARAMETERS p_zahl_2 LIKE lv_zahl.
*
*  PARAMETERS p_add RADIOBUTTON GROUP r1.
*  PARAMETERS p_sub RADIOBUTTON GROUP r1.
*  PARAMETERS p_mult RADIOBUTTON GROUP r1.
*  PARAMETERS p_div RADIOBUTTON GROUP r1.
*SELECTION-SCREEN END OF BLOCK b0.
*
*
*IF p_add EQ abap_true.
*
*  lv_ergebnis = p_zahl_1 + p_zahl_2.
*  WRITE: / 'Addition!', lv_ergebnis.
*
*ELSEIF p_sub EQ 'X'.
*  lv_ergebnis = p_zahl_1 - p_zahl_2.
*  WRITE: / ' Substraktion!', lv_ergebnis.
*
*ELSEIF p_mult EQ 'X'.
*  lv_ergebnis = p_zahl_1 * p_zahl_2.
*  WRITE: / 'Multiplikation!', lv_ergebnis.
*
*ELSEIF p_div EQ 'X'.
*
*  WRITE: /'Division!'.
*  IF p_zahl_2 EQ 0.
*    WRITE: 'Fehler'.
*    EXIT.
*  ELSE.
*    lv_ergebnis = p_zahl_1 / p_zahl_2.
*    WRITE: / 'Division!', lv_ergebnis.
*
*  ENDIF.
*
*  IF lv_ergebnis IS NOT INITIAL.
*    WRITE: / lv_ergebnis.
*  ELSE.
*    WRITE: / 'Fehler: Ergebnismenge leer!'.
*  ENDIF.
*
*ENDIF.

*TASCHENRECHNER VON RAINER

PARAMETERS:
a1 TYPE i DEFAULT 3,
op1 TYPE c LENGTH 1 DEFAULT '+',
b1 TYPE i DEFAULT 4,
A2 TYPE i DEFAULT 5,
op2 TYPE c LENGTH 1 DEFAULT '*',
b2 TYPE i DEFAULT 7.

DATA: res TYPE i.

PERFORM rechnen USING a1 op1 b1 CHANGING res.
  PERFORM ausgabe USING a1 op1 b1 res.

   PERFORM rechnen USING a2 op2 b2 CHANGING res.
  PERFORM ausgabe USING a2 op2 b2 res.


FORM rechnen USING a op b CHANGING res.
CASE op1.
  WHEN '+'. res = a + b.
  WHEN '-'. res = a - b.
  WHEN '*'. res = a * b.
  WHEN '/'. res = a / b.
  ENDCASE.
  ENDFORM.

  FORM ausgabe USING a op b res.
  WRITE: /3 a,
  / op, b.
  ULINE /3(12).
  WRITE: /3 res.
   ULINE.

  ENDFORM.



* Attention quand on fait rechnen et ausgabe et on code en dur, il faut que les opérations soient les mêmes!
