FUNCTION ZS12_AUSGABE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS12_ZAHL
*"     REFERENCE(I_OP) TYPE  ZS12_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS12_ZAHL
*"     REFERENCE(I_RES) TYPE  ZS12_ZAHL
*"----------------------------------------------------------------------

  WRITE: /3 i_a,
  / i_op, i_b.
  ULINE /3(12).
  WRITE: /3 i_res.



ENDFUNCTION.
