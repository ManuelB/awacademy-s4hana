*&---------------------------------------------------------------------*
*& Report Z_S01_SELECT_COUNT_DISTINCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_select_count_distinct.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.

  PARAMETERS:

    p_carrid TYPE s_carr_id DEFAULT 'AA',
    p_cityto TYPE s_to_city DEFAULT 'HOUSTON'.

SELECTION-SCREEN END OF BLOCK a1.

*Bestimmung der Anzahl unterschiedlicher Werte entsprechend dem SQL Ausdruck.
*Anzahl der Fluggesselschaften (Count), die Houston bedienen ohne Doppelnennungen (Distinct).
*START-OF-SELECTION. unnötig.

  SELECT COUNT( DISTINCT carrid )
      FROM spfli
      WHERE carrid = @p_carrid
      AND cityto = @p_cityto
  INTO @DATA(sumofflights).
WRITE: / sumofflights.
