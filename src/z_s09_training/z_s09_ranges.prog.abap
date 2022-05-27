*&---------------------------------------------------------------------*
*& Report Z_S09_RANGES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_RANGES.

INCLUDE z_t04_i_flugdaten.


TABLES scarr.

DATA ls_scarr TYPE scarr.

SELECT-OPTIONS so_carr FOR scarr-carrid.

LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.

  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
  ENDLOOP.
  IF sy-subrc <> 0.
    MESSAGE: |Keine Fluggesellschaft gefunden.| TYPE 'S'.
ENDIF.

"-----------------------"
"RANGES Reichweiten"

 "Beispiel TSTC - Tabelle aller Transaktionscodes, in SE16 ansehen, TCODE über select-option der SE16

 DATA lr_range TYPE RANGE OF scarr-carrid.
 DATA ls_range LIKE LINE OF lr_range.

 "Obsolete Deklarierung-

 RANGES lr_range FOR scarr-carrid.

 lr-range-sign = 'I'.
 lr_range-option = 'EQ'.
 lr_range-low = 'LH'.
 lr_range-high = ''.

 APPEND ls_range to lr_range.

 DATA lt_OBSOLET TYPE TABLE OF scarr WITH HEADER LINE.
 "lt_obsolet[]

 ULINE.
 "-----------------------------------"

"Robins richtige Variante"



 DATA ls_book TYPE sbook.

 DATA lt_sbook_result TYPE TABLE OF sbook.

"Obsolet
 "RANGES lr_datum FOR sbook-order_date.
 "RANGES lr_value FOR sbook_forcuram.

 DATA lr_datum TYPE RANGE OF sbook-order_date.
 DATA ls_datum LIKE LINE OF lr_range.

 DATA lr_value TYPE RANGE OF sbook-forcuram.
 DATA ls_value LIKE LINE OF lr_value.

 DATA lv_currency TYPE sbook-FORCURKEY VALUE 'EUR'.

 lr_datum-sign = 'I'.
 lr_datum-option = 'EQ'.
 lr_datum-low = 20210329.
 lr_datum-high = ''.

 APPEND ls_datum TO ls_datum.

 ls_value-sign = 'I'.
 ls_value-option = 'BT'.
 ls_value-low = 500.
 ls_value-high = 1000.

 LOOP AT lt_sbook INTO ls_sbook

   WHERE

   forcurkey EQ lv_currency AND
   order-date IN lr_datum AND
   forcuram IN lr_value.

   APPEND ls_sbook TO lt_sbook_result.

   ENDLOOP.
