*&---------------------------------------------------------------------*
*& Report Z_AW07_STRING_TAMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_STRING_TAMPLATES.
DAta lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'TEXT'.


lv_ausgabetext = |Variableninhalt|.


Write: |Dies ist ein Text|.



Write:  / |Dies ist ein Text. { lv_ausgabetext } |.

WRITE: / 'Texttext', lv_zahl.
WRITE: / |Texttext-{ lv_zahl } |.

WRITE: / | { lv_text ALIGN = RIGHT WIDTH = 100 } |.

WRITE: / sy-datlo.
WRITE: / | { sy-datlo DATE = RAW } |.
WRITE: / | { sy-datlo DATE = ISO } |.
WRITE: / | { sy-datlo DATE = USER } |.

WRITE: / sy-uzeit.
WRITE: / | { sy-uzeit TIME = RAW } |.
WRITE: / | { sy-uzeit TIME = ISO } |.
WRITE: / | { sy-uzeit time = USER } |.

DATA lv_timestamp TYPE timestampl.
get time STAMP FIELD lv_timestamp.

WRITE: / 'Timestamp:', lv_timestamp.
WRITE: / |'Timestamp:', { lv_timestamp  TIMESTAMP = ISO }|.

WAIT up to 2 SECONDS.
GET TIME STAMP FIELD lv_timestamp.
WRITE: / |'Timestamp:', { lv_timestamp  TIMESTAMP = ISO }|.
