*&---------------------------------------------------------------------*
*& Report Z_S09_TR3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_tr3.

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
    n_argu         = 3
    OTHERS         = 4.

"IF sy-subrc <> 0.
CASE sy-subrc.

  WHEN 0. PERFORM AUSGABE USING a1 op1 b1 res.
  WHEN 1. WRITE: / 'DIVISION DURCH 0'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / text-002 COLOR COL_GROUP.
  WHEN 4. WRITE: / 'negatives argument' COLOR COL_GROUP.
  WHEN 3. WRITE: / 'UNBEKANNTE FEHLER' COLOR COL_NEGATIVE.
  WHEN OTHERS.


    WRITE: / 'neue Fehler' COLOR COL_GROUP.


ENDCASE.


"ENDIF.
"PERFORM RECHNEN USING A2 OP2 B2 CHANGING RES.
"PERFORM AUSGABE USING A1 OP1 B1 RES.


"PERFORM RECHNEN USING A1 OP1 B1 CHANGING RES.
"PERFORM AUSGABE USING A1 OP1 B1 RES.


CALL FUNCTION 'Z09_RECHNEN'
  EXPORTING
    i_a            = a2
    i_op           = op2
    i_b            = b2
  IMPORTING
    e_res          = res
  EXCEPTIONS
    zero_divide    = 1
    wrong_operator = 2
    n_argu         = 3
    OTHERS         = 4.

"IF sy-subrc <> 0.
CASE sy-subrc.
  WHEN 0. PERFORM ausgabe USING a2 op2 b2 res.
  WHEN 1. WRITE: / 'DIVISION DURCH 0' COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / 'FALSHER OPERATOR' COLOR COL_GROUP.
  WHEN 3. WRITE: / 'negatives argument' COLOR COL_GROUP.
  WHEN 4. WRITE: / 'UNBEKANNTE FEHLER' COLOR COL_NEGATIVE.
  WHEN OTHERS.
    WRITE: / 'neue Fehler' COLOR COL_GROUP.
ENDCASE.

"ENDIF.
"PERFORM RECHNEN USING A2 OP2 B2 CHANGING RES.

FORM AUSGABE USING a op b res.
  WRITE: /3 a,
  / op, b.
  ULINE /3(12).
  WRITE: /3 res.
  Endform.
