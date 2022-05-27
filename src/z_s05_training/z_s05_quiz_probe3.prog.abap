**&---------------------------------------------------------------------*
**& Report Z_S05_QUIZ_PROBE3
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
REPORT Z_S05_QUIZ_PROBE3.
*
* PARAMETERS:
*
*   zl TYPE zrkOl_ty_betrag DEFAULT '3,14',
*
*   op TYPE foperator DEFAULT '+', " VALUE CHECK,
*
*   z2 TYPE zrkOl_ty_betrag DEFAULT '8.335'.
*
* * Ausgabe-Variable, interne Variable
*
* DATA:
*
*   result TYPE zrk01 ty_betrag.
*
* * Verarbeitung: Rechnung durchnihren
*
* CALL FUNCTION 1ZOl_taschenrechner'
*
*   EXPORTING
*
*     im— zl       = zl
*     .
*     im_op        = op
*
*     im_z2        = z2
*
*   IMPORTING
*
*     ex_result    = result
*
*   EXCEPTIONS
*
*     wrong_operator = 1
*
*     zero_division = 2
*
*     OTHERS = 3.
*
*OIF sy-subrc <> 0.
*
*   CASE sy-subrc.
*
*     WHEN 1. WRITE: / 'falscher Operator' COLOR COL_GROUP.
*
*     WHEN 2. WRITE: / 'Div. durch Null' COLOR COL NEGATIVE.
*
*     WHEN OTHERS.
*
*   ENDCASE.
*
* ELSE.
*
* * Ausgabe der Berechnung
*
*   WRITE: /3 im_z1,
*
*         / foperator, im_z2,
*
*         /3(15) sy-uline,
*
*         / '=', ex result.
*
* ENDIF.

*PARAMETERS: b TYPE i DEFAULT 4.
*DATA: res TYPE i VALUE 5.
*WRITE: b, res.
*PERFORM rechne USING res CHANGING b.
*WRITE: b, res.
*FORM rechne USING b CHANGING c.
*DATA: res TYPE i VALUE 6.
*c = res.
*WRITE: b, res.
*ENDFORM.
