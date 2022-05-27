FUNCTION ZS11_RECHNEN_AUSGABE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_A) TYPE  ZDL_FUBA
*"     REFERENCE(I_B) TYPE  ZDL_FUBA
*"     REFERENCE(I_RES) TYPE  ZDL_FUBA
*"     REFERENCE(I_OP) TYPE  /SAPAPO/OPERATOR
*"----------------------------------------------------------------------

WRITE: /3 i_a,
       / i_op, i_b.
ULINE /3(12).
WRITE: /3 i_res.



ENDFUNCTION.
