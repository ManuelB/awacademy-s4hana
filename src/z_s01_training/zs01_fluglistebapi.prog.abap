*&---------------------------------------------------------------------*
REPORT zs01_fluglistebapi.
*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH' VALUE CHECK,
  "p_connid TYPE sflight-connid,
  p_cityfr TYPE sflights-cityfrom DEFAULT 'FRANKFURT',
  p_cnto   TYPE bapisfldst-countr DEFAULT 'US'.
DATA:
  "lt_flugliste TYPE sflight_tab2,
  ls_cityfrom TYPE bapisfldst,
  ls_cityto   TYPE bapisfldst,
  ls_fluege   TYPE bapisfldat,
  lt_fluege   TYPE TABLE OF bapisfldat,
  ls_return   TYPE bapiret2,
  lt_return   TYPE TABLE OF bapiret2.
*
* message-Typ: I, S, W, E, A

* Schnittstelle versorgen
ls_cityfrom-city = p_cityfr.
ls_cityto-countr = p_cnto.

CALL FUNCTION 'BAPI_FLIGHT_GETLIST'
  EXPORTING
    airline          = p_carrid
    destination_from = ls_cityfrom
    destination_to   = ls_cityto
*   MAX_ROWS         =
  TABLES
*   DATE_RANGE       =
*   EXTENSION_IN     =
    flight_list      = lt_fluege
*   EXTENSION_OUT    =
    return           = lt_return.
DATA: count TYPE i.
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


*ls_flug2-carrid = ls_fluege-airlineid.
