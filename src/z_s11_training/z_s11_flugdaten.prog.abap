*&---------------------------------------------------------------------*
*& Report Z_S11_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_flugdaten.

*DATA lt_spfli   TYPE TABLE OF spfli   .
*DATA lt_sflight TYPE TABLE OF sflight .
*DATA lt_scarr   TYPE TABLE OF scarr   .
*DATA lt_sbook   TYPE TABLE OF sbook   .
*DATA lt_scustom TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.

*select * from spfli   INTO TABLE lt_spfli  .
*select * from sflight INTO TABLE lt_sflight.
*select * from scarr   INTO TABLE lt_scarr  .
*select * from sbook   INTO TABLE lt_sbook  .
*select * from scustom INTO TABLE lt_scustom.
*select * from scounter INTO TABLE lt_scounter.
*select * from sbuspart INTO TABLE lt_sbuspart.

INCLUDE z_t04_i_flugdaten.

DATA : ls_scustom TYPE scustom,
       ls_scarr   TYPE scarr,
       ls_spfli   TYPE spfli.

"finde alle buchungen die eine Kunde hat

PARAMETERS: p_kunde TYPE scustom-id DEFAULT '00000001'.

DATA ls_sbook TYPE sbook.

  WRITE :/ 'Booking ID', 'Booking Class','Carrier Name','From','Destination'.
LOOP AT lt_sbook INTO ls_sbook WHERE customid = p_kunde. "using key where scustom-id = p_kunde.

  READ TABLE lt_scarr INTO ls_scarr WITH KEY carrid = ls_sbook-carrid.
  READ TABLE lt_spfli INTO ls_spfli WITH KEY connid = ls_sbook-connid.



  WRITE :/ ls_sbook-bookid, ls_sbook-class, ls_scarr-carrname, ls_spfli-countryfr, ls_spfli-countryto.

ENDLOOP.
