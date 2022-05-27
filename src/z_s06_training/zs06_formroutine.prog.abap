*&---------------------------------------------------------------------*
*& Report ZS06_FORMROUTINE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_formroutine.
PARAMETERS:

  preis1 TYPE p LENGTH 10 DECIMALS 2,                           "eingabe feld fur original preis
  rab1   TYPE p LENGTH 3,                                       "eingabe feld fur rabatt in %
  preis2 TYPE p LENGTH 10 DECIMALS 2,
  rab2   TYPE p LENGTH 3.


DATA:

  ergib1 TYPE p DECIMALS 2,                                     "reduzierte preis
  red1   TYPE p DECIMALS 2,                                     "% in wert von euro
  ergib2 TYPE p DECIMALS 2,
  red2   TYPE p DECIMALS 2.



PERFORM rechnen USING preis1 rab1 CHANGING ergib1 red1.         "wie es berechnet wird ORIGINAL PREIS,RABATT = REDUZIERTE PREIS,WIEVIEL GESPART WIRD
PERFORM rechnen USING preis2 rab2 CHANGING ergib2 red2.

"How the results will be desplayd
WRITE: / 'ORIGINAL_PREIS!: 1', preis1, / 'RABATT:',rab1, '%',
/ 'SIE_SPAREN!:', red1,
/ 'SIE_ZAHLEN!:', ergib1.

ULINE.

WRITE: / 'ORIGINAL_PREIS!: 1', preis2,/ 'RABATT:',rab2, '%',
/ 'SIE_SPAREN!:', red2,
/ 'SIE_ZAHLEN!:', ergib2.

ULINE.

FORM rechnen USING preis rab CHANGING ergib red.
  red = preis / 100 * rab.
  ergib = preis - red.
ENDFORM.
