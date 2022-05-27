*&---------------------------------------------------------------------*
*& Report ZAWS04_EREIGNISBEHANDLUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAWS04_EREIGNISBEHANDLUNG.

*CLASS raising_event DEFINITION.
*
*  EVENTS freeseats [ EXPORTING value(ev_par) TYPE i ].
*
*  ENDCLASS.



DATA carrid TYPE zaws04_sflight-carrid.
DATA seatmax TYPE zaws04_sflight-seatsmax.
DATA seatsocc TYPE zaws04_sflight-seatsocc.
DATA seatfree TYPE i.

seatfree = seatmax - seatsocc.

START-OF-SELECTION.


cl_demo_input=>new( )->add_field( CHANGING field = carrid )->add_field( CHANGING field = seatfree )->request( ).

SELECT carrid, connid, seatsmax, seatsocc
  FROM zaws04_sflight
  WHERE carrid = @carrid
  GROUP BY carrid, connid, seatsmax, seatsocc
  ORDER BY seatsocc
  INTO TABLE @DATA(result).

  cl_demo_output=>display( result ).
