*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE6.

PARAMETERS:
  p_carrid TYPE sbook-carrid DEFAULT 'AA',
  p_connid TYPE sbook-connid DEFAULT '0017',
  p_dof TYPE sbook-order_date.

DATA:
      count type i,
      ls_booking TYPE BAPISBLIST,
      lt_booking TYPE TABLE OF BAPISBLIST,
      ls_return TYPE BAPIRET2,
      lt_return TYPE TABLE OF BAPIRET2.





CALL FUNCTION 'BAPI_SBOOK_GETLIST'
 EXPORTING
   AIRLINECARRIER         = p_carrid
   CONNECTIONNUMBER       = p_connid
   DATEOFFLIGHT           = p_dof
*   CUSTOMERNUMBER         = '00001324'
*   ORDERDATE              = '20001111'
*   CANCELLEDFLAG          = ' '
*   MAXREAD                = 0
 IMPORTING
   RETURN                 = ls_return
  TABLES
    bookinglist            = lt_booking.





LOOP AT lt_return INTO ls_return
  WHERE type CA 'E'.
  ADD 1 TO count.
  WRITE: / ls_return-type, ls_return-message.
ENDLOOP.

IF count <> 0.
  WRITE: / 'Fehler!'.
  ELSE.
  WRITE: / lines( lt_booking ), 'Buchungen Gefunden'.
  LOOP AT lt_booking INTO ls_booking.
    WRITE: / ls_booking-carrid,
             ls_booking-connid,
             ls_booking-customid,
             ls_booking-fldate,
             ls_booking-order_date.
   ENDLOOP.
    ENDIF.
