*&---------------------------------------------------------------------*
*& Report Z_S06_STRING_TEMPLATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_string_template.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'TEXT'.
**********************************************************************
lv_ausgabetext = |Variableninhalt|.
**********************************************************************
WRITE: |Dies ist ein Text.|.
WRITE: / |Dies ist ein Text.{ lv_ausgabetext }|.
*Ziel test:  Testtext-192
WRITE: 'Testtext-', lv_zahl. "Alte Variante (Aufwändig)
WRITE: |Testtext-{ lv_zahl }|.
WRITE: / |{ lv_text ALIGN = RIGHT WIDTH = 100 }|.
WRITE: / sy-datlo.
WRITE: / |{ sy-datlo DATE = RAW }|.
WRITE: / |{ sy-datlo DATE = ISO }|.
WRITE: / |{ sy-datlo DATE = USER }|.
ULINE.
**********************************************************************
WRITE: / sy-uzeit.
WRITE: / |{ sy-uzeit TIME = RAW }|.
WRITE: / |{ sy-uzeit TIME = ISO }|.
WRITE: / |{ sy-uzeit TIME = USER }|.
ULINE.

DATA lv_timestamp TYPE timestampl.
GET TIME STAMP FIELD lv_timestamp.

WRITE: / 'Timestamp:', lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = USER }|.
**********************************************************************
WAIT UP TO 2 SECONDS.
GET TIME STAMP FIELD lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = USER }|.
**********************************************************************
