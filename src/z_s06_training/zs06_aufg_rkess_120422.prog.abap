*&---------------------------------------------------------------------*
*& Report ZS06_AUFG_RKESS_120422
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs06_aufg_rkess_120422.

DATA:
  "  t_scarr     TYPE zs06_ttyp_st_1,
  st_sflight  TYPE zs06_ttyp_SO_2, "slussel zugrif
  st_spfli    TYPE zs06_ttyp_SO_3,
  ht_sbook    TYPE zs06_ttyp_HA_4, "slussel für performance

  st_bookings TYPE SORTED TABLE OF sbook
  WITH UNIQUE KEY carrid, connid, fldate,

  carrier     TYPE scarr, "brauchen wir weil wir auf SELECT OPTIONS drauf hinweised
  loc         TYPE spfli. "brauchen wir weil wir auf SELECT OPTIONS drauf hinweised



FIELD-SYMBOLS: <flights> TYPE sflight,
<bookings> type sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.


  SELECT-OPTIONS: so_scarr FOR carrier-carrid,"gleich namig tabelle
                  so_spfli FOR loc-cityfrom.


SELECTION-SCREEN END OF BLOCK a.


START-OF-SELECTION. "def ein ereigniss.

  SELECT DISTINCT * INTO TABLE zs06_ttyp_SO_3
    FROM spfli
    WHERE carrid IN so_scarr
    AND cityfrom IN so_spfli.


  SELECT * INTO TABLE zs06_ttyp_SO_2
    FROM sflight
    FOR ALL ENTRIES IN zs06_ttyp_SO_2
    WHERE carrid = zs06_ttyp_SO_3-carrid
    AND connid = zs06_ttyp_SO_3-connid.

  select* into table zs06_ttyp_HA-4
  from sbook.

  LOOP AT zs06_ttyp_SO_2 ASSIGNING <flights>.
    IF <flights> IS ASSIGNED.

      READ TABLE zs06_ttyp_HA-4 ASSIGNING <bookings>
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

  cl_demo_output=>display(st_bookings).
