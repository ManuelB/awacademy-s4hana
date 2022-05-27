*&---------------------------------------------------------------------*
*& Report Z_S04_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s04_string_templates.

DATA lv_ausgabetext TYPE string.
DATA lv_zahl TYPE i VALUE 192.
DATA lv_text(50) TYPE c VALUE 'TEXT'.


lv_ausgabetext = |Variableninhalt|.

WRITE: |Dies ist ein Text.|.

WRITE: / |Dies ist ein Text. { lv_ausgabetext } |.

* Ziel ist ein Text, der wie folgt aussieht: Testtext-192.
WRITE: / 'Testtext-', lv_zahl. "Alte Variante (Aufwändig mit CONCATENATE und CONDENSE)
WRITE: / |Testtext-{ lv_zahl }|. "Neue Variante.

WRITE: / |{ lv_text ALIGN = RIGHT WIDTH = 100 }|.

ULINE.
**********************************************************************

WRITE: / 'DATE (Standard):  ', sy-datlo.
WRITE: / |DATE (RAW):        { sy-datlo DATE = RAW }|.
WRITE: / |DATE (ISO):        { sy-datlo DATE = ISO }|.
WRITE: / |DATE (USER):       { sy-datlo DATE = USER }|.
WRITE: / |DATE (ENVIRONMENT):{ sy-datlo DATE = ENVIRONMENT }|.

ULINE.
**********************************************************************

WRITE: / 'TIME (Standard):  ', sy-timlo.
WRITE: / |TIME (RAW):        { sy-timlo TIME = RAW }|.
WRITE: / |TIME (ISO):        { sy-timlo TIME = ISO }|.
WRITE: / |TIME (USER):       { sy-timlo TIME = USER }|.
WRITE: / |TIME (ENVIRONMENT):{ sy-timlo TIME = ENVIRONMENT }|.

ULINE.
**********************************************************************

DATA lv_timestamp TYPE timestampl.
GET TIME STAMP FIELD lv_timestamp. "Zeitstempel wird befüllt

WRITE: / 'TIMESTAMP (Standard):   ', lv_timestamp.
WRITE: / |TIMESTAMP (SPACE):       { lv_timestamp TIMESTAMP = SPACE }|.
WRITE: / |TIMESTAMP (ISO):         { lv_timestamp TIMESTAMP = ISO }|.
WRITE: / |TIMESTAMP (USER):        { lv_timestamp TIMESTAMP = USER }|.
WRITE: / |TIMESTAMP (ENVIRONMENT): { lv_timestamp TIMESTAMP = ENVIRONMENT }|.

ULINE.
**********************************************************************

WAIT UP TO 2 SECONDS.
GET TIME STAMP FIELD lv_timestamp.
WRITE: / |TIMESTAMP (2 SEC./ISO):  { lv_timestamp TIMESTAMP = ISO }|.

ULINE.
**********************************************************************
