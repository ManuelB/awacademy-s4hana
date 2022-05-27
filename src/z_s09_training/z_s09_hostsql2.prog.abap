*&---------------------------------------------------------------------*
*& Report Z_S09_HOSTSQL2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_hostsql2.





SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME. "Lässt ein guten Eingabeblock entstehen mit Rahmen"

  PARAMETERS: p_carr   TYPE s_carr_id default 'LH',
              p_connid TYPE s_CONN_ID '0400'.


SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE carrid, connid, price INTO @DATA(flights)
    FROM sflight
    WHERE carrid = @p_carr
    AND carrid = @p_connid.

  BREAK-POINT.

  update sflight set price = '100.00' where carrid = 'LH'and connid = '0400'.
  commit work.
