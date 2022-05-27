**&---------------------------------------------------------------------*
**& Report Z_S02_CASE
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
*REPORT z_s02_case.
*
*
*
*PARAMETERS p_zahl_1 TYPE p. "Parameter kann man auch so Typisieren wie Variablen
*PARAMETERS p_zahl_2 TYPE p.
*PARAMETERS p_OP(1) TYPE c.
*DATA lv_ergebnis TYPE p DECIMALS 2.
*
*IF p_op CA '+-*/'. " CA contains any. Programm fuunktioniert nur, wenn ein zulässiger Operator verwendet wird.
*ELSE.
*  MESSAGE 'Bitte geben Sie einen validen Rechenoperator an.' Type 'S'.
*  RETURN. "Ablauflogik wird wieder beendet. Man kommt nicht weiter und kann
*ENDIF.
*
*CASE p_OP. "man kann Parameter oder Variablen abfragen nach ihrem Zustand
*  WHEN '+'.
*    WRITE: / 'Addition'.
*    lv_ergebnis = p_zahl_1 + p_zahl_2.
*  WHEN '-'.
*    WRITE: / 'Subtaktion'.
*    lv_ergebnis = p_zahl_1 - p_zahl_2.
*  WHEN '*'.
*    WRITE: / 'Multiplikation'.
*    lv_ergebnis = p_zahl_1 * p_zahl_2.
*  WHEN '/'.
*
*    IF p_zahl_2 EQ 0.
*      WRITE: / 'Fehler'.
*    ELSE.
*      WRITE: / 'Division'.
*      lv_ergebnis = p_zahl_1 / p_zahl_2.
*    ENDIF.
*
*  WHEN OTHERS.
*    WRITE: 'Fehler'.
*ENDCASE.
*
*WRITE: / p_zahl_1, p_op, p_zahl_2, '=', lv_ergebnis.


DATA: a TYPE i VALUE 3, b TYPE i VALUE 7.
