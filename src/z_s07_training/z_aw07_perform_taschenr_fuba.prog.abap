*&---------------------------------------------------------------------*
*& Report Z_AW07_PERFORM_TASCHENRECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_perform_taschenr_fuba.



PARAMETERS a1 TYPE zs07z_ty_betrag DEFAULT 5.
PARAMETERS op1 TYPE ZS07Z_TY_operator DEFAULT '+'.
PARAMETERS b1 TYPE zs07z_ty_betrag DEFAULT 17.

PARAMETERS a2 TYPE zs07z_ty_betrag DEFAULT 5.
PARAMETERS op2  TYPE ZS07Z_TY_operator DEFAULT '*'.
PARAMETERS b2 TYPE zs07z_ty_betrag DEFAULT 17.


DATA res TYPE zs07z_ty_betrag.

CALL FUNCTION 'ZS07_RECHNEN'
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


CASE sy-subrc.
  WHEN 0.
    PERFORM ausgabe USING a1 op1 b1 res.
  WHEN 1.
    WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2.
    WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 3.
    WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
    WRITE: / 'neuer Fehler'.
ENDCASE.

CALL FUNCTION 'ZS07_RECHNEN'
  EXPORTING
    i_a            = a2
    i_op           = op2
    i_b            = b2
  IMPORTING
    e_res          = res
  exceptions
    zero_divide    = 1
    wrong_operator = 2
    OTHERS         = 3.


CASE sy-subrc.
  WHEN 0.
    PERFORM ausgabe USING a2 op2 b2 res.
  WHEN 1.
    WRITE: / 'Null-Division' COLOR COL_NEGATIVE.
  WHEN 2.
    WRITE: / 'falscher Operator' COLOR COL_GROUP.
  WHEN 3.
    WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
    WRITE: / 'neuer Fehler'.
ENDCASE.


*PERFORM rechnen USING a1 op1 b1 CHANGING res.
PERFORM ausgabe USING a1 op1 b1 res.
*
* 2. Rechnung
*PERFORM rechnen USING a2 op2 b2 CHANGING res.
PERFORM ausgabe USING a2 op2 b2 res.

*FORM rechnen USING a op b CHANGING res.
*  CASE op.
*    WHEN '+'.
*      WRITE:/ 'ADDITION'.
*      res = a + b.
*
*    WHEN '-'.
*      WRITE:/ 'SUBTRAKTION'.
*      res = a - b.
*
*    WHEN '*'.
*      WRITE:/ 'MULTIPLIKATION'.
*      res = a * b.
*
*    WHEN '/'.
*      IF b EQ 0.
*        WRITE: / 'Fehler: Division durch 0 nicht möglich'.
*      ELSE.
*        WRITE:/ 'DIVISION'.
*        res = a / b.
*      ENDIF.
*
*    WHEN OTHERS.
*      WRITE: 'FEHLER'.
*  ENDCASE.
*
*
*  WRITE: / a, op, b, '=', res.
*ENDFORM.

FORM ausgabe USING a op b res.
  WRITE: / a, op, b.

  WRITE: / res.
  ULINE.
ENDFORM.
