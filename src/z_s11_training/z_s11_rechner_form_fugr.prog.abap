*&---------------------------------------------------------------------*
*& Report Z_S11_RECHNER_FORM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_rechner_form_fugr.

*include Z_S11_INCLUDE_FUGR.
PARAMETERS:
*p_curr type sflight-currency VALUE CHECK,
*p_oper type foperator value check,
  a  TYPE i DEFAULT '3',
  op TYPE zrk02_ty_operator DEFAULT '+',
  b  TYPE zrk02_ty_betrag DEFAULT '8.335'.
*  a2  TYPE zrk02_ty_betrag DEFAULT 5,
*  op2 TYPE  zrk02_ty_operator DEFAULT '*',
*  b2  TYPE zrk02_ty_betrag DEFAULT 7.

DATA:
  res TYPE zrk02_ty_betrag.

**************** 1. Rechnung***********************************

*CALL FUNCTION 'ZS11_RECHNEN'
*  EXPORTING
*    i_a           = a
*    i_op          = op
*    i_b           = b
* IMPORTING
*   E_RES         = res
* EXCEPTIONS
*   ZERO_DIVISION             = 1
*   WRONG_OPERATOR          = 2
*   NEGATIVE_ARGUMENT       = 3
*   OTHERS                  = 4
*          .
**
*CASE sy-subrc.
*  WHEN 0. PERFORM ausgabe USING a op b res.
*  WHEN 1. WRITE: / 'Null-Division' COLOR COL_NEGATIVE.
*  WHEN 2. WRITE: / 'falscher Operator' COLOR COL_GROUP.
*  WHEN 3. WRITE: / 'Negative arguent for square root ..not accepted !' color COL_HEADING.
*  WHEN OTHERS.
*    WRITE: / 'neuer Fehler: handling -> coming soon'.
*ENDCASE.


***********************2.Rechnung*****************************


*CALL FUNCTION 'ZS11_RECHNEN'
*  EXPORTING
*    i_a           = a2
*    i_op          = op2
*    i_b           = b2
* IMPORTING
*   E_RES         = res
* EXCEPTIONS
*   ZERO_DIVIDE             = 1
*   WRONG_OPERATOR          = 2
*   NEGATIVE_ARGUMENT       = 3
*   OTHERS                  = 4
*          .
* CASE sy-subrc.
*  WHEN 0. PERFORM ausgabe USING a2 op2 b2 res.
*  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
*  WHEN 2. WRITE: / text-002 COLOR COL_GROUP.
*  WHEN 3. WRITE: / 'Negative arguent for square root ..not accepted !' color COL_HEADING.
*  WHEN OTHERS.
*    WRITE: / 'neuer Fehler: handling -> coming soon'.
*ENDCASE.

*
*form ausgabe USING a op b res.
*WRITE: /3 a,
*       / op, b.
*ULINE /3(12).
*WRITE: /3 res.
*ENDFORM.


*************************asessment1 question2**************************

CALL FUNCTION 'ZS11_RECHNEN'
  EXPORTING
    i_a               = a
*    i_op1              = op
    i_b               = b
*  IMPORTING
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
  WRITE: /3 a,
         / op, b.
  ULINE /3(12).
  WRITE: /3 res.
ENDIF.
