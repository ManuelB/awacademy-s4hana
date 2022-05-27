*&---------------------------------------------------------------------*
*& Report Z_S11_DEMO_RK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_DEMO_RK.



PARAMETERS:
 pi TYPE zrk02_ty_betrag DEFAULT '3.14159'.
*pi2 type f.
*TYPE p LENGTH 5 DECIMALS 3
DATA:
      zahl TYPE f.

  WRITE: / pi.
  zahl = pi.
  WRITE: / zahl.
  uline.


*****************Rainer demo****************

*PARAMETERS:
*  persnr TYPE n LENGTH 3 DEFAULT '1a2b3c4d5e' ,
*  id TYPE c LENGTH 3 DEFAULT '1a2b3c' LOWER CASE.
**
*WRITE: / persnr, id.
*persnr = id.
*write: / persnr.

**********************************************************************************************

*DATA:
*  ls_sflight TYPE sflight,
*  lt_sflight TYPE TABLE OF sflight.
*SELECT-OPTIONS:
*  s_carrid FOR ls_sflight-carrid DEFAULT 'AA',
*  s_fldate FOR ls_sflight-fldate.
**
*SELECT * FROM sflight INTO TABLE lt_sflight
*  WHERE carrid IN s_carrid
*  AND   fldate IN s_fldate.
**
*LOOP AT lt_sflight INTO ls_sflight.
*  WRITE: / ls_sflight-carrid, ls_sflight-connid, ls_sflight-fldate,
*  ls_sflight-seatsocc.
*ENDLOOP.
*****************************************************************************************
*
*

*WRITE: / 'Hallo Welt', 'ich bin', sy-uname.
*write :/ sy-index, sy-datum.
*BREAK-POINT.
******************************************************************************************
*
*
*DATA: summe TYPE i.
*SELECT-OPTIONS:
* zahl FOR summe.
*
*LOOP AT zahl.
*  summe = summe + zahl-low.
*ENDLOOP.
*WRITE: / 'Fertig:', summe.
