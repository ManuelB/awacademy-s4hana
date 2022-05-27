*&---------------------------------------------------------------------*
*& Report ZS07_TTY_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS07_TTY_UEBUNG.


DATA:
      st_sflight type Zs07_TTyp_so_test,
      st_spfli TYPE zs07_ttyp_so_sp_test,
      ht_sbook type ZS07_TTYP_HT_TEST,

      st_bookings TYPE SORTED TABLE OF sbook
      WITH UNIQUE key carrid, connid, fldate,

      carrier TYPE scarr,
      loc TYPE spfli.

FIELD-SYMBOLS: <flights> type sflight,
               <bookings> type sbook.



SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_scarr FOR carrier-carrid,
                  so_spfli FOR loc-cityfrom.

SELECTION-SCREEN END OF BLOCK a.

START-OF-SELECTION.


*------ INNER JOIN geschickter ?
*- get flight scheduling according to select options
  SELECT DISTINCT * INTO TABLE st_spfli
   FROM spfli
   WHERE carrid IN so_scarr
     AND cityfrom IN so_spfli.


*- get flights according to selection from spfli
  SELECT * INTO TABLE st_sflight
    FROM sflight
    FOR ALL ENTRIES IN st_spfli
    WHERE carrid = st_spfli-carrid
      AND connid = st_spfli-connid.

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
