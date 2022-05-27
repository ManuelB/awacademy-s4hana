*&---------------------------------------------------------------------*
*& Report Z_S11_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_flugliste_bapi.

PARAMETERS : p_carrid TYPE sflight-carrid,

p_cityfr type spfli-cityfrom  DEFAULT 'FRANKFURT'  ,
*p_cityfr type spfli-cityfrom value check  DEFAULT 'FRANKFURT'  , "value check not working

p_cnto type spfli-countryto DEFAULT 'US'. "value check checking input against 'SGEOCITY' and not 'TOO5'
*p_cnto type land1  value check DEFAULT 'US'.

DATA :ls_cityfrom type bapisfldst,
      ls_countryto type bapisfldst,

      ls_flightlist TYPE bapisfldat,
      lt_flightlist TYPE table of bapisfldat,

       ls_return type bapiret2,
       lt_return type table of bapiret2
       .



ls_cityfrom-city = p_cityfr.
ls_countryto-countr = p_cnto.

          .

CALL FUNCTION 'BAPI_FLIGHT_GETLIST'
 EXPORTING
   AIRLINE                = p_carrid
   DESTINATION_FROM       = ls_cityfrom
   DESTINATION_TO         = ls_countryto
*   MAX_ROWS               =
 TABLES
*   DATE_RANGE             =
*   EXTENSION_IN           =
   FLIGHT_LIST            = lt_flightlist
*   EXTENSION_OUT          =
   RETURN                 = lt_return.

          DATA: count TYPE i.
LOOP AT lt_return INTO ls_return
  WHERE type CA 'WEA'.
  ADD 1 TO count.
  WRITE: / ls_return-type, ls_return-message.
ENDLOOP.

*IF sy-subrc <> 0.     "without lt_return loop
IF count <> 0.
* Implement suitable error handling here
  WRITE: / 'Some Mistake!'.
ELSE.
  WRITE: / lines( lt_flightlist ), 'Found flights'.
  LOOP AT  lt_flightlist INTO ls_flightlist.
    WRITE :/ ls_flightlist-airline, ls_flightlist-airlineid, ls_flightlist-connectid, ls_flightlist-cityfrom, ls_flightlist-cityto.
  ENDLOOP.

ENDIF.
