*&---------------------------------------------------------------------*
*& Report ZS04_RECHNER_MWST.
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_rechner_rabatt_form.

SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME TITLE TEXT-100.
  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
    PARAMETERS:

      preis1  TYPE p LENGTH 5 DECIMALS 2 DEFAULT 100,
      rabatt1 TYPE p LENGTH 2 DEFAULT 10,

      preis2  TYPE p LENGTH 5 DECIMALS 2 DEFAULT 50,
      rabatt2 TYPE p LENGTH 2 DEFAULT 10.

  SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF BLOCK b.

DATA ergebnis1 TYPE p DECIMALS 2.
DATA ergebnis2 TYPE p DECIMALS 2.
DATA nachlass1 TYPE p DECIMALS 2.
DATA nachlass2 TYPE p DECIMALS 2.

PERFORM rechnen USING preis1 rabatt1 CHANGING ergebnis1 nachlass1.
PERFORM rechnen USING preis2 rabatt2 CHANGING ergebnis2 nachlass2.

WRITE: / 'Originalpreis 1. Artikel:', preis1, 'EUR'.
ULINE.
WRITE: / 'Rabatt in Prozent:', rabatt1,'|', 'Rabatt in EUR:', nachlass1.
ULINE.
WRITE: / 'Reduzierter Preis:', ergebnis1,'EUR','|'.
ULINE.
ULINE.
WRITE: / 'Originalpreis 2. Artikel:', preis2, 'EUR'.
ULINE.
WRITE: / 'Rabatt in Prozent:', rabatt2,'|', 'Rabatt in EUR:', nachlass2.
ULINE.
WRITE: / 'Reduzierter Preis:', ergebnis2,'EUR','|'.
ULINE.

FORM rechnen USING preis rabatt CHANGING ergebnis nachlass.
  nachlass = preis / 100 * rabatt.
  ergebnis = preis - nachlass.
ENDFORM.
