*&---------------------------------------------------------------------*
*& Report Z_S05_QUIZ_PROBE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_QUIZ_PROBE.

INITIALIZATION.

DATA lv_brutto TYPE p LENGTH 5 DECIMALS 2.
DATA lv_netto TYPE p LENGTH 5 DECIMALS 2.
DATA lv_steuer_pr TYPE p LENGTH 2 DECIMALS 2.
DATA lv_steuer TYPE p LENGTH 5 DECIMALS 2.

PARAMETERS p_brutto LIKE lv_brutto.

START-OF-SELECTION.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.


PARAMETERS p_7 RADIOBUTTON GROUP rb_1.
PARAMETERS p_19 RADIOBUTTON GROUP rb_1.

IF p_7 EQ 'X'.
    "lv_steuer = 7.
     lv_steuer_pr = p_brutto * ( 7  / 100 ).
     lv_netto = p_brutto - lv_steuer_pr.

     WRITE:
      | Warentyp  =  Lebensmitel |,
     / | Steuer = 7 % |,
   /  | Netto Preis = { lv_netto }  |.

    ELSEIF p_19 EQ 'X'.
    "  lv_steuer = 19.
     lv_steuer_pr = p_brutto * ( 19  / 100 ).
     lv_netto = p_brutto - lv_steuer_pr.

     WRITE:
       | Warentyp  =  Handelsware |,
     / | Steuer = 19 % |,
   /  | Netto Preis = { lv_netto }  |.

   ELSE.
     MESSAGE: |Fehler! Wahlen Sie eine gultige Warentyp| TYPE 'e'.

     endif.




SELECTION-SCREEN END OF BLOCK b1.

* IF lv_brutto IS NOT INITIAL.
*      WRITE: / lv_ergebnis.
*      ELSE.
*        WRITE: / 'Fehler! Ergemnismenge ist Leer!'.
*     ENDIF.
