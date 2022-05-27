*&---------------------------------------------------------------------*
*& Report Z_S05_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_HOSTVAR.
tables ZS05_SPFLI_DEMO.


SELECTION-SCREEN BEGIN OF BLOCK B0 WITH FRAME.
  parameterS p_carr TYPE s_carr_id."ZS05_AIRFROM.
   parameterS p_sta TYPE S_FROM_CIT DEFAULT 'NEW YORK'.
  SELECTION-SCREEN END OF BLOCK B0.

START-OF-SELECTION.

*DELETE FROM ZS05_SPFLI_DEMO.
*INSERT ZS05_SPFLI_DEMO FROM @.
*COMMIT CONNECTION default.

SELECT SINGLE FOR UPDATE CARRID, CITYFROM, AIRPFROM INTO @data(flights)
  FROM ZS05_SPFLI_DEMO
  WHERE CARRID EQ @p_carr
 AND CITYFROM EQ @p_sta.
"ENDSELECT.



UPDATE ZS05_SPFLI_DEMO SET AIRPFROM = 'MUC' WHERE CITYFROM = 'NEW YORK'.
commit work.


 BREAK-POINT.



  WRITE: flights.
  .
