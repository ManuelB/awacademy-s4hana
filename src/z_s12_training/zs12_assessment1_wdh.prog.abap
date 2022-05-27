*&---------------------------------------------------------------------*
*& Report ZS12_ASSESSMENT1_WDH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_assessment1_wdh.

TYPES:
  betrag TYPE p LENGTH 6 DECIMALS 2,
  reduzierung TYPE i.

PARAMETERS:
  Preis1  TYPE betrag DEFAULT 80,
  rabatt1 TYPE reduzierung DEFAULT 19,
  preis2  TYPE betrag DEFAULT 45,
  rabatt2 TYPE reduzierung DEFAULT 15.

DATA:
  rabattpreis1 TYPE betrag,
  rabattpreis2 TYPE betrag.

PERFORM Rabattierung USING Preis1 rabatt1 CHANGING rabattpreis1.
WRITE: / 'Der Original-Preis betrug', Preis1, 'da wir aber einen Rabatt-Prozentsatz von', rabatt1, 'angerechnet haben, beträgt der reduzierte Preis nun', rabattpreis1.
PERFORM Rabattierung USING Preis2 rabatt2 CHANGING rabattpreis2.
WRITE: / 'Der Original-Preis betrug', Preis2, 'da wir aber einen Rabatt-Prozentsatz von', rabatt2, 'angerechnet haben, beträgt der reduzierte Preis nun', rabattpreis2.





FORM Rabattierung USING preis rabatt CHANGING rabattpreis.
  rabattpreis = preis / ( 1 + ( '0.01' * rabatt ) ).
ENDFORM.
