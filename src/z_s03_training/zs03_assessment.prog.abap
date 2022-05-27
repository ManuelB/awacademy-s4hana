*&---------------------------------------------------------------------*
*& Report ZS03_ASSESSMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_ASSESSMENT.

TYPES: ty_betrag TYPE p LENGTH 7 DECIMALS 2.

PARAMETERS:
bw1 TYPE ty_betrag DEFAULT 10,
bw2 TYPE ty_betrag DEFAULT 100,
wtyp1 TYPE c LENGTH 1 DEFAULT 'L',
wtyp2 TYPE c LENGTH 1 DEFAULT 'H'.



DATA:
mwst TYPE ty_betrag,
nw1 TYPE ty_betrag,
nw2 TYPE ty_betrag.

PERFORM rechnen USING bw1 wtyp1 CHANGING nw1 mwst.
  PERFORM ausgabe USING bw1 nw1 mwst.

   PERFORM rechnen USING bw2 wtyp2 CHANGING nw2 mwst.
  PERFORM ausgabe USING bw2 nw2 mwst.


FORM rechnen USING bw wtyp CHANGING nw mwst.
CASE wtyp.
  WHEN 'L'.
    nw = bw - ( '0.07' * bw ).
     mwst = bw - nw.
  WHEN 'H'.
    nw = bw - ( '0.19' * bw ).
     mwst = bw - nw.
  WHEN OTHERS.
    WRITE: /'Fehler'. EXIT.
  ENDCASE.
  ENDFORM.

  FORM ausgabe USING bw nw mwst.
  WRITE: /' Bruttopreis:', bw, ' Nettopreis:', nw, ' Mehrwertsteuer Anteil:', mwst.

  ENDFORM.
