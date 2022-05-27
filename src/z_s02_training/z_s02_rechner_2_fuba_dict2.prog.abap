*&---------------------------------------------------------------------*
*& Report Z_S02_RECHNER_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_rechner_2_fuba_dict2.

********* Mit externen globalen Datenelementen **********


*** EIngabeparameter

PARAMETERS:
  a1  TYPE EHFND_GEOLOC_ELEVATION DEFAULT 3,
  op1 TYPE /PM0/ALD_MATHOPERATOR_ID DEFAULT '+',
  b1  TYPE EHFND_GEOLOC_ELEVATION DEFAULT 4,
  a2  TYPE EHFND_GEOLOC_ELEVATION DEFAULT 5,
  op2 TYPE zrk02_ty_operator DEFAULT '*',
  b2  TYPE EHFND_GEOLOC_ELEVATION DEFAULT 7.

DATA:
  res TYPE EHFND_GEOLOC_ELEVATION.



*** 1. Rechnung




** steht
CALL FUNCTION 'Z_S02_RECHNEN_2'
  EXPORTING                       " im rufenden Programm exporting, Frage der Perspektive
    i_a               = a1            " Tipp: i_ hinpinseln, damit man weiss, dass es der importparameter ist.
    i_op              = op1
    i_b               = b1
  IMPORTING
    e_res             = res            " Tipp: e_ hinpinseln, damit man weiss, dass es der Exportparameter ist.
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 3
    OTHERS            = 4.
IF sy-subrc <> 0.                     " Handling der Ausnahmen
  CASE sy-subrc.    " wenn alles gut geht --> Ausgeben (0)
*    WHEN 0. PERFORM ausgabe USING a1 op1 b1 CHANGING res.
    WHEN 1. WRITE: /'Null-Division'(001) COLOR COL_NEGATIVE.
    WHEN 2. WRITE: / text-002,'falscher Operator' COLOR COL_GROUP.
    WHEN 3. WRITE: / 'negatives Argument' COLOR COL_NEGATIVE.
    WHEN 4. WRITE: /'ein anderer Fehler' COLOR COL_NEGATIVE.
    WHEN OTHERS.
      WRITE: /'neuer Fehler: handling -> coming soon'  COLOR COL_NEGATIVE.
  ENDCASE.
ELSEIF sy-subrc = 0.
  PERFORM ausgabe USING a1 op1 b1 CHANGING res.
ENDIF.

.




*****  Der Funktionsbaustein ersetzt den Operator > CASE op .... ENDCASE.
*****FORM rechnen USING a op b CHANGING res.
*****  CASE op.
*****    WHEN '+'. res = a + b.
*****    WHEN '-'. res = a - b.
*****    WHEN '*'. res = a * b.
*****    WHEN '/'. res = a / b.
*****  ENDCASE.
*****ENDFORM.



*PERFORM rechnen USING a1 op1 b1 CHANGING res.
*PERFORM ausgabe USING a1 op1 b1 CHANGING res.



*** 2. Rechnung

CALL FUNCTION 'Z_S02_RECHNEN_2'
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
CASE sy-subrc.
  WHEN 0. PERFORM ausgabe USING a2 op2 b2 CHANGING res.
  WHEN 1. WRITE: /'Null-Division'  COLOR COL_NEGATIVE.
  WHEN 2. WRITE: /'falscher Operator'  COLOR COL_NEGATIVE.
  WHEN 3. WRITE: / 'negatives Argument'  COLOR COL_NEGATIVE.
  WHEN 4. WRITE: /'ein anderer Fehler'.
  WHEN OTHERS.
    WRITE: /'neuer Fehler: handling -> coming soon'  COLOR COL_NEGATIVE.
ENDCASE.


*PERFORM rechnen USING a2 op2 b2 CHANGING res.
*PERFORM ausgabe USING a2 op2 b2 CHANGING res.


FORM ausgabe USING a op b res.
  WRITE: /3 a,
         / op, b.
  ULINE /3(12).
  WRITE: /3 res.
ENDFORM.
