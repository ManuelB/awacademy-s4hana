*&---------------------------------------------------------------------*
*& Report Z_S09_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_RECHNER.


DATA lv_zahl_1 TYPE p VALUE IS INITIAL.
DATA lv_zahl_2 TYPE p.

DATA lv_ergebnis TYPE p DECIMALS 2.
"DATA lv_ergebnis TYPE f.  "Macht das Minus Zahlen -44 zB das das Minus vorne steht beim Ergebnis"

INITIALIZATION.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

    PARAMETERS p_zahl_1 LIKE lv_zahl_1.
    PARAMETERS p_zahl_2 LIKE lv_zahl_2.

    SELECTION-SCREEN END OF BLOCK b1.

    SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

      PARAMETERS p_add RADIOBUTTON GROUP r1.
      PARAMETERS p_sub RADIOBUTTON GROUP r1.
      PARAMETERS p_mult RADIOBUTTON GROUP r1.
      PARAMETERS p_div RADIOBUTTON GROUP r1.

      SELECTION-SCREEN END OF BLOCK b2.
      SELECTION-SCREEN END OF BLOCK b0.


         WRITE : / 'Zahl 1', p_zahl_1.
         WRITE : / 'Zahl 2', p_zahl_2.

         IF p_add = 'X'.
           WRITE: / 'Addition'.
           lv_ergebnis = p_zahl_1 + p_zahl_2.
           ELSEIF
             p_sub = 'X'.
             WRITE: / 'Subtraktion'.
             lv_ergebnis = p_zahl_1 - p_zahl_2.
             ELSEIF
               p_mult = 'X'.
               WRITE: / 'Multiplikation'.
               lv_ergebnis = p_zahl_1 * p_zahl_2.
               ELSEIF
                 p_div = 'X'.
                 WRITE: / 'Division'.
                 IF p_zahl_2 EQ 0.
                   WRITE: 'FEHLER! Division durch 0 nicht zulässig'.
                   EXIT.

                   ELSE.
                 lv_ergebnis = p_zahl_1 DIV p_zahl_2.
                 ENDIF.

                 ENDIF.

WRITE: / 'Das Ergebnis ist', lv_ergebnis.
