*&---------------------------------------------------------------------*
*& Report Z_S03_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_STRING_TEMPLATES.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'TEXT' .

lv_ausgabetext = |Variableninhalt|.

WRITE: / |Dies ist Text.|.
WRITE: / |Dies ist Text. { lv_ausgabetext }|.

WRITE: / 'Testtext-', lv_zahl. "Alte Variante (Aufwändig)
WRITE: / |Testtext-{ lv_zahl }|.

WRITE: / | { lv_text ALIGN = RIGHT WIDTH = 100 }|.

WRITE: / sy-datlo.
WRITE: / |{ sy-datlo DATE = RAW }|.
WRITE: / |{ sy-datlo DATE = ISO }|.
WRITE: / |{ sy-datlo DATE = USER }|.

WRITE: / sy-timlo.
WRITE: / |{ sy-timlo TIME = RAW }|.
WRITE: / |{ sy-timlo TIME = ISO }|.
WRITE: / |{ sy-timlo TIME = USER }|.

DATA lv_timestamp TYPE timestampl.
GET TIME STAMP FIELD lv_timestamp.

WRITE: / 'Timestamp:', lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|.
* iso ist nur damit ich das vernünftig lesen kann.

WAIT UP TO 2 SECONDS.
GET TIME STAMP FIELD lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|.
