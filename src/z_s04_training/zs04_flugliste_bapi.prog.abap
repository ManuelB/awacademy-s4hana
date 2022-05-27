*&---------------------------------------------------------------------*
*& Report ZS04_FLUGLISTE_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_flugliste_bapi.

*
*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  PARAMETERS p_carrid TYPE s_carr_id.
*SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
PARAMETERS:
p_carrid TYPE sflight-carrid DEFAULT 'LH'.
SELECTION-SCREEN END OF BLOCK a1.

DATA:
*  lt_flugliste TYPE sflight_tab2,
  ls_fluege TYPE bapisfldat,
  lt_fluege TYPE TABLE OF bapisfldat,
  ls_return TYPE bapiret2,
  lt_return TYPE TABLE OF bapiret2.



CALL FUNCTION 'BAPI_FLIGHT_GETLIST'
  EXPORTING
    airline     = p_carrid
*   DESTINATION_FROM       =
*   DESTINATION_TO         =
*   MAX_ROWS    =
  TABLES
*   DATE_RANGE  =
*   EXTENSION_IN           =
    flight_list = lt_fluege
*   EXTENSION_OUT          =
    return      = lt_return.



IF sy-subrc <> 0.
* Implement suitable error handling here
  WRITE: / 'Fehler!'.
ELSE.
  WRITE: / lines( lt_fluege ), 'Flüge für', ls_fluege-airline, 'gefunden'.

  LOOP AT lt_fluege INTO ls_fluege.
    WRITE: / ls_fluege-cityfrom, ls_fluege-cityto.
  ENDLOOP.

ENDIF.
