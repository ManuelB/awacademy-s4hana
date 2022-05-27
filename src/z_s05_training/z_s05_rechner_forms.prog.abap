*&---------------------------------------------------------------------*
*& Report Z_S05_RECHNER_FORMS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_RECHNER_FORMS.

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



PARAMETERS p_add RADIOBUTTON GROUP rb_1 .
PARAMETERS p_sub RADIOBUTTON GROUP rb_1 .
PARAMETERS p_div RADIOBUTTON GROUP rb_1 .
PARAMETERS p_mult RADIOBUTTON GROUP rb_1 .


"lv_zahl1 = 1.
"lv_zahl2 = 1.
 "lv_zeichen = '+'.

"IF lv_zahl1 EQ lv_zahl2.

  "WRITE: lv_zahl2.

  "p_zahl1 = 1.


PERFORM RECHNEN USING p_zahl1 p_add p_zahl2 CHANGING lv_ergebnis.
PERFORM RES USING p_zahl1 p_add p_zahl2 lv_ergebnis.

PERFORM RECHNEN USING p_zahl1 p_sub p_zahl2 CHANGING lv_ergebnis.
PERFORM RES USING p_zahl1 p_sub p_zahl2 lv_ergebnis.

PERFORM RECHNEN USING p_zahl1 p_div p_zahl2 CHANGING lv_ergebnis.
PERFORM RES USING p_zahl1 p_div p_zahl2 lv_ergebnis.

PERFORM RECHNEN USING p_zahl1 p_mult p_zahl2 CHANGING lv_ergebnis.
PERFORM RES USING p_zahl1 p_mult p_zahl2 lv_ergebnis.

form RECHNEN USING p_zahl1 p_op p_zahl2 CHANGING lv_ergebnis.
  CASE  p_op.
  WHEN p_add. lv_ergebnis = p_zahl1 + p_zahl2.

  WHEN p_sub . lv_ergebnis = p_zahl1 - p_zahl2.
  WHEN p_div . lv_ergebnis = p_zahl1 * p_zahl2..
  WHEN p_mult . lv_ergebnis = p_zahl1 / p_zahl2.
endcase.
endform.


 FORM res USING p_zahl1 p_op p_zahl2 lv_ergebnis.
  WRITE: /3 p_zahl1,
        / p_add, p_zahl2.
  ULINE /3(12).
  WRITE: /3 lv_ergebnis.
endform.
