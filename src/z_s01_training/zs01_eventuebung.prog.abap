*&---------------------------------------------------------------------*
*& Report zs01_eventuebung
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_eventuebung.

CLASS lcl_example DEFINITION.
  PUBLIC SECTION.

    EVENTS: e.

    METHODS:
      start_event,
      constructor, "special method. produces defined initial state for objects, classes.
      react_to_event FOR EVENT e OF lcl_example.

ENDCLASS.

CLASS lcl_example IMPLEMENTATION.

  METHOD Constructor.

    SET HANDLER me->react_to_event FOR me.

  ENDMETHOD.


  METHOD start_event.

    RAISE EVENT e.

  ENDMETHOD.

  METHOD react_to_event.

    WRITE:/ 'Event E wurde aktiviert und ich habe reagiert'.


  ENDMETHOD.


ENDCLASS.



START-OF-SELECTION.

DATA:
        event_demo TYPE REF TO lcl_example.
        event_demo = NEW lcl_example( ).
        CALL METHOD event_demo->start_event.
