*&---------------------------------------------------------------------*
*& Report Z_S05_STRUKTUREN_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_STRUKTUREN_STRUKTUR.

DATA: lv_nummer TYPE i.
DATA: lv_string TYPE string VALUE 'testtext'.

FIND 't' IN lv_string .
IF sy-subrc EQ 0.
  WRITE: '"T" wurde gefunden'.
  else.
    WRITE: '"T" wurde gefunden'.
    ENDIF.

ULINE.

DATA lv_datum TYPE sy-datlo.
data lv_ausgabe TYPE string.
DATA lv_tag TYPE string.
DATA lv_monat TYPE string.
DATA lv_jahr TYPE string.







lv_datum = sy-datlo.


WRITE: / sy-datlo.

ULINE .

lv_tag = lv_datum+4(2).
lv_monat = lv_datum+4(2).
lv_jahr = lv_datum(4).

CONCATENATE: lv_tag lv_monat lv_jahr INTO lv_ausgabe SEPARATED BY '-'.

WRITE: 'Datum', lv_ausgabe.


lv_ausgabe = lv_datum+6(2).

WRITE: / sy-uzeit.

"lv_uhr = sy-uzeit.

DATA lv_uhr TYPE sy-uzeit.
DATA lv_stunde TYPE string.
DATA lv_minute TYPE string.
DATA lv_sekunde TYPE string.
DATA lv_aufgabe TYPE string.

lv_uhr = sy-uzeit.

lv_stunde = lv_uhr(2).
lv_minute = lv_uhr+2(2).
lv_sekunde = lv_uhr+4(2).

WRITE: / 'Stunde:', lv_stunde.
WRITE: / 'Minute:', lv_minute.
WRITE: / 'Sekunde:', lv_sekunde.


"Stunde:
"Minute:
"Sekundwe:
