*&---------------------------------------------------------------------*
*& Report Z_S05_STRING_TEMPLATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_STRING_TEMPLATE.



DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 152.
DATA lv_text(10) TYPE c VALUE 'TEXT'.

lv_ausgabetext  = |Variableninhalt|.

WRITE: |Die ist ein Text|.

"Ziel Text: Testtext-192"

"CONCATENATE:


WRITE: / |Dies ist ein Text. { lv_ausgabetext } |.

WRITE: / 'Testtext', lv_zahl. "Alte Variante
WRITE: / |Testtext-{ lv_zahl } |.

WRITE: / |{ lv_text ALIGN = RIGHT WIDTH = 100 }|.



WrITE / sy-datlo.

ULINE.
ULINE.
WRITE: / | { sy-datlo DATE = RAW } |.

ULINE.
WRITE: / | { sy-datlo DATE = ISO } |.
WRITE: / | { sy-datlo DATE = USER } |.

ULINE.


WRITE: / sy-uzeit.
WRITE: / | { sy-uzeit TIME = RAW } |.
WRITE: / | { sy-uzeit TIME = ISO } |.
WRITE: / | { sy-uzeit TIME = USER } |.

WRITE: / |{ 'Nachmitag' ALIGN = RIGHT WIDTH = 100 }|.

ULINE.

DATA lv_timestamp TYPE timestampl.
get TIME STAMP FIELD lv_timestamp.

WRITE: / 'Timestamp:', lv_timestamp.
WRITE: / |Timestamp { lv_timestamp TIMESTAMP = ISO } |.

WAIT UP TO 2 SECONDS.
get TIME STAMP FIELD lv_timestamp.
WRITE: / |Timestamp { lv_timestamp TIMESTAMP = ISO } |.
