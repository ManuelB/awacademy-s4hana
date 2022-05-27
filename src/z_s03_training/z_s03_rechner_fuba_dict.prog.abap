*&---------------------------------------------------------------------*
*& Report Z_S03_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_rechner_fuba_dict.


*TASCHENRECHNER VON RAINER

PARAMETERS:

  a1     TYPE bruteil DEFAULT 3,
  op1    TYPE foperator DEFAULT '+',
  b1     TYPE bruteil DEFAULT 5,
  a2     TYPE bruteil DEFAULT 5,
  op2    TYPE foperator DEFAULT '*',
  b2     TYPE bruteil DEFAULT 7.

DATA: res TYPE bruteil.
CALL FUNCTION 'ZS03_RECHNEN2'
  EXPORTING
    i_a  = a1
    i_op = op1
    i_b  = a2
 IMPORTING
   E_RES                = res
 EXCEPTIONS
   ZERO_DIVIDE          = 1
   WRONG_OPERATOR       = 2
   OTHERS               = 3
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
  CASE sy-subrc.
    WHEN 0. PERFORM ausgabe USING a1 op1 b1 res.
    WHEN 1. WRITE: / 'Null Division'(001) COLOR COL_NEGATIVE.
    WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
    WHEN 3. WRITE: / 'Anderer Fehler'.
  ENDCASE.

ENDIF.

.
CALL FUNCTION 'ZS03_RECHNEN'
  EXPORTING
    i_a   = a2
    i_op  = op2
    i_b   = b2
  IMPORTING
    e_res = res.

*PERFORM rechnen USING a1 op1 b1 CHANGING res.
PERFORM ausgabe USING a1 op1 b1 res.



*   PERFORM rechnen USING a2 op2 b2 CHANGING res.
PERFORM ausgabe USING a2 op2 b2 res.


*FORM rechnen USING a op b CHANGING res.
*CASE op.
*  WHEN '+'. res = a + b.
*  WHEN '-'. res = a - b.
*  WHEN '*'. res = a * b.
*  WHEN '/'. res = a / b.
*  ENDCASE.
*  ENDFORM.

FORM ausgabe USING a op b res.
  WRITE: /3 a,
  / op, b.
  ULINE /3(12).
  WRITE: /3 res.
  ULINE.

ENDFORM.



* Attention quand on fait rechnen et ausgabe et on code en dur, il faut que les opérations soient les mêmes!
