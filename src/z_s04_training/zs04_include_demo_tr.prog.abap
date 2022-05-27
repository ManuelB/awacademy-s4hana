*&---------------------------------------------------------------------*
*& Include          ZS04_DEMO_INCLUDE
*&---------------------------------------------------------------------*

**********************************************************************
*Eingabefelder:

SELECTION-SCREEN BEGIN OF BLOCK e WITH FRAME.

*  SELECTION-SCREEN BEGIN OF BLOCK e0 WITH FRAME.
*    PARAMETERS:
*    op TYPE foperator VALUE CHECK.
*  SELECTION-SCREEN END OF BLOCK e0.

  SELECTION-SCREEN BEGIN OF BLOCK e1 WITH FRAME.
    PARAMETERS:
      a1  TYPE betrag11  DEFAULT 3,
      op1 TYPE foperator VALUE CHECK DEFAULT '/',
      b1  TYPE betrag11  DEFAULT 0.
  SELECTION-SCREEN END OF BLOCK e1.

  SELECTION-SCREEN BEGIN OF BLOCK e2 WITH FRAME.
    PARAMETERS:
      a2  TYPE betrag11  DEFAULT 5,
      op2 TYPE foperator VALUE CHECK DEFAULT 'R',
      b2  TYPE betrag11  DEFAULT 7.
  SELECTION-SCREEN END OF BLOCK e2.

SELECTION-SCREEN END OF BLOCK e.



**********************************************************************
*Typisierung des Ergebnis (res = result):

DATA: res TYPE betrag11.
