*&---------------------------------------------------------------------*
*& Report Z_S12_RANGES_UEBUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S12_RANGES_UEBUNG.
INCLUDE z_t04_i_flugdaten.

TABLES scarr.

DATA ls_scarr TYPE scarr.


*Beispiel SCARR
*SELECT-OPTIONS so_carr FOR scarr-carrid NO INTERVALS.

SORT lt_scarr BY carrid.

LOOP AT lt_scarr INTO ls_scarr ."WHERE carrid IN so_carr.
  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
ENDLOOP.
IF sy-subrc <> 0.
  MESSAGE:  |Keine Fluggeselschaft gefunden.| TYPE 'S'.
ENDIF.


**********************************************************************
*RANGES Reichweiten
*Beispiel TSTC - Tabelle aller Transaktionscodes  in SE16 ansehen, TCODE über SELECT-OPTION der SE16 einschränken.

*TYPISIERUNG der Range
RANGES lr_range FOR scarr-carrid.

lr_range-sign   = 'I'.
lr_range-option = 'EQ'.
lr_range-low    = 'LH'.
lr_range-high   = ''.

APPEND lr_range TO lr_range.


*AUFGABE: Einschränkungkriterium Buchungsdatum 29.03.2021 UND zwischen 500 und 1000€ Kosten der Buchung.


DATA ls_sbook TYPE sbook.

DATA lt_sbook_result TYPE TABLE OF sbook.

RANGES lr_datum FOR sbook-order_date.
RANGES lr_value FOR sbook-forcuram.
DATA lv_currency TYPE sbook-forcurkey VALUE 'EUR'.


lr_datum-sign   = 'I'. " Möglichkeit INCLUDE oder EXCLUDE zu wählen.
lr_datum-option = 'EQ'.
lr_datum-low    = '20210928'.
lr_datum-high   = ''.
APPEND lr_datum TO lr_datum.

lr_value-sign   = 'I'.
lr_value-option = 'BT'.
lr_value-low    = 500.
lr_value-high   = 1000.
APPEND lr_value TO lr_value.



LOOP AT lt_sbook INTO ls_sbook
  WHERE
  order_date IN lr_datum AND
  forcurkey EQ lv_currency AND
  Forcuram IN lr_value
  .

  APPEND ls_sbook TO lt_sbook_result.

ENDLOOP.


BREAK-POINT.
