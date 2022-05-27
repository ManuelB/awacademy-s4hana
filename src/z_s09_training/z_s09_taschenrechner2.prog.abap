*&---------------------------------------------------------------------*
*& Report Z_S09_TASCHENRECHNER2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_taschenrechner2.

PARAMETERS:

  a1  TYPE i DEFAULT 3,
  op1 TYPE c LENGTH 1 DEFAULT '+',
  b1  TYPE i DEFAULT 4,
  a2  TYPE i DEFAULT 5,
  op2 TYPE c LENGTH 1 DEFAULT '*',
  b2  TYPE i DEFAULT 7.

DATA:
res TYPE i.

CALL FUNCTION 'Z09_RECHNEN'
  EXPORTING
    i_a            = a1
    i_op           = op1
    i_b            = b1
  IMPORTING
    e_res          = res
  EXCEPTIONS
    zero_divide    = 1
    wrong_operator = 2
    OTHERS         = 3.

IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1. WRITE: / 'Null-Division' COLOR COL_NEGATIVE.
    WHEN 2. WRITE: / 'falscher Operator' COLOR COL_GROUP.
    WHEN 3. WRITE: / 'ein anderer Fehler'.
    WHEN OTHERS.
      "coming soon"
  ENDCASE.

  WRITE: / 'Fehler' COLOR COL_NEGATIVE, sy-subrc.
ELSE. "wenn alles gut geht ->Ausgeben.
  PERFORM ausgabe USING a1 op1 b1 res.
ENDIF.
.




"1. Rechnung"
"PERFORM rechnen USING a1 op1 b1 CHANGING res.
"PERFORM ausgabe USING a1 op1 b1 res.

"2. Rechnung"
"PERFORM rechnen USING a2 op2 b2 CHANGING res.
"PERFORM ausgabe USING a2 op2 b2 res.

"FORM rechnen USING a op b CHANGING res.

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
ENDFORM.
