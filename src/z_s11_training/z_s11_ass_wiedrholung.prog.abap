*&---------------------------------------------------------------------*
*& Report Z_S11_ASS_WIEDRHOLUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ASS_WIEDRHOLUNG.

Parameters:

  i_a  TYPE i DEFAULT '3',
  op TYPE zrk02_ty_operator DEFAULT '+',
  i_b  TYPE i DEFAULT 4.


DATA:
  res TYPE i.



*************************asessment1 question2**************************

CALL FUNCTION 'ZS11_RECHNEN'
  EXPORTING
    i_a              = i_a
    i_op              = op
    i_b              = i_b
  IMPORTING
    e_res             = res
  EXCEPTIONS
    zero_division     = 1
    wrong_operator    = 2
    negative_argument = 3
    OTHERS            = 4. "differently named 'Zero division exception' will through a runtime error only if there is no others clause
*
IF sy-subrc <> 0.
  CASE sy-subrc.
    WHEN 1. WRITE: / 'Null-Division' COLOR COL_NEGATIVE.
    WHEN 2. WRITE: / 'falscher Operator' COLOR COL_GROUP.
    WHEN 3. WRITE: / 'Negative arguent for square root ..not accepted !' COLOR COL_HEADING.
    WHEN OTHERS.
*      WRITE: / 'neuer Fehler: handling -> coming soon'.
  ENDCASE.

ELSE.
  WRITE: i_a, op, i_b, '=', res.
ENDIF.
