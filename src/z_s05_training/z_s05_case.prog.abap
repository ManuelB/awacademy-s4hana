*&---------------------------------------------------------------------*
*& Report Z_S05_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_CASE.

PARAMETERS p_zahl_1 TYPE p DEFAULT 5.
PARAMETERS p_op(1) TYPE c.
PARAMETERS p_zahl_2 TYPE p DEFAULT 17.
DATA lv_ergebnis TYPE p.

IF p_op CA '+-*/'.
  "gehe weiter.
  ELSE.
    MESSAGE 'Bitte geben sie einen valieden Rechenoperator an.' TYPE 's' DISPLAY LIKE 'E'.
  RETURN. "Ablauflogik wird wieder beendet

  ENDIF.



CASE p_op.
  WHEN '+'.
    WRITE: / 'ADDITION'.
     lv_ergebnis = p_zahl_1 + p_zahl_2.

    WHEN'-' .
  WRITE: / 'SUBTRACTION'.
   lv_ergebnis = p_zahl_1 - p_zahl_2.

   WHEN: '*'.
     WRITE: / 'MULTIPLICATION'.
      lv_ergebnis = p_zahl_1 * p_zahl_2.

    WHEN '/' .
      IF p_zahl_2 EQ 0.
        WRITE: / 'Fehler. Division durch 0 nicht möglich'.
        exit.
       ELSE.
        WRITE: / 'DIVISION'.
    lv_ergebnis = p_zahl_1 / p_zahl_2.
    ENDIF.


      WHEN OTHERS.
        WRITE: 'FEHLER'.
        ENDCASE.



WRITE: / p_zahl_1, p_op, p_zahl_2, '=', lv_ergebnis.
