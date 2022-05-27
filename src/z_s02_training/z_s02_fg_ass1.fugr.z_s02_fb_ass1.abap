FUNCTION Z_S02_FB_ASS1.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(BWERT) TYPE  ZS02C_TY_BETRAG
*"     REFERENCE(WTYP) TYPE  ZS02C_TY_MWST
*"  EXPORTING
*"     REFERENCE(NWERT) TYPE  ZS02C_TY_BETRAG
*"     REFERENCE(TWERT) TYPE  ZS02C_TY_BETRAG
*"----------------------------------------------------------------------


  CASE wtyp.
    WHEN 'L'.
      nwert = bwert / '1.07'.
      twert = bwert - nwert.
    WHEN 'H'.
      nwert = bwert / '1.19'.
      twert = bwert - nwert.
    WHEN OTHERS.
  ENDCASE.


ENDFUNCTION.
