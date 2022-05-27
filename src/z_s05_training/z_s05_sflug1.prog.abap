*&---------------------------------------------------------------------*
*& Report Z_S05_SFLUG1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SFLUG1.

DATA:
  ls_sflight TYPE sflight,
  lt_sflight TYPE TABLE OF sflight.
SELECT-OPTIONS:
  s_carrid FOR ls_sflight-carrid DEFAULT 'AA',
  s_fldate FOR ls_sflight-fldate.
*
SELECT * FROM sflight INTO TABLE lt_sflight
  WHERE carrid IN s_carrid
  AND   fldate IN s_fldate.
*
LOOP AT lt_sflight INTO ls_sflight.
  WRITE: / ls_sflight-carrid, ls_sflight-connid, ls_sflight-fldate,
  ls_sflight-seatsocc.
ENDLOOP.
