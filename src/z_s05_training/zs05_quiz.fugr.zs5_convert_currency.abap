FUNCTION ZS5_CONVERT_CURRENCY.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(SOURCE_AMOUNT) TYPE  ZS05_DEC5_2
*"     REFERENCE(SOURCE_CURR) TYPE  CHAR03
*"     REFERENCE(TARGET_CURR) TYPE  CHAR03
*"     REFERENCE(TARGET_FACTOR) TYPE  TCURR-UKURS
*"  EXPORTING
*"     REFERENCE(TARGET_AMOUNT) TYPE  ZS05_DEC5_2
*"----------------------------------------------------------------------

Target_amount = source_curr * target_factor.



ENDFUNCTION.
