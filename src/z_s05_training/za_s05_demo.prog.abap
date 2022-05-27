*&---------------------------------------------------------------------*
*& Report ZA_S05_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZA_S05_DEMO.

PARAMETERS:
persnr TYPE n LENGTH 4 DEFAULT 123,
id TYPE C LENGTH 4 DEFAULT '1A2B3C'.

WRITE: / persnr, id.
persnr = id.
WRITE: / persnr.



PARAMETERS:
a1 TYPE i DEFAULT 3,
op1 TYPE c LENGTH 1 DEFAULT '+',
B1 TYPE I DEFAULT 4,
a2 TYPE i DEFAULT 5,
op2 TYPE c LENGTH 1 DEFAULT '*',
B2 TYPE I DEFAULT 7.

DATA:
      RES TYPE i.
WRITE: / 'Heute ist:', sy-datlo.
PERFORM RECHNEN USING A1 OP1 B1 CHANGING RES.
PERFORM AUSGABE USING A1 OP1 B1 RES.

PERFORM RECHNEN USING A2 OP2 B2 CHANGING RES.
PERFORM AUSGABE USING A2 OP2 B2 RES.


FORM RECHNEN USING a op b CHANGING res.
CASE OP.
  WHEN '+'. RES = A + B.
  WHEN '-'. RES = A - B.
  WHEN '*'. RES = A * B.
  WHEN '/'. RES = A / B.
  ENDCASE.

ENDFORM.

  FORM AUSGABE USING A OP B RES.
  WRITE: /3 A,
        / OP, B.
  ULINE /3(12).
  WRITE: /3 RES.
endform.

sELECTION-SCREEN: BEGIN OF LINE,

PUSHBUTTON 2(10) push USER-COMMAND fcode.

PARAMETERS para TYPE c LENGTH 20.

SELECTION-SCREEN:

COMMENT 40(40) text,

END OF LINE.
