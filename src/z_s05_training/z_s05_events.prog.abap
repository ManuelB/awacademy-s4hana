*&---------------------------------------------------------------------*
*& Report Z_S05_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_EVENTS.

CLASS lcl_demo_car DEFINITION.

  PUBLIC SECTION.

  EVENTS:

  car_ride

  EXPORTING

    VALUE(city) TYPE string
    VALUE(km) TYPE i.

  METHODS:

   constructor
   IMPORTING
     iv_drivername type STRING.

  METHODS: write.

  METHODS: get_name
  RETURNING VALUE(rv_drivername) TYPE string.

  PRIVATE section.
  DATA: gv_employeename. " = iv_drivername
  ENDCLASS.


  CLASS lcl_demo_car IMPLEMENTATION.

    method constructor.
      gv_employeename = iv_drivername.
      endmethod.

      method write.
        WRITE: '1. lcl_demo_car triggered Event "Car_ride"'.

        RAISE EVENT car_ride
        EXPORTING
          city = 'Munich'
          km = 35.
          ENDMETHOD.

          method get_name.
            rv_drivername = gv_employeename.
            endmethod.
            endclass.

            class lcl_passenger DEFINITION.
              PUBLIC SECTION.
              CLASS-METHODS:  passenger_car_ride FOR EVENT car_ride OF lcl_demo_car
              IMPORTING
                city
                km
                passenger.
              ENDCLASS.

               class lcl_passenger implementation.
                WRITE: / '2. lcl_passenger=>passenger_car_ride'.
                WRITE: / 'Passenger name:', passenger->get_name( ).
                WRITE: / 'to City:', city.
                WRITE: / 'km:', km.
                endmethod.
                endclass.

                start-of-selection.
                DATA(o_evnt) = NEW lcl_demo_car( 'Passenger' ).

  SET HANDLER lcl_passenger=>passenger_car_ride FOR o_evt.


  o_evt->write( ).
