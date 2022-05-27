*&---------------------------------------------------------------------*
*& Report Z_S06_SELECT_SINGLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_select_single.

SELECTION-SCREEN BEGIN OF BLOCK al WITH FRAME.

  PARAMETERS: p_carrid TYPE s_carr_id,
              p_flight TYPE s_conn_id,
              p_cyfrom TYPE s_from_cit.

SELECTION-SCREEN END OF BLOCK al.

START-OF-SELECTION.
  SELECT SINGLE FOR UPDATE carrid, connid, cityfrom INTO @DATA(flights)
    FROM spfli
    WHERE carrid = 'LH'"@p_carrid'
   .

  UPDATE spfli SET cityfrom = 'Flight Cancled' WHERE carrid = 'LH' AND cityfrom = 'FRANKFURT'.
  WRITE: / flights.

  BREAK-POINT.
