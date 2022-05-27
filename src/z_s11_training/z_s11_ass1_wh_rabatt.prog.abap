*&---------------------------------------------------------------------*
*& Report Z_S11_ASS1_WH_RABATT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

 REPORT Z_S11_ASS1_WH_RABATT.


TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.

parameters:
p_price1 tYPE ty_betrag DEFAULT '200',
p_rabpr1 TYPE ty_betrag DEFAULT '10',

p_price2 tYPE ty_betrag DEFAULT '400',
p_rabpr2 TYPE ty_betrag DEFAULT '20'.

*
DATA:
red_price1 TYPE ty_betrag,
red_price2 TYPE ty_betrag,
rabatt1 TYPE ty_betrag,
rabatt2 TYPE ty_betrag.


* ABAP-Code: Berechnungen für beide Artikel

PERFORM rechnen USING p_price1 p_rabpr1 CHANGING red_price1 rabatt1.
PERFORM ausgabe USING p_price1 p_rabpr1 red_price1 rabatt1.

PERFORM rechnen USING p_price2 p_rabpr2 CHANGING red_price2 rabatt2.
PERFORM ausgabe USING p_price2 p_rabpr2 red_price2 rabatt2.


FORM rechnen USING original_price rabatt_per CHANGING reduced_price rabatt.

  rabatt = ( rabatt_per / 100 ) * original_price.
  reduced_price = original_price - Rabatt.

 ENDFORM.

FORM ausgabe USING original_price rabatt_per reduced_price rabatt.

WRITE: / 'Original Price', original_price,
/ 'Discount Percentage', rabatt_per , 'Calculated discout :', rabatt, 'Reduced Price:', reduced_price.

 ENDFORM.
