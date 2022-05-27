*&---------------------------------------------------------------------*
*& Report ZAW_S04_SELECT_SINGLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_select_single.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
  PARAMETERS: p_carr   TYPE s_carr_id DEFAULT 'LH',
              p_connid TYPE s_conn_id DEFAULT '0400'.

SELECTION-SCREEN END OF BLOCK a1.


DATA fldate TYPE sdate.

START-OF-SELECTION.

  SELECT SINGLE FOR UPDATE carrid, connid, price, fldate INTO @DATA(flights)
    FROM sflight WHERE carrid = @p_carr AND connid = @p_connid.

  cl_demo_output=>display( flights ).


*  BREAK-POINT.

*  UPDATE sflight SET price = '747.00'
*  WHERE carrid = 'LH'
*  AND connid = '0400'
*  AND fldate = '20220127'.
*
*  COMMIT WORK.
