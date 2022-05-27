*&---------------------------------------------------------------------*
*& Report Z_S02_RECHNER_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_rechner_2.

*** Ziel: Rechner mit der Möglichkeit, zwei Berechnungen zu machen
*********** man könnte die zweite REchnung nochaml aufschreiben. Das will man aber nicht
*********** Code definieren, damit man ihn als Block aufrufen kann


*** EIngabeparameter

PARAMETERS:
  a1  TYPE i DEFAULT 3,
  op1 TYPE c LENGTH 1 DEFAULT '+',
  b1  TYPE i DEFAULT 4,
  a2  TYPE i DEFAULT 5,
  op2 TYPE c LENGTH 1 DEFAULT '*',
  b2  TYPE i DEFAULT 7.



*** Resultat typisieren

DATA:
  res TYPE i.


*** 1. Rechnung
PERFORM rechnen USING a1 op1 b1 CHANGING res.
PERFORM ausgabe USING a1 op1 b1 res.




*** 2. Rechnung
PERFORM rechnen USING a2 op2 b2 CHANGING res.
PERFORM ausgabe USING a2 op2 b2 res.


***
FORM rechnen USING a op b CHANGING res.
  CASE op.
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
ENDFORM.
