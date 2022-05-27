*&---------------------------------------------------------------------*
*& Report Z_S05_SELECT_SINGLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SELECT_SINGLE.

SELECTION-SCREEN BEGIN OF BLOCK B0 WITH FRAME.
  parameterS p_CARR TYPE s_carr_id."ZS05_AIRFROM.
   parameterS p_conn TYPE S_CONN_ID DEFAULT 'NEW YORK'.


  SELECTION-SCREEN END OF BLOCK B0.

*DELETE FROM ZS05_SPFLI_DEMO


  SELECT SINGLE FOR UPDATE CARRID, connid, price INTO @DATA(flights)
    FROM sflight
    WHERE carrid = @p_CARR
    AND CONNID = @P_CONN.

    break-point.
