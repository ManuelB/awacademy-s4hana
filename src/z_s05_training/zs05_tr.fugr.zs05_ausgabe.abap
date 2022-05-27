FUNCTION ZS05_AUSGABE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     REFERENCE(A) TYPE  ZS05_D_PZAHL
*"     REFERENCE(OP) TYPE  Z05WW_OPER
*"     REFERENCE(B) TYPE  ZS05_D_PZAHL
*"     REFERENCE(RES) TYPE  ZS05_D_PZAHL
*"----------------------------------------------------------------------

WRITE: /3 A,
        / OP, B.
  ULINE /3(12).
  WRITE: /3 RES.


ENDFUNCTION.
