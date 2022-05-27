*&---------------------------------------------------------------------*
*& Report ZS03_CB_ASSESS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_CB_ASSESS.


TYPES: ty_betrag TYPE p LENGTH 4 DECIMALS 2.

PARAMETERS:
opreis1 TYPE ty_betrag DEFAULT '10.05',
opreis2 TYPE ty_betrag DEFAULT 21,
rabatt1 TYPE i,
rabatt2 TYPE i.



DATA:
rpreis1 type ty_betrag,
rpreis2 type ty_betrag.

PERFORM rechnen USING opreis1 rabatt1 CHANGING rpreis1.
  PERFORM ausgabe USING opreis1 rabatt1 rpreis1.

   PERFORM rechnen USING opreis2 rabatt2 CHANGING rpreis2.
  PERFORM ausgabe USING opreis2 rabatt2 rpreis2.


FORM rechnen USING opreis rabatt CHANGING rpreis.
  rpreis = opreis - opreis * ( rabatt / '100' ).
  ENDFORM.

  FORM ausgabe USING opreis rabatt rpreis.
  WRITE: /'Der Originalpreis für diesen Artikel war:', opreis, 'Euro.'.
  WRITE: /'Sie bekommen einen Rabatt von:', rabatt, 'Prozent.'.
  WRITE: /'Der reduzierte Preis beträgt jetzt :', rpreis, 'Euro.'.

  ENDFORM.
