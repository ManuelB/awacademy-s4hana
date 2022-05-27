*&---------------------------------------------------------------------*
*& Report Z_S05_BAPI_FL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_BAPI_FL.



PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH',
  p_cityfr TYPE spfli-cityfrom DEFAULT 'FRANKFURT',
  p_cnto TYPE bapisfldst-countr DEFAULT 'US'.
 " p_max TYPE BAPIMAXROW.
DATA:
  "lt_flugliste TYPE sflight_tab2,
  ls_cityfrom TYPE bapisfldst,
  ls_cityto TYPE bapisfldst,
  ls_fluege   TYPE bapisfldat,
  lt_fluege   TYPE TABLE OF bapisfldat,
  ls_return   TYPE bapiret2,
  lt_return   TYPE TABLE OF bapiret2.
*  ls_max   TYPE BAPISFLAUX-BAPIMAXROW,
*  lt_max   TYPE TABLE OF BAPISFLAUX-BAPIMAXROW.
*
* message-Typ: I, S, W, E, A


"Schnittstelle versorgen
ls_cityfrom-city = p_cityfr.
ls_cityto-countr = p_cnto.


CALL FUNCTION 'BAPI_FLIGHT_GETLIST'
  EXPORTING
    airline          = p_carrid
    destination_from = ls_cityfrom
   DESTINATION_TO   = ls_cityto
   "  MAX_ROWS         = ls_max
  TABLES
*   DATE_RANGE       =
*   EXTENSION_IN     =
    flight_list      = lt_fluege
*   EXTENSION_OUT    =
    return           = lt_return.

DATA: count TYPE i.
DATA: max TYPE i VALUE 15.


LOOP AT lt_return INTO ls_return
  WHERE type CA 'WEA'.
  ADD 1 TO count.
  WRITE: / ls_return-type, ls_return-message.
ENDLOOP.

IF count <> 0.
* Implement suitable error handling here
  WRITE: / 'irgendein Fehler'.
ELSE.
  WRITE: / lines( lt_fluege ), 'Flüge gefunden'.
  LOOP AT lt_fluege INTO ls_fluege.
    WRITE: / ls_fluege-airlineid, ls_fluege-airline,
             ls_fluege-cityfrom, ls_fluege-cityto,
             ls_fluege-price, ls_fluege-curr.
  ENDLOOP.
ENDIF.
