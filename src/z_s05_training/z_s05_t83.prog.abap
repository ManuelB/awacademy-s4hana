*&---------------------------------------------------------------------*
*& Report Z_S05_T83
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_T83.

DATA:
 " t_scarr     TYPE zs05_TT_scarr,
  st_sflight  TYPE zs05_TT_sflight,
  st_spfli    TYPE zs05_TT_spfli,
  ht_sbook    TYPE zs05_TT_sbook,
*
  st_bookings TYPE SORTED TABLE OF sbook
              WITH UNIQUE KEY carrid, connid, fldate,
*
  carrier     TYPE scarr,
  loc         TYPE spfli.


FIELD-SYMBOLS: <flights>  TYPE sflight,
               <bookings> TYPE sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_scarr FOR carrier-carrid,
                  so_spfli FOR loc-cityfrom.

SELECTION-SCREEN END OF BLOCK a.

INITIALIZATION.



START-OF-SELECTION.


*------ INNER JOIN geschickter ?
*- get flight scheduling according to select options
  SELECT DISTINCT * INTO TABLE st_spfli
   FROM spfli
   WHERE carrid IN so_scarr
     AND cityfrom IN so_spfli.

*- get flights according to selection from spfli
IF NOT ST_SPFLI[] IS INITIAL.
  SELECT * INTO TABLE st_sflight
    FROM sflight
    FOR ALL ENTRIES IN st_spfli
    WHERE carrid = st_spfli-carrid
      AND connid = st_spfli-connid.
    ENDIF.

*- get bookings if applicable
  SELECT * INTO TABLE ht_sbook
  FROM sbook.

  LOOP AT st_sflight ASSIGNING <flights>.
    IF <flights> IS ASSIGNED.

********** Hash table ersetzen durch standard table ??

      READ TABLE ht_sbook ASSIGNING <bookings>
      WITH KEY carrid = <flights>-carrid
               connid = <flights>-connid.
      IF <bookings> IS ASSIGNED.
        READ TABLE st_bookings
        WITH KEY carrid = <bookings>-carrid
                 connid = <bookings>-connid
        TRANSPORTING NO FIELDS.
        IF NOT sy-subrc = 0.
          INSERT <bookings> INTO TABLE st_bookings.
        ENDIF.
      ENDIF.

    ENDIF.
  ENDLOOP.

  cl_demo_output=>display( st_bookings ).
