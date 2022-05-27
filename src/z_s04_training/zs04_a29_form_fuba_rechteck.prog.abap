*&---------------------------------------------------------------------*
*& Report zs04_form_fuba_rechteck
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a29_form_fuba_rechteck.


**********************************************************************
*Eingabefelder:
SELECTION-SCREEN BEGIN OF BLOCK e WITH FRAME TITLE TEXT-100.

    PARAMETERS: laenge TYPE i,
                breite TYPE i.

SELECTION-SCREEN END OF BLOCK e.



**********************************************************************
*Typisierung des Ergebnis (res = result):

DATA: flaeche TYPE i,
      umfang  TYPE i.



**********************************************************************
*Berechnung über FuBa:

CALL FUNCTION 'ZS04_FUBA_RECHTECK'
  EXPORTING
    laenge        = laenge
    breite        = breite
 IMPORTING
   FLAECHE       = flaeche
   UMFANG        = umfang
 EXCEPTIONS
   NULL          = 1
*   OTHERS        = 2
          .
IF sy-subrc <> 0.
WRITE: / 'Fehlercode:', sy-subrc.
IF sy-subrc EQ 1.
  WRITE: / 'Berechnungen mit "0" nicht möglich!' COLOR COL_NEGATIVE.
ENDIF.
ELSE.
  PERFORM ausgabe USING flaeche umfang.
ENDIF.


**********************************************************************
*Formparameter Ausgabe

FORM ausgabe USING flaeche umfang.
  WRITE: / 'Fläche:', flaeche, 'm2'.
  WRITE: / 'Umfang:', umfang, 'm'.
ENDFORM.
