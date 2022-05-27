*&---------------------------------------------------------------------*
*& Report Z_S04_RANGES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_ranges.

*INCLUDE z_t04_i_flugdaten.

*TABLES scarr.
*
*DATA ls_scarr TYPE scarr.


*Beispiel SCARR
*SELECT-OPTIONS so_carr FOR scarr-carrid.
*
*SORT lt_scarr BY carrid.
*
*LOOP AT lt_scarr INTO ls_scarr WHERE carrid IN so_carr.
*  WRITE: / |{ ls_scarr-carrid } - { ls_scarr-carrname }|.
*ENDLOOP.
*
*IF sy-subrc <> 0.
*  MESSAGE: |KEINE FLUGGESELLSCHAFT GEFUNDEN!| TYPE 'S' DISPLAY LIKE 'E'.
*ENDIF.

**********************************************************************
*RANGES Reichweiten
*Beispiel TSTC - Tabelle aller Transaktionscodes inb SE16 ansehen, TCODE über SELECT-OPTION der SE16 einschränken.


*Typisierung der Range
*RANGES lr_range FOR scarr-carrid.
*
*lr_range-sign   = 'I'.
*lr_range-option = 'EQ'.
*lr_range-low    = 'LH'.
*lr_range-high   = ''.
*
*APPEND lr_range TO lr_range.


**********************************************************************
*Aufgabe: Auflistung von Flugbuchungen vom 29.03.2021 im Bereich 500 - 1000€ erzeugen.

TABLES sbook.


DATA: lt_sbook TYPE TABLE OF sbook,
      ls_sbook  TYPE sbook.

DATA lt_sbook_ausgabe TYPE TABLE OF sbook.


DATA lr_range TYPE RANGE OF scarr-carrid.
DATA ls_range LIKE LINE OF lr_range.



*Obsolete Deklarierung
*RANGES lr_datum FOR sbook-order_date.
*RANGES lr_value FOR sbook-forcuram.

*Neue Deklarierung
DATA lr_datum TYPE RANGE OF sbook-order_date.
DATA ls_datum LIKE LINE OF lr_range.

DATA lr_value TYPE RANGE OF sbook-forcuram.
DATA ls_value LIKE LINE OF lr_value.

DATA lv_currency TYPE sbook-forcurkey VALUE 'EUR'.

*Befüllen der Range mit Daten
ls_datum-sign   = 'I'. "Möglichkeit INCLUDE oder EXCLUDE zu wählen.
ls_datum-option = 'EQ'.
ls_datum-low    = '20210928'.
ls_datum-high   = ''.
APPEND ls_datum TO lr_datum.

ls_value-sign   = 'I'.
ls_value-option = 'BT'.
ls_value-low    = 500.
ls_value-high   = 1000.
APPEND ls_value TO lr_value.

LOOP AT lt_sbook INTO ls_sbook WHERE order_date IN lr_datum AND forcurkey EQ lv_currency AND Forcuram IN lr_value.

APPEND ls_sbook TO lt_sbook_ausgabe.

ENDLOOP.



"SELECT-OPTIONS so_date FOR sbook-order_date DEFAULT '20210329'.

*LOOP AT lt_sbook INTO ls_book
*  WHERE order_date = 20210329 AND
*  forcurkey = 'EUR' AND
*  loccuram BETWEEN 500 AND 1000.
*
*  APPEND ls_book TO lt_sbook_ausgabe.
*
*  WRITE: / |Buchungen: { ls_book-order_date DATE = ISO }|.
**ENDLOOP.
*
*
*IF sy-subrc <> 0.
*  MESSAGE: |KEINE BUCHUNG GEFUNDEN!| TYPE 'I' DISPLAY LIKE 'E'.
*ENDIF.
