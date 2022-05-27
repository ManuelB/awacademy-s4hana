*&---------------------------------------------------------------------*
*& Report Z_S11_RECHNER_FORM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_RECHNER_FORM_FUGR2_DL.

PARAMETERS:
*p_curr type sflight-currency VALUE CHECK,
*p_oper type foperator value check,
  a1  TYPE zdl_fuba DEFAULT 3,
  op1 TYPE /SAPAPO/OPERATOR DEFAULT '+',
  b1  TYPE zdl_fuba DEFAULT 4,
  a2  TYPE zdl_fuba DEFAULT 5,
  op2 TYPE  /SAPAPO/OPERATOR DEFAULT '*',
  b2  TYPE zdl_fuba DEFAULT 7.
*
DATA:
  res TYPE zdl_fuba.

**************** 1. Rechnung***********************************

CALL FUNCTION 'ZS11_RECHNEN2'
  EXPORTING
    i_a           = a1
    i_op          = op1
    i_b           = b1
 IMPORTING
   E_RES         = res
 EXCEPTIONS
   ZERO_DIVIDE             = 1
   WRONG_OPERATOR          = 2
   NEGATIVE_ARGUMENT       = 3
   OTHERS                  = 4
          .
*
CASE sy-subrc.
  WHEN 0. PERFORM ausgabe USING a1 op1 b1 res.
  WHEN 1. WRITE: / 'Null-Division' COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / 'falscher Operator' COLOR COL_GROUP.
  WHEN 3. WRITE: / 'Negative arguent for square root ..not accepted !' color COL_HEADING.
  WHEN OTHERS.
    WRITE: / 'neuer Fehler: handling -> coming soon'.
ENDCASE.


***********************2.Rechnung*****************************


CALL FUNCTION 'ZS11_RECHNEN'
  EXPORTING
    i_a           = a2
    i_op          = op2
    i_b           = b2
 IMPORTING
   E_RES         = res
 EXCEPTIONS
   ZERO_DIVIDE             = 1
   WRONG_OPERATOR          = 2
   NEGATIVE_ARGUMENT       = 3
   OTHERS                  = 4
          .
 CASE sy-subrc.
  WHEN 0. PERFORM ausgabe USING a2 op2 b2 res.
  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / text-002 COLOR COL_GROUP.
  WHEN 3. WRITE: / 'Negative arguent for square root ..not accepted !' color COL_HEADING.
  WHEN OTHERS.
    WRITE: / 'neuer Fehler: handling -> coming soon'.
ENDCASE.


*
form ausgabe USING a op b res.
WRITE: /3 a,
       / op, b.
ULINE /3(12).
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
