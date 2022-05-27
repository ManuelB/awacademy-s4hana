FUNCTION ZS03_AUSGABE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZRK02_TY_BETRAG
*"     REFERENCE(I_OP) TYPE  ZRK02_TY_OPERATOR
*"     REFERENCE(I_B) TYPE  ZRK02_TY_BETRAG
*"     REFERENCE(E_RES) TYPE  ZRK02_TY_BETRAG
*"----------------------------------------------------------------------


  WRITE: /3 i_a,
         / i_op, i_b.
  ULINE /3(12).
  WRITE: /3 e_res.




ENDFUNCTION.
