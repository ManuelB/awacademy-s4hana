FUNCTION zs04_fuba_rechteck.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(LAENGE) TYPE  I
*"     REFERENCE(BREITE) TYPE  I
*"  EXPORTING
*"     REFERENCE(FLAECHE) TYPE  I
*"     REFERENCE(UMFANG) TYPE  I
*"  EXCEPTIONS
*"      NULL
*"----------------------------------------------------------------------



  flaeche = breite * laenge.

  umfang = breite + breite + laenge + laenge.


  IF breite = laenge.
    WRITE: / 'Es handelt sich um ein Quadrat'.
  ENDIF.

  IF laenge = 0 OR breite = 0.
        RAISE null.
        WRITE: / 'Berechnungen mit "0" nicht möglich!' COLOR COL_NEGATIVE.
      ENDIF.






ENDFUNCTION.
