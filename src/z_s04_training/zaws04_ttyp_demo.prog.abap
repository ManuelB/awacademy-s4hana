*&---------------------------------------------------------------------*
*& Report ZAWS04_TTYP_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_ttyp_demo.

DATA:
  st_sflight  TYPE zaws04_ttyp_st_sflight,
  st_spfli    TYPE zaws04_ttyp_st_spfli_wk,
  ht_sbook    TYPE zaws04_ttyp_ht_sbook,

  st_bookings TYPE SORTED TABLE OF sbook WITH UNIQUE KEY carrid, connid, fldate,

  carrier     TYPE scarr,
  loc         TYPE spfli.

FIELD-SYMBOLS: <flights>  TYPE sflight,
               <bookings> TYPE sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_scarr FOR carrier-carrid,
                  so_splfi FOR loc-cityfrom.

SELECTION-SCREEN END OF BLOCK a.


INITIALIZATION.

START-OF-SELECTION.


* get flights sheduling according to select options.
  SELECT DISTINCT * INTO TABLE st_spfli
    FROM spfli
    WHERE carrid IN so_scarr
    AND cityfrom IN so_splfi.



* get flights according to selection from spfli.
  IF NOT st_spfli[] IS INITIAL.
    SELECT * INTO TABLE st_sflight
      FROM sflight
      FOR ALL ENTRIES IN st_spfli
      WHERE carrid = st_spfli-carrid
      AND connid = st_spfli-connid.
    ENDIF.


* get bookings if applicable.
    SELECT * INTO TABLE ht_sbook
      FROM sbook.
