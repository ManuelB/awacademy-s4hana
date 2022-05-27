*&---------------------------------------------------------------------*
*& Report Z_S02_TABTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_tabtypen.

DATA:
  lt_sflight  TYPE zaws02_ttyp_st_sflight,
  st_spfli    TYPE zaws02_ttyp_st_spfli,
  ht_sbook    TYPE zaws02_ttyp_ht_test1,

  st_bookings TYPE SORTED TABLE OF sbook
  WITH        UNIQUE KEY carrid, connid, fldate,

  carrier     TYPE scarr,
  loc         TYPE spfli.


***

FIELD-SYMBOLS: <flights> TYPE sflight,
               <bookings> TYPE sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_scarr FOR carrier-carrid,
  so_spfli FOR loc-cityfrom.

  SELECTION-SCREEN END OF BLOCK a.

  INITIALIZATION.



  START-OF-SELECTION.

*
*
**
*  SELECT DISTINCT * INTO TABLE st_spfli
*    from spfli
*    where carrid IN so-scarr
*    AND cityfrom IN so_spfli.
*
*   SELECT * INTO TABLE st_flight
*     from sflight
*     WHERE
