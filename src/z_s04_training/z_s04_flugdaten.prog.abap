*&---------------------------------------------------------------------*
*& Report Z_S04_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_flugdaten.

*DATA lt_spfli    TYPE TABLE OF spfli   .
*DATA lt_sflight  TYPE TABLE OF sflight .
*DATA lt_scarr    TYPE TABLE OF scarr   .
*DATA lt_sbook    TYPE TABLE OF sbook   .
*DATA lt_scustom  TYPE TABLE OF scustom .
*DATA lt_scounter TYPE TABLE OF scounter.
*DATA lt_SBUSPART TYPE TABLE OF SBUSPART.
*
*select * from spfli    INTO TABLE lt_spfli  .
*select * from sflight  INTO TABLE lt_sflight.
*select * from scarr    INTO TABLE lt_scarr  .
*select * from sbook    INTO TABLE lt_sbook  .
*select * from scustom  INTO TABLE lt_scustom.
*select * from scounter INTO TABLE lt_scounter.
*select * from sbuspart INTO TABLE lt_sbuspart.


INCLUDE z_t04_i_flugdaten.

PARAMETERS: p_kunde TYPE scustom-id.



**********************************************************************
*Aufgabe: Alle getätigten Buchungen eines Kunden, abhängig von der ID in einer Tabelle ausgeben.

DATA ls_spfli TYPE spfli.
DATA ls_scarr TYPE scarr.
DATA ls_book  TYPE sbook.

WRITE: / 'Bestehende Buchungen für Kundennummer:', p_kunde,':'.

*SELECT * FROM sbook WHERE id EQ 00000180.   "(SELECT ist ein SQL Befehl!)
*  WRITE: / 'KUNDE', p_kunde.
*ENDSELECT.

LOOP AT lt_sbook INTO ls_book WHERE customid EQ p_kunde.

  READ TABLE lt_spfli WITH KEY connid = ls_book-connid INTO ls_spfli.
  READ TABLE lt_scarr WITH KEY carrid = ls_book-carrid INTO ls_scarr.

  WRITE: / |date: { ls_book-fldate DATE = ISO } with: { ls_scarr-carrname } from: { ls_spfli-cityfrom } to: { ls_spfli-cityto }|.

ENDLOOP.


IF sy-subrc <> 0.
  WRITE: / 'KEINE BUCHUNG VORHANDEN!'.
ENDIF.
