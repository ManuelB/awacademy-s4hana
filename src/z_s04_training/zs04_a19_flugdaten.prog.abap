*&---------------------------------------------------------------------*
*& Report Z_S04_FLUGDATEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a19_flugdaten.


*DATA lt_spfli    TYPE TABLE OF spfli   .
*DATA lt_sflight  TYPE TABLE OF sflight .
*DATA lt_sbook    TYPE TABLE OF sbook   .



*DATA ls_spfli TYPE spfli.
*DATA ls_scarr TYPE scarr.
*DATA ls_book  TYPE sbook.


DATA: ls_carrid TYPE spfli-carrid,
      ls_connid TYPE spfli-connid,
      ls_fldate TYPE sflight-fldate,
      ls_bookid TYPE sbook-bookid,
      ls_customid TYPE scustom-id.
*      lr_customid TYPE RANGE OF scustom-id,
*      ls_customid LIKE LINE OF lr_customid.


*ls_customid-sign = 'I'.
*ls_customid-option = 'BT'.
*ls_customid-low = '1'.
*ls_customid-high = '100'.
*APPEND ls_customid TO lr_customid.



SELECT-OPTIONS: carrid FOR ls_carrid,
                connid FOR ls_connid,
                fldate FOR ls_fldate,
                bookid FOR ls_bookid,
                costumid FOR ls_customid DEFAULT 1 TO 100.



SELECT FROM sbook FIELDS carrid, connid, fldate, bookid




  ORDER BY fldate
  INTO TABLE @DATA(result).

cl_demo_output=>display( result ).



*select * from spfli    INTO TABLE lt_spfli.
*
*
*
*
*
*SELECT * FROM sflight  INTO TABLE lt_sflight.
*SELECT * FROM sbook    INTO TABLE lt_sbook  .










*SELECT FROM sflight FIELDS carrid,
*  MIN( price ) AS min_price,
*  MAX( price ) AS max_price
*  GROUP BY carrid
*  ORDER BY carrid DESCENDING
*  INTO TABLE @DATA(result).
*
*  cl_demo_output=>display( result ).




**********************************************************************
*Aufgabe: Alle getätigten Buchungen eines Kunden, abhängig von der ID in einer Tabelle ausgeben.


*WRITE: / 'Bestehende Buchungen für Kundennummer:', p_kunde,':'.

*SELECT * FROM sbook WHERE id EQ 00000180.   "(SELECT ist ein SQL Befehl!)
*  WRITE: / 'KUNDE', p_kunde.
*ENDSELECT.

*LOOP AT lt_sbook INTO ls_book WHERE customid EQ p_kunde.
*
*  READ TABLE lt_spfli WITH KEY connid = ls_book-connid INTO ls_spfli.
*  READ TABLE lt_scarr WITH KEY carrid = ls_book-carrid INTO ls_scarr.
*
*  WRITE: / |date: { ls_book-fldate DATE = ISO } with: { ls_scarr-carrname } from: { ls_spfli-cityfrom } to: { ls_spfli-cityto }|.
*
*ENDLOOP.


IF sy-subrc <> 0.
  WRITE: / 'KEINE BUCHUNG VORHANDEN!'.
ENDIF.
