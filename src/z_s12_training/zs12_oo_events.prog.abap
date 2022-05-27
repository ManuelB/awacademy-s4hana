*&---------------------------------------------------------------------*
*& Report ZS12_OO_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS12_OO_EVENTS.
* Demo-Objekt, welches ein Event definiert und auslöst
CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.
* der Event, der getriggert werden soll
    EVENTS:
      my_event
        EXPORTING
          VALUE(txt) TYPE string
          VALUE(val) TYPE i.

* Instanzkonstruktor mit Übergabeparameter
    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string.

* die Methode, die den Event auslöst
    METHODS: write.

* gibt Namen zurück
    METHODS: get_name
      RETURNING VALUE(rv_name) TYPE string.

* Variable zum Speichern des Namens
  PRIVATE SECTION.
    DATA: gv_name TYPE string.
ENDCLASS.

CLASS lcl_demo IMPLEMENTATION.
* Instanzkonstruktor mit Übergabeparameter
  METHOD constructor.
    gv_name = iv_name.
  ENDMETHOD.
* die Methode, die den Event auslöst
  METHOD write.
    WRITE: / '1. lcl_demo triggert Event "my_event"'.
* Event auslösen
    RAISE EVENT my_event
      EXPORTING
        txt = 'Übergabetext'
        val = 1.
  ENDMETHOD.
* gibt Namen zurück
  METHOD get_name.
    rv_name = gv_name .
  ENDMETHOD.
ENDCLASS.

* Eventhandlerklasse, die Methoden zur Ereignisbehalndlung abbildet
CLASS lcl_eventhandler DEFINITION.
  PUBLIC SECTION.
* die Ereignisbehandlungsroutine, die mit dem Event über SET HANDLER verknüpft wird
    CLASS-METHODS: on_my_event FOR EVENT my_event OF lcl_demo
      IMPORTING
        txt
        val
        sender.
ENDCLASS.

CLASS lcl_eventhandler IMPLEMENTATION.
* die Ereignisbehandlungsroutine, die mit dem Event verknüpft wird
  METHOD on_my_event.
    WRITE: / '2. lcl_eventhandler=>on_my_event:'.
    WRITE: / '   Name:', sender->get_name( ).
    WRITE: / '    txt:', txt.
    WRITE: / '    val:', val.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
* Objekt erzeugen
  DATA(o_evt) = NEW lcl_demo( 'LOCALCLASS' ).

* Handler registrieren: Zuordnung von Eventhandler "on_my_event" zu Objekt der Demo-Klasse mit Eventtrigger für my_event
  SET HANDLER lcl_eventhandler=>on_my_event FOR o_evt.

* Funktionsaufruf, welcher den Event triggert
  o_evt->write( ).
