FUNCTION ZS07_RECHNEN_AUSGABE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(RES) TYPE  CACSMAPFACTOR
*"  EXPORTING
*"     REFERENCE(A) TYPE  CACSMAPFACTOR
*"     REFERENCE(OP) TYPE  /SAPAPO/OPERATOR
*"     REFERENCE(B) TYPE  CACSMAPFACTOR
*"----------------------------------------------------------------------


  WRITE: /3 A,
        / OP, B.
  ULINE /3(12).
  WRITE: /3 RES.




ENDFUNCTION.
