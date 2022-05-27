FUNCTION Z_S07_UEBUNG_R_A.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(ERG) TYPE  CACSMAPFACTOR
*"  EXPORTING
*"     REFERENCE(A) TYPE  I
*"     REFERENCE(OP) TYPE  C
*"     REFERENCE(B) TYPE  I
*"----------------------------------------------------------------------
WRITE: / a, op, b, '=', erg.

ENDFUNCTION.
