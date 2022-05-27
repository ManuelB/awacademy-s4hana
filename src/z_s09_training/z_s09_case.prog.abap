*&---------------------------------------------------------------------*
*& Report Z_S09_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_CASE.

PARAMETERS p_zahl_1 TYPE p.   "Zahl 1"
PARAMETERS p_op(1) TYPE c.    "Rechenoperator sowas wie plus/minus/geteilt"
PARAMETERS p_zahl_2 TYPE p.   "Zahl 2"

DATA lv_ergebnis TYPE p.

IF p_op CA '+-*/'.
  "Das sagt es dürfen NUR diese Operatoren eingegeben werden."
ELSE.
  MESSAGE 'Bitte geben SIe einen validen Rechenoperator ein.' TYPE 'S' DISPLAY LIKE 'E'. "Spezielle Message Befehle dieser erzeugt ein beim ERROR Fenster"
RETURN. "Ablauflogik wird wieder beendet"

ENDIF.



CASE p_op.
  WHEN '+'.
    WRITE: / 'Addition'.
    lv_ergebnis = p_zahl_1 + p_zahl_2.  "Ergebnis der Rechnung"

  WHEN '-'.
    WRITE: / 'Subtraktion'.              "Macht das da steht Addition als Hinweis"
    lv_ergebnis = p_zahl_1 - p_zahl_2.

  WHEN '*'.
    WRITE: / 'Multiplikation'.
     lv_ergebnis = p_zahl_1 * p_zahl_2.

   WHEN '/'.
      IF p_zahl_2 EQ 0.                 "Das ist quasi das man nicht durch Null teilen kann"
        WRITE: 'FEHLER! Division durch 0 nicht zulässig'.
        ELSE.

     WRITE: / 'Division'.
        lv_ergebnis = p_zahl_1 / p_zahl_2.
        ENDIF.

  WHEN OTHERS.
    WRITE: 'FEHLER'.
ENDCASE.

WRITE: / p_zahl_1, p_op, p_zahl_2, '=', lv_ergebnis. "Das auch das Ergbnis ausgegeben wird"
