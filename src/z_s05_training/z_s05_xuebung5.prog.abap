*&---------------------------------------------------------------------*
*& Report Z_S05_XUEBUNG5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XUEBUNG5.


DATA:
      ls_flight TYPE sflight,
     lt_flight TYPE TABLE OF sflight,
     i_carrid TYPE sflight-carrid.


.

CALL FUNCTION 'ZS05_FB_FLIGHT1'
  EXPORTING
    p_carrid            = i_carrid
  tables
    lt_flug             = lt_flight
* EXCEPTIONS
*   NOTHING_FOUND       = 1
*   OTHERS              = 2
          .
IF sy-subrc <> 0.
 WRITE: 'Fehler'.
 ELSE.
  WRITE: lines( lt_flight ), 'Gefunden' .
  LOOP AT lt_flight into ls_flight.
    WRITE: / ls_flight-carrid,
           ls_flight-connid,
           ls_flight-fldate,
           ls_flight-price,
           ls_flight-currency,
           ls_flight-paymentsum,
           ls_flight-seatsocc.
    ENDLOOP.
ENDIF.
