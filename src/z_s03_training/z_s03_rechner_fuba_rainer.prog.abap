
*& Report Z_S03_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s03_rechner_fuba_rainer.

INCLUDE ZS03_INCLUDE_DEMO.

*PARAMETERS:
*  P_curr TYPE sflight-currency DEFAULT 'EUR' VALUE CHECK, "Dtel S_CURRCODE
*  p_oper TYPE foperator," value CHECK,
*  a1     TYPE zrk02_ty_betrag DEFAULT 3,
*  op1    TYPE zrk02_ty_operator DEFAULT '+',
*  b1     TYPE zrk02_ty_betrag DEFAULT 4,
*  a2     TYPE zrk02_ty_betrag DEFAULT 5,
*  op2    TYPE zrk02_ty_operator DEFAULT '*',
*  b2     TYPE zrk02_ty_betrag DEFAULT 7.
**
*DATA:
*  res TYPE zrk02_ty_betrag.
* 1. Rechnung

CALL FUNCTION 'Z02_RECHNEN'
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
"IF sy-subrc <> 0.
CASE sy-subrc. "wenn alles gut geht -> Ausgeben

        WHEN 0.   CALL FUNCTION 'ZS03_AUSGABE'
            EXPORTING
              i_a           = a1
              i_op          = op1
              i_b           = b1
              e_res         = res
                    .


*    PERFORM ausgabe USING a1 op1 b1 res.
  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
    "WHEN 17. WRITE: / 'negatives Argument bei SQRT' COLOR COL_TOTAL.
  WHEN 3. WRITE: / 'ein anderer Fehler'(003).
  WHEN OTHERS.
    "coming soon
    WRITE: / 'neuer Fehler: handling -> coming soon'.
ENDCASE.
"ELSE.
"  PERFORM ausgabe USING a1 op1 b1 res.
"ENDIF.



"PERFORM rechnen USING a1 op1 b1 CHANGING res.

*
* 2. Rechnung
CALL FUNCTION 'Z02_RECHNEN'
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

         When 0.        CALL FUNCTION 'ZS03_AUSGABE'
                  EXPORTING
                    i_a           = a2
                    i_op          = op2
                    i_b           = b2
                    e_res         = res
                          .


*    PERFORM ausgabe USING a2 op2 b2 res.
  WHEN 1. WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / TEXT-002 COLOR COL_GROUP.
    "WHEN 17. WRITE: / 'negatives Argument bei SQRT' COLOR COL_TOTAL.
  WHEN 3. WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
    "coming soon
    WRITE: / 'neuer Fehler: handling -> coming soon'.
ENDCASE.


"PERFORM rechnen USING a2 op2 b2 CHANGING res.
*PERFORM ausgabe USING a2 op2 b2 res.
* 3. Rechnung
CALL FUNCTION 'Z02_RECHNEN'
  EXPORTING
    i_a   = 47
    i_op  = '+'
    i_b   = 99
  IMPORTING
    e_res = res.
"PERFORM rechnen USING 47 '+' 99 CHANGING res.
*PERFORM ausgabe USING 47 '+' 99 res.

*
*FORM ausgabe USING a op b res.
*  WRITE: /3 a,
*         / op, b.
*  ULINE /3(12).
*  WRITE: /3 res.
*ENDFORM.
