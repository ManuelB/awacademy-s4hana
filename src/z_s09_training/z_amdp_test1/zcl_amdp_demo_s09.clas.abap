CLASS zcl_amdp_demo_s09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_amdp_marker_hdb,
if_oo_adt_classrun.

TYPES:
BEGIN OF ty_result_line,
airline TYPE sflight-carrid,
flight_connection TYPE sflight-connid,
old_price TYPE sflight-PRICE,
old_currency TYPE sflight-CURRENCY,
new_price TYPE sflight-PRICE,
new_currency TYPE sflight-CURRENCY,
END OF ty_result_line,



BEGIN OF ty_flights_line,
airline TYPE sflight-carrid,
flight_connection TYPE sflight-connid,
price TYPE sflight-PRICE,
currency TYPE sflight-CURRENCY,
END OF ty_flights_line,



ty_result_table TYPE STANDARD TABLE OF ty_result_line WITH EMPTY KEY,
ty_flights_table TYPE STANDARD TABLE OF ty_flights_line WITH EMPTY KEY,
ty_flights TYPE STANDARD TABLE OF sflight.

  METHODS:
  get_flights
    EXPORTING
              VALUE(result) TYPE ty_result_table
    RAISING   cx_amdp_execution_error,

  convert_currency
    IMPORTING
              VALUE(flights) TYPE ty_flights_table
    EXPORTING
              VALUE(result)  TYPE ty_result_table
    RAISING   cx_amdp_execution_error.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AMDP_DEMO_S09 IMPLEMENTATION.


  METHOD convert_currency.

  ENDMETHOD.


  METHOD get_flights.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

  ENDMETHOD.
ENDCLASS.
