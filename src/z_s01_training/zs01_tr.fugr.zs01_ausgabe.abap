FUNCTION ZS01_AUSGABE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     REFERENCE(F_1ZAHL) TYPE  OPERAND_VALUE
*"     REFERENCE(F_2ZAHL) TYPE  OPERAND_VALUE
*"     REFERENCE(F_OP) TYPE  FOPERATOR
*"     REFERENCE(F_LV_RESULT1) TYPE  OPERAND_VALUE
*"----------------------------------------------------------------------


WRITE:/ |  { f_1zahl } |.
WRITE:/ |  { f_2zahl } |.
WRITE:/ |  { f_op } |.
ULINE.
WRITE:/ |  { f_lv_result1 } |.




ENDFUNCTION.
