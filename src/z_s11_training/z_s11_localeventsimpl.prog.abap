*&---------------------------------------------------------------------*
*& Include          ZRK_REPS_LOCALEVENTSIMPL
*&---------------------------------------------------------------------*

CLASS lcl_seatsocc IMPLEMENTATION.

*- constructor, aufruf wenn eine Instanz der Klasse erzeugt wird
  METHOD constructor.

    DATA: selopt   TYPE selopt,
          selopt_t TYPE TABLE OF selopt.

    selopt-sign = 'I'.
    IF NOT carrid = ''.
      selopt-option = 'EQ'.
      selopt-low = carrid.
    ELSE.
      selopt-option = 'CP'.
      selopt-low = '*' .
    ENDIF.
    APPEND selopt TO selopt_t.

    SELECT carrid, seatsmax, seatsocc
       FROM sflights
       WHERE carrid IN @selopt_t
       INTO TABLE @t_flights.

  ENDMETHOD.

*-
  METHOD chk_seats.

    DATA t_collect LIKE TABLE OF flight.

    LOOP AT t_flights INTO flight.
      COLLECT flight INTO t_collect .
    ENDLOOP.

    CLEAR flight.
    IF NOT t_collect[] IS INITIAL.
      flight = t_collect[ 1 ].
      seatsfree = flight-seatsmax - flight-seatsocc.
    ENDIF.

  ENDMETHOD.

*
  METHOD raise_event.

    RAISE EVENT evt_noseats
    EXPORTING
      val = freeseats
      txt = get_description( ).

  ENDMETHOD.

  METHOD get_description.
    reason = evt_reason.
  ENDMETHOD.


ENDCLASS.


CLASS lcl_eventhandler IMPLEMENTATION.
* die Ereignisbehandlungsroutine, die mit dem Event verknüpft wird
  METHOD on_my_event.
    WRITE: / 'LCL_EVENTHANDLER=>on_my_event'.
    WRITE: / '    txt:', txt.
    WRITE: / '    val:', val.
  ENDMETHOD.
ENDCLASS.
