FUNCTION Z_S02_RECHNEN_AUSG.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZS02C_TY_BETRAG
*"     REFERENCE(I_OP) TYPE  ZS02C_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  ZS02C_TY_BETRAG
*"  EXPORTING
*"     REFERENCE(E_RES) TYPE  ZS02C_TY_BETRAG
*"----------------------------------------------------------------------
  WRITE: /3 i_a,
         / i_op, i_b.
  ULINE /3(12).
  WRITE: /3 e_res.




ENDFUNCTION.
