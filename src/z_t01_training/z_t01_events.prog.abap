*&---------------------------------------------------------------------*
*& Report z_t01_events
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_t01_events.

CLASS lcl_event_raiser DEFINITION FINAL.
  PUBLIC SECTION.
    EVENTS : event_raised.

    CLASS-METHODS : start.
  PRIVATE SECTION.
    CLASS-DATA : m_object TYPE REF TO lcl_event_raiser.

    METHODS : raise_event.
ENDCLASS.

CLASS lcl_event_handler DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS : handle_event_raised FOR EVENT event_raised OF lcl_event_raiser.

    METHODS : constructor
      IMPORTING
        i_raiser TYPE REF TO lcl_event_raiser
        i_number TYPE i.

  PRIVATE SECTION.
    DATA : m_handler TYPE i.
ENDCLASS.

CLASS lcl_event_raiser IMPLEMENTATION.
  METHOD start.
    CREATE OBJECT m_object.

    DO 3 TIMES.
      DATA(l_handler) = NEW lcl_event_handler( i_raiser = m_object
                                               i_number = sy-index ).
      m_object->raise_event( ).
      FREE l_handler.
    ENDDO.

    m_object->raise_event( ).
  ENDMETHOD.

  METHOD raise_event.
    RAISE EVENT event_raised.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.
  METHOD constructor.
    SET HANDLER me->handle_event_raised FOR i_raiser.
    me->m_handler = i_number.
  ENDMETHOD.

  METHOD handle_event_raised.
     CL_DEMO_OUTPUT=>display( me->m_handler ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_event_raiser=>start( ).
