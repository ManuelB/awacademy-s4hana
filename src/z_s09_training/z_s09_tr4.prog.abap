*&---------------------------------------------------------------------*
*& Report Z_S09_TR4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_TR4.

PARAMETERS:
 pi TYPE zrk02_ty_betrag DEFAULT '3.14159',
  "zahl TYPE bruteil,
  "P_curr TYPE sflight-currency DEFAULT 'EUR' VALUE CHECK, "Dtel S_CURRCODE
  "p_oper TYPE foperator," value CHECK,
  a1   TYPE zrk02_ty_betrag DEFAULT 3,
  op1  TYPE foperator DEFAULT '+',
  b1   TYPE zrk02_ty_betrag DEFAULT 4,
  a2   TYPE zrk02_ty_betrag DEFAULT 5,
  op2  TYPE foperator DEFAULT '*',
  b2   TYPE zrk02_ty_betrag DEFAULT 7.
*
DATA:
      zahl TYPE f,
  "demozahl TYPE bruteil VALUE '-123456.789',
  res      TYPE zrk02_ty_betrag.
* 1. Rechnung
"WRITE: / 'demo:', demozahl.
"exit.
  WRITE: / pi.
  zahl = pi.
  WRITE: / zahl.
  uline.


CALL FUNCTION 'Z02_RECHNEN2'
  EXPORTING
    i_a               = a1
    i_op              = op1
    i_b               = b1
  IMPORTING
    e_res             = res
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 17
    OTHERS            = 3.

CASE sy-subrc. "wenn alles gut geht -> Ausgeben
  WHEN 0. PERFORM ausgabe USING a1 op1 b1 res.
  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 17. WRITE: / 'negatives Argument bei SQRT' COLOR COL_TOTAL.
  WHEN 3. WRITE: / 'ein anderer Fehler'(003).
  WHEN OTHERS.
    "coming soon
    WRITE: / 'neuer Fehler: handling -> coming soon'.
ENDCASE.

* 2. Rechnung
CALL FUNCTION 'Z02_RECHNEN2'
  EXPORTING
    i_a               = a2
    i_op              = op2
    i_b               = b2
  IMPORTING
    e_res             = res
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 3
    OTHERS            = 4.
CASE sy-subrc. "wenn alles gut geht -> Ausgeben
  WHEN 0. PERFORM ausgabe USING a2 op2 b2 res.
  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 17. WRITE: / 'negatives Argument bei SQRT' COLOR COL_TOTAL.
  WHEN 3. WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
    "coming soon
    WRITE: / 'neuer Fehler: handling -> coming soon'.
ENDCASE.

PERFORM ausgabe USING a2 op2 b2 res.
* 3. Rechnung
CALL FUNCTION 'Z02_RECHNEN2'
  EXPORTING
    i_a   = 47
    i_op  = '+'
    i_b   = 99
  IMPORTING
    e_res = res.
PERFORM ausgabe USING 47 '+' 99 res.

*
FORM ausgabe USING a op b res.
  WRITE: /3 a,
         / op, b.
  ULINE /3(12).
  WRITE: /3 res.
ENDFORM.


"--------------------------------------

"FUNCTION Z02_RECHNEN2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  BRUTEIL DEFAULT 5
*"     REFERENCE(I_OP) TYPE  ZRK02_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  BRUTEIL
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  BRUTEIL
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      NEGATIVE_ARGUMENT
*"----------------------------------------------------------------------

  CASE i_op.
    WHEN '+'. e_res = i_a + i_b.
    WHEN '-'. e_res = i_a - i_b.
    WHEN '*'. e_res = i_a * i_b.
    WHEN '/'.
      IF i_b <> 0.
        e_res = i_a / i_b.
      ELSE.
        RAISE zero_divide.
        "WRITE: / 'Division durch Null' COLOR COL_NEGATIVE.
      ENDIF.
    WHEN 'r' OR 'R'. " square root
      IF i_a < 0.
        RAISE negative_argument.
      ELSE.
        e_res = sqrt( i_a ).
      ENDIF.
    WHEN OTHERS.
      RAISE wrong_operator.
      "WRITE: / 'Falscher Operator' COLOR COL_GROUP.
  ENDCASE.

ENDFUNCTION.
