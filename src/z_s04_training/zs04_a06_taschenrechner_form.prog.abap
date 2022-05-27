*&---------------------------------------------------------------------*
*& Report ZS04_TASCHENRECHNER_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a06_taschenrechner_form.


**********************************************************************
*Eingabefelder:

PARAMETERS:
  a1  TYPE i DEFAULT 3,
  op1 TYPE c LENGTH 1 DEFAULT '+',
  b1  TYPE i DEFAULT 4,
  a2  TYPE i DEFAULT 5,
  op2 TYPE c LENGTH 1 DEFAULT '*',
  b2  TYPE i DEFAULT 7.


**********************************************************************
*Typisierung des Ergebnis (res = result):


DATA: res TYPE i.


**********************************************************************
*1. Rechnung:


PERFORM rechnen USING a1 op1 b1 CHANGING res.
PERFORM ausgabe USING a1 op1 b1 res.


**********************************************************************
*2.Rechnung:


PERFORM rechnen USING a2 op2 b2 CHANGING res.
PERFORM ausgabe USING a2 op2 b2 res.


**********************************************************************
*Rechnen:


FORM rechnen USING a op b CHANGING res.
  CASE op.
    WHEN '+'. res = a + b.
    WHEN '-'. res = a - b.
    WHEN '*'. res = a * b.
    WHEN '/'. res = a / b.
  ENDCASE.
ENDFORM.


**********************************************************************
*Ausgabe:


FORM ausgabe USING a op b res.
  WRITE: /3 a,
         / op ,b.
  ULINE: /3(12).
  WRITE: /3 res.
ENDFORM.
