FUNCTION ZS05_FB_TR2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(P_ZAHL1) TYPE  Z05WW_PZAHL
*"     REFERENCE(P_OP) TYPE  Z05WW_OPER
*"     REFERENCE(P_ZAHL2) TYPE  Z05WW_PZAHL
*"     REFERENCE(ERGEBNIS) TYPE  Z05WW_PZAHL
*"----------------------------------------------------------------------

WRITE: /3 p_zahl1,
        / p_OP, p_zahl2.
  ULINE /3(12).
  WRITE: /3 ergebnis.


ENDFUNCTION.
