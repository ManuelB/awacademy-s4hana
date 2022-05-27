*&---------------------------------------------------------------------*
*& Report Z_S12_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*REPORT z_s12_case.
*
*PARAMETERS p_zahl_1 TYPE p DECIMALS 2.
*PARAMETERS p_op(2) TYPE c. "Charakter der Länge 1 --> schöner zu lesen im Code.
*PARAMETERS p_zahl_2 TYPE p DECIMALS 2.
*DATA lv_ergebnis TYPE p DECIMALS 2.
*
**Nur die gängigen Rechenoperatoren als Eingabe zulassen
*IF p_op CA '+-*/**'. "CA = Contains Any
*  "geht weiter vor
*ELSE.
*  MESSAGE 'Bitte geben sie einen validen Rechenoperator an!' TYPE 'S' DISPLAY LIKE 'E'.
*  RETURN. "Ablauflogik wird beendet.
*ENDIF.
*
*CASE p_op. "Welchen Zustand hat welche Varable --> Variable angeben
*  WHEN '+'. "Frägt Zustand der Variable ab.
*    WRITE: / 'Ergebnis der Addition'.
*    lv_ergebnis = p_zahl_1 + p_zahl_2.
*    WRITE: / lv_ergebnis.
*
*  WHEN '-'. " Anderer Zustand der Variable.
*    WRITE: / 'Ergebnis der Subtraction'.
*    lv_ergebnis = p_zahl_1 - p_zahl_2.
*    WRITE: / lv_ergebnis.
*
*  WHEN '*'. " Anderer Zustand der Variable.
*    WRITE: / 'Ergebnis der Multiplikation'.
*    lv_ergebnis = p_zahl_1 * p_zahl_2.
*    WRITE: / lv_ergebnis.
*
*  WHEN '/'. " Anderer Zustand der Variable.
*    IF p_zahl_2 EQ 0. "Kann man ineinander verschachteln.
*      WRITE: / 'Nicht zulässige Rechenoperation'.
*    ELSE.
*      WRITE: / 'Ergenbnis der Division'.
*      lv_ergebnis = p_zahl_1 DIV p_zahl_2.
*      WRITE: / lv_ergebnis.
*    ENDIF.
*
*  WHEN '**'. " Anderer Zustand der Variable.
*    WRITE: / 'Potentiert'.
*    lv_ergebnis = p_zahl_1 ** p_zahl_2.
*    WRITE: / lv_ergebnis.
*
*
*
*  WHEN OTHERS.
*    WRITE: / 'Fehler!'.
*ENDCASE.

*DO .
*
*ENDDO.
*Write: 'fertig'.

report zrk_exit_schleife.
data: count type i value 3.
DO 3 TIMES.
while count < 5.
  count = count + 1.
  IF count = 2.
    continue.
    else.
      count = count + 2.
  ENDIF.
  ENDWHILE.
ENDDO.
Write: / count.
