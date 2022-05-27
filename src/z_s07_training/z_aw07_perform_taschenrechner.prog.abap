*&---------------------------------------------------------------------*
*& Report Z_AW07_PERFORM_TASCHENRECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_PERFORM_TASCHENRECHNER.

*PARAMETERS:
*  a1  TYPE i DEFAULT 3,
*  op1 TYPE c LENGTH 1 DEFAULT '+',
*  b1  TYPE i DEFAULT 4,
*  a2  TYPE i DEFAULT 5,
*  op2 TYPE c LENGTH 1 DEFAULT '*',
*  b2  TYPE i DEFAULT 7.
**
*DATA:
*  res TYPE i.
** 1. Rechnung
*PERFORM rechnen USING a1 op1 b1 CHANGING res.
*PERFORM ausgabe USING a1 op1 b1 res.
**
** 2. Rechnung
*PERFORM rechnen USING a2 op2 b2 CHANGING res.
*PERFORM ausgabe USING a2 op2 b2 res.
*
**
*FORM rechnen USING a op b CHANGING res.
*  CASE op.
*    WHEN '+'. res = a + b.
*    WHEN '-'. res = a - b.
*    WHEN '*'. res = a * b.
*    WHEN '/'. res = a / b.
*  ENDCASE.
*ENDFORM.
**
*form ausgabe USING a op b res.
*WRITE: /3 a,
*       / op, b.
*ULINE /3(12).
*WRITE: /3 res.
*ENDFORM.

PARAMETERS p_a1 TYPE i DEFAULT 5.
PARAMETERS p_op1(1)  TYPE c DEFAULT '+'.
PARAMETERS p_b1 TYPE i DEFAULT 17.

PARAMETERS p_a2 TYPE i DEFAULT 5.
PARAMETERS p_op2(1)  TYPE c DEFAULT '*'.
PARAMETERS p_b2 TYPE i DEFAULT 17.

DATA lv_ergebnis TYPE i.




IF p_op1 CA '+-*/'.
*gehe weiter.
ELSE.
*  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S'.
  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN. "Ablauflogik wird wieder beendet
ENDIF.

IF p_op2 CA '+-*/'.
*gehe weiter.
ELSE.
*  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S'.
  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S' DISPLAY LIKE 'E'.
RETURN. "Ablauflogik wird wieder beendet
ENDIF.

PERFORM rechnen USING p_a1 p_op1 p_b1 CHANGING lv_ergebnis.
*PERFORM ausgabe USING p_a1 p_op1 p_b1 lv_ergebnis.
*
* 2. Rechnung
PERFORM rechnen USING p_a2 p_op2 p_b2 CHANGING lv_ergebnis.
*PERFORM ausgabe USING p_a2 p_op2 p_b2 lv_ergebnis.

FORM rechnen USING p_a p_op p_b CHANGING lv_ergebnis.
CASE p_op.
  WHEN '+'.
    WRITE:/ 'ADDITION'.
    lv_ergebnis = p_a + p_b.

  WHEN '-'.
    WRITE:/ 'SUBTRAKTION'.
    lv_ergebnis = p_a - p_b.

  WHEN '*'.
    WRITE:/ 'MULTIPLIKATION'.
    lv_ergebnis = p_a * p_b.

  WHEN '/'.
    IF p_b1 EQ 0.
      WRITE: / 'Fehler: Division durch 0 nicht möglich'.
    ELSE.
      WRITE:/ 'DIVISION'.
      lv_ergebnis = p_a / p_b.
    ENDIF.

  WHEN OTHERS.
    WRITE: 'FEHLER'.
ENDCASE.


WRITE: / p_a, p_op, p_b, '=', lv_ergebnis.
ENDFORM.



*IF p_zahl_1 BETWEEN 1 AND 18.
*
*ENDIF.
