*&---------------------------------------------------------------------*
*& Report Z_S09_HOSTSQL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_hostsql.





SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME. "Lässt ein guten Eingabeblock entstehen mit Rahmen"

  PARAMETERS: p_carr    TYPE s_carr_id,
              p_flights TYPE s_date,
              p_price   TYPE s_price.



  "ZAWS09_AIRPFROM.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE carrid, connid, fldate, price INTO @DATA(flights)
    FROM sflight
    WHERE carrid = @p_carr
    AND fldate = @p_flight
    AND carrid >= @p_preis.

  BREAK-POINT.

  ULINE.
  "---------------------------------------"


  SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME. "Lässt ein guten Eingabeblock entstehen mit Rahmen"

    PARAMETERS p_connid TYPE s_conn_id.                 "ZAWS09_AIRPFROM.
  SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE * INTO @DATA(flights)
    FROM sflight
    WHERE connid = @p_connid.

  BREAK-POINT.
