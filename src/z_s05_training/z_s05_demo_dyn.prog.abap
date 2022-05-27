*&---------------------------------------------------------------------*
*& Report Z_S05_DEMO_DYN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_DEMO_DYN.

data: summe type I.
sElect-options:
ZAHL FOR SUMME.


loop at zahl.
  summe = summe + zahl-low.


  endloop.
WRITE: / 'fERTIG#/', summe.




data:
      ls_sflight TYPE sflight,
      lt_sflight type table of sflight.
SELECT-OPTIONS:
s_carrid FOR ls_sflight-carrid DEFAULT 'LH',
s_fldate FOR ls_sflight-fldate.

SELECT * FROM sflight into Table lt_sflight
  WHERE carrid in s_carrid
  AND fldate in s_fldate.

  LOOP AT lt_sflight into ls_sflight.
    WRITE: / ls_sflight-carrid,  ls_sflight-connid,  ls_sflight-fldate,  ls_sflight-seatsocc.
    endloop.
