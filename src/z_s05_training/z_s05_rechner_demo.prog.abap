*&---------------------------------------------------------------------*
*& Report Z_S05_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_RECHNER_DEMO.


"INITIALIZATION.

DATA lv_zahl TYPE I.
DATA lv_zahl1 TYPE I.
DATA lv_zahl2 TYPE I.
DATA lv_ergebnis TYPE i.
DATA lv_zeichen(1) TYPE c.


PARAMETERS p_zahl1 LIKE lv_zahl.
PARAMETERS p_zahl2 LIKE lv_zahl.

"SELECT-OPTIONS s_rech FOR p_rech NO INTERVALS.7
 START-OF-SELECTION.



PARAMETERS p_add RADIOBUTTON GROUP rb_1.
PARAMETERS p_sub RADIOBUTTON GROUP rb_1.
PARAMETERS p_div RADIOBUTTON GROUP rb_1.
PARAMETERS p_mult RADIOBUTTON GROUP rb_1.

CALL FUNCTION 'ZS05_RADIO'
  EXPORTING
   P_ADD                = P_ADD
  P_SUB                = P_SUB
   P_MULT               = P_MULT
   P_DIV                = P_DIV
    p_zahl1              = p_zahl1
    p_zahl2              = p_zahl2
 IMPORTING
   LV_ERGEBNIS          = LV_ERGEBNIS
 EXCEPTIONS
   ZERO_DIVIDE          = 1
   WRONG_OPERATOR       = 2
   OTHERS               = 3
          .
case sy-subrc.
    WHEN 0. PERFORM AUSGABE USING p_zahl1 p_zahl1 P_ADD P_SUB P_MULT P_DIV LV_ERGEBNIS.
  WHEN 1. WRITE: / 'DIVISION DURCH 0' COLOR COL_NEGATIVE.
  WHEN 2. WRITE: / 'FALSHER OPERATOR' COLOR COL_GROUP.
  WHEN 3. WRITE: / 'Fehler' COLOR COL_GROUP.
  WHEN OTHERS.
     WRITE: / 'neue Fehler' COLOR COL_GROUP.
    ENDCASE.
          .
FORM AUSGABE USING zahl1 zahl2 ADD SUB MULT DIV ERGEBNIS.
  WRITE: /3 p_zahl1,
        /2 p_zahl2.
  ULINE /3(12).
  WRITE: /3 LV_ERGEBNIS.
endform.
