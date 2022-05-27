*&---------------------------------------------------------------------*
*& Report ZS12_CLASS_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs12_class_events.

CLASS fluege DEFINITION.
  PUBLIC SECTION.
*Zur triggerndes Event
    EVENTS:
      flug_platz
        EXPORTING
          VALUE(txt)  TYPE string
          VALUE(wert) TYPE i.
    METHODS:
      constructor
        IMPORTING
          xy TYPE string.
    METHODS:
      get_flugplaetze
        IMPORTING  im_fp TYPE i
        EXCEPTIONS
                   fp_low,
      get_carrid
        IMPORTING im_carrid TYPE string.



  PRIVATE SECTION.
    DATA:
          s_sflight TYPE sflight.

ENDCLASS.

CLASS fluege IMPLEMENTATION.
  METHOD get_flugplaetze.
    SELECT carrid, connid, SUM( seatsocc ) as seattaken
      FROM sflight
      group by carrid, connid
      order by carrid, connid
      into @DATA(s_sflight).
      IF s_sflight-seattaken < 15.
        RAISE flug_platz.
      ELSE.
        CONTINUE.
      ENDIF.
    ENDMETHOD.

ENDCLASS.
