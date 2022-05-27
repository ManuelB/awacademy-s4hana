*&---------------------------------------------------------------------*
*& Report Z_S03_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_rechner_fuba.


*TASCHENRECHNER VON RAINER

PARAMETERS:
p_curr TYPE sflight-currency VALUE CHECK,
* on peut aussi déclarer DTEL S_CURRCODE avec DTEL pour Datenelement
p_oper TYPE foperator,
a1 TYPE i DEFAULT 3,
op1 TYPE c LENGTH 1,
b1 TYPE i,
A2 TYPE i DEFAULT 5,
op2 TYPE c LENGTH 1 DEFAULT '*',
b2 TYPE i DEFAULT 7.

DATA: res TYPE i.
CALL FUNCTION 'ZS03_RECHNEN'
  EXPORTING
    i_a                  = a1
    i_op                 = op1
    i_b                  = b1
 IMPORTING
   E_RES                = res
 EXCEPTIONS
   ZERO_DIVIDE          = 1
   WRONG_OPERATOR       = 2
   OTHERS               = 3
          .

* Implement suitable error handling here
  CASE sy-subrc.
    WHEN 0. PERFORM ausgabe USING a1 op1 b1 res.
    WHEN 1. WRITE: / 'Null Division'(001) COLOR COL_NEGATIVE.
    WHEN 2. WRITE: / text-002 COLOR COL_GROUP.
    WHEN 3. WRITE: / 'Anderer Fehler'.
    ENDCASE.


          .
CALL FUNCTION 'ZS03_RECHNEN'
  EXPORTING
    i_a           = a2
    i_op          = op2
    i_b           = b2
 IMPORTING
   E_RES         = res
          .

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
