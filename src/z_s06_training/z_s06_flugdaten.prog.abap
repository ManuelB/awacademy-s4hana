*&---------------------------------------------------------------------*
*& Report Z_S06_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_flugdaten.

INCLUDE z_t04_i_flugdaten.

*DATA lt_spfli   TYPE TABLE OF spfli   .
*DATA lt_sflight TYPE TABLE OF sflight .
*DATA lt_scarr   TYPE TABLE OF scarr   .
*DATA lt_sbook   TYPE TABLE OF sbook   .
*DATA lt_scustom TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.
*
*select * from spfli   INTO TABLE lt_spfli  .
*select * from sflight INTO TABLE lt_sflight.
*select * from scarr   INTO TABLE lt_scarr  .
*select * from sbook   INTO TABLE lt_sbook  .
*select * from scustom INTO TABLE lt_scustom.
*select * from scounter INTO TABLE lt_scounter.
*select * from sbuspart INTO TABLE lt_sbuspart.

**********************************************************************
*DATA ls_spfli   TYPE spfli   .
*DATA ls_scarr   TYPE scarr   .
*DATA ls_sbook   TYPE sbook   .
***********************************************************************
*"alle info von kunde 00000001 finden.
***********************************************************************
*PARAMETERS: p_kunde TYPE scustom-id DEFAULT '00000001'.
*
*LOOP AT lt_sbook INTO ls_sbook WHERE customid EQ p_kunde.
*
*  READ TABLE lt_spfli WITH KEY connid = ls_sbook-connid INTO ls_spfli.
*
*  READ TABLE lt_scarr WITH KEY carrid = ls_sbook-carrid INTO ls_scarr.
*
*  WRITE: / |Flug: { ls_sbook-fldate DATE = ISO } #with:{ ls_scarr-carrname  } #from:{ ls_spfli-cityfrom } #to:{ ls_spfli-cityto }|.
*
*ENDLOOP.

**********************************************************************
