*&---------------------------------------------------------------------*
*& Report ZS04_KLASSE_RECHTECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a10_form_rechteck.


**********************************************************************
*Eingabefelder:

PARAMETERS: laenge TYPE i,
            breite TYPE i.


**********************************************************************
*Typisierung der Ergebnisse:

DATA: flaeche TYPE i,
      umfang  TYPE i.


**********************************************************************
*Berechnungen

PERFORM ber_fl USING laenge breite CHANGING flaeche.
PERFORM ber_um USING laenge breite CHANGING umfang.
PERFORM ausgabe USING flaeche umfang.


**********************************************************************
*Formparameter Fläche

FORM ber_fl USING laenge breite CHANGING flaeche.
  flaeche = breite * laenge.
  IF breite = laenge.
    WRITE: / 'Es handelt sich um ein Quadrat'.
  ENDIF.
  EXIT.
ENDFORM.


**********************************************************************
*Formparameter Umfang

FORM ber_um USING laenge breite CHANGING umfang.
  umfang = breite + breite + laenge + laenge.
ENDFORM.


**********************************************************************
*Ausgabe

FORM ausgabe USING flaeche umfang.
  WRITE: / 'Fläche:', flaeche, 'm2'.
  WRITE: / 'Umfang:', umfang, 'm'.
ENDFORM.
