*&---------------------------------------------------------------------*
*& Include          ZRK_REPS_LOCALEVENTSDATA
*&---------------------------------------------------------------------*

DATA: BEGIN OF flight,
        carrid   TYPE sflight-carrid,
        seatsmax TYPE sflight-seatsmax,
        seatsocc TYPE sflight-seatsocc,
      END OF flight,
      t_flights LIKE TABLE OF flight,
      sflight   TYPE sflight,
      freeseats TYPE sflight-seatsocc.


* Demo-Objekt, welches ein Event definiert und auslöst
CLASS lcl_seatsocc DEFINITION.

  PUBLIC SECTION.
* der Event, der getriggert werden soll
    EVENTS:
      evt_noseats
        EXPORTING
          VALUE(val) TYPE sflight-seatsmax
          VALUE(txt) TYPE string.

* Instanzkonstruktor mit Übergabeparameter
    METHODS constructor
      IMPORTING
        carrid TYPE sflight-carrid.

*- Prüfen wie wieviele Sitzplätze zur Verfügung stehen
*  returning = Anzahl freie Plätze.
    METHODS: chk_seats
      RETURNING VALUE(seatsfree) TYPE sflight-seatsmax.

*- Methode mit dem einzigen Zweck das Ereignis auszulösen
*  wenn die vorgegebene Minseatanzahl freier Sitze nicht erreicht ist.
    METHODS: raise_event
      IMPORTING freeseats TYPE sflight-seatsmax.

*- PUBLIC Methode für das Lesen eines PRIVTE ( nicht öffentlichen ) Attributes
    METHODS: get_description
      returning value(reason) TYPE string.

  PRIVATE SECTION.

    DATA: evt_reason TYPE string VALUE 'Carrier ist überbucht:'.

ENDCLASS.

* Eventhandlerklasse, die Methoden zur Ereignisbehalndlung abbildet
CLASS lcl_eventhandler DEFINITION.
  PUBLIC SECTION.
* die Ereignisbehandlungsroutine, die mit dem Event über SET HANDLER verknüpft wird
    CLASS-METHODS: on_my_event FOR EVENT  evt_noseats OF lcl_seatsocc
      IMPORTING
        val
        txt
        sender.
ENDCLASS.
