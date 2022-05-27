*&---------------------------------------------------------------------*
*& Report Z_S11_RECHNER_FORM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_RECHNER_FORM.

PARAMETERS:
  a1  TYPE i DEFAULT 3,
  op1 TYPE c LENGTH 1 DEFAULT '+',
  b1  TYPE i DEFAULT 4,
  a2  TYPE i DEFAULT 5,
  op2 TYPE c LENGTH 1 DEFAULT '*',
  b2  TYPE i DEFAULT 7.
*
DATA:
  res TYPE i.
* 1. Rechnung
PERFORM rechnen USING a1 op1 b1 CHANGING res.
PERFORM ausgabe USING a1 op1 b1 res.
*
* 2. Rechnung
PERFORM rechnen USING a2 op2 b2 CHANGING res.
PERFORM ausgabe USING a2 op2 b2 res.
*write a.

*
FORM rechnen USING a op b CHANGING res.
  CASE op.
    WHEN '+'. res = a + b.
    WHEN '-'. res = a - b.
    WHEN '*'. res = a * b.
    WHEN '/'. res = a / b.
  ENDCASE.

ENDFORM.
*
form ausgabe USING a op b res.
  data x type i value 3.
WRITE: /3 a,
       / op, b.
ULINE /3(100).
WRITE: /3 res.
ENDFORM.


*DATA lv_zahl_1 TYPE p.  "VALUE IS INITIAL.
*DATA lv_zahl_2 TYPE p.
*DATA lv_ergebnis TYPE p DECIMALS 2.
**DATA lv_ergebnis TYPE F.
*
*INITIALIZATION.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
*  PARAMETERS p_zahl_1 LIKE lv_zahl_1.
*  PARAMETERS p_zahl_2 LIKE lv_zahl_2.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
*  PARAMETERS p_add RADIOBUTTON GROUP rb_1.
*  PARAMETERS p_sub RADIOBUTTON GROUP rb_1.
*  PARAMETERS p_mul RADIOBUTTON GROUP rb_1.
*  PARAMETERS p_div RADIOBUTTON GROUP rb_1.
*SELECTION-SCREEN END OF BLOCK b2.
*
*START-OF-SELECTION.
*
**1. Rechnung
*
*PERFORM rechnen USING p_zahl_1 p_zahl_2 CHANGING lv_ergebnis.
*PERFORM ausgabe USING p_zahl_1 p_zahl_2 lv_ergebnis.
*
**2. Rechnung
*
*PERFORM rechnen USING p_zahl_1 p_zahl_2 CHANGING lv_ergebnis.
*PERFORM ausgabe USING p_zahl_1 p_zahl_2 lv_ergebnis.
*
*Form rechnen USING p_zahl_1 p_zahl_2 changing lv_ergebnis.
*WRITE : /'Zahl 1', p_zahl_1.
*WRITE : /'Zahl 2', p_zahl_2.
*IF p_add = 'X'.
*  lv_ergebnis = p_zahl_1 + p_zahl_2.
*ELSEIF
*  p_sub = 'X'.
*  if p_zahl_1 >= p_zahl_2.
*  lv_ergebnis = p_zahl_1 - p_zahl_2.
*  else.
*   lv_ergebnis = p_zahl_2 - p_zahl_1.
*   endif.
*ELSEIF
*  p_mul = 'X'.
*
*  lv_ergebnis = p_zahl_1 * p_zahl_2.
**  write :/ | p_zahl_1 { * } p_zahl_2 |.
*ELSEIF
*  p_div = 'X'.
*  IF p_zahl_2 EQ 0.
*    WRITE :/ 'Division by 0 is not possible'.
*    Exit.
*
*  ELSE.
*    lv_ergebnis = p_zahl_1 / p_zahl_2.
*  ENDIF.
**ELSE.
**  WRITE :/ 'No operand selected'.
*
*ENDIF.
*ENDFORM.
*
*form ausgabe USING p_zahl_1 p_zahl_2 lv_ergebnis.
*IF lv_ergebnis IS NOT INITIAL.
*
*  WRITE : /'The ergebnis is',lv_ergebnis.
*ELSE.
*  WRITE : / 'The result is 0.00'.
*ENDIF.
*ENDFORM.
*
*End-of-SELECTION.
