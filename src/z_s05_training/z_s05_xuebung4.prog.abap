*&---------------------------------------------------------------------*
*& Report Z_S05_XUEBUNG4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XUEBUNG4.

DATA:
 ls_flight TYPE sflight,
lt_flight TYPE TABLE OF sflight.

SELECT-OPTIONS:
 s_carrid for ls_flight-carrid DEFAULT 'AA',
 s_fldate FOR ls_flight-fldate,
 s_SEATS FOR ls_flight-seatsocc,
 s_planet FOR ls_flight-planetype NO INTERVALS.


SELECT * FROM sflight INTO TABLE lt_flight
  where:
  carrid IN s_carrid
  AND
  fldate IN s_fldate
  AND
  seatsocc IN  s_SEATS
  AND
  planetype IN s_planet.
  .

  LOOP AT lt_flight INTO ls_flight.
  WRITE: / ls_flight-carrid, ls_flight-PRICE, ls_flight-PLANETYPE,'-----Number of the booked seats---', ls_flight-seatsocc, '---Number of the total seats---', ls_flight-seatsmax.
  IF ls_flight-seatsocc GE ls_flight-seatsmax.
    WRITE: ' No more avalible seats.' .
    ELSE.
      WRITE:  ' Avalible for booking.'.
      ENDIF.
     ENDLOOP.
