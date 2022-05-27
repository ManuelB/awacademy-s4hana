*&---------------------------------------------------------------------*
*& Report Z_S02_RANGO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_rango.





PARAMETERS:
  p_brpr TYPE p LENGTH 4 DECIMALS 2,
  p_lm   RADIOBUTTON GROUP rb_1,
  p_hw   RADIOBUTTON GROUP rb_1.

DATA : res_p_brpr TYPE p LENGTH 4 DECIMALS 2,
       res_MW     TYPE p LENGTH 4 DECIMALS 2.

CASE 'X'.
  WHEN p_lm.

    PERFORM r_lm USING p_brpr CHANGING res_p_brpr res_MW.
    WRITE :/ 'Preis', res_p_brpr, 'MwSt', res_MW.

  WHEN p_hw.

    PERFORM r_hw USING p_brpr CHANGING res_p_brpr res_MW.
    WRITE :/ 'Preis', res_p_brpr, 'MwSt', res_MW.
ENDCASE.


FORM r_lm USING preis CHANGING p_brpr mw.
  mw =  ( 7 / 100 ) * preis.
  p_brpr = preis.
ENDFORM.




FORM r_hw USING preis CHANGING p_brpr mw.
  mw =  ( 19 / 100 ) * preis.
  p_brpr = preis.
ENDFORM.
