*&---------------------------------------------------------------------*
*& Report Z_S05_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_RECHNER.


INITIALIZATION.

DATA lv_zahl TYPE p.
DATA lv_zahl1 TYPE p.
DATA lv_zahl2 TYPE p.
DATA lv_ergebnis TYPE p decimals 2.
DATA lv_zeichen(1) TYPE c.



PARAMETERS p_zahl1 LIKE lv_zahl.
PARAMETERS p_zahl2 LIKE lv_zahl.

"SELECT-OPTIONS s_rech FOR p_rech NO INTERVALS.7
 START-OF-SELECTION.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.


PARAMETERS p_add RADIOBUTTON GROUP rb_1.
PARAMETERS p_sub RADIOBUTTON GROUP rb_1.
PARAMETERS p_div RADIOBUTTON GROUP rb_1.
PARAMETERS p_mult RADIOBUTTON GROUP rb_1.


"lv_zahl1 = 1.
"lv_zahl2 = 1.
 "lv_zeichen = '+'.

"IF lv_zahl1 EQ lv_zahl2.

  "WRITE: lv_zahl2.

  p_zahl1 = 1.






  IF p_add EQ 'X'.
    WRITE: / 'Addition'.
     lv_ergebnis = p_zahl1 + p_zahl2.
     WRITE: lv_ergebnis.


    ELSEIF p_sub = 'X'.
    WRITE: / 'Subtraction'.
    lv_ergebnis = p_zahl1 - p_zahl2.
    WRITE: lv_ergebnis.

    ELSEIF p_mult = 'X'.
    WRITE: / 'Multiplication'.
    lv_ergebnis = p_zahl1 * p_zahl2.
    WRITE: lv_ergebnis.

    ELSEIF p_div = 'X'.
    IF p_zahl2 EQ 0.
      WRITE 'Fehler! Die Division durch 0 ist nicht erlaubt '.
      "EXIT.
      ELSEIF p_zahl2 NE 0.
        WRITE: / 'Division'.
    lv_ergebnis = p_zahl1 / p_zahl2.
        WRITE: / lv_ergebnis.
    ENDIF.


ELSE.
  WRITE: / 'Fehler! Keine korrekte Verrechnungsoperation gewält'.


    "ELSE. p_mult = 'X'.
    "WRITE: /

    ENDIF.
SELECTION-SCREEN END OF BLOCK b1.





    IF lv_ergebnis IS NOT INITIAL.
      WRITE: / lv_ergebnis.
      ELSE.
        WRITE: / 'Fehler! Ergemnismenge ist Leer!'.
     ENDIF.
