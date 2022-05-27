*&---------------------------------------------------------------------*
*& Report Z_S11_VERSCHATTUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_VERSCHATTUNG.

***********Verschattung1******************************

*DATA:
*  op1 TYPE i,
*  op2 TYPE i,
*  res TYPE i.
*op1 = 10.
*op2 = 1.
**call FUNCTION 'HALLO'.
**
*PERFORM add USING op1 res.
*WRITE: / 'Ergebnis:', op1, res.
**
*FORM add USINg p_op1 p_res.
*  DATA:
*        op1 TYPE i VALUE 4.
*  p_res = p_op1 + op2.
**  res = 99.
*
*ENDFORM.

*******************Verschattung2***********************


DATA:
  op1    TYPE i,
  name TYPE string VALUE 'Rainer',
  op2    TYPE i,
  op3    TYPE i VALUE 7,
  result TYPE i.
*
op1 = 1.
op2 = 1.
*
*PERFORM addition USING op1 name CHANGING result.
PERFORM addition USING op1 op2 CHANGING result.
WRITE: / 'Ergebnis:', op1, '+', op2, '=', result, op3.
*
FORM addition USING VALUE(p_op1) VALUE(p_op2)  CHANGING VALUE(P_result).
  "DATA:
   " result TYPE i.
  op1 = 99.
  result = p_op1 + p_op2.
  p_op2 = 77.
  op3 = 111.
  "p_op3 = 55.
  p_result = result.
ENDFORM.


***************Verschattung3******************************


*DATA:
*  op1    TYPE i,
*  op2    TYPE i,
*  ergebnis TYPE i.
**  result TYPE i.
**
*op1 = 1.
*op2 = 1.
**
* PERFORM addition USING op1 op2 ergebnis.
*  WRITE: / 'Ergebnis:', op1, '+', op2, '=', ergebnis.
**
*FORM addition USING VALUE(p_op1) VALUE(p_op2) CHANGING VALUE(P_result).
*  DATA:
*    result TYPE I.
*  result = p_op1 + p_op2.
*  p_result = ergebnis.
*ENDFORM.
