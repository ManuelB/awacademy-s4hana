*&---------------------------------------------------------------------*
*& Report ZS03_T83
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_T83.

DATA:

st_sflight TYPE ZS03_TTYP_ST_TEST_SFLIGHT,
st_spfli TYPE ZS03_TTYP_ST_TEST_SPFLI,
ht_sbook TYPE ZS03_TTYP_HT_TEST1,


st_bookings TYPE SORTED TABLE OF sbook
with UNIQUE KEY carrid, connid, fldate,

carrier TYPE scarr,
loc TYPE spfli.
* gebraucht für seléct option
* by parameter würde ich so was nicht brauchen weil parameter typisiert sind: p_test type s_carr_id.
* sinon il faut declarer TABLES: scarr pour pouvoir utiliser scarr-carrid ligne 30
*Qd on fait select-opt, on ne typise pas.


FIELD-SYMBOLS: <flights> TYPE sflight,
               <bookings> TYPE sbook.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS  so_scarr for carrier-carrid,
  so_spfli for loc-cityfrom.
  SELECTION-SCREEN END OF BLOCK a.

  INITIALIZATION.

  START-OF-SELECTION.

SELECT DISTINCT * INTO TABLE st_spfli
  FROM SPFLI
  WHERE carrid IN so_scarr
  AND cityfrom IN so_spfli.


  if not st_spfli() is initial.
  SELECT * INTO TABLE st_sflight
  FROM sflight
    FOR ALL ENTRIES IN st_spfli
  WHERE carrid = st_spfli-carrid
  AND connid = st_spfli-connid.
*    c mieux avec des joins!
    endif.

    select * into TABLE hr_sbook
      from sbook.

    loop at st_sflight ASSIGNING <flights>.
      if <flights> is ASSIGNED.
