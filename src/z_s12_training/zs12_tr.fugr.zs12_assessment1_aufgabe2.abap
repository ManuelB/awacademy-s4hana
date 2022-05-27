FUNCTION ZS12_ASSESSMENT1_AUFGABE2.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(SOURCE_AMOUNT) TYPE DEC5_2
*"     REFERENCE(SOURCE_CURR) TYPE  CHAR03
*"     REFERENCE(TARGET_CURR) TYPE  CHAR03
*"     REFERENCE(TARGET_FACTOR) TYPE TCURR-FACTOR
*"  EXPORTING
*"     REFERENCE(TARGET_AMOUNT) TYPE DEC5_2
*"----------------------------------------------------------------------
function.
  target_amount = source_curr * target_factor.
  endfunction.




ENDFUNCTION.
