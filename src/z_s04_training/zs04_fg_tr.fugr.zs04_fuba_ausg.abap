FUNCTION ZS04_FUBA_AUSG.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IM_A) TYPE  I
*"     REFERENCE(IM_OP) TYPE  C
*"     REFERENCE(IM_B) TYPE  I
*"  EXPORTING
*"     REFERENCE(EX_RES) TYPE  I
*"  EXCEPTIONS
*"      ZERO_DIVIDE
*"      WRONG_OPERATOR
*"      NEGATIVE_ARGUMENT
*"----------------------------------------------------------------------


  WRITE: /3 im_a,
         / im_op ,im_b.
  ULINE: /3(12).
  WRITE: /3 ex_res.

ENDFUNCTION.
