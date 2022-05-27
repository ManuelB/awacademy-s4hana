*&---------------------------------------------------------------------*
*& Report Z_S09_REPORTTABLEAUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_reporttableaufgabe.


DATA:

  st_sflight  TYPE z_s09_ttyp_sortedtable1,
  st_spfli    TYPE z_s09_ttyp_sortedtable2,
  ht_sbook    TYPE z_s09_ttyp_hashtable1,

  st_bookings TYPE SORTED TABLE OF sbook
                WITH UNIQUE KEY carrid, connid, fldate,

  carrier     TYPE scarr,
  loc         TYPE spfli.


************************************

FIELD-SYMBOLS: <flights> TYPE sflight,
               <bookings> TYPE sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.
  PARAMETERS p_test TYPE S_CARR_ID.

  SELECT-OPTIONS: so_carr FOR carrier-carrid,
  so_spfli FOR loc-cityfrom.

  SELECTION-SCREEN END OF BLOCK a.

  INITIALIZATION.



  START-OF-SELECTION.

  ***************************************
